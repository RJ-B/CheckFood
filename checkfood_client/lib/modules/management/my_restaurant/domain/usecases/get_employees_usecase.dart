import '../entities/employee.dart';
import '../repositories/my_restaurant_repository.dart';

/// Returns the full employee roster for the managed restaurant.
class GetEmployeesUseCase {
  final MyRestaurantRepository _repository;
  GetEmployeesUseCase(this._repository);

  Future<List<Employee>> execute({String? restaurantId}) =>
      _repository.getEmployees(restaurantId: restaurantId);
}
