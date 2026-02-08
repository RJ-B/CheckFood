import '../entities/auth_tokens.dart';
import '../entities/user.dart';
import '../../data/models/auth/request/login_request_model.dart';
import '../../data/models/auth/request/register_request_model.dart';
import '../../data/models/auth/request/verify_email_request_model.dart';
import '../../data/models/auth/request/refresh_token_request_model.dart';

abstract class AuthRepository {
  Future<AuthTokens> login(LoginRequestModel request);

  // Změna na void
  Future<void> register(RegisterRequestModel request);

  // Změna na void
  Future<void> verifyEmail(VerifyEmailRequestModel request);

  /// Znovu odešle verifikační kód na e-mail.
  Future<void> resendVerificationCode(String email);

  /// Odhlásí uživatele (server i local).
  Future<void> logout();

  /// Obnoví access token pomocí refresh tokenu.
  Future<AuthTokens> refreshToken(RefreshTokenRequestModel request);

  /// Vrátí aktuálně přihlášeného uživatele (z cache).
  Future<User?> getAuthenticatedUser();
}
