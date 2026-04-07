import '../../data/models/request/add_employee_request_model.dart';
import '../../data/models/request/update_employee_role_request_model.dart';
import '../../data/models/request/update_restaurant_request_model.dart';

/// Base class for [MyRestaurantBloc] events.
abstract class MyRestaurantEvent {
  const MyRestaurantEvent();
}

class LoadMyRestaurant extends MyRestaurantEvent {
  const LoadMyRestaurant();
}

class SelectRestaurant extends MyRestaurantEvent {
  final String restaurantId;
  const SelectRestaurant(this.restaurantId);
}

class UpdateRestaurant extends MyRestaurantEvent {
  final UpdateRestaurantRequestModel request;
  const UpdateRestaurant(this.request);
}

class LoadEmployees extends MyRestaurantEvent {
  const LoadEmployees();
}

class AddEmployee extends MyRestaurantEvent {
  final AddEmployeeRequestModel request;
  const AddEmployee(this.request);
}

class UpdateEmployeeRole extends MyRestaurantEvent {
  final int employeeId;
  final UpdateEmployeeRoleRequestModel request;
  const UpdateEmployeeRole(this.employeeId, this.request);
}

class RemoveEmployee extends MyRestaurantEvent {
  final int employeeId;
  const RemoveEmployee(this.employeeId);
}

class UpdateEmployeePermissions extends MyRestaurantEvent {
  final int employeeId;
  final List<String> permissions;
  const UpdateEmployeePermissions(this.employeeId, this.permissions);
}
