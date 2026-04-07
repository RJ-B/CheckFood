import '../entities/reservation.dart';
import '../repositories/reservation_repository.dart';

/// Accepts a staff-proposed change to the user's reservation.
class AcceptChangeRequestUseCase {
  final ReservationRepository _repository;
  AcceptChangeRequestUseCase(this._repository);

  Future<Reservation> call(String changeRequestId) {
    return _repository.acceptChangeRequest(changeRequestId);
  }
}
