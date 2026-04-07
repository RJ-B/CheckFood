import '../../domain/entities/recurring_reservation.dart';
import '../../domain/repositories/reservation_repository.dart';

/// Zruší aktivní sérii opakované rezervace podle jejího ID.
class CancelRecurringReservationUseCase {
  final ReservationRepository _repository;
  CancelRecurringReservationUseCase(this._repository);

  Future<RecurringReservation> call(String id) {
    return _repository.cancelRecurringReservation(id);
  }
}
