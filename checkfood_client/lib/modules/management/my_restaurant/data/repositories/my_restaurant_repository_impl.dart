import '../../domain/entities/employee.dart';
import '../../domain/entities/my_restaurant.dart';
import '../../domain/repositories/my_restaurant_repository.dart';
import '../datasources/my_restaurant_remote_datasource.dart';
import '../models/request/add_employee_request_model.dart';
import '../models/request/update_employee_role_request_model.dart';
import '../models/request/update_restaurant_request_model.dart';

class MyRestaurantRepositoryImpl implements MyRestaurantRepository {
  final MyRestaurantRemoteDataSource _remoteDataSource;

  MyRestaurantRepositoryImpl(this._remoteDataSource);

  @override
  Future<MyRestaurant> getMyRestaurant() async {
    final model = await _remoteDataSource.getMyRestaurant();
    return model.toEntity();
  }

  @override
  Future<MyRestaurant> updateMyRestaurant(UpdateRestaurantRequestModel request) async {
    final model = await _remoteDataSource.updateMyRestaurant(request);
    return model.toEntity();
  }

  @override
  Future<List<Employee>> getEmployees() async {
    final models = await _remoteDataSource.getEmployees();
    return models.map((m) => m.toEntity()).toList();
  }

  @override
  Future<Employee> addEmployee(AddEmployeeRequestModel request) async {
    final model = await _remoteDataSource.addEmployee(request);
    return model.toEntity();
  }

  @override
  Future<Employee> updateEmployeeRole(
      int employeeId, UpdateEmployeeRoleRequestModel request) async {
    final model = await _remoteDataSource.updateEmployeeRole(employeeId, request);
    return model.toEntity();
  }

  @override
  Future<void> removeEmployee(int employeeId) async {
    await _remoteDataSource.removeEmployee(employeeId);
  }
}
