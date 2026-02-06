import 'package:dio/dio.dart';
import '../../domain/entities/user_profile.dart';
import '../../domain/entities/device.dart';
import '../../domain/repositories/profile_repository.dart';
import '../datasources/profile_remote_data_source.dart';
import '../models/profile/request/update_profile_request_model.dart';
import '../models/profile/request/change_password_request_model.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  final ProfileRemoteDataSource _remoteDataSource;
  ProfileRepositoryImpl(this._remoteDataSource);

  @override
  Future<UserProfile> getUserProfile() async {
    try {
      final model = await _remoteDataSource.getUserProfile();
      return model.toEntity();
    } on DioException catch (e) {
      _handleDioException(e);
      rethrow;
    }
  }

  @override
  Future<UserProfile> updateProfile(UpdateProfileRequestModel request) async {
    try {
      // Žádné ruční vytváření modelu, používáme ten z parametru
      final model = await _remoteDataSource.updateProfile(request);
      return model.toEntity();
    } on DioException catch (e) {
      _handleDioException(e);
      rethrow;
    }
  }

  @override
  Future<void> changePassword(ChangePasswordRequestModel request) async {
    try {
      // Žádné ruční vytváření modelu, používáme ten z parametru
      await _remoteDataSource.changePassword(request);
    } on DioException catch (e) {
      _handleDioException(e);
      rethrow;
    }
  }

  @override
  Future<List<Device>> getActiveDevices() async {
    try {
      final models = await _remoteDataSource.getDevices();
      return models.map((model) => model.toEntity()).toList();
    } on DioException catch (e) {
      _handleDioException(e);
      rethrow;
    }
  }

  @override
  Future<void> logoutDevice(String deviceId) async {
    try {
      await _remoteDataSource.logoutDevice(deviceId);
    } on DioException catch (e) {
      _handleDioException(e);
      rethrow;
    }
  }

  @override
  Future<void> logoutAllDevices() async {
    try {
      await _remoteDataSource.logoutAllDevices();
    } on DioException catch (e) {
      _handleDioException(e);
      rethrow;
    }
  }

  // --- Helper metody pro sjednocené ošetření chyb ---

  void _handleDioException(DioException e) {
    if (e.type == DioExceptionType.connectionTimeout ||
        e.type == DioExceptionType.receiveTimeout) {
      throw 'Server neodpovídá. Zkontrolujte připojení k internetu.';
    }

    final serverMessage = _extractServerMessage(e);
    throw serverMessage ?? 'Došlo k chybě při správě profilu.';
  }

  String? _extractServerMessage(DioException e) {
    try {
      if (e.response?.data != null && e.response?.data is Map) {
        final data = e.response!.data as Map<String, dynamic>;
        return data['message'] ?? data['detail'] ?? data['error'];
      }
    } catch (_) {}
    return null;
  }
}
