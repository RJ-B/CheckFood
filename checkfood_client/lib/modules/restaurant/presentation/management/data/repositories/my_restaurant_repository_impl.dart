import '../../domain/entities/employee.dart';
import '../../domain/entities/my_restaurant.dart';
import '../../domain/repositories/my_restaurant_repository.dart';
import '../datasources/my_restaurant_remote_datasource.dart';
import '../models/request/add_employee_request_model.dart';
import '../models/request/update_employee_role_request_model.dart';
import '../models/request/update_restaurant_request_model.dart';

/// Implementace repository delegující na [MyRestaurantRemoteDataSource]
/// a mapující response modely na doménové entity.
class MyRestaurantRepositoryImpl implements MyRestaurantRepository {
  final MyRestaurantRemoteDataSource _remoteDataSource;

  MyRestaurantRepositoryImpl(this._remoteDataSource);

  @override
  Future<List<MyRestaurant>> getMyRestaurants() async {
    final models = await _remoteDataSource.getMyRestaurants();
    return models.map((m) => m.toEntity()).toList();
  }

  @override
  Future<MyRestaurant> getMyRestaurant({String? restaurantId}) async {
    final model = await _remoteDataSource.getMyRestaurant(restaurantId: restaurantId);
    return model.toEntity();
  }

  @override
  Future<MyRestaurant> updateMyRestaurant(UpdateRestaurantRequestModel request, {String? restaurantId}) async {
    final model = await _remoteDataSource.updateMyRestaurant(request, restaurantId: restaurantId);
    return model.toEntity();
  }

  @override
  Future<List<Employee>> getEmployees({String? restaurantId}) async {
    final models = await _remoteDataSource.getEmployees(restaurantId: restaurantId);
    return models.map((m) => m.toEntity()).toList();
  }

  @override
  Future<Employee> addEmployee(AddEmployeeRequestModel request, {String? restaurantId}) async {
    final model = await _remoteDataSource.addEmployee(request, restaurantId: restaurantId);
    return model.toEntity();
  }

  @override
  Future<Employee> updateEmployeeRole(
      int employeeId, UpdateEmployeeRoleRequestModel request, {String? restaurantId}) async {
    final model = await _remoteDataSource.updateEmployeeRole(employeeId, request, restaurantId: restaurantId);
    return model.toEntity();
  }

  @override
  Future<void> removeEmployee(int employeeId, {String? restaurantId}) async {
    await _remoteDataSource.removeEmployee(employeeId, restaurantId: restaurantId);
  }

  @override
  Future<List<String>> getEmployeePermissions(int employeeId, {String? restaurantId}) {
    return _remoteDataSource.getEmployeePermissions(employeeId, restaurantId: restaurantId);
  }

  @override
  Future<List<String>> updateEmployeePermissions(int employeeId, List<String> permissions, {String? restaurantId}) {
    return _remoteDataSource.updateEmployeePermissions(employeeId, permissions, restaurantId: restaurantId);
  }
}
