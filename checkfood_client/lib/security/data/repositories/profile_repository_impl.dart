import 'dart:async';
import 'dart:typed_data';
import 'package:dio/dio.dart';

import '../../config/security_json_keys.dart';
import '../../domain/entities/user_profile.dart';
import '../../domain/entities/device.dart';
import '../../domain/repositories/profile_repository.dart';
import '../../exceptions/auth_exceptions.dart';
import '../datasources/profile_remote_data_source.dart';
import '../models/profile/request/update_profile_request_model.dart';
import '../models/profile/request/change_password_request_model.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  final ProfileRemoteDataSource _remoteDataSource;

  ProfileRepositoryImpl({
    required ProfileRemoteDataSource remoteDataSource,
  }) : _remoteDataSource = remoteDataSource;

  @override
  Future<UserProfile> getUserProfile() async {
    try {
      final model = await _remoteDataSource.getUserProfile();
      return model.toEntity();
    } on DioException catch (e) {
      throw _handleDioException(e);
    }
  }

  @override
  Future<UserProfile> updateProfile(UpdateProfileRequestModel request) async {
    try {
      final model = await _remoteDataSource.updateProfile(request);
      return model.toEntity();
    } on DioException catch (e) {
      throw _handleDioException(e);
    }
  }

  @override
  Future<void> changePassword(ChangePasswordRequestModel request) async {
    try {
      await _remoteDataSource.changePassword(request);
    } on DioException catch (e) {
      throw _handleDioException(e);
    }
  }

  @override
  Future<List<Device>> getActiveDevices() async {
    try {
      final models = await _remoteDataSource.getDevices();
      return models.map((m) => m.toEntity()).toList();
    } on DioException catch (e) {
      throw _handleDioException(e);
    }
  }

  @override
  Future<void> logoutDevice(int deviceId) async {
    try {
      await _remoteDataSource.logoutDevice(deviceId);
    } on DioException catch (e) {
      throw _handleDioException(e);
    }
  }

  @override
  Future<void> logoutAllDevices() async {
    try {
      await _remoteDataSource.logoutAllDevices();
    } on DioException catch (e) {
      throw _handleDioException(e);
    }
  }

  @override
  Future<Map<String, dynamic>> updateNotificationPreference({
    required String deviceIdentifier,
    required bool notificationsEnabled,
    String? fcmToken,
  }) async {
    try {
      return await _remoteDataSource.updateNotificationPreference(
        deviceIdentifier: deviceIdentifier,
        notificationsEnabled: notificationsEnabled,
        fcmToken: fcmToken,
      );
    } on DioException catch (e) {
      throw _handleDioException(e);
    }
  }

  @override
  Future<Map<String, dynamic>> getNotificationPreference({
    required String deviceIdentifier,
  }) async {
    try {
      return await _remoteDataSource.getNotificationPreference(
        deviceIdentifier: deviceIdentifier,
      );
    } on DioException catch (e) {
      throw _handleDioException(e);
    }
  }

  @override
  Future<String> uploadProfilePhoto(Uint8List imageBytes, String filename) async {
    try {
      return await _remoteDataSource.uploadProfilePhoto(imageBytes, filename);
    } on DioException catch (e) {
      throw _handleDioException(e);
    }
  }

  // --- Helper metody ---

  SecurityException _handleDioException(DioException e) {
    if (e.type == DioExceptionType.connectionTimeout ||
        e.type == DioExceptionType.connectionError) {
      return const AuthServerException('Server je nedostupný.');
    }

    final statusCode = e.response?.statusCode;
    String? serverMessage;
    if (e.response?.data is Map) {
      serverMessage =
          (e.response!.data as Map<String, dynamic>)[SecurityJsonKeys.message];
    }

    switch (statusCode) {
      case 400:
        return AuthServerException(serverMessage ?? 'Neplatný požadavek.');
      case 401:
        return const AuthServerException(
          'Relace vypršela. Přihlaste se znovu.',
        );
      case 403:
        return const AuthServerException('Nemáte oprávnění k této akci.');
      case 404:
        return AuthServerException(serverMessage ?? 'Záznam nebyl nalezen.');
      default:
        return AuthServerException(
          serverMessage ?? 'Chyba komunikace se serverem.',
        );
    }
  }
}
