import '../repositories/staff_reservation_repository.dart';

/// Rejects a reservation that is awaiting confirmation.
class RejectReservationUseCase {
  final StaffReservationRepository _repository;

  RejectReservationUseCase(this._repository);

  Future<void> call(String id) {
    return _repository.rejectReservation(id);
  }
}
