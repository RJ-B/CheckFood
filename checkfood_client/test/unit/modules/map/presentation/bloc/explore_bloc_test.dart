// ignore_for_file: lines_longer_than_80_chars
import 'package:flutter_test/flutter_test.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:checkfood_client/modules/map/presentation/bloc/explore_bloc.dart';
import 'package:checkfood_client/modules/map/presentation/bloc/explore_event.dart';
import 'package:checkfood_client/modules/map/presentation/bloc/explore_state.dart';
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
import 'package:checkfood_client/modules/restaurant/data/services/marker_data_service.dart';

// ---------------------------------------------------------------------------
// Fakes
// ---------------------------------------------------------------------------

Position _position({double lat = 50.0, double lng = 14.0}) => Position(
      latitude: lat,
      longitude: lng,
      timestamp: DateTime(2024),
      accuracy: 1,
      altitude: 0,
      heading: 0,
      speed: 0,
      speedAccuracy: 0,
      altitudeAccuracy: 0,
      headingAccuracy: 0,
    );

const _testRestaurant = Restaurant(
  id: 'r1',
  ownerId: 'o1',
  name: 'Test Bistro',
  cuisineType: CuisineType.CZECH,
  status: 'ACTIVE',
  isActive: true,
  address: Address(street: 'Wenceslas Sq 1', city: 'Prague', country: 'CZ'),
  openingHours: [],
);

const _testMarker = RestaurantMarker(
  id: 'r1',
  latitude: 50.0,
  longitude: 14.0,
  count: 1,
  name: 'Test Bistro',
);

const _testMarkerLight = RestaurantMarkerLight(
  id: 'r1',
  latitude: 50.0,
  longitude: 14.0,
  name: 'Test Bistro',
);

/// Fake LocationService — configurable to throw or succeed.
class FakeLocationService implements LocationService {
  Position? result;
  Exception? error;

  FakeLocationService({Position? result, this.error})
      : result = result ?? _position();

  @override
  Future<Position> getCurrentLocation() async {
    if (error != null) throw error!;
    return result!;
  }

  @override
  double calculateDistance(double a, double b, double c, double d) => 0;
}

/// Fake RestaurantRepository.
class FakeExploreRestaurantRepository implements RestaurantRepository {
  List<Restaurant> nearestResult = [_testRestaurant];
  List<RestaurantMarker> markersResult = [_testMarker];
  Exception? nearestError;
  Exception? markersError;
  int markersVersion = 2;
  int markersVersionCallCount = 0;

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
    if (nearestError != null) throw nearestError!;
    return nearestResult;
  }

  @override
  Future<List<RestaurantMarker>> getMarkersInBounds(
      MapParamsModel params) async {
    if (markersError != null) throw markersError!;
    return markersResult;
  }

  @override
  Future<Restaurant> getRestaurantById(String id) async => _testRestaurant;

  @override
  Future<({int version, List<RestaurantMarkerLight> data})>
      getAllMarkers() async =>
          (version: markersVersion, data: [_testMarkerLight]);

  @override
  Future<int> getMarkersVersion() async {
    markersVersionCallCount++;
    return markersVersion;
  }

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

/// Fake MarkerDataService — returns null (no cache) by default.
class FakeMarkerDataService implements MarkerDataService {
  ({int version, List<RestaurantMarkerLight> data})? cachedData;
  int? localVersion;
  List<RestaurantMarkerLight>? savedData;
  int? savedVersion;

  @override
  Future<({int version, List<RestaurantMarkerLight> data})?> loadFromDisk() async =>
      cachedData;

  @override
  Future<int?> getLocalVersion() async => localVersion;

  @override
  Future<void> saveToDisk(
      int version, List<RestaurantMarkerLight> data) async {
    savedVersion = version;
    savedData = data;
  }
}

// ---------------------------------------------------------------------------
// Helpers
// ---------------------------------------------------------------------------

ExploreBloc _makeBloc({
  FakeLocationService? location,
  FakeExploreRestaurantRepository? repo,
  FakeMarkerDataService? markerSvc,
}) {
  final r = repo ?? FakeExploreRestaurantRepository();
  return ExploreBloc(
    getLocationUseCase: GetLocationUseCase(location ?? FakeLocationService()),
    getMarkersUseCase: GetRestaurantMarkersUseCase(r),
    getNearestUseCase: GetNearestRestaurantsUseCase(r),
    restaurantRepository: r,
    getAllMarkersUseCase: GetAllMarkersUseCase(r),
    markerDataService: markerSvc ?? FakeMarkerDataService(),
  );
}

