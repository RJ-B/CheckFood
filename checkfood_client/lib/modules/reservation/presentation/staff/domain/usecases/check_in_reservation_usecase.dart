import '../repositories/staff_reservation_repository.dart';

/// Označí rezervaci jako check-in při příjezdu hostů.
class CheckInReservationUseCase {
  final StaffReservationRepository _repository;

  CheckInReservationUseCase(this._repository);

  Future<void> call(String id) {
    return _repository.checkInReservation(id);
  }
}
