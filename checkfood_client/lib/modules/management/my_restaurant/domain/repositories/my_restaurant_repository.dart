import '../../data/models/request/add_employee_request_model.dart';
import '../../data/models/request/update_employee_role_request_model.dart';
import '../../data/models/request/update_restaurant_request_model.dart';
import '../entities/employee.dart';
import '../entities/my_restaurant.dart';

/// Domain contract for managing a restaurant's info and employee roster.
abstract class MyRestaurantRepository {
  Future<List<MyRestaurant>> getMyRestaurants();
  Future<MyRestaurant> getMyRestaurant({String? restaurantId});
  Future<MyRestaurant> updateMyRestaurant(UpdateRestaurantRequestModel request, {String? restaurantId});
  Future<List<Employee>> getEmployees({String? restaurantId});
  Future<Employee> addEmployee(AddEmployeeRequestModel request, {String? restaurantId});
  Future<Employee> updateEmployeeRole(int employeeId, UpdateEmployeeRoleRequestModel request, {String? restaurantId});
  Future<void> removeEmployee(int employeeId, {String? restaurantId});
  Future<List<String>> getEmployeePermissions(int employeeId, {String? restaurantId});
  Future<List<String>> updateEmployeePermissions(int employeeId, List<String> permissions, {String? restaurantId});
}
