import '../entities/restaurant.dart';
import '../repositories/restaurant_repository.dart';

/// Fetches the full detail of a single restaurant by its unique identifier.
class GetRestaurantByIdUseCase {
  final RestaurantRepository _repository;

  GetRestaurantByIdUseCase(this._repository);

  Future<Restaurant> call(String id) async {
    return await _repository.getRestaurantById(id);
  }
}
