import '../entities/my_restaurant.dart';
import '../repositories/my_restaurant_repository.dart';

/// Načte plný management detail jedné restaurace vlastněné přihlášeným uživatelem.
class GetMyRestaurantUseCase {
  final MyRestaurantRepository _repository;
  GetMyRestaurantUseCase(this._repository);

  Future<MyRestaurant> execute({String? restaurantId}) =>
      _repository.getMyRestaurant(restaurantId: restaurantId);
}