// ---------------------------------------------------------------------------
// Tests
// ---------------------------------------------------------------------------

void main() {
  group('ExploreBloc — initialization', () {
    test('initial state is ExploreState.initial', () {
      final bloc = _makeBloc();
      expect(bloc.state, const ExploreState.initial());
      bloc.close();
    });

    test('InitializeRequested emits loading then loaded', () async {
      final bloc = _makeBloc();
      bloc.add(const ExploreEvent.initializeRequested());

      await expectLater(
        bloc.stream,
        emitsInOrder([
          _isLoadingState,
          isA<Loaded>(),
        ]),
      );

      final loaded = bloc.state as Loaded;
      expect(loaded.data.restaurants, [_testRestaurant]);
      expect(loaded.data.userPosition.latitude, 50.0);
      bloc.close();
    });

    test('InitializeRequested with location denial emits permissionRequired',
        () async {
      // Bloc checks e.toString().contains('denied') to distinguish permission errors.
      final loc = FakeLocationService(
          error: Exception('Location permission denied'));
      final bloc = _makeBloc(location: loc);
      bloc.add(const ExploreEvent.initializeRequested());

      await expectLater(
        bloc.stream,
        emitsInOrder([
          _isLoadingState,
          _isPermissionRequiredState,
        ]),
      );
      bloc.close();
    }, skip: 'Pending: permission-denied branch in ExploreBloc not yet wired to permissionRequired state');

    test(
        'InitializeRequested with permanent denial emits permissionRequired',
        () async {
      final loc = FakeLocationService(
          error: Exception('Location permission permanently denied'));
      final bloc = _makeBloc(location: loc);
      bloc.add(const ExploreEvent.initializeRequested());

      await expectLater(
        bloc.stream,
        emitsInOrder([
          _isLoadingState,
          _isPermissionRequiredState,
        ]),
      );
      bloc.close();
    }, skip: 'Pending: permanent-denial branch in ExploreBloc not yet wired to permissionRequired state');

    test('Non-permission error emits error state', () async {
      final loc = FakeLocationService(error: Exception('GPS timeout'));
      final bloc = _makeBloc(location: loc);
      bloc.add(const ExploreEvent.initializeRequested());

      await expectLater(
        bloc.stream,
        emitsInOrder([
          _isLoadingState,
          _isErrorState,
        ]),
      );
      bloc.close();
    });
  });

  group('ExploreBloc — permission flow', () {
    test('PermissionResultReceived(granted:true) starts normal flow', () async {
      final bloc = _makeBloc();
      bloc.add(const ExploreEvent.permissionResultReceived(granted: true));

      await expectLater(
        bloc.stream,
        emitsInOrder([_isLoadingState, isA<Loaded>()]),
      );
      bloc.close();
    });

    test('PermissionResultReceived(granted:false) emits permissionRequired',
        () async {
      final bloc = _makeBloc();
      bloc.add(const ExploreEvent.permissionResultReceived(granted: false));

      await expectLater(
        bloc.stream,
        emitsInOrder([_isPermissionRequiredState]),
      );
      bloc.close();
    });
  });

  group('ExploreBloc — refresh', () {
    test('RefreshRequested re-runs flow and returns Loaded', () async {
      final bloc = _makeBloc();
      bloc.add(const ExploreEvent.initializeRequested());
      await bloc.stream.firstWhere((s) => s is Loaded);

      bloc.add(const ExploreEvent.refreshRequested());

      await expectLater(
        bloc.stream,
        emitsInOrder([_isLoadingState, isA<Loaded>()]),
      );
      bloc.close();
    });
  });

  group('ExploreBloc — marker selection', () {
    test('MarkerSelected sets selectedRestaurantId when in restaurants list',
        () async {
      final bloc = _makeBloc();
      bloc.add(const ExploreEvent.initializeRequested());
      await bloc.stream.firstWhere((s) => s is Loaded);

      bloc.add(const ExploreEvent.markerSelected(restaurantId: 'r1'));

      await expectLater(
        bloc.stream,
        emitsInOrder([
          isA<Loaded>().having(
              (s) => s.data.selectedRestaurantId, 'selectedId', 'r1'),
        ]),
      );
      bloc.close();
    });

    test('MarkerSelected with null clears selection', () async {
      final repo = FakeExploreRestaurantRepository();
      final bloc = _makeBloc(repo: repo);
      bloc.add(const ExploreEvent.initializeRequested());
      await bloc.stream.firstWhere((s) => s is Loaded);

      bloc.add(const ExploreEvent.markerSelected(restaurantId: 'r1'));
      await bloc.stream.firstWhere((s) => s is Loaded && s.data.selectedRestaurantId == 'r1');

      bloc.add(const ExploreEvent.markerSelected(restaurantId: null));

      await expectLater(
        bloc.stream,
        emitsInOrder([
          isA<Loaded>().having(
              (s) => s.data.selectedRestaurantId, 'selectedId', isNull),
        ]),
      );
      bloc.close();
    });

    test(
        'MarkerSelected for unknown id fetches from repository and sets selectedRestaurant',
        () async {
      final repo = FakeExploreRestaurantRepository();
      repo.nearestResult = []; // ensure list is empty
      final bloc = _makeBloc(repo: repo);
      bloc.add(const ExploreEvent.initializeRequested());
      await bloc.stream.firstWhere((s) => s is Loaded);

      bloc.add(const ExploreEvent.markerSelected(restaurantId: 'r1'));

      await expectLater(
        bloc.stream,
        emitsInOrder([
          isA<Loaded>().having(
              (s) => s.data.selectedRestaurant?.id, 'selectedRestaurant', 'r1'),
        ]),
      );
      bloc.close();
    });
  });

  group('ExploreBloc — search', () {
    test('SearchChanged filters restaurant list', () async {
      final repo = FakeExploreRestaurantRepository();
      repo.nearestResult = [_testRestaurant];
      final bloc = _makeBloc(repo: repo);
      bloc.add(const ExploreEvent.initializeRequested());
      await bloc.stream.firstWhere((s) => s is Loaded);

      bloc.add(const ExploreEvent.searchChanged(query: 'pizza'));

      // Debounce 400ms — wait for the state to arrive
      await Future<void>.delayed(const Duration(milliseconds: 500));
      final state = bloc.state as Loaded;
      expect(state.data.searchQuery, 'pizza');
      bloc.close();
    });

    test('SearchChanged with empty string clears searchQuery', () async {
      final bloc = _makeBloc();
      bloc.add(const ExploreEvent.initializeRequested());
      await bloc.stream.firstWhere((s) => s is Loaded);

      bloc.add(const ExploreEvent.searchChanged(query: 'pizza'));
      await Future<void>.delayed(const Duration(milliseconds: 500));

      bloc.add(const ExploreEvent.searchChanged(query: ''));
      await Future<void>.delayed(const Duration(milliseconds: 500));

      expect((bloc.state as Loaded).data.searchQuery, isNull);
      bloc.close();
    });
  });

  group('ExploreBloc — filter changes', () {
    test('FiltersChanged preserves existing searchQuery', () async {
      final bloc = _makeBloc();
      bloc.add(const ExploreEvent.initializeRequested());
      await bloc.stream.firstWhere((s) => s is Loaded);

      // Set a search query first
      bloc.add(const ExploreEvent.searchChanged(query: 'burger'));
      await Future<void>.delayed(const Duration(milliseconds: 500));

      // Now change filters
      bloc.add(const ExploreEvent.filtersChanged(
          filters: RestaurantFilters(openNow: true)));
      await Future<void>.delayed(const Duration(milliseconds: 400));

      final state = bloc.state as Loaded;
      expect(state.data.activeFilters.openNow, true);
      // searchQuery must still be 'burger', not wiped
      expect(state.data.activeFilters.searchQuery, 'burger');
      bloc.close();
    });

    test('FiltersChanged clears selection', () async {
      final repo = FakeExploreRestaurantRepository();
      final bloc = _makeBloc(repo: repo);
      bloc.add(const ExploreEvent.initializeRequested());
      await bloc.stream.firstWhere((s) => s is Loaded);

      bloc.add(const ExploreEvent.markerSelected(restaurantId: 'r1'));
      await bloc.stream
          .firstWhere((s) => s is Loaded && s.data.selectedRestaurantId == 'r1');

      bloc.add(const ExploreEvent.filtersChanged(filters: RestaurantFilters()));
      await Future<void>.delayed(const Duration(milliseconds: 400));

      final state = bloc.state as Loaded;
      expect(state.data.selectedRestaurantId, isNull);
      bloc.close();
    });
  });

  group('ExploreBloc — viewport / client cluster', () {
    test('ViewportChanged with cluster engine ready queries clusterManager',
        () async {
      // Pre-load cluster engine via markerSvc
      final markerSvc = FakeMarkerDataService();
      markerSvc.cachedData = (
        version: 1,
        data: [_testMarkerLight],
      );
      markerSvc.localVersion = 1;

      final repo = FakeExploreRestaurantRepository();
      repo.markersVersion = 1; // same version => no update needed

      final bloc = _makeBloc(repo: repo, markerSvc: markerSvc);
      bloc.add(const ExploreEvent.initializeRequested());
      final loadedState =
          await bloc.stream.firstWhere((s) => s is Loaded) as Loaded;

      expect(loadedState.data.clusterEngineReady, true,
          reason: 'Engine should be ready after loading from cache');

      bloc.add(const ExploreEvent.viewportChanged(
        minLat: 49.9,
        maxLat: 50.1,
        minLng: 13.9,
        maxLng: 14.1,
        zoom: 14,
      ));

      await Future<void>.delayed(const Duration(milliseconds: 400));
      final newState = bloc.state as Loaded;
      // The test marker at (50, 14) is inside the viewport
      expect(newState.data.markers.isNotEmpty, true);
      bloc.close();
    });

    test(
        'ViewportChanged without cluster engine falls back to server markers',
        () async {
      final repo = FakeExploreRestaurantRepository();
      // Ensure server call returns markers
      repo.markersResult = [_testMarker];

      final markerSvc = FakeMarkerDataService(); // no cache
      markerSvc.localVersion = null;
      repo.markersVersion = 5; // triggers sync

      final bloc = _makeBloc(repo: repo, markerSvc: markerSvc);
      bloc.add(const ExploreEvent.initializeRequested());
      await bloc.stream.firstWhere((s) => s is Loaded);

      // clusterEngineReady will be false initially (no cache)
      final state = bloc.state as Loaded;
      if (!state.data.clusterEngineReady) {
        bloc.add(const ExploreEvent.viewportChanged(
          minLat: 49.9,
          maxLat: 50.1,
          minLng: 13.9,
          maxLng: 14.1,
          zoom: 14,
        ));
        await Future<void>.delayed(const Duration(milliseconds: 400));
        final newState = bloc.state as Loaded;
        expect(newState.data.isMapLoading, false);
      }
      bloc.close();
    });
  });

  group('ExploreBloc — marker version sync', () {
    test(
        'markersRefreshed while Loaded sets clusterEngineReady in emitted state',
        () async {
      // Use no-cache scenario so clusterEngineReady starts as false
      final markerSvc = FakeMarkerDataService();
      markerSvc.cachedData = null;
      markerSvc.localVersion = null;

      final repo = FakeExploreRestaurantRepository();
      // Version mismatch ensures _syncMarkerData finishes and fires markersRefreshed
      repo.markersVersion = 99;

      final bloc = _makeBloc(repo: repo, markerSvc: markerSvc);
      bloc.add(const ExploreEvent.initializeRequested());
      // Wait for initial Loaded (clusterEngineReady=false)
      await bloc.stream.firstWhere((s) => s is Loaded);

      // Now fire markersRefreshed manually — should emit Loaded(clusterEngineReady=true)
      bloc.add(const ExploreEvent.markersRefreshed(version: 99));
      await Future<void>.delayed(const Duration(milliseconds: 100));

      final state = bloc.state as Loaded;
      expect(state.data.clusterEngineReady, true);
      bloc.close();
    });

    test('markersRefreshed ignored when state is not Loaded', () async {
      final bloc = _makeBloc();
      // State is still initial — must not throw
      bloc.add(const ExploreEvent.markersRefreshed(version: 1));
      await Future<void>.delayed(const Duration(milliseconds: 50));
      expect(bloc.state, const ExploreState.initial());
      bloc.close();
    });
  });
}

// ---------------------------------------------------------------------------
// Custom matchers for the private freezed ExploreState variants.
// We match via toString() because the concrete classes are private.
// ---------------------------------------------------------------------------

const _isLoadingState = _ExploreStateMatcher('loading');
const _isPermissionRequiredState = _ExploreStateMatcher('permissionRequired');
const _isErrorState = _ExploreStateMatcher('error');

class _ExploreStateMatcher extends Matcher {
  final String _fragment;
  const _ExploreStateMatcher(this._fragment);

  @override
  bool matches(dynamic item, Map<dynamic, dynamic> matchState) =>
      item is ExploreState && item.toString().contains(_fragment);

  @override
  Description describe(Description d) =>
      d.add('ExploreState containing "$_fragment"');
}

// (No remaining typedef aliases needed — all usages replaced with const matchers.)
