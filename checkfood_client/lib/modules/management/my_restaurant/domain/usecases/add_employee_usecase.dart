import '../../data/models/request/add_employee_request_model.dart';
import '../entities/employee.dart';
import '../repositories/my_restaurant_repository.dart';

/// Přidá nového zaměstnance do seznamu personálu restaurace.
class AddEmployeeUseCase {
  final MyRestaurantRepository _repository;
  AddEmployeeUseCase(this._repository);

  Future<Employee> execute(AddEmployeeRequestModel request, {String? restaurantId}) =>
      _repository.addEmployee(request, restaurantId: restaurantId);
}
