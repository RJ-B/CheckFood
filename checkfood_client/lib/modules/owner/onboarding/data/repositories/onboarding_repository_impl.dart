import 'dart:typed_data';

import '../../domain/entities/onboarding_menu_category.dart';
import '../../domain/entities/onboarding_menu_item.dart';
import '../../domain/entities/onboarding_status.dart';
import '../../domain/entities/onboarding_table.dart';
import '../../domain/entities/panorama_photo.dart';
import '../../domain/entities/panorama_session.dart';
import '../../domain/repositories/onboarding_repository.dart';
import '../datasources/onboarding_remote_datasource.dart';
import '../models/address_model.dart';
import '../models/opening_hours_model.dart';
import '../models/restaurant_response_model.dart';

class OnboardingRepositoryImpl implements OnboardingRepository {
  final OnboardingRemoteDataSource _remoteDataSource;

  OnboardingRepositoryImpl(this._remoteDataSource);

  @override
  Future<OwnerRestaurantResponseModel> getMyRestaurant() =>
      _remoteDataSource.getMyRestaurant();

  @override
  Future<OwnerRestaurantResponseModel> updateInfo({
    required String name,
    String? description,
    String? phone,
    String? email,
    AddressModel? address,
    String? cuisineType,
  }) {
    final data = <String, dynamic>{
      'name': name,
      if (description != null) 'description': description,
      if (phone != null) 'phone': phone,
      if (email != null) 'email': email,
      if (address != null) 'address': address.toJson(),
      if (cuisineType != null) 'cuisineType': cuisineType,
    };
    return _remoteDataSource.updateInfo(data);
  }

  @override
  Future<OwnerRestaurantResponseModel> updateHours(List<OpeningHoursModel> hours) {
    final data = {
      'openingHours': hours.map((h) => h.toJson()).toList(),
    };
    return _remoteDataSource.updateHours(data);
  }

  @override
  Future<List<OnboardingTable>> getTables() async {
    final models = await _remoteDataSource.getTables();
    return models.map((m) => m.toEntity()).toList();
  }

  @override
  Future<OnboardingTable> addTable({
    required String label,
    required int capacity,
    bool active = true,
  }) async {
    final model = await _remoteDataSource.addTable({
      'label': label,
      'capacity': capacity,
      'active': active,
    });
    return model.toEntity();
  }

  @override
  Future<OnboardingTable> updateTable(
    String id, {
    required String label,
    required int capacity,
    bool active = true,
    double? yaw,
    double? pitch,
  }) async {
    final model = await _remoteDataSource.updateTable(id, {
      'label': label,
      'capacity': capacity,
      'active': active,
      if (yaw != null) 'yaw': yaw,
      if (pitch != null) 'pitch': pitch,
    });
    return model.toEntity();
  }

  @override
  Future<void> deleteTable(String id) => _remoteDataSource.deleteTable(id);

  @override
  Future<List<OnboardingMenuCategory>> getMenu() async {
    final models = await _remoteDataSource.getMenu();
    return models.map((m) => m.toEntity()).toList();
  }

  @override
  Future<OnboardingMenuCategory> createCategory({
    required String name,
    int sortOrder = 0,
  }) async {
    final model = await _remoteDataSource.createCategory({
      'name': name,
      'sortOrder': sortOrder,
    });
    return model.toEntity();
  }

  @override
  Future<OnboardingMenuCategory> updateCategory(
    String id, {
    required String name,
    int sortOrder = 0,
  }) async {
    final model = await _remoteDataSource.updateCategory(id, {
      'name': name,
      'sortOrder': sortOrder,
    });
    return model.toEntity();
  }

  @override
  Future<void> deleteCategory(String id) => _remoteDataSource.deleteCategory(id);

  @override
  Future<OnboardingMenuItem> createItem(
    String categoryId, {
    required String name,
    String? description,
    int priceMinor = 0,
    String currency = 'CZK',
    String? imageUrl,
    bool available = true,
    int sortOrder = 0,
  }) async {
    final model = await _remoteDataSource.createItem(categoryId, {
      'name': name,
      if (description != null) 'description': description,
      'priceMinor': priceMinor,
      'currency': currency,
      if (imageUrl != null) 'imageUrl': imageUrl,
      'available': available,
      'sortOrder': sortOrder,
    });
    return model.toEntity();
  }

  @override
  Future<OnboardingMenuItem> updateItem(
    String id, {
    required String name,
    String? description,
    int priceMinor = 0,
    String currency = 'CZK',
    String? imageUrl,
    bool available = true,
    int sortOrder = 0,
  }) async {
    final model = await _remoteDataSource.updateItem(id, {
      'name': name,
      if (description != null) 'description': description,
      'priceMinor': priceMinor,
      'currency': currency,
      if (imageUrl != null) 'imageUrl': imageUrl,
      'available': available,
      'sortOrder': sortOrder,
    });
    return model.toEntity();
  }

  @override
  Future<void> deleteItem(String id) => _remoteDataSource.deleteItem(id);

  @override
  Future<OnboardingStatus> getOnboardingStatus() async {
    final model = await _remoteDataSource.getOnboardingStatus();
    return model.toEntity();
  }

  @override
  Future<OwnerRestaurantResponseModel> publish() => _remoteDataSource.publish();

  @override
  Future<PanoramaSession> createPanoramaSession() async {
    final model = await _remoteDataSource.createPanoramaSession();
    return model.toEntity();
  }

  @override
  Future<PanoramaPhoto> uploadPhoto(
    String sessionId,
    int angleIndex,
    double actualAngle,
    Uint8List fileBytes,
    String filename,
  ) async {
    final model = await _remoteDataSource.uploadPhoto(
      sessionId, angleIndex, actualAngle, fileBytes, filename,
    );
    return model.toEntity();
  }

  @override
  Future<PanoramaSession> finalizePanoramaSession(String sessionId) async {
    final model = await _remoteDataSource.finalizePanoramaSession(sessionId);
    return model.toEntity();
  }

  @override
  Future<PanoramaSession> getPanoramaSessionStatus(String sessionId) async {
    final model = await _remoteDataSource.getPanoramaSessionStatus(sessionId);
    return model.toEntity();
  }

  @override
  Future<List<PanoramaSession>> listPanoramaSessions() async {
    final models = await _remoteDataSource.listPanoramaSessions();
    return models.map((m) => m.toEntity()).toList();
  }

  @override
  Future<void> activatePanorama(String sessionId) =>
      _remoteDataSource.activatePanorama(sessionId);
}
