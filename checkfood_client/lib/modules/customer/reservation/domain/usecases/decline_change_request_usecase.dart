import '../entities/reservation.dart';
import '../repositories/reservation_repository.dart';

/// Odmítne změnu rezervace navrženou personálem.
class DeclineChangeRequestUseCase {
  final ReservationRepository _repository;
  DeclineChangeRequestUseCase(this._repository);

  Future<Reservation> call(String changeRequestId) {
    return _repository.declineChangeRequest(changeRequestId);
  }
}
