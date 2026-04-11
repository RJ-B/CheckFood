import 'package:flutter_secure_storage/flutter_secure_storage.dart';

/// Zabezpečené úložiště pro autentizační tokeny a session data.
///
/// Využívá [FlutterSecureStorage] s hardwarovým šifrováním:
/// na Androidu `EncryptedSharedPreferences`, na iOS Keychain.
class TokenStorage {
  final FlutterSecureStorage _storage;

  static const String _accessTokenKey = 'access_token';
  static const String _refreshTokenKey = 'refresh_token';
  static const String _deviceIdentifierKey = 'device_identifier';
  static const String _needsRestaurantClaimKey = 'needs_restaurant_claim';
  static const String _needsOnboardingKey = 'needs_onboarding';

  static const AndroidOptions _androidOptions = AndroidOptions(
    encryptedSharedPreferences: true,
  );

  /// iOS Keychain accessibility set to `first_unlock_this_device` —
  /// the entry is tied to the physical device and is **excluded from
  /// iCloud Keychain sync**. Previously the token blob was
  /// `first_unlock`, which is iCloud-syncable, so a user who
  /// disabled PIN/FaceID and enabled Keychain sync could see their
  /// refresh token land on every other Apple device in their account.
  /// `first_unlock_this_device` closes that exfiltration path at the
  /// cost of the user having to re-login after a full factory reset
  /// (which is the correct trade-off — a restore is not the same
  /// trust level as a running device).
  static const IOSOptions _iosOptions = IOSOptions(
    accessibility: KeychainAccessibility.first_unlock_this_device,
  );

  TokenStorage(this._storage);

  /// Rychlá kontrola existence Access Tokenu pro startovací logiku aplikace.
  Future<bool> hasAccessToken() async {
    final token = await _storage.read(
      key: _accessTokenKey,
      aOptions: _androidOptions,
      iOptions: _iosOptions,
    );
    return token != null && token.isNotEmpty;
  }

  /// Uloží sadu tokenů získaných z API.
  Future<void> saveTokens({
    required String accessToken,
    required String refreshToken,
  }) async {
    await _storage.write(
      key: _accessTokenKey,
      value: accessToken,
      aOptions: _androidOptions,
      iOptions: _iosOptions,
    );
    await _storage.write(
      key: _refreshTokenKey,
      value: refreshToken,
      aOptions: _androidOptions,
      iOptions: _iosOptions,
    );
  }

  /// Získá Access Token pro autorizaci síťových požadavků.
  Future<String?> getAccessToken() async {
    return await _storage.read(
      key: _accessTokenKey,
      aOptions: _androidOptions,
      iOptions: _iosOptions,
    );
  }

  /// Získá Refresh Token pro proces obnovy vypršelého sezení.
  Future<String?> getRefreshToken() async {
    return await _storage.read(
      key: _refreshTokenKey,
      aOptions: _androidOptions,
      iOptions: _iosOptions,
    );
  }

  /// Uloží UUID zařízení svázané s aktuální session.
  Future<void> saveDeviceId(String deviceIdentifier) async {
    await _storage.write(
      key: _deviceIdentifierKey,
      value: deviceIdentifier,
      aOptions: _androidOptions,
      iOptions: _iosOptions,
    );
  }

  /// Získá uložené ID zařízení pro aktuální session.
  Future<String?> getDeviceId() async {
    return await _storage.read(
      key: _deviceIdentifierKey,
      aOptions: _androidOptions,
      iOptions: _iosOptions,
    );
  }

  /// Uloží příznak, zda uživatel musí projít procesem nárokování restaurace.
  Future<void> saveNeedsRestaurantClaim(bool value) async {
    await _storage.write(
      key: _needsRestaurantClaimKey,
      value: value.toString(),
      aOptions: _androidOptions,
      iOptions: _iosOptions,
    );
  }

  /// Vrátí uložený příznak pro nárokování restaurace.
  Future<bool> getNeedsRestaurantClaim() async {
    final value = await _storage.read(
      key: _needsRestaurantClaimKey,
      aOptions: _androidOptions,
      iOptions: _iosOptions,
    );
    return value == 'true';
  }

  /// Uloží příznak, zda uživatel musí projít onboardingem.
  Future<void> saveNeedsOnboarding(bool value) async {
    await _storage.write(
      key: _needsOnboardingKey,
      value: value.toString(),
      aOptions: _androidOptions,
      iOptions: _iosOptions,
    );
  }

  /// Vrátí uložený příznak pro onboarding.
  Future<bool> getNeedsOnboarding() async {
    final value = await _storage.read(
      key: _needsOnboardingKey,
      aOptions: _androidOptions,
      iOptions: _iosOptions,
    );
    return value == 'true';
  }

  /// Kompletní vyčištění autentizačních dat (např. při odhlášení).
  Future<void> clearAuthData() async {
    await _storage.delete(
      key: _accessTokenKey,
      aOptions: _androidOptions,
      iOptions: _iosOptions,
    );
    await _storage.delete(
      key: _refreshTokenKey,
      aOptions: _androidOptions,
      iOptions: _iosOptions,
    );
    await _storage.delete(
      key: _deviceIdentifierKey,
      aOptions: _androidOptions,
      iOptions: _iosOptions,
    );
    await _storage.delete(
      key: _needsRestaurantClaimKey,
      aOptions: _androidOptions,
      iOptions: _iosOptions,
    );
    await _storage.delete(
      key: _needsOnboardingKey,
      aOptions: _androidOptions,
      iOptions: _iosOptions,
    );
  }
}
