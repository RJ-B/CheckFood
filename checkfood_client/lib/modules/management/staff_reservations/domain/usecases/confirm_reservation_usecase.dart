import '../repositories/staff_reservation_repository.dart';

/// Potvrdí čekající rezervaci a přesune ji do stavu CONFIRMED.
class ConfirmReservationUseCase {
  final StaffReservationRepository _repository;

  ConfirmReservationUseCase(this._repository);

  Future<void> call(String id) {
    return _repository.confirmReservation(id);
  }
}
