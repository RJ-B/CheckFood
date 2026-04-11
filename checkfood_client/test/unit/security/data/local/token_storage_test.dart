import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:checkfood_client/security/data/local/token_storage.dart';

class MockSecureStorage extends Mock implements FlutterSecureStorage {}

// Matcher helpers — FlutterSecureStorage uses named platform option params
// that are typed as platform-specific classes. We match by key only.
Matcher _hasKey(String key) => predicate<Map<dynamic, dynamic>>(
      (map) => true,
      'any options map',
    );

void main() {
  late MockSecureStorage mockStorage;
  late TokenStorage tokenStorage;

  setUp(() {
    mockStorage = MockSecureStorage();
    tokenStorage = TokenStorage(mockStorage);

    // Provide default stubs for all write/delete calls to avoid MissingStubError
    when(
      () => mockStorage.write(
        key: any(named: 'key'),
        value: any(named: 'value'),
        aOptions: any(named: 'aOptions'),
        iOptions: any(named: 'iOptions'),
      ),
    ).thenAnswer((_) async {});
    when(
      () => mockStorage.delete(
        key: any(named: 'key'),
        aOptions: any(named: 'aOptions'),
        iOptions: any(named: 'iOptions'),
      ),
    ).thenAnswer((_) async {});
  });

  group('TokenStorage.saveTokens / read', () {
    test('should write access and refresh token to secure storage', () async {
      await tokenStorage.saveTokens(
        accessToken: 'acc',
        refreshToken: 'ref',
      );

      verify(
        () => mockStorage.write(
          key: 'access_token',
          value: 'acc',
          aOptions: any(named: 'aOptions'),
          iOptions: any(named: 'iOptions'),
        ),
      ).called(1);
      verify(
        () => mockStorage.write(
          key: 'refresh_token',
          value: 'ref',
          aOptions: any(named: 'aOptions'),
          iOptions: any(named: 'iOptions'),
        ),
      ).called(1);
    });

    test('should return stored access token', () async {
      when(
        () => mockStorage.read(
          key: 'access_token',
          aOptions: any(named: 'aOptions'),
          iOptions: any(named: 'iOptions'),
        ),
      ).thenAnswer((_) async => 'stored_access');

      final result = await tokenStorage.getAccessToken();

      expect(result, 'stored_access');
    });

    test('should return null when access token is absent', () async {
      when(
        () => mockStorage.read(
          key: 'access_token',
          aOptions: any(named: 'aOptions'),
          iOptions: any(named: 'iOptions'),
        ),
      ).thenAnswer((_) async => null);

      final result = await tokenStorage.getAccessToken();

      expect(result, isNull);
    });

    test('hasAccessToken returns true when token is non-empty', () async {
      when(
        () => mockStorage.read(
          key: 'access_token',
          aOptions: any(named: 'aOptions'),
          iOptions: any(named: 'iOptions'),
        ),
      ).thenAnswer((_) async => 'tok');

      expect(await tokenStorage.hasAccessToken(), isTrue);
    });

    test('hasAccessToken returns false when token is null', () async {
      when(
        () => mockStorage.read(
          key: 'access_token',
          aOptions: any(named: 'aOptions'),
          iOptions: any(named: 'iOptions'),
        ),
      ).thenAnswer((_) async => null);

      expect(await tokenStorage.hasAccessToken(), isFalse);
    });

    test('hasAccessToken returns false when token is empty string', () async {
      when(
        () => mockStorage.read(
          key: 'access_token',
          aOptions: any(named: 'aOptions'),
          iOptions: any(named: 'iOptions'),
        ),
      ).thenAnswer((_) async => '');

      expect(await tokenStorage.hasAccessToken(), isFalse);
    });
  });

  group('TokenStorage.clearAuthData', () {
    test('should delete all five keys', () async {
      await tokenStorage.clearAuthData();

      for (final key in [
        'access_token',
        'refresh_token',
        'device_identifier',
        'needs_restaurant_claim',
        'needs_onboarding',
      ]) {
        verify(
          () => mockStorage.delete(
            key: key,
            aOptions: any(named: 'aOptions'),
            iOptions: any(named: 'iOptions'),
          ),
        ).called(1);
      }
    });
  });

  group('TokenStorage — flags', () {
    test('should persist and read needs_restaurant_claim flag', () async {
      await tokenStorage.saveNeedsRestaurantClaim(true);

      verify(
        () => mockStorage.write(
          key: 'needs_restaurant_claim',
          value: 'true',
          aOptions: any(named: 'aOptions'),
          iOptions: any(named: 'iOptions'),
        ),
      ).called(1);
    });

    test('getNeedsRestaurantClaim returns true when stored value is "true"',
        () async {
      when(
        () => mockStorage.read(
          key: 'needs_restaurant_claim',
          aOptions: any(named: 'aOptions'),
          iOptions: any(named: 'iOptions'),
        ),
      ).thenAnswer((_) async => 'true');

      expect(await tokenStorage.getNeedsRestaurantClaim(), isTrue);
    });

    test('getNeedsRestaurantClaim returns false when stored value is null',
        () async {
      when(
        () => mockStorage.read(
          key: 'needs_restaurant_claim',
          aOptions: any(named: 'aOptions'),
          iOptions: any(named: 'iOptions'),
        ),
      ).thenAnswer((_) async => null);

      expect(await tokenStorage.getNeedsRestaurantClaim(), isFalse);
    });
  });
}
