import '../../data/models/request/add_employee_request_model.dart';
import '../entities/employee.dart';
import '../repositories/my_restaurant_repository.dart';

/// Adds a new employee to the restaurant's staff roster.
class AddEmployeeUseCase {
  final MyRestaurantRepository _repository;
  AddEmployeeUseCase(this._repository);

  Future<Employee> execute(AddEmployeeRequestModel request, {String? restaurantId}) =>
      _repository.addEmployee(request, restaurantId: restaurantId);
}
