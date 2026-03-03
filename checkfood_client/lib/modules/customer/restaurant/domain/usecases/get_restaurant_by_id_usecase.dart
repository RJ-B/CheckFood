import '../entities/restaurant.dart';
import '../repositories/restaurant_repository.dart';

/**
 * Případ užití pro získání detailu restaurace na základě jejího unikátního identifikátoru.
 */
class GetRestaurantByIdUseCase {
  final RestaurantRepository _repository;

  GetRestaurantByIdUseCase(this._repository);

  /**
   * Vykoná byznys logiku pro získání detailu.
   * [id] představuje UUID restaurace v systému.
   */
  Future<Restaurant> call(String id) async {
    return await _repository.getRestaurantById(id);
  }
}
