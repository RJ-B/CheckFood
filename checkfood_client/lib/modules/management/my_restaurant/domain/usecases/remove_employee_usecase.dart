import '../repositories/my_restaurant_repository.dart';

/// Removes an employee from the restaurant's staff roster.
class RemoveEmployeeUseCase {
  final MyRestaurantRepository _repository;
  RemoveEmployeeUseCase(this._repository);

  Future<void> execute(int employeeId, {String? restaurantId}) =>
      _repository.removeEmployee(employeeId, restaurantId: restaurantId);
}
