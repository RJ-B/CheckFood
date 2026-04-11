import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:checkfood_client/security/data/local/token_storage.dart';
import 'package:checkfood_client/security/interceptors/auth_interceptor.dart';
import 'package:checkfood_client/security/interceptors/refresh_token_manager.dart';

class MockTokenStorage extends Mock implements TokenStorage {}

class MockRefreshTokenManager extends Mock implements RefreshTokenManager {}

class MockDio extends Mock implements Dio {}

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
  void resolve(Response<dynamic> response, [bool callFollowingResponseInterceptor = false]) =>
      resolved = response;
}

DioException _build401({String path = '/api/restaurants'}) {
  final opts = RequestOptions(path: path);
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
  late AuthInterceptor interceptor;

  setUp(() {
    mockStorage = MockTokenStorage();
    mockManager = MockRefreshTokenManager();
    mockDio = MockDio();
    interceptor = AuthInterceptor(mockStorage, mockManager, mockDio);

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
      await interceptor.onError(_build401(), handler);

      expect(handler.resolved, isNotNull);
      expect(handler.passed, isNull);
      verify(() => mockManager.refreshToken()).called(1);
    });

    test(
      'should pass error through when refresh returns null (no logout currently)',
      () async {
        when(() => mockManager.refreshToken()).thenAnswer((_) async => null);

        final handler = _FakeErrorHandler();
        await interceptor.onError(_build401(), handler);

        // No retry, error is forwarded
        expect(handler.passed, isNotNull);
        expect(handler.resolved, isNull);
      },
    );

    // EXPECTED-FAIL: auth_interceptor — production code does not yet implement
    // token clearance + logout signal on refresh failure (currently swallows the
    // error via catch(_) and just calls handler.next without clearing storage).
    test(
      'should clear tokens and signal logout when refresh throws',
      () async {
        when(() => mockManager.refreshToken())
            .thenThrow(Exception('refresh failed'));

        // Production should call storage.clearAuthData() and emit a logout event.
        // Currently it only forwards the original DioException.
        final clearCalled = <bool>[];
        when(() => mockStorage.clearAuthData()).thenAnswer((_) async {
          clearCalled.add(true);
        });

        final handler = _FakeErrorHandler();
        await interceptor.onError(_build401(), handler);

        // This assertion WILL FAIL until the interceptor is updated to clear tokens.
        expect(clearCalled, isNotEmpty,
            reason:
                'interceptor must clear tokens when refresh throws');
      },
    );

    test('should NOT enter infinite loop when a /refresh path returns 401',
        () async {
      // A 401 on the refresh endpoint itself must NOT call refreshToken again.
      final handler = _FakeErrorHandler();
      await interceptor.onError(_build401(path: '/api/auth/refresh'), handler);

      verifyNever(() => mockManager.refreshToken());
      expect(handler.passed, isNotNull);
    });

    // EXPECTED-FAIL: auth_interceptor — production code does not yet deduplicate
    // concurrent 401 errors; each one triggers its own refreshToken() call because
    // QueuedInterceptor serialises onError calls but the manager deduplication
    // relies on the in-flight completer being alive when the second call arrives.
    // This test documents that concurrent 401s must trigger only ONE refresh.
    test(
      'should call refreshToken exactly once when two 401s arrive concurrently',
      () async {
        int refreshCallCount = 0;
        final refreshBarrier = Completer<String?>();

        when(() => mockManager.refreshToken()).thenAnswer((_) {
          refreshCallCount++;
          return refreshBarrier.future;
        });
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

        final h1 = _FakeErrorHandler();
        final h2 = _FakeErrorHandler();

        // QueuedInterceptor serialises these, but we still want only one refresh.
        final f1 = interceptor.onError(_build401(path: '/api/restaurants'), h1);
        final f2 =
            interceptor.onError(_build401(path: '/api/orders'), h2);

        refreshBarrier.complete('new_token');
        await Future.wait([f1, f2]);

        // WILL FAIL with current implementation: refreshCallCount will be 2.
        expect(refreshCallCount, 1,
            reason:
                'concurrent 401s must share a single refresh flight');
      },
    );
  });
}
