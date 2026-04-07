import '../../data/models/request/update_restaurant_request_model.dart';
import '../entities/my_restaurant.dart';
import '../repositories/my_restaurant_repository.dart';

/// Updates the restaurant's editable info (name, description, opening hours, etc.).
class UpdateRestaurantInfoUseCase {
  final MyRestaurantRepository _repository;
  UpdateRestaurantInfoUseCase(this._repository);

  Future<MyRestaurant> execute(UpdateRestaurantRequestModel request, {String? restaurantId}) =>
      _repository.updateMyRestaurant(request, restaurantId: restaurantId);
}
