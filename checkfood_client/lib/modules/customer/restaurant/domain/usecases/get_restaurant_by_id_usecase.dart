import '../entities/restaurant.dart';
import '../repositories/restaurant_repository.dart';

/// Načte úplný detail jedné restaurace podle jejího jedinečného identifikátoru.
class GetRestaurantByIdUseCase {
  final RestaurantRepository _repository;

  GetRestaurantByIdUseCase(this._repository);

  Future<Restaurant> call(String id) async {
    return await _repository.getRestaurantById(id);
  }
}
