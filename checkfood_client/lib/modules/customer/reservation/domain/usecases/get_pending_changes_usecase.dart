import '../entities/pending_change.dart';
import '../repositories/reservation_repository.dart';

/// Returns all pending change proposals for the authenticated user's reservations.
class GetPendingChangesUseCase {
  final ReservationRepository _repository;
  GetPendingChangesUseCase(this._repository);

  Future<List<PendingChange>> call() {
    return _repository.getPendingChanges();
  }
}
