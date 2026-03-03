import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../../config/security_config.dart';

abstract class SecureStorageService {
  Future<void> saveTokens({required String access, required String refresh});
  Future<String?> getAccessToken();
  Future<String?> getRefreshToken();
  Future<void> saveUserRole(String role);
  Future<String?> getUserRole();
  Future<void> deleteAll();
}

class SecureStorageServiceImpl implements SecureStorageService {
  final FlutterSecureStorage _storage;

  SecureStorageServiceImpl(this._storage);

  @override
  Future<void> saveTokens({
    required String access,
    required String refresh,
  }) async {
    await _storage.write(key: SecurityConfig.accessTokenKey, value: access);
    await _storage.write(key: SecurityConfig.refreshTokenKey, value: refresh);
  }

  @override
  Future<String?> getAccessToken() =>
      _storage.read(key: SecurityConfig.accessTokenKey);

  @override
  Future<String?> getRefreshToken() =>
      _storage.read(key: SecurityConfig.refreshTokenKey);

  @override
  Future<void> saveUserRole(String role) async {
    await _storage.write(key: SecurityConfig.userRoleKey, value: role);
  }

  @override
  Future<String?> getUserRole() =>
      _storage.read(key: SecurityConfig.userRoleKey);

  @override
  Future<void> deleteAll() => _storage.deleteAll();
}
