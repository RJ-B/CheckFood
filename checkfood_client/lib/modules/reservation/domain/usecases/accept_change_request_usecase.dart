import '../entities/reservation.dart';
import '../repositories/reservation_repository.dart';

/// Přijme změnu rezervace navrženou personálem.
class AcceptChangeRequestUseCase {
  final ReservationRepository _repository;
  AcceptChangeRequestUseCase(this._repository);

  Future<Reservation> call(String changeRequestId) {
    return _repository.acceptChangeRequest(changeRequestId);
  }
}
