import 'dart:typed_data';

import 'package:dio/dio.dart';
import '../../../../../security/config/security_endpoints.dart';
import '../models/menu_category_response_model.dart';
import '../models/menu_item_response_model.dart';
import '../models/onboarding_status_response_model.dart';
import '../models/panorama_photo_response_model.dart';
import '../models/panorama_session_response_model.dart';
import '../models/restaurant_response_model.dart';
import '../models/table_response_model.dart';

abstract class OnboardingRemoteDataSource {
  Future<OwnerRestaurantResponseModel> getMyRestaurant();
  Future<OwnerRestaurantResponseModel> updateInfo(Map<String, dynamic> data);
  Future<OwnerRestaurantResponseModel> updateHours(Map<String, dynamic> data);
  Future<List<TableResponseModel>> getTables();
  Future<TableResponseModel> addTable(Map<String, dynamic> data);
  Future<TableResponseModel> updateTable(String id, Map<String, dynamic> data);
  Future<void> deleteTable(String id);
  Future<List<OwnerMenuCategoryResponseModel>> getMenu();
  Future<OwnerMenuCategoryResponseModel> createCategory(Map<String, dynamic> data);
  Future<OwnerMenuCategoryResponseModel> updateCategory(String id, Map<String, dynamic> data);
  Future<void> deleteCategory(String id);
  Future<OwnerMenuItemResponseModel> createItem(String categoryId, Map<String, dynamic> data);
  Future<OwnerMenuItemResponseModel> updateItem(String id, Map<String, dynamic> data);
  Future<void> deleteItem(String id);
  Future<OnboardingStatusResponseModel> getOnboardingStatus();
  Future<OwnerRestaurantResponseModel> publish();
  Future<PanoramaSessionResponseModel> createPanoramaSession();
  Future<PanoramaPhotoResponseModel> uploadPhoto(String sessionId, int angleIndex, double actualAngle, Uint8List fileBytes, String filename);
  Future<PanoramaSessionResponseModel> finalizePanoramaSession(String sessionId);
  Future<PanoramaSessionResponseModel> getPanoramaSessionStatus(String sessionId);
  Future<List<PanoramaSessionResponseModel>> listPanoramaSessions();
  Future<void> activatePanorama(String sessionId);
}

class OnboardingRemoteDataSourceImpl implements OnboardingRemoteDataSource {
  final Dio _dio;

  OnboardingRemoteDataSourceImpl(this._dio);

  @override
  Future<OwnerRestaurantResponseModel> getMyRestaurant() async {
    final response = await _dio.get(SecurityEndpoints.ownerRestaurant);
    return OwnerRestaurantResponseModel.fromJson(response.data as Map<String, dynamic>);
  }

  @override
  Future<OwnerRestaurantResponseModel> updateInfo(Map<String, dynamic> data) async {
    final response = await _dio.put(SecurityEndpoints.ownerRestaurantInfo, data: data);
    return OwnerRestaurantResponseModel.fromJson(response.data as Map<String, dynamic>);
  }

  @override
  Future<OwnerRestaurantResponseModel> updateHours(Map<String, dynamic> data) async {
    final response = await _dio.put(SecurityEndpoints.ownerRestaurantHours, data: data);
    return OwnerRestaurantResponseModel.fromJson(response.data as Map<String, dynamic>);
  }

  @override
  Future<List<TableResponseModel>> getTables() async {
    final response = await _dio.get(SecurityEndpoints.ownerRestaurantTables);
    return (response.data as List)
        .map((json) => TableResponseModel.fromJson(json as Map<String, dynamic>))
        .toList();
  }

  @override
  Future<TableResponseModel> addTable(Map<String, dynamic> data) async {
    final response = await _dio.post(SecurityEndpoints.ownerRestaurantTables, data: data);
    return TableResponseModel.fromJson(response.data as Map<String, dynamic>);
  }

  @override
  Future<TableResponseModel> updateTable(String id, Map<String, dynamic> data) async {
    final response = await _dio.put(SecurityEndpoints.ownerRestaurantTable(id), data: data);
    return TableResponseModel.fromJson(response.data as Map<String, dynamic>);
  }

  @override
  Future<void> deleteTable(String id) async {
    await _dio.delete(SecurityEndpoints.ownerRestaurantTable(id));
  }

