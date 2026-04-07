import '../../domain/entities/recurring_reservation.dart';
import '../../domain/repositories/reservation_repository.dart';

/// Creates a weekly recurring reservation for the authenticated user.
class CreateRecurringReservationUseCase {
  final ReservationRepository _repository;
  CreateRecurringReservationUseCase(this._repository);

  Future<RecurringReservation> call({
    required String restaurantId,
    required String tableId,
    required String dayOfWeek,
    required String startTime,
    required int partySize,
  }) {
    return _repository.createRecurringReservation(
      restaurantId: restaurantId,
      tableId: tableId,
      dayOfWeek: dayOfWeek,
      startTime: startTime,
      partySize: partySize,
    );
  }
}
