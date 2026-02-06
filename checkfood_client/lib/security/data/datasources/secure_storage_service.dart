// Příklad rozhraní pro váš SecureStorageService
abstract class SecureStorageService {
  Future<void> saveTokens({required String access, required String refresh});
  Future<String?> getAccessToken();
  Future<String?> getRefreshToken();
  Future<void> deleteAll();
}
