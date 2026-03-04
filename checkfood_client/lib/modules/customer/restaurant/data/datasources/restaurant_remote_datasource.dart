import 'package:dio/dio.dart';

import '../models/request/map_params_model.dart';
import '../models/request/restaurant_request_model.dart';
import '../models/request/restaurant_table_request_model.dart';
import '../models/response/restaurant_marker_response_model.dart';
import '../models/response/restaurant_response_model.dart';
import '../models/response/restaurant_table_response_model.dart';

/// Kontrakt pro dálkový datový zdroj modulu restaurací.
abstract class RestaurantRemoteDataSource {
  // --- NOVÉ OPTIMALIZOVANÉ ENDPOINTY (PostGIS) ---

  /// Získá lehké markery (nebo shluky) pro zobrazení na mapě.
  /// ✅ OPRAVENO: Signatura nyní odpovídá implementaci a přijímá MapParamsModel.
  Future<List<RestaurantMarkerResponseModel>> getMarkers(MapParamsModel params);

  /// Získá seznam nejbližších restaurací seřazený podle vzdálenosti (stránkovaný).
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

  // --- STANDARDNÍ CRUD ENDPOINTY ---

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

  // --- SPRÁVA STOLŮ ---

  Future<RestaurantTableResponseModel> addTable(
    String restaurantId,
    RestaurantTableRequestModel request,
  );

  Future<List<RestaurantTableResponseModel>> getTables(String restaurantId);
}

/// Implementace využívající Dio pro REST komunikaci.
class RestaurantRemoteDataSourceImpl implements RestaurantRemoteDataSource {
  final Dio _dio;

  // Base URL navazuje na globální nastavení Dio (obvykle /api)
  static const String _baseUrl = '/v1/restaurants';

  RestaurantRemoteDataSourceImpl(this._dio);

  @override
  Future<List<RestaurantMarkerResponseModel>> getMarkers(
    MapParamsModel params,
  ) async {
    final response = await _dio.get(
      '$_baseUrl/markers',
      queryParameters:
          params.toQueryParameters(), // ✅ Čisté předání parametrů skrze model
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
}
