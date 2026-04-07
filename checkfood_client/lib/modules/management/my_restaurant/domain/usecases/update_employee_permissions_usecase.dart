import '../repositories/my_restaurant_repository.dart';

/// Updates the granular permissions granted to a specific employee.
class UpdateEmployeePermissionsUseCase {
  final MyRestaurantRepository _repository;

  UpdateEmployeePermissionsUseCase(this._repository);

  Future<List<String>> execute(int employeeId, List<String> permissions, {String? restaurantId}) {
    return _repository.updateEmployeePermissions(employeeId, permissions, restaurantId: restaurantId);
  }
}
