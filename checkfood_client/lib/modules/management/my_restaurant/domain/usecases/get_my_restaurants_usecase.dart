import '../entities/my_restaurant.dart';
import '../repositories/my_restaurant_repository.dart';

/// Vrátí všechny restaurace vlastněné přihlášeným uživatelem.
class GetMyRestaurantsUseCase {
  final MyRestaurantRepository _repository;
  GetMyRestaurantsUseCase(this._repository);

  Future<List<MyRestaurant>> execute() => _repository.getMyRestaurants();
}
