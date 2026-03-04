import '../repositories/staff_reservation_repository.dart';

class CheckInReservationUseCase {
  final StaffReservationRepository _repository;

  CheckInReservationUseCase(this._repository);

  Future<void> call(String id) {
    return _repository.checkInReservation(id);
  }
}
