import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:checkfood_client/security/domain/entities/auth_tokens.dart';
import 'package:checkfood_client/security/domain/repositories/auth_repository.dart';
import 'package:checkfood_client/security/interceptors/refresh_token_manager.dart';

class MockAuthRepository extends Mock implements AuthRepository {}

void main() {
  late MockAuthRepository mockRepo;
  late RefreshTokenManager manager;

  const tTokens = AuthTokens(
    accessToken: 'new_access',
    refreshToken: 'new_refresh',
    expiresIn: Duration(minutes: 30),
  );

  setUp(() {
    mockRepo = MockAuthRepository();
    manager = RefreshTokenManager(mockRepo);
  });

  group('RefreshTokenManager', () {
    test('should return new access token on successful refresh', () async {
      when(() => mockRepo.refreshToken()).thenAnswer((_) async => tTokens);

      final result = await manager.refreshToken();

      expect(result, 'new_access');
      verify(() => mockRepo.refreshToken()).called(1);
    });

    test('should return null when repository throws', () async {
      when(() => mockRepo.refreshToken()).thenThrow(Exception('network error'));

      final result = await manager.refreshToken();

      expect(result, isNull);
    });

    test(
      'should make only ONE repository call when 10 callers fire simultaneously',
      () async {
        final completer = Completer<AuthTokens>();
        when(() => mockRepo.refreshToken()).thenAnswer((_) => completer.future);

        // Fire 10 concurrent calls
        final futures = List.generate(10, (_) => manager.refreshToken());

        // Let them all register on the in-flight completer
        await Future.microtask(() {});

        completer.complete(tTokens);

        final results = await Future.wait(futures);

        // All 10 should receive the same token
        expect(results.every((r) => r == 'new_access'), isTrue);
        // Repository must have been called exactly once
        verify(() => mockRepo.refreshToken()).called(1);
      },
    );

    test(
      'should allow a second refresh after the first completes',
      () async {
        when(() => mockRepo.refreshToken()).thenAnswer((_) async => tTokens);

        await manager.refreshToken();
        final second = await manager.refreshToken();

        expect(second, 'new_access');
        verify(() => mockRepo.refreshToken()).called(2);
      },
    );

    test(
      'should propagate null to all concurrent callers when refresh fails',
      () async {
        final completer = Completer<AuthTokens>();
        when(() => mockRepo.refreshToken()).thenAnswer((_) => completer.future);

        final futures = List.generate(5, (_) => manager.refreshToken());
        await Future.microtask(() {});

        completer.completeError(Exception('refresh failed'));

        final results = await Future.wait(futures);

        expect(results.every((r) => r == null), isTrue);
        verify(() => mockRepo.refreshToken()).called(1);
      },
    );

    test(
      'should reset state so next call after failure creates a fresh request',
      () async {
        when(() => mockRepo.refreshToken())
            .thenThrow(Exception('transient failure'));
        await manager.refreshToken();

        when(() => mockRepo.refreshToken()).thenAnswer((_) async => tTokens);
        final result = await manager.refreshToken();

        expect(result, 'new_access');
        verify(() => mockRepo.refreshToken()).called(2);
      },
    );
  });
}
