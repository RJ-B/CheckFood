import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:checkfood_client/security/data/local/token_storage.dart';
import 'package:checkfood_client/security/interceptors/auth_interceptor.dart';
import 'package:checkfood_client/security/interceptors/refresh_token_manager.dart';
import 'package:checkfood_client/security/interceptors/session_expired_bus.dart';

class MockTokenStorage extends Mock implements TokenStorage {}

class MockRefreshTokenManager extends Mock implements RefreshTokenManager {}

class MockDio extends Mock implements Dio {}

/// Test-local SessionExpiredBus we can inspect.
class _CountingBus implements SessionExpiredBus {
  int emitCount = 0;

  @override
  Stream<void> get stream => const Stream.empty();

  @override
  void signalExpired() => emitCount++;

  @override
  Future<void> disposeForTest() async {}

  // Satisfy non-abstract method (if any added in the future)
  @override
  noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

// Capture handler calls so we can inspect them in assertions.
class _FakeRequestHandler extends Fake implements RequestInterceptorHandler {
  RequestOptions? passed;
  @override
  void next(RequestOptions options) => passed = options;
}

class _FakeErrorHandler extends Fake implements ErrorInterceptorHandler {
  DioException? passed;
  Response<dynamic>? resolved;

  @override
  void next(DioException err) => passed = err;

