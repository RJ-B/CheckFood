import '../repositories/my_restaurant_repository.dart';

class RemoveEmployeeUseCase {
  final MyRestaurantRepository _repository;
  RemoveEmployeeUseCase(this._repository);

  Future<void> execute(int employeeId) => _repository.removeEmployee(employeeId);
}
