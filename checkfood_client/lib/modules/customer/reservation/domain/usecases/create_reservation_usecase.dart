import '../entities/reservation.dart';
import '../repositories/reservation_repository.dart';

/// Creates a new table reservation for the authenticated user.
class CreateReservationUseCase {
  final ReservationRepository _repository;

  CreateReservationUseCase(this._repository);

  Future<Reservation> call({
    required String restaurantId,
    required String tableId,
    required String date,
    required String startTime,
    int partySize = 2,
  }) async {
    return await _repository.createReservation(
      restaurantId: restaurantId,
      tableId: tableId,
      date: date,
      startTime: startTime,
      partySize: partySize,
    );
  }
}
