import '../../entities/user.dart';
import '../../repositories/auth_repository.dart';

/// Use Case pro získání aktuálně přihlášeného uživatele.
///
/// Využívá se především pro zjištění stavu autentizace a
/// přístup k základním údajům uživatele uloženým v paměti.
class GetAuthenticatedUserUseCase {
  final AuthRepository _repository;

  GetAuthenticatedUserUseCase(this._repository);

  /// Vrátí entitu [User], pokud je uživatel přihlášen, jinak null.
  Future<User?> call() async {
    return await _repository.getAuthenticatedUser();
  }
}
