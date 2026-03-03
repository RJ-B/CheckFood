import '../../entities/user.dart';
import '../../repositories/auth_repository.dart';

class CheckAuthStatusUseCase {
  final AuthRepository _repository;

  CheckAuthStatusUseCase(this._repository);

  /// Zkontroluje stav přihlášení voláním repozitáře.
  /// Vrací [User], pokud je uživatel přihlášen a má platný token.
  /// Jinak vrací [null].
  Future<User?> call() async {
    try {
      return await _repository.getAuthenticatedUser();
    } catch (_) {
      return null;
    }
  }
}