  @override
  void resolve(Response<dynamic> response,
          [bool callFollowingResponseInterceptor = false]) =>
      resolved = response;
}

DioException _build401({
  String path = '/api/restaurants',
  String? attachedToken,
}) {
  final opts = RequestOptions(path: path);
  if (attachedToken != null) {
    opts.headers['Authorization'] = 'Bearer $attachedToken';
  }
  return DioException(
    requestOptions: opts,
    response: Response(requestOptions: opts, statusCode: 401),
    type: DioExceptionType.badResponse,
  );
}

void main() {
  late MockTokenStorage mockStorage;
  late MockRefreshTokenManager mockManager;
  late MockDio mockDio;
  late _CountingBus bus;
  late AuthInterceptor interceptor;

  setUp(() {
    mockStorage = MockTokenStorage();
    mockManager = MockRefreshTokenManager();
    mockDio = MockDio();
    bus = _CountingBus();
    interceptor = AuthInterceptor(
      mockStorage,
      mockManager,
      mockDio,
      sessionBus: bus,
    );

    // Default: no token in storage unless a test overrides.
    when(() => mockStorage.getAccessToken()).thenAnswer((_) async => null);
    when(() => mockStorage.clearAuthData()).thenAnswer((_) async {});

    registerFallbackValue(RequestOptions(path: ''));
    registerFallbackValue(Options());
  });

  group('AuthInterceptor.onRequest', () {
    test('should attach Bearer token when access token is available', () async {
      when(() => mockStorage.getAccessToken())
          .thenAnswer((_) async => 'access_abc');

      final opts = RequestOptions(path: '/api/restaurants');
      final handler = _FakeRequestHandler();

      await interceptor.onRequest(opts, handler);

      expect(handler.passed?.headers['Authorization'], 'Bearer access_abc');
    });

    test('should not attach Authorization header when token is null', () async {
      when(() => mockStorage.getAccessToken()).thenAnswer((_) async => null);

      final opts = RequestOptions(path: '/api/restaurants');
      final handler = _FakeRequestHandler();

      await interceptor.onRequest(opts, handler);

      expect(handler.passed?.headers.containsKey('Authorization'), isFalse);
    });

    test('should skip token injection for /api/auth/refresh requests',
        () async {
      when(() => mockStorage.getAccessToken())
          .thenAnswer((_) async => 'access_abc');

      final opts = RequestOptions(path: '/api/auth/refresh');
      final handler = _FakeRequestHandler();

      await interceptor.onRequest(opts, handler);

      // getAccessToken should NOT be called for refresh paths
      verifyNever(() => mockStorage.getAccessToken());
    });
  });

  group('AuthInterceptor.onError — 401 handling', () {
    test('should retry with new token after successful refresh', () async {
      when(() => mockManager.refreshToken())
          .thenAnswer((_) async => 'new_token');
      when(
        () => mockDio.request<dynamic>(
          any(),
          options: any(named: 'options'),
          data: any(named: 'data'),
          queryParameters: any(named: 'queryParameters'),
        ),
      ).thenAnswer(
        (_) async => Response(
          requestOptions: RequestOptions(path: '/api/restaurants'),
          statusCode: 200,
          data: {},
        ),
      );

      final handler = _FakeErrorHandler();
      await interceptor.onError(_build401(attachedToken: 'stale'), handler);

      expect(handler.resolved, isNotNull);
      expect(handler.passed, isNull);
      verify(() => mockManager.refreshToken()).called(1);
    });

    test('clears tokens + emits session-expired when refresh returns null',
        () async {
      when(() => mockManager.refreshToken()).thenAnswer((_) async => null);

      final handler = _FakeErrorHandler();
      await interceptor.onError(_build401(attachedToken: 'stale'), handler);

      // Error is forwarded
      expect(handler.passed, isNotNull);
      expect(handler.resolved, isNull);
      // AND tokens are wiped + UI is notified
      verify(() => mockStorage.clearAuthData()).called(1);
      expect(bus.emitCount, 1);
    });

    test('clears tokens + emits session-expired when refresh throws',
        () async {
      when(() => mockManager.refreshToken())
          .thenThrow(Exception('refresh failed'));

      final handler = _FakeErrorHandler();
      await interceptor.onError(_build401(attachedToken: 'stale'), handler);

      verify(() => mockStorage.clearAuthData()).called(1);
      expect(bus.emitCount, 1);
      expect(handler.passed, isNotNull);
    });

    test('does NOT refresh again when storage already holds a newer token',
        () async {
      // Sibling request already refreshed and wrote a new token to storage
      // while this one was still queued in onError.
      when(() => mockStorage.getAccessToken())
          .thenAnswer((_) async => 'new_token');
      when(
        () => mockDio.request<dynamic>(
          any(),
          options: any(named: 'options'),
          data: any(named: 'data'),
          queryParameters: any(named: 'queryParameters'),
        ),
      ).thenAnswer(
        (_) async => Response(
          requestOptions: RequestOptions(path: '/api/restaurants'),
          statusCode: 200,
          data: {},
        ),
      );

      final handler = _FakeErrorHandler();
      await interceptor.onError(
        _build401(attachedToken: 'stale_old_token'),
        handler,
      );

      // The retry must succeed using the newer token — no second refresh fires.
      expect(handler.resolved, isNotNull);
      verifyNever(() => mockManager.refreshToken());
      verify(() => mockStorage.getAccessToken()).called(1);
    });

    test('should NOT enter infinite loop when a /refresh path returns 401',
        () async {
      // A 401 on the refresh endpoint itself must NOT call refreshToken again
      // and must emit a session-expired signal.
      final handler = _FakeErrorHandler();
      await interceptor.onError(
        _build401(path: '/api/auth/refresh'),
        handler,
      );

      verifyNever(() => mockManager.refreshToken());
      expect(handler.passed, isNotNull);
      verify(() => mockStorage.clearAuthData()).called(1);
      expect(bus.emitCount, 1);
    });

    test('passes non-401 errors through without touching refresh', () async {
      final opts = RequestOptions(path: '/api/restaurants');
      final err500 = DioException(
        requestOptions: opts,
        response: Response(requestOptions: opts, statusCode: 500),
        type: DioExceptionType.badResponse,
      );

      final handler = _FakeErrorHandler();
      await interceptor.onError(err500, handler);

      expect(handler.passed, isNotNull);
      verifyNever(() => mockManager.refreshToken());
      verifyNever(() => mockStorage.clearAuthData());
      expect(bus.emitCount, 0);
    });
  });
}
