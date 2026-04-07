import '../entities/table_status.dart';
import '../repositories/reservation_repository.dart';

/// Fetches the availability status of all tables for a given restaurant and date.
class GetTableStatusesUseCase {
  final ReservationRepository _repository;

  GetTableStatusesUseCase(this._repository);

  Future<TableStatusList> call(String restaurantId, String date) async {
    return await _repository.getTableStatuses(restaurantId, date);
  }
}
