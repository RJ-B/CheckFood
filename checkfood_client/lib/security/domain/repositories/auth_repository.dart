import '../entities/auth_tokens.dart';
import '../entities/user.dart';
import '../usecases/auth/params/auth_params.dart';

abstract class AuthRepository {
  /// Přihlášení uživatele pomocí doménových parametrů.
  Future<AuthTokens> login(LoginParams params);

  /// Registrace nového uživatele pomocí doménových parametrů.
  Future<void> register(RegisterParams params);

  /// Registrace majitele restaurace (role OWNER).
  Future<void> registerOwner(RegisterParams params);

  /// Verifikace emailu pouze pomocí tokenu (jednoduchý String).
  Future<void> verifyEmail(String token);

  /// Znovuodeslání verifikačního kódu.
  Future<void> resendVerificationCode(String email);

  /// Odhlášení (lokální i vzdálené).
  Future<void> logout();

  /// Obnovení tokenu (parametry si repozitář bere interně ze storage).
  Future<AuthTokens> refreshToken();

  /// Získání aktuálně přihlášeného uživatele z paměti nebo cache.
  Future<User?> getAuthenticatedUser();
}
