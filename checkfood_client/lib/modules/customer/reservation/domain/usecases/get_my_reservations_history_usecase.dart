import '../entities/reservation.dart';
import '../repositories/reservation_repository.dart';

/// Fetches the full reservation history for the authenticated user.
class GetMyReservationsHistoryUseCase {
  final ReservationRepository _repository;

  GetMyReservationsHistoryUseCase(this._repository);

  Future<List<Reservation>> call() async {
    return await _repository.getMyReservationsHistory();
  }
}
