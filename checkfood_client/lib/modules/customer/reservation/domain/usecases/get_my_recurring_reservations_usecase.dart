import '../../domain/entities/recurring_reservation.dart';
import '../../domain/repositories/reservation_repository.dart';

/// Returns all active recurring reservations for the authenticated user.
class GetMyRecurringReservationsUseCase {
  final ReservationRepository _repository;
  GetMyRecurringReservationsUseCase(this._repository);

  Future<List<RecurringReservation>> call() {
    return _repository.getMyRecurringReservations();
  }
}
