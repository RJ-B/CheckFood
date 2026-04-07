import '../../data/models/request/update_employee_role_request_model.dart';
import '../entities/employee.dart';
import '../repositories/my_restaurant_repository.dart';

/// Změní roli existujícího zaměstnance (např. STAFF → MANAGER).
class UpdateEmployeeRoleUseCase {
  final MyRestaurantRepository _repository;
  UpdateEmployeeRoleUseCase(this._repository);

  Future<Employee> execute(int employeeId, UpdateEmployeeRoleRequestModel request, {String? restaurantId}) =>
      _repository.updateEmployeeRole(employeeId, request, restaurantId: restaurantId);
}
