import '../entities/pending_change.dart';
import '../repositories/reservation_repository.dart';

/// Vrátí všechny čekající návrhy změn rezervací přihlášeného uživatele.
class GetPendingChangesUseCase {
  final ReservationRepository _repository;
  GetPendingChangesUseCase(this._repository);

  Future<List<PendingChange>> call() {
    return _repository.getPendingChanges();
  }
}
