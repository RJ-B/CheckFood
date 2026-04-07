import '../repositories/staff_reservation_repository.dart';

/// Confirms a pending reservation, moving it to CONFIRMED status.
class ConfirmReservationUseCase {
  final StaffReservationRepository _repository;

  ConfirmReservationUseCase(this._repository);

  Future<void> call(String id) {
    return _repository.confirmReservation(id);
  }
}
