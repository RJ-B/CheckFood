import 'dart:typed_data';

import 'package:dio/dio.dart';

import '../../config/security_endpoints.dart';

// Importy Response Modelů
import '../models/profile/response/user_profile_response_model.dart';
import '../models/device/response/device_response_model.dart';

// Importy Request Modelů
import '../models/profile/request/update_profile_request_model.dart';
import '../models/profile/request/change_password_request_model.dart';

abstract class ProfileRemoteDataSource {
  /// Načte profil uživatele (GET /api/user/me).
  Future<UserProfileResponseModel> getUserProfile();

  Future<UserProfileResponseModel> updateProfile(
    UpdateProfileRequestModel request,
  );

  Future<void> changePassword(ChangePasswordRequestModel request);

  /// Načte samostatný seznam zařízení (GET /api/user/devices).
  Future<List<DeviceResponseModel>> getDevices();

  Future<void> logoutAllDevices();

  /// Odhlásí konkrétní zařízení (DELETE /api/user/devices/{id}).
  Future<void> logoutDevice(int deviceId);

  /// Aktualizuje preferenci notifikaci pro zarizeni (PUT /api/user/devices/notifications).
  Future<Map<String, dynamic>> updateNotificationPreference({
    required String deviceIdentifier,
    required bool notificationsEnabled,
    String? fcmToken,
  });

  /// Nacte stav notifikaci pro zarizeni (GET /api/user/devices/notifications).
  Future<Map<String, dynamic>> getNotificationPreference({
    required String deviceIdentifier,
  });

  /// Uploaduje profilovou fotku pres generic upload endpoint.
  /// Vraci URL uploadovane fotky.
  Future<String> uploadProfilePhoto(Uint8List imageBytes, String filename);
}

class ProfileRemoteDataSourceImpl implements ProfileRemoteDataSource {
  final Dio _dio;

  ProfileRemoteDataSourceImpl(this._dio);

  @override
  Future<UserProfileResponseModel> getUserProfile() async {
    final response = await _dio.get(SecurityEndpoints.profileMe);
    return UserProfileResponseModel.fromJson(response.data);
  }

  @override
  Future<UserProfileResponseModel> updateProfile(
    UpdateProfileRequestModel request,
  ) async {
    final response = await _dio.patch(
      SecurityEndpoints.updateProfile,
      data: request.toJson(),
    );
    return UserProfileResponseModel.fromJson(response.data);
  }

  @override
  Future<void> changePassword(ChangePasswordRequestModel request) async {
    await _dio.post(
      SecurityEndpoints.changePassword,
      data: request.toJson(),
    );
  }

  @override
  Future<List<DeviceResponseModel>> getDevices() async {
    final response = await _dio.get(SecurityEndpoints.devices);

    return (response.data as List)
        .map((device) => DeviceResponseModel.fromJson(device))
        .toList();
  }

  @override
  Future<void> logoutAllDevices() async {
    await _dio.post(SecurityEndpoints.logoutAllDevices);
  }

  @override
  Future<void> logoutDevice(int deviceId) async {
    await _dio.delete(SecurityEndpoints.logoutDevice(deviceId));
  }

  @override
  Future<Map<String, dynamic>> updateNotificationPreference({
    required String deviceIdentifier,
    required bool notificationsEnabled,
    String? fcmToken,
  }) async {
    final response = await _dio.put(
      SecurityEndpoints.notificationPreference,
      data: {
        'deviceIdentifier': deviceIdentifier,
        'notificationsEnabled': notificationsEnabled,
        if (fcmToken != null) 'fcmToken': fcmToken,
      },
    );
    return response.data as Map<String, dynamic>;
  }

  @override
  Future<Map<String, dynamic>> getNotificationPreference({
    required String deviceIdentifier,
  }) async {
    final response = await _dio.get(
      SecurityEndpoints.notificationPreference,
      queryParameters: {'deviceIdentifier': deviceIdentifier},
    );
    return response.data as Map<String, dynamic>;
  }

  @override
  Future<String> uploadProfilePhoto(Uint8List imageBytes, String filename) async {
    final formData = FormData.fromMap({
      'file': MultipartFile.fromBytes(imageBytes, filename: filename),
      'directory': 'profile',
    });
    final response = await _dio.post(
      SecurityEndpoints.upload,
      data: formData,
    );
    final data = response.data as Map<String, dynamic>;
    return data['url'] as String;
  }
}
