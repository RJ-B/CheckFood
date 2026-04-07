import '../repositories/staff_reservation_repository.dart';

/// Marks a reservation as completed when the guests have finished their visit.
class CompleteReservationUseCase {
  final StaffReservationRepository _repository;

  CompleteReservationUseCase(this._repository);

  Future<void> call(String id) {
    return _repository.completeReservation(id);
  }
}
