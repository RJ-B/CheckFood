import '../entities/my_reservations_overview.dart';
import '../repositories/reservation_repository.dart';

/// Fetches a combined view of the user's upcoming and past reservations.
class GetMyReservationsOverviewUseCase {
  final ReservationRepository _repository;

  GetMyReservationsOverviewUseCase(this._repository);

  Future<MyReservationsOverview> call() async {
    return await _repository.getMyReservationsOverview();
  }
}
