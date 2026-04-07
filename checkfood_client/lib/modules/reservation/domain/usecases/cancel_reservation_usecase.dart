import '../entities/reservation.dart';
import '../repositories/reservation_repository.dart';

/// Zruší existující rezervaci podle jejího ID.
class CancelReservationUseCase {
  final ReservationRepository _repository;

  CancelReservationUseCase(this._repository);

  Future<Reservation> call(String reservationId) async {
    return await _repository.cancelReservation(reservationId);
  }
}
