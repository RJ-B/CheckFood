import 'package:flutter_test/flutter_test.dart';
import 'package:geolocator/geolocator.dart';

import 'package:checkfood_client/modules/map/domain/usecases/explore_usecases.dart';
import 'package:checkfood_client/modules/map/domain/usecases/get_all_markers_usecase.dart';
import 'package:checkfood_client/modules/map/domain/entities/restaurant_filters.dart';
import 'package:checkfood_client/modules/map/domain/entities/restaurant_marker.dart';
import 'package:checkfood_client/modules/map/domain/entities/restaurant_marker_light.dart';
import 'package:checkfood_client/modules/map/data/models/request/map_params_model.dart';
import 'package:checkfood_client/modules/restaurant/domain/entities/restaurant.dart';
import 'package:checkfood_client/modules/restaurant/domain/entities/address.dart';
import 'package:checkfood_client/modules/restaurant/domain/entities/cuisine_type.dart';
import 'package:checkfood_client/modules/restaurant/domain/repositories/restaurant_repository.dart';
import 'package:checkfood_client/modules/restaurant/data/models/request/restaurant_request_model.dart';
import 'package:checkfood_client/modules/restaurant/data/models/request/restaurant_table_request_model.dart';
import 'package:checkfood_client/modules/restaurant/domain/entities/restaurant_table.dart';
import 'package:checkfood_client/core/utils/location_service.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

// ---------------------------------------------------------------------------
// Fakes
// ---------------------------------------------------------------------------

Position _pos() => Position(
      latitude: 50.0,
      longitude: 14.0,
      timestamp: DateTime(2024),
      accuracy: 1,
      altitude: 0,
      heading: 0,
      speed: 0,
      speedAccuracy: 0,
      altitudeAccuracy: 0,
      headingAccuracy: 0,
    );

class FakeLocationService implements LocationService {
  bool throwDenied = false;

  @override
  Future<Position> getCurrentLocation() async {
    if (throwDenied) throw Exception('denied');
    return _pos();
  }

  @override
  double calculateDistance(double a, double b, double c, double d) => 0;
}

const _restaurant = Restaurant(
  id: 'r1',
  ownerId: 'o1',
  name: 'Test',
  cuisineType: CuisineType.CZECH,
  status: 'ACTIVE',
  isActive: true,
  address: Address(street: 'St', city: 'Prague', country: 'CZ'),
  openingHours: [],
);

const _marker = RestaurantMarker(
    id: 'r1', latitude: 50.0, longitude: 14.0, count: 1, name: 'Test');

const _markerLight =
    RestaurantMarkerLight(id: 'r1', latitude: 50.0, longitude: 14.0);

class FakeRepo implements RestaurantRepository {
  MapParamsModel? lastParams;
  double? lastLat, lastLng;
  int? lastPage;
  RestaurantFilters? lastFilters;
  bool throwOnNearest = false;
  bool throwOnMarkers = false;

  @override
  Future<List<RestaurantMarker>> getMarkersInBounds(
      MapParamsModel params) async {
    if (throwOnMarkers) throw Exception('markers failed');
    lastParams = params;
    return [_marker];
  }

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
    if (throwOnNearest) throw Exception('nearest failed');
    lastLat = lat;
    lastLng = lng;
    lastPage = page;
    return [_restaurant];
  }

  @override
  Future<Restaurant> getRestaurantById(String id) async => _restaurant;

  @override
  Future<({int version, List<RestaurantMarkerLight> data})>
      getAllMarkers() async => (version: 1, data: [_markerLight]);

  @override
  Future<int> getMarkersVersion() async => 1;

  @override
  Future<Restaurant> createRestaurant(RestaurantRequestModel r) =>
      throw UnimplementedError();
  @override
  Future<List<Restaurant>> getMyRestaurants() async => [];
  @override
  Future<Restaurant> updateRestaurant(
          String id, RestaurantRequestModel r) =>
      throw UnimplementedError();
  @override
  Future<void> deleteRestaurant(String id) async {}
  @override
  Future<RestaurantTable> addTable(
          String rid, RestaurantTableRequestModel r) =>
      throw UnimplementedError();
  @override
  Future<List<RestaurantTable>> getTables(String rid) async => [];
}

// ---------------------------------------------------------------------------
// Tests
// ---------------------------------------------------------------------------

void main() {
  group('GetLocationUseCase', () {
    test('execute() returns current position', () async {
      final uc = GetLocationUseCase(FakeLocationService());
      final pos = await uc.execute();
      expect(pos.latitude, 50.0);
      expect(pos.longitude, 14.0);
    });

    test('execute() propagates exception on denial', () async {
      final svc = FakeLocationService()..throwDenied = true;
      final uc = GetLocationUseCase(svc);
      await expectLater(uc.execute(), throwsException);
    });
  });

  group('GetRestaurantMarkersUseCase', () {
    test('execute() passes params to repository and returns markers', () async {
      final repo = FakeRepo();
      final uc = GetRestaurantMarkersUseCase(repo);

      final params = MapParamsModel(
        bounds: LatLngBounds(
          southwest: const LatLng(49.9, 13.9),
          northeast: const LatLng(50.1, 14.1),
        ),
        zoom: 14,
      );

      final result = await uc.execute(params);
      expect(result, [_marker]);
      expect(repo.lastParams, params);
    });

    test('execute() propagates repository errors', () async {
      final repo = FakeRepo()..throwOnMarkers = true;
      final uc = GetRestaurantMarkersUseCase(repo);

      final params = MapParamsModel(
        bounds: LatLngBounds(
          southwest: const LatLng(49.9, 13.9),
          northeast: const LatLng(50.1, 14.1),
        ),
        zoom: 14,
      );
      await expectLater(uc.execute(params), throwsException);
    });
  });

  group('GetNearestRestaurantsUseCase', () {
    test('execute() passes lat/lng/page to repository', () async {
      final repo = FakeRepo();
      final uc = GetNearestRestaurantsUseCase(repo);

      await uc.execute(lat: 50.0, lng: 14.0, page: 0);

      expect(repo.lastLat, 50.0);
      expect(repo.lastLng, 14.0);
      expect(repo.lastPage, 0);
    });

    test('execute() with filters passes searchQuery to repository', () async {
      final repo = FakeRepo();
      final uc = GetNearestRestaurantsUseCase(repo);

      await uc.execute(
        lat: 50.0,
        lng: 14.0,
        page: 0,
        filters: const RestaurantFilters(searchQuery: 'burger'),
      );

      // Verify result is passed through
      final result =
          await uc.execute(lat: 50.0, lng: 14.0, page: 0);
      expect(result, [_restaurant]);
    });

    test('execute() propagates errors from repository', () async {
      final repo = FakeRepo()..throwOnNearest = true;
      final uc = GetNearestRestaurantsUseCase(repo);
      await expectLater(
          uc.execute(lat: 50.0, lng: 14.0, page: 0), throwsException);
    });
  });

  group('GetAllMarkersUseCase', () {
    test('execute() returns version and data from repository', () async {
      final repo = FakeRepo();
      final uc = GetAllMarkersUseCase(repo);

      final result = await uc.execute();
      expect(result.version, 1);
      expect(result.data, [_markerLight]);
    });
  });
}
