import '../../repositories/auth_repository.dart';

/// UseCase pro bezpečné ukončení relace uživatele.
///
/// Zajišťuje zneplatnění tokenů na straně serveru a následné
/// odstranění všech citlivých autentizačních dat z lokálního úložiště.
class LogoutUseCase {
  final AuthRepository _repository;

  LogoutUseCase(this._repository);

  /// Spustí proces odhlášení.
  Future<void> call() async {
    return await _repository.logout();
  }
}
