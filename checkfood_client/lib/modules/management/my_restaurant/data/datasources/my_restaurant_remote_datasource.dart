import 'package:dio/dio.dart';

import '../models/request/add_employee_request_model.dart';
import '../models/request/update_employee_role_request_model.dart';
import '../models/request/update_restaurant_request_model.dart';
import '../models/response/employee_response_model.dart';
import '../models/response/my_restaurant_response_model.dart';

abstract class MyRestaurantRemoteDataSource {
  Future<MyRestaurantResponseModel> getMyRestaurant();
  Future<MyRestaurantResponseModel> updateMyRestaurant(UpdateRestaurantRequestModel request);
  Future<List<EmployeeResponseModel>> getEmployees();
  Future<EmployeeResponseModel> addEmployee(AddEmployeeRequestModel request);
  Future<EmployeeResponseModel> updateEmployeeRole(int employeeId, UpdateEmployeeRoleRequestModel request);
  Future<void> removeEmployee(int employeeId);
}

class MyRestaurantRemoteDataSourceImpl implements MyRestaurantRemoteDataSource {
  final Dio _dio;
  // Dio baseUrl already includes /api, so paths must NOT repeat it.
  static const String _baseUrl = '/my-restaurant';

  MyRestaurantRemoteDataSourceImpl(this._dio);

  @override
  Future<MyRestaurantResponseModel> getMyRestaurant() async {
    final response = await _dio.get(_baseUrl);
    return MyRestaurantResponseModel.fromJson(response.data as Map<String, dynamic>);
  }

  @override
  Future<MyRestaurantResponseModel> updateMyRestaurant(UpdateRestaurantRequestModel request) async {
    final response = await _dio.put(_baseUrl, data: request.toJson());
    return MyRestaurantResponseModel.fromJson(response.data as Map<String, dynamic>);
  }

  @override
  Future<List<EmployeeResponseModel>> getEmployees() async {
    final response = await _dio.get('$_baseUrl/employees');
    return (response.data as List)
        .map((json) => EmployeeResponseModel.fromJson(json as Map<String, dynamic>))
        .toList();
  }

  @override
  Future<EmployeeResponseModel> addEmployee(AddEmployeeRequestModel request) async {
    final response = await _dio.post('$_baseUrl/employees', data: request.toJson());
    return EmployeeResponseModel.fromJson(response.data as Map<String, dynamic>);
  }

  @override
  Future<EmployeeResponseModel> updateEmployeeRole(
      int employeeId, UpdateEmployeeRoleRequestModel request) async {
    final response = await _dio.put('$_baseUrl/employees/$employeeId', data: request.toJson());
    return EmployeeResponseModel.fromJson(response.data as Map<String, dynamic>);
  }

  @override
  Future<void> removeEmployee(int employeeId) async {
    await _dio.delete('$_baseUrl/employees/$employeeId');
  }
}
