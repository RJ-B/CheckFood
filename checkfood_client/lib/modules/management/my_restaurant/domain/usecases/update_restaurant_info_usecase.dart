import '../../data/models/request/update_restaurant_request_model.dart';
import '../entities/my_restaurant.dart';
import '../repositories/my_restaurant_repository.dart';

class UpdateRestaurantInfoUseCase {
  final MyRestaurantRepository _repository;
  UpdateRestaurantInfoUseCase(this._repository);

  Future<MyRestaurant> execute(UpdateRestaurantRequestModel request) =>
      _repository.updateMyRestaurant(request);
}
