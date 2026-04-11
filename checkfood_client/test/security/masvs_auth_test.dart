// MASVS-AUTH
//
// - JWT expiry MUST be checked locally before using the access token.
// - Refresh failure MUST clear storage and log the user out.
// - Refresh MUST be single-flight (only one refresh in-flight at a time).
//
// We exercise RefreshTokenManager directly with a mock AuthRepository.

import 'dart:async';

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
      'GAP: refresh failure SHOULD also clear TokenStorage — '
      'RefreshTokenManager currently delegates that concern away', () {
    // GAP: When refresh fails, RefreshTokenManager merely returns null.
    // The AuthInterceptor then forwards the original 401. Nothing in the
    // security layer is guaranteed to call tokenStorage.clearAuthData()
    // on that path — it relies on a BLoC higher up to react. Wire a
    // dedicated logout side-effect into the interceptor or repository
    // so a compromised refresh token can't linger in secure storage.
    fail(
      'Refresh failure must eagerly wipe tokens from TokenStorage. '
      'Currently no code path in lib/security guarantees this — '
      'see AuthInterceptor.onError() which only returns handler.next(err).',
    );
  });
}
