import '../entities/staff_table.dart';
import '../repositories/staff_reservation_repository.dart';

/// Returns all tables for the managed restaurant.
class GetRestaurantTablesUseCase {
  final StaffReservationRepository _repository;
  GetRestaurantTablesUseCase(this._repository);

  Future<List<StaffTable>> call({String? restaurantId}) => _repository.getRestaurantTables(restaurantId: restaurantId);
}
