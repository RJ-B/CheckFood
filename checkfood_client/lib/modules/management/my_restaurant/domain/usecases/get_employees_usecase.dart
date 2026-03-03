import '../entities/employee.dart';
import '../repositories/my_restaurant_repository.dart';

class GetEmployeesUseCase {
  final MyRestaurantRepository _repository;
  GetEmployeesUseCase(this._repository);

  Future<List<Employee>> execute() => _repository.getEmployees();
}
