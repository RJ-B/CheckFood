import 'package:dio/dio.dart';

import '../data/local/token_storage.dart';
import 'refresh_token_manager.dart';
import 'session_expired_bus.dart';

/// Dio interceptor adding a Bearer token to every outgoing request and
/// handling access-token refresh on HTTP 401.
///
/// Concurrency design:
/// ────────────────────
/// Dio's [QueuedInterceptor] serialises `onError` — concurrent 401s land
/// in a queue and are processed one by one. That creates a subtle race:
/// the first handler performs a refresh (via [RefreshTokenManager]), which
/// resets its `_refreshCompleter` to null in its `finally`. By the time
/// the second 401 reaches `onError`, the completer is gone and a second
/// (redundant) refresh call would fire — potentially invalidating the
/// freshly-issued token on the server (rotation).
///
/// The fix is to compare the token attached to the failing request with
/// what's currently in [TokenStorage]. If they differ, somebody already
/// refreshed; retry the request with the new token instead of refreshing
/// again. If they match, perform the refresh.
///
/// On refresh failure we proactively clear all tokens from storage and
/// emit a signal on [SessionExpiredBus] so the UI layer (AuthBloc) can
/// navigate back to the login screen. Without this step stale tokens
/// would linger in storage and the next app start would accept a dead
/// session.
///
/// The auth-endpoint dio instance (`dioAuth`) intentionally does not
/// install this interceptor — login/register/refresh must never queue
/// themselves behind each other.
class AuthInterceptor extends QueuedInterceptor {
  final TokenStorage _storage;
  final RefreshTokenManager _tokenManager;
  final Dio _dio;
  final SessionExpiredBus _sessionBus;

  AuthInterceptor(
    this._storage,
    this._tokenManager,
    this._dio, {
    SessionExpiredBus? sessionBus,
  }) : _sessionBus = sessionBus ?? SessionExpiredBus.instance;

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    if (options.path.contains('/api/auth/refresh')) {
      return handler.next(options);
    }

    final token = await _storage.getAccessToken();
    if (token != null) {
      options.headers['Authorization'] = 'Bearer $token';
    }

    return handler.next(options);
  }

  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    if (err.response?.statusCode != 401) {
      return handler.next(err);
    }

    final RequestOptions options = err.requestOptions;
    if (options.path.contains('/refresh')) {
      // The refresh endpoint itself returned 401 → the refresh token is
      // gone or revoked. Clear everything and signal the UI.
      await _clearAndNotify();
      return handler.next(err);
    }

    // Compare the token that was attached to the failing request with the
    // one currently in storage. If a sibling request already refreshed,
    // just retry with the fresh token — don't invalidate it by refreshing
    // again (server rotation would kill the brand-new token).
    final attachedAuth = options.headers['Authorization'] as String?;
    final currentToken = await _storage.getAccessToken();
    if (currentToken != null &&
        attachedAuth != null &&
        attachedAuth != 'Bearer $currentToken') {
      final retryResponse = await _retryWithToken(options, currentToken);
      if (retryResponse != null) {
        return handler.resolve(retryResponse);
      }
      // Retry still 401 → fall through to refresh path.
    }

    try {
      final newToken = await _tokenManager.refreshToken();
      if (newToken == null) {
        await _clearAndNotify();
        return handler.next(err);
      }

      final response = await _retryWithToken(options, newToken);
      if (response != null) {
        return handler.resolve(response);
      }
      // Retry failed after a successful refresh — treat as an auth fault.
      await _clearAndNotify();
      return handler.next(err);
    } catch (_) {
      // Any unexpected exception inside the refresh/retry path must wipe
      // tokens and notify; swallowing it (as the previous implementation
      // did via `catch(_)`) would leave the app in a zombie auth state.
      await _clearAndNotify();
      return handler.next(err);
    }
  }

  Future<Response<dynamic>?> _retryWithToken(
    RequestOptions options,
    String token,
  ) async {
    try {
      final opts = Options(
        method: options.method,
        headers: Map<String, dynamic>.from(options.headers),
      );
      opts.headers!['Authorization'] = 'Bearer $token';
      return await _dio.request<dynamic>(
        options.path,
        options: opts,
        data: options.data,
        queryParameters: options.queryParameters,
      );
    } catch (_) {
      return null;
    }
  }

  Future<void> _clearAndNotify() async {
    try {
      await _storage.clearAuthData();
    } catch (_) {
      // Even if storage is unavailable, still signal — UI must react.
    }
    _sessionBus.signalExpired();
  }
}
