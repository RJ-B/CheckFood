import '../../entities/user.dart';
import '../../repositories/auth_repository.dart';

/// UseCase pro získání aktuálně přihlášeného uživatele z cache.
///
/// Slouží k rychlému ověření identity přihlášeného uživatele
/// bez nutnosti provádět síťový požadavek.
class GetAuthenticatedUserUseCase {
  final AuthRepository _repository;

  GetAuthenticatedUserUseCase(this._repository);

  /// Vrátí entitu [User], pokud je uživatel přihlášen, jinak null.
  Future<User?> call() async {
    return await _repository.getAuthenticatedUser();
  }
}
