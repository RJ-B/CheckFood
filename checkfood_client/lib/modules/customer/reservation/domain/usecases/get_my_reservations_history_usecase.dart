import '../entities/reservation.dart';
import '../repositories/reservation_repository.dart';

/// Načte celou historii rezervací přihlášeného uživatele.
class GetMyReservationsHistoryUseCase {
  final ReservationRepository _repository;

  GetMyReservationsHistoryUseCase(this._repository);

  Future<List<Reservation>> call() async {
    return await _repository.getMyReservationsHistory();
  }
}
