import '../entities/my_reservations_overview.dart';
import '../repositories/reservation_repository.dart';

class GetMyReservationsOverviewUseCase {
  final ReservationRepository _repository;

  GetMyReservationsOverviewUseCase(this._repository);

  Future<MyReservationsOverview> call() async {
    return await _repository.getMyReservationsOverview();
  }
}
