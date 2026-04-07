import '../entities/my_restaurant.dart';
import '../repositories/my_restaurant_repository.dart';

/// Returns all restaurants owned by the authenticated user.
class GetMyRestaurantsUseCase {
  final MyRestaurantRepository _repository;
  GetMyRestaurantsUseCase(this._repository);

  Future<List<MyRestaurant>> execute() => _repository.getMyRestaurants();
}
