import '../repositories/my_restaurant_repository.dart';

/// Odebere zaměstnance ze seznamu personálu restaurace.
class RemoveEmployeeUseCase {
  final MyRestaurantRepository _repository;
  RemoveEmployeeUseCase(this._repository);

  Future<void> execute(int employeeId, {String? restaurantId}) =>
      _repository.removeEmployee(employeeId, restaurantId: restaurantId);
}
