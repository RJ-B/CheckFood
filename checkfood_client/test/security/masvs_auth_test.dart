// MASVS-AUTH
//
// - JWT expiry MUST be checked locally before using the access token.
// - Refresh failure MUST clear storage and log the user out.
// - Refresh MUST be single-flight (only one refresh in-flight at a time).
//
// We exercise RefreshTokenManager directly with a mock AuthRepository.

import 'dart:async';
import 'dart:io';

import 'package:checkfood_client/security/domain/entities/auth_tokens.dart';
import 'package:checkfood_client/security/domain/repositories/auth_repository.dart';
import 'package:checkfood_client/security/interceptors/refresh_token_manager.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class _MockAuthRepository extends Mock implements AuthRepository {}

AuthTokens _tokens(String access) => AuthTokens(
      accessToken: access,
      refreshToken: 'R-$access',
      expiresIn: const Duration(minutes: 15),
    );

void main() {
  late _MockAuthRepository repo;
  late RefreshTokenManager sut;

  setUp(() {
    repo = _MockAuthRepository();
    sut = RefreshTokenManager(repo);
  });

  test('refresh is single-flight — two parallel calls trigger one API call',
      () async {
    final completer = Completer<AuthTokens>();
    when(() => repo.refreshToken()).thenAnswer((_) => completer.future);

    final f1 = sut.refreshToken();
    final f2 = sut.refreshToken();

    completer.complete(_tokens('A1'));

    final r1 = await f1;
    final r2 = await f2;

    expect(r1, 'A1');
    expect(r2, 'A1');
    verify(() => repo.refreshToken()).called(1);
  });

  test('refresh failure completes with null so the interceptor logs user out',
      () async {
    when(() => repo.refreshToken()).thenThrow(Exception('refresh denied'));

    final result = await sut.refreshToken();
    expect(result, isNull);
  });

  test(
      'refresh failure wipes TokenStorage AND emits session-expired (P3 fix)',
      () {
    // Phase 3H fix: AuthInterceptor.onError now calls
    //   tokenStorage.clearAuthData()
    //   sessionExpiredBus.signalExpired()
    // whenever refresh returns null, throws, or the /refresh path
    // itself returns 401. Static check here — full behavioural
    // coverage lives in test/unit/security/interceptors/
    // auth_interceptor_test.dart.
    final src = File(
      'lib/security/interceptors/auth_interceptor.dart',
    ).readAsStringSync();

    expect(
      src.contains('clearAuthData'),
      isTrue,
      reason: 'AuthInterceptor must call tokenStorage.clearAuthData() '
          'on the refresh-failure path.',
    );
    expect(
      src.contains('signalExpired'),
      isTrue,
      reason: 'AuthInterceptor must emit on SessionExpiredBus so the UI '
          'can force a logout navigation.',
    );
  });
}
