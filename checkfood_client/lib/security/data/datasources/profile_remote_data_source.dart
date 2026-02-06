import 'package:dio/dio.dart';

// Importy Response Modelů
import '../models/profile/response/user_profile_response_model.dart';
import '../models/device/response/device_response_model.dart';

// Importy Request Modelů
import '../models/profile/request/update_profile_request_model.dart';
import '../models/profile/request/change_password_request_model.dart';

abstract class ProfileRemoteDataSource {
  Future<UserProfileResponseModel> getUserProfile();

  Future<UserProfileResponseModel> updateProfile(
    UpdateProfileRequestModel request,
  );

  Future<void> changePassword(ChangePasswordRequestModel request);

  Future<List<DeviceResponseModel>> getDevices();

  Future<void> logoutAllDevices();

  Future<void> logoutDevice(String deviceId);
}

class ProfileRemoteDataSourceImpl implements ProfileRemoteDataSource {
  final Dio _dio;

  // Definice base cesty pro Profile modul.
  // Všechny endpointy pro správu uživatele začínají tímto prefixem.
  static const String _userPath = '/api/user';

  ProfileRemoteDataSourceImpl(this._dio);

  @override
  Future<UserProfileResponseModel> getUserProfile() async {
    final response = await _dio.get('$_userPath/me');
    return UserProfileResponseModel.fromJson(response.data);
  }

  @override
  Future<UserProfileResponseModel> updateProfile(
    UpdateProfileRequestModel request,
  ) async {
    // Používáme PATCH pro částečnou úpravu profilu
    final response = await _dio.patch(
      '$_userPath/profile',
      data: request.toJson(),
    );
    return UserProfileResponseModel.fromJson(response.data);
  }

  @override
  Future<void> changePassword(ChangePasswordRequestModel request) async {
    await _dio.post('$_userPath/change-password', data: request.toJson());
  }

  @override
  Future<List<DeviceResponseModel>> getDevices() async {
    final response = await _dio.get('$_userPath/devices');

    // Mapování seznamu zařízení z JSON pole
    return (response.data as List)
        .map((device) => DeviceResponseModel.fromJson(device))
        .toList();
  }

  @override
  Future<void> logoutAllDevices() async {
    await _dio.post('$_userPath/logout-all');
  }

  @override
  Future<void> logoutDevice(String deviceId) async {
    // Dynamické doplnění ID do URL cesty
    await _dio.delete('$_userPath/devices/$deviceId');
  }
}
