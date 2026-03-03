import '../../data/models/request/add_employee_request_model.dart';
import '../entities/employee.dart';
import '../repositories/my_restaurant_repository.dart';

class AddEmployeeUseCase {
  final MyRestaurantRepository _repository;
  AddEmployeeUseCase(this._repository);

  Future<Employee> execute(AddEmployeeRequestModel request) =>
      _repository.addEmployee(request);
}