  @override
  Future<List<OwnerMenuCategoryResponseModel>> getMenu() async {
    final response = await _dio.get(SecurityEndpoints.ownerMenu);
    return (response.data as List)
        .map((json) => OwnerMenuCategoryResponseModel.fromJson(json as Map<String, dynamic>))
        .toList();
  }

  @override
  Future<OwnerMenuCategoryResponseModel> createCategory(Map<String, dynamic> data) async {
    final response = await _dio.post(SecurityEndpoints.ownerMenuCategories, data: data);
    return OwnerMenuCategoryResponseModel.fromJson(response.data as Map<String, dynamic>);
  }

  @override
  Future<OwnerMenuCategoryResponseModel> updateCategory(String id, Map<String, dynamic> data) async {
    final response = await _dio.put(SecurityEndpoints.ownerMenuCategory(id), data: data);
    return OwnerMenuCategoryResponseModel.fromJson(response.data as Map<String, dynamic>);
  }

  @override
  Future<void> deleteCategory(String id) async {
    await _dio.delete(SecurityEndpoints.ownerMenuCategory(id));
  }

  @override
  Future<OwnerMenuItemResponseModel> createItem(String categoryId, Map<String, dynamic> data) async {
    final response = await _dio.post(SecurityEndpoints.ownerMenuCategoryItems(categoryId), data: data);
    return OwnerMenuItemResponseModel.fromJson(response.data as Map<String, dynamic>);
  }

  @override
  Future<OwnerMenuItemResponseModel> updateItem(String id, Map<String, dynamic> data) async {
    final response = await _dio.put(SecurityEndpoints.ownerMenuItem(id), data: data);
    return OwnerMenuItemResponseModel.fromJson(response.data as Map<String, dynamic>);
  }

  @override
  Future<void> deleteItem(String id) async {
    await _dio.delete(SecurityEndpoints.ownerMenuItem(id));
  }

  @override
  Future<OnboardingStatusResponseModel> getOnboardingStatus() async {
    final response = await _dio.get(SecurityEndpoints.ownerOnboardingStatus);
    return OnboardingStatusResponseModel.fromJson(response.data as Map<String, dynamic>);
  }

  @override
  Future<OwnerRestaurantResponseModel> publish() async {
    final response = await _dio.post(SecurityEndpoints.ownerPublish);
    return OwnerRestaurantResponseModel.fromJson(response.data as Map<String, dynamic>);
  }

  @override
  Future<PanoramaSessionResponseModel> createPanoramaSession() async {
    final response = await _dio.post(SecurityEndpoints.ownerPanoramaSessions);
    return PanoramaSessionResponseModel.fromJson(response.data as Map<String, dynamic>);
  }

  @override
  Future<PanoramaPhotoResponseModel> uploadPhoto(
    String sessionId,
    int angleIndex,
    double actualAngle,
    Uint8List fileBytes,
    String filename,
  ) async {
    final formData = FormData.fromMap({
      'file': MultipartFile.fromBytes(fileBytes, filename: filename),
      'angleIndex': angleIndex,
      'actualAngle': actualAngle,
    });
    final response = await _dio.post(
      SecurityEndpoints.ownerPanoramaPhotos(sessionId),
      data: formData,
    );
    return PanoramaPhotoResponseModel.fromJson(response.data as Map<String, dynamic>);
  }

  @override
  Future<PanoramaSessionResponseModel> finalizePanoramaSession(String sessionId) async {
    final response = await _dio.post(SecurityEndpoints.ownerPanoramaFinalize(sessionId));
    return PanoramaSessionResponseModel.fromJson(response.data as Map<String, dynamic>);
  }

  @override
  Future<PanoramaSessionResponseModel> getPanoramaSessionStatus(String sessionId) async {
    final response = await _dio.get(SecurityEndpoints.ownerPanoramaSession(sessionId));
    return PanoramaSessionResponseModel.fromJson(response.data as Map<String, dynamic>);
  }

  @override
  Future<List<PanoramaSessionResponseModel>> listPanoramaSessions() async {
    final response = await _dio.get(SecurityEndpoints.ownerPanoramaSessions);
    return (response.data as List)
        .map((json) => PanoramaSessionResponseModel.fromJson(json as Map<String, dynamic>))
        .toList();
  }

  @override
  Future<void> activatePanorama(String sessionId) async {
    await _dio.post(SecurityEndpoints.ownerPanoramaActivate(sessionId));
  }
}
