import '../entities/reservation.dart';
import '../repositories/reservation_repository.dart';

/// Updates the time, table, or party size of an existing reservation.
class UpdateReservationUseCase {
  final ReservationRepository _repository;

  UpdateReservationUseCase(this._repository);

  Future<Reservation> call({
    required String reservationId,
    required String tableId,
    required String date,
    required String startTime,
    int partySize = 2,
  }) async {
    return await _repository.updateReservation(
      reservationId: reservationId,
      tableId: tableId,
      date: date,
      startTime: startTime,
      partySize: partySize,
    );
  }
}
