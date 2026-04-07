import '../repositories/staff_reservation_repository.dart';

/// Marks a reservation as checked-in when the guests arrive.
class CheckInReservationUseCase {
  final StaffReservationRepository _repository;

  CheckInReservationUseCase(this._repository);

  Future<void> call(String id) {
    return _repository.checkInReservation(id);
  }
}
