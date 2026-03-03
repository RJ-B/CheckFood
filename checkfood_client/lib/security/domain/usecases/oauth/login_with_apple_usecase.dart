import '../../entities/user.dart';
import '../../repositories/oauth_repository.dart';

/// UseCase pro autentizaci uživatele prostřednictvím Apple ID.
/// Zapouzdřuje volání repozitáře a umožňuje snadné testování byznys logiky.
class LoginWithAppleUseCase {
  final OAuthRepository _repository;

  LoginWithAppleUseCase(this._repository);

  /// Vyvolá proces přihlášení přes Apple.
  /// Vrací doménovou entitu [User].
  /// Vyhazuje výjimku v případě zrušení uživatelem nebo chyby sítě/verifikace.
  Future<User> call() async {
    try {
      return await _repository.loginWithApple();
    } catch (e) {
      rethrow;
    }
  }
}
