import '../../domain/entities/restaurant.dart';
import '../../domain/entities/restaurant_marker.dart';
import '../../domain/entities/restaurant_table.dart';
import '../../domain/repositories/restaurant_repository.dart';
import '../datasources/restaurant_remote_datasource.dart';
import '../models/request/map_params_model.dart'; // ✅ Přidán import modelu
import '../models/request/restaurant_request_model.dart';
import '../models/request/restaurant_table_request_model.dart';

/// Implementace repozitáře pro modul restaurací.
/// Propojuje doménovou vrstvu s dálkovým datovým zdrojem (API).
class RestaurantRepositoryImpl implements RestaurantRepository {
  final RestaurantRemoteDataSource _remoteDataSource;

  RestaurantRepositoryImpl(this._remoteDataSource);

  // ✅ OPRAVENO: Použití MapParamsModel pro konzistenci s interface
  @override
  Future<List<RestaurantMarker>> getMarkersInBounds(
    MapParamsModel params,
  ) async {
    // Předáváme celý model do data source [cite: 2026-01-25]
    final models = await _remoteDataSource.getMarkers(params);

    // Mapování modelů (Data) na entity (Domain)
    return models.map((m) => m.toEntity()).toList();
  }

  // ✅ KONZISTENTNÍ IMPLEMENTACE: Get Nearest (Seznam pod mapou)
  @override
  Future<List<Restaurant>> getNearestRestaurants({
    required double lat,
    required double lng,
    required int page,
    required int size,
    String? searchQuery,
    List<String>? cuisineTypes,
    double? minRating,
    bool? openNow,
    bool? favouritesOnly,
  }) async {
    final models = await _remoteDataSource.getNearestRestaurants(
      lat: lat,
      lng: lng,
      page: page,
      size: size,
      searchQuery: searchQuery,
      cuisineTypes: cuisineTypes,
      minRating: minRating,
      openNow: openNow,
      favouritesOnly: favouritesOnly,
    );
    return models.map((m) => m.toEntity()).toList();
  }

  // --- SPRÁVA RESTAURACÍ ---

  @override
  Future<Restaurant> getRestaurantById(String id) async {
    final model = await _remoteDataSource.getRestaurantById(id);
    return model.toEntity();
  }

  @override
  Future<Restaurant> createRestaurant(RestaurantRequestModel request) async {
    final model = await _remoteDataSource.createRestaurant(request);
    return model.toEntity();
  }

  @override
  Future<List<Restaurant>> getMyRestaurants() async {
    final models = await _remoteDataSource.getMyRestaurants();
    return models.map((m) => m.toEntity()).toList();
  }

  @override
  Future<Restaurant> updateRestaurant(
    String id,
    RestaurantRequestModel request,
  ) async {
    final model = await _remoteDataSource.updateRestaurant(id, request);
    return model.toEntity();
  }

  @override
  Future<void> deleteRestaurant(String id) async {
    await _remoteDataSource.deleteRestaurant(id);
  }

  // --- SPRÁVA STOLŮ ---

  @override
  Future<RestaurantTable> addTable(
    String restaurantId,
    RestaurantTableRequestModel request,
  ) async {
    final model = await _remoteDataSource.addTable(restaurantId, request);
    return model.toEntity();
  }

  @override
  Future<List<RestaurantTable>> getTables(String restaurantId) async {
    final models = await _remoteDataSource.getTables(restaurantId);
    return models.map((m) => m.toEntity()).toList();
  }
}
