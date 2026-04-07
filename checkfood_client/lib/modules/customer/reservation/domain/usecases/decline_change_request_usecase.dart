import '../entities/reservation.dart';
import '../repositories/reservation_repository.dart';

/// Declines a staff-proposed change to the user's reservation.
class DeclineChangeRequestUseCase {
  final ReservationRepository _repository;
  DeclineChangeRequestUseCase(this._repository);

  Future<Reservation> call(String changeRequestId) {
    return _repository.declineChangeRequest(changeRequestId);
  }
}
