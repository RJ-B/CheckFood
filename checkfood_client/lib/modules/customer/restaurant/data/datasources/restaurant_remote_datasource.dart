import 'package:dio/dio.dart';

import '../models/request/map_params_model.dart';
import '../models/request/restaurant_request_model.dart';
import '../models/request/restaurant_table_request_model.dart';
import '../models/response/all_markers_response_model.dart';
import '../models/response/restaurant_marker_response_model.dart';
import '../models/response/restaurant_response_model.dart';
import '../models/response/restaurant_table_response_model.dart';

/// Kontrakt remote data source pro modul restaurací.
abstract class RestaurantRemoteDataSource {
  /// Vrátí markery nebo clustery viditelné v zadaném výřezu mapy.
  Future<List<RestaurantMarkerResponseModel>> getMarkers(MapParamsModel params);

  /// Stáhne úplný snapshot lehkých markerů pro klientské clusterování.
  Future<AllMarkersResponseModel> getAllMarkers();

  /// Vrátí aktuální verzi snapshotu markerů na straně serveru.
  Future<int> getMarkersVersion();

  /// Vrátí stránkovaný seznam restaurací seřazených podle vzdálenosti od zadaných souřadnic.
  Future<List<RestaurantResponseModel>> getNearestRestaurants({
    required double lat,
    required double lng,
    required int page,
    required int size,
    String? searchQuery,
    List<String>? cuisineTypes,
    double? minRating,
    bool? openNow,
    bool? favouritesOnly,
  });

  Future<RestaurantResponseModel> getRestaurantById(String id);

  Future<RestaurantResponseModel> createRestaurant(
    RestaurantRequestModel request,
  );

  Future<List<RestaurantResponseModel>> getMyRestaurants();

  Future<RestaurantResponseModel> updateRestaurant(
    String id,
    RestaurantRequestModel request,
  );

  Future<void> deleteRestaurant(String id);

  Future<RestaurantTableResponseModel> addTable(
    String restaurantId,
    RestaurantTableRequestModel request,
  );

  Future<List<RestaurantTableResponseModel>> getTables(String restaurantId);
}

/// Implementace [RestaurantRemoteDataSource] využívající Dio.
class RestaurantRemoteDataSourceImpl implements RestaurantRemoteDataSource {
  final Dio _dio;

  static const String _baseUrl = '/v1/restaurants';

  RestaurantRemoteDataSourceImpl(this._dio);

  @override
  Future<List<RestaurantMarkerResponseModel>> getMarkers(
    MapParamsModel params,
  ) async {
    final response = await _dio.get(
      '$_baseUrl/markers',
      queryParameters: params.toQueryParameters(),
    );

    return (response.data as List)
        .map(
          (json) => RestaurantMarkerResponseModel.fromJson(
            json as Map<String, dynamic>,
          ),
        )
        .toList();
  }

  @override
  Future<List<RestaurantResponseModel>> getNearestRestaurants({
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
    final queryParams = <String, dynamic>{
      'lat': lat,
      'lng': lng,
      'page': page,
      'size': size,
    };
    if (searchQuery != null && searchQuery.isNotEmpty) {
      queryParams['q'] = searchQuery;
    }
    if (cuisineTypes != null && cuisineTypes.isNotEmpty) {
      queryParams['cuisineTypes'] = cuisineTypes;
    }
    if (minRating != null) {
      queryParams['minRating'] = minRating;
    }
    if (openNow == true) {
      queryParams['openNow'] = true;
    }
    if (favouritesOnly == true) {
      queryParams['favouritesOnly'] = true;
    }

    final response = await _dio.get(
      '$_baseUrl/nearest',
      queryParameters: queryParams,
    );

    return (response.data as List)
        .map(
          (json) =>
              RestaurantResponseModel.fromJson(json as Map<String, dynamic>),
        )
        .toList();
  }

  @override
  Future<RestaurantResponseModel> getRestaurantById(String id) async {
    final response = await _dio.get('$_baseUrl/$id');
    return RestaurantResponseModel.fromJson(
      response.data as Map<String, dynamic>,
    );
  }

  @override
  Future<RestaurantResponseModel> createRestaurant(
    RestaurantRequestModel request,
  ) async {
    final response = await _dio.post(_baseUrl, data: request.toJson());
    return RestaurantResponseModel.fromJson(
      response.data as Map<String, dynamic>,
    );
  }

  @override
  Future<List<RestaurantResponseModel>> getMyRestaurants() async {
    final response = await _dio.get('$_baseUrl/me');
    return (response.data as List)
        .map(
          (json) =>
              RestaurantResponseModel.fromJson(json as Map<String, dynamic>),
        )
        .toList();
  }

  @override
  Future<RestaurantResponseModel> updateRestaurant(
    String id,
    RestaurantRequestModel request,
  ) async {
    final response = await _dio.put('$_baseUrl/$id', data: request.toJson());
    return RestaurantResponseModel.fromJson(
      response.data as Map<String, dynamic>,
    );
  }

  @override
  Future<void> deleteRestaurant(String id) async {
    await _dio.delete('$_baseUrl/$id');
  }

  @override
  Future<RestaurantTableResponseModel> addTable(
    String restaurantId,
    RestaurantTableRequestModel request,
  ) async {
    final response = await _dio.post(
      '$_baseUrl/$restaurantId/tables',
      data: request.toJson(),
    );
    return RestaurantTableResponseModel.fromJson(
      response.data as Map<String, dynamic>,
    );
  }

  @override
  Future<List<RestaurantTableResponseModel>> getTables(
    String restaurantId,
  ) async {
    final response = await _dio.get('$_baseUrl/$restaurantId/tables');
    return (response.data as List)
        .map(
          (json) => RestaurantTableResponseModel.fromJson(
            json as Map<String, dynamic>,
          ),
        )
        .toList();
  }

  @override
  Future<AllMarkersResponseModel> getAllMarkers() async {
    final response = await _dio.get('$_baseUrl/all-markers');
    return AllMarkersResponseModel.fromJson(
      response.data as Map<String, dynamic>,
    );
  }

  @override
  Future<int> getMarkersVersion() async {
    final response = await _dio.get('$_baseUrl/markers-version');
    return response.data['version'] as int;
  }
}
