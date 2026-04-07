import '../entities/my_restaurant.dart';
import '../repositories/my_restaurant_repository.dart';

/// Fetches the full management detail of a single restaurant owned by the authenticated user.
class GetMyRestaurantUseCase {
  final MyRestaurantRepository _repository;
  GetMyRestaurantUseCase(this._repository);

  Future<MyRestaurant> execute({String? restaurantId}) =>
      _repository.getMyRestaurant(restaurantId: restaurantId);
}
