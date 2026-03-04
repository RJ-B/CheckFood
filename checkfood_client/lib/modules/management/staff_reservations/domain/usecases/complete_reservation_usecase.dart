import '../repositories/staff_reservation_repository.dart';

class CompleteReservationUseCase {
  final StaffReservationRepository _repository;

  CompleteReservationUseCase(this._repository);

  Future<void> call(String id) {
    return _repository.completeReservation(id);
  }
}
