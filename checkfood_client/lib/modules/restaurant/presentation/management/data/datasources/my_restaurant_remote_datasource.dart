import 'package:dio/dio.dart';

import '../models/request/add_employee_request_model.dart';
import '../models/request/update_employee_role_request_model.dart';
import '../models/request/update_restaurant_request_model.dart';
import '../models/response/employee_response_model.dart';
import '../models/response/my_restaurant_response_model.dart';

/// Kontrakt remote data source pro endpointy správy restaurace majitelem.
abstract class MyRestaurantRemoteDataSource {
  Future<List<MyRestaurantResponseModel>> getMyRestaurants();
  Future<MyRestaurantResponseModel> getMyRestaurant({String? restaurantId});
  Future<MyRestaurantResponseModel> updateMyRestaurant(UpdateRestaurantRequestModel request, {String? restaurantId});
  Future<List<EmployeeResponseModel>> getEmployees({String? restaurantId});
  Future<EmployeeResponseModel> addEmployee(AddEmployeeRequestModel request, {String? restaurantId});
  Future<EmployeeResponseModel> updateEmployeeRole(int employeeId, UpdateEmployeeRoleRequestModel request, {String? restaurantId});
  Future<void> removeEmployee(int employeeId, {String? restaurantId});
  Future<List<String>> getEmployeePermissions(int employeeId, {String? restaurantId});
  Future<List<String>> updateEmployeePermissions(int employeeId, List<String> permissions, {String? restaurantId});
}

/// Implementace [MyRestaurantRemoteDataSource] využívající Dio.
class MyRestaurantRemoteDataSourceImpl implements MyRestaurantRemoteDataSource {
  final Dio _dio;
  static const String _baseUrl = '/my-restaurant';

  MyRestaurantRemoteDataSourceImpl(this._dio);

  String _url(String path, {String? restaurantId}) {
    if (restaurantId != null) {
      return '$path?restaurantId=$restaurantId';
    }
    return path;
  }

  @override
  Future<List<MyRestaurantResponseModel>> getMyRestaurants() async {
    final response = await _dio.get('$_baseUrl/list');
    return (response.data as List)
        .map((json) => MyRestaurantResponseModel.fromJson(json as Map<String, dynamic>))
        .toList();
  }

  @override
  Future<MyRestaurantResponseModel> getMyRestaurant({String? restaurantId}) async {
    final response = await _dio.get(_url(_baseUrl, restaurantId: restaurantId));
    return MyRestaurantResponseModel.fromJson(response.data as Map<String, dynamic>);
  }

  @override
  Future<MyRestaurantResponseModel> updateMyRestaurant(UpdateRestaurantRequestModel request, {String? restaurantId}) async {
    final response = await _dio.put(_url(_baseUrl, restaurantId: restaurantId), data: request.toJson());
    return MyRestaurantResponseModel.fromJson(response.data as Map<String, dynamic>);
  }

  @override
  Future<List<EmployeeResponseModel>> getEmployees({String? restaurantId}) async {
    final response = await _dio.get(_url('$_baseUrl/employees', restaurantId: restaurantId));
    return (response.data as List)
        .map((json) => EmployeeResponseModel.fromJson(json as Map<String, dynamic>))
        .toList();
  }

  @override
  Future<EmployeeResponseModel> addEmployee(AddEmployeeRequestModel request, {String? restaurantId}) async {
    final response = await _dio.post(_url('$_baseUrl/employees', restaurantId: restaurantId), data: request.toJson());
    return EmployeeResponseModel.fromJson(response.data as Map<String, dynamic>);
  }

  @override
  Future<EmployeeResponseModel> updateEmployeeRole(
      int employeeId, UpdateEmployeeRoleRequestModel request, {String? restaurantId}) async {
    final response = await _dio.put(_url('$_baseUrl/employees/$employeeId', restaurantId: restaurantId), data: request.toJson());
    return EmployeeResponseModel.fromJson(response.data as Map<String, dynamic>);
  }

  @override
  Future<void> removeEmployee(int employeeId, {String? restaurantId}) async {
    await _dio.delete(_url('$_baseUrl/employees/$employeeId', restaurantId: restaurantId));
  }

  @override
  Future<List<String>> getEmployeePermissions(int employeeId, {String? restaurantId}) async {
    final response = await _dio.get(
      _url('$_baseUrl/employees/$employeeId/permissions', restaurantId: restaurantId),
    );
    final data = response.data as Map<String, dynamic>;
    return (data['permissions'] as List<dynamic>).map((e) => e as String).toList();
  }

  @override
  Future<List<String>> updateEmployeePermissions(
      int employeeId, List<String> permissions, {String? restaurantId}) async {
    final response = await _dio.put(
      _url('$_baseUrl/employees/$employeeId/permissions', restaurantId: restaurantId),
      data: {'permissions': permissions},
    );
    final data = response.data as Map<String, dynamic>;
    return (data['permissions'] as List<dynamic>).map((e) => e as String).toList();
  }
}
