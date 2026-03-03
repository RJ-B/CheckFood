import '../../data/models/request/add_employee_request_model.dart';
import '../../data/models/request/update_employee_role_request_model.dart';
import '../../data/models/request/update_restaurant_request_model.dart';
import '../entities/employee.dart';
import '../entities/my_restaurant.dart';

abstract class MyRestaurantRepository {
  Future<MyRestaurant> getMyRestaurant();
  Future<MyRestaurant> updateMyRestaurant(UpdateRestaurantRequestModel request);
  Future<List<Employee>> getEmployees();
  Future<Employee> addEmployee(AddEmployeeRequestModel request);
  Future<Employee> updateEmployeeRole(int employeeId, UpdateEmployeeRoleRequestModel request);
  Future<void> removeEmployee(int employeeId);
}
