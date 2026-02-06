import 'package:flutter_secure_storage/flutter_secure_storage.dart';

/// Služba pro bezpečné ukládání citlivých dat (tokenů).
///
/// Využívá šifrované úložiště systému (Keychain/Keystore).
class SecureStorageService {
  final FlutterSecureStorage _storage;

  SecureStorageService(this._storage);

  // Klíče pro ukládání dat
  static const _accessTokenKey = 'access_token';
  static const _refreshTokenKey = 'refresh_token';

  /// Uloží samostatně Access Token (vyžadováno v repozitáři).
  Future<void> saveAccessToken(String token) async {
    await _storage.write(key: _accessTokenKey, value: token);
  }

  /// Uloží samostatně Refresh Token (vyžadováno v repozitáři).
  Future<void> saveRefreshToken(String token) async {
    await _storage.write(key: _refreshTokenKey, value: token);
  }

  /// Uloží oba tokeny najednou (pomocná metoda).
  Future<void> saveTokens({
    required String access,
    required String refresh,
  }) async {
    await saveAccessToken(access);
    await saveRefreshToken(refresh);
  }

  /// Načte uložený Access Token.
  Future<String?> getAccessToken() async {
    return await _storage.read(key: _accessTokenKey);
  }

  /// Načte uložený Refresh Token.
  Future<String?> getRefreshToken() async {
    return await _storage.read(key: _refreshTokenKey);
  }

  /// Smaže všechny uložené údaje (použito při logoutu).
  Future<void> deleteAll() async {
    await _storage.deleteAll();
  }

  /// Vymaže pouze tokeny, ale zachová ostatní nastavení (pokud existují).
  Future<void> clearTokens() async {
    await _storage.delete(key: _accessTokenKey);
    await _storage.delete(key: _refreshTokenKey);
  }
}
