import '../entities/my_restaurant.dart';
import '../repositories/my_restaurant_repository.dart';

class GetMyRestaurantUseCase {
  final MyRestaurantRepository _repository;
  GetMyRestaurantUseCase(this._repository);

  Future<MyRestaurant> execute() => _repository.getMyRestaurant();
}
