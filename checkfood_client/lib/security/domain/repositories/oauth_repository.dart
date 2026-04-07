import '../entities/user.dart';

/// Abstraktní kontrakt pro přihlašování přes sociální sítě (OAuth2).
abstract class OAuthRepository {
  /// Provede flow přihlášení přes Google a vrátí doménovou entitu User.
  Future<User> loginWithGoogle();

  /// Provede flow přihlášení přes Apple a vrátí doménovou entitu User.
  Future<User> loginWithApple();
}
