import '../../entities/user.dart';
import '../../repositories/oauth_repository.dart';

/// UseCase pro autentizaci uživatele prostřednictvím Google OAuth2.
/// Zapouzdřuje volání repozitáře a umožňuje snadné testování byznys logiky.
class LoginWithGoogleUseCase {
  final OAuthRepository _repository;

  LoginWithGoogleUseCase(this._repository);

  /// Vyvolá proces přihlášení.
  /// Vrací doménovou entitu [User].
  /// Vyhazuje výjimku v případě zrušení uživatelem nebo chyby sítě/verifikace.
  Future<User> call() async {
    try {
      return await _repository.loginWithGoogle();
    } catch (e) {
      rethrow;
    }
  }
}
