import '../repositories/staff_reservation_repository.dart';

class ConfirmReservationUseCase {
  final StaffReservationRepository _repository;

  ConfirmReservationUseCase(this._repository);

  Future<void> call(String id) {
    return _repository.confirmReservation(id);
  }
}
