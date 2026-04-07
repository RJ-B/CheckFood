import 'package:dio/dio.dart';

import '../data/local/token_storage.dart';
import 'refresh_token_manager.dart';

/// Dio interceptor přidávající Bearer token ke každému požadavku a řešící
/// automatickou obnovu tokenu při obdržení odpovědi 401.
///
/// Používá [QueuedInterceptor], aby se zamezilo souběžným refresh voláním.
/// Pro login/register endpointy (instance `dioAuth`) tento interceptor není použit.
class AuthInterceptor extends QueuedInterceptor {
  final TokenStorage _storage;
  final RefreshTokenManager _tokenManager;
  final Dio _dio;

  AuthInterceptor(this._storage, this._tokenManager, this._dio);

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
    if (err.response?.statusCode == 401) {
      final RequestOptions options = err.requestOptions;

      if (options.path.contains('/refresh')) {
        return handler.next(err);
      }

      try {
        final newToken = await _tokenManager.refreshToken();

        if (newToken != null) {
          final opts = Options(
            method: options.method,
            headers: options.headers,
          );

          opts.headers?['Authorization'] = 'Bearer $newToken';

          final response = await _dio.request(
            options.path,
            options: opts,
            data: options.data,
            queryParameters: options.queryParameters,
          );

          return handler.resolve(response);
        }
      } catch (_) {
        return handler.next(err);
      }
    }

    return handler.next(err);
  }
}
