import 'dart:typed_data';

import 'package:dio/dio.dart';

import '../../config/security_endpoints.dart';

import '../models/profile/response/user_profile_response_model.dart';
import '../models/device/response/device_response_model.dart';
import '../models/profile/request/update_profile_request_model.dart';
import '../models/profile/request/change_password_request_model.dart';

/// Abstraktní kontrakt pro vzdálený zdroj dat profilu a správy zařízení.
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

  /// Odhlásí (deaktivuje) konkrétní zařízení (POST /api/user/devices/{id}/logout).
  Future<void> logoutDevice(int deviceId);

  /// Smaže konkrétní zařízení z DB (DELETE /api/user/devices/{id}).
  Future<void> deleteDevice(int deviceId);

  /// Smaže všechna zařízení kromě aktuálního (DELETE /api/user/devices/all).
  Future<void> deleteAllDevices();

  /// Aktualizuje preferenci notifikací pro zařízení (PUT /api/user/devices/notifications).
  Future<Map<String, dynamic>> updateNotificationPreference({
    required String deviceIdentifier,
    required bool notificationsEnabled,
    String? fcmToken,
  });

  /// Načte stav notifikací pro zařízení (GET /api/user/devices/notifications).
  Future<Map<String, dynamic>> getNotificationPreference({
    required String deviceIdentifier,
  });

  /// Nahraje profilovou fotku přes generický upload endpoint.
  /// Vrátí URL nahrané fotky.
  Future<String> uploadProfilePhoto(Uint8List imageBytes, String filename);

  /// Smaže soubor z úložiště podle relativní cesty.
  Future<void> deleteStorageFile(String path);

  /// Trvale smaže účet přihlášeného uživatele a všechna jeho data (DELETE /api/user/account).
  Future<void> deleteAccount();
}

/// Implementace [ProfileRemoteDataSource] komunikující s backendem přes [Dio].
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
    await _dio.post(SecurityEndpoints.logoutDevice(deviceId));
  }

  @override
  Future<void> deleteDevice(int deviceId) async {
    await _dio.delete(SecurityEndpoints.deleteDevice(deviceId));
  }

  @override
  Future<void> deleteAllDevices() async {
    await _dio.delete(SecurityEndpoints.deleteAllDevices);
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
    final url = data['url'] as String;
    return _resolveUrl(url);
  }

  /// Pokud backend vrátí relativní URL (lokální profil, začíná '/'), doplní base URL hostu.
  /// V produkci jsou URL absolutní (GCS), takže se vrátí nezměněné.
  String _resolveUrl(String url) {
    if (url.startsWith('http://') || url.startsWith('https://')) return url;
    // Relativní URL — doplníme origin z baseUrl Dia (odstraníme '/api' suffix)
    final baseUrl = _dio.options.baseUrl;
    final origin = baseUrl.endsWith('/api')
        ? baseUrl.substring(0, baseUrl.length - 4)
        : baseUrl.replaceAll(RegExp(r'/api/?$'), '');
    return '$origin$url';
  }

  @override
  Future<void> deleteStorageFile(String path) async {
    await _dio.delete(
      SecurityEndpoints.upload,
      queryParameters: {'path': path},
    );
  }

  @override
  Future<void> deleteAccount() async {
    await _dio.delete(SecurityEndpoints.deleteAccount);
  }
}
