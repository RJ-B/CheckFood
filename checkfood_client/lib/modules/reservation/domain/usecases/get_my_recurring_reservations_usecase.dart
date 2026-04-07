import '../../domain/entities/recurring_reservation.dart';
import '../../domain/repositories/reservation_repository.dart';

/// Vrátí všechny aktivní opakované rezervace přihlášeného uživatele.
class GetMyRecurringReservationsUseCase {
  final ReservationRepository _repository;
  GetMyRecurringReservationsUseCase(this._repository);

  Future<List<RecurringReservation>> call() {
    return _repository.getMyRecurringReservations();
  }
}
