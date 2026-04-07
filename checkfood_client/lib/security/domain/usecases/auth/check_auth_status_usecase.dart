import '../../entities/user.dart';
import '../../repositories/auth_repository.dart';

/// UseCase pro ověření stavu přihlášení při startu aplikace.
///
/// Vrací [User] pokud je uživatel přihlášen a token platný, jinak `null`.
/// Nikdy nevyhazuje výjimku — chyby jsou tiše potlačeny.
class CheckAuthStatusUseCase {
  final AuthRepository _repository;

  CheckAuthStatusUseCase(this._repository);

  /// Zkontroluje stav přihlášení a vrátí přihlášeného uživatele, nebo `null`.
  Future<User?> call() async {
    try {
      return await _repository.getAuthenticatedUser();
    } catch (_) {
      return null;
    }
  }
}
