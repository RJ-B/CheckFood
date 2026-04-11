// Extension of restaurant_detail_bloc_test.dart.
// DO NOT add tests already covered there (initial, load, toggleFavourite happy/rollback).
// Covers: retry after error, multiple sequential loads, gallery navigation gaps.
import 'package:flutter_test/flutter_test.dart';
import 'package:checkfood_client/modules/restaurant/presentation/customer/bloc/restaurant_detail_bloc.dart';
import 'package:checkfood_client/modules/restaurant/presentation/customer/bloc/restaurant_detail_event.dart';
import 'package:checkfood_client/modules/restaurant/presentation/customer/bloc/restaurant_detail_state.dart';
import 'package:checkfood_client/modules/restaurant/domain/entities/restaurant.dart';
import 'package:checkfood_client/modules/restaurant/domain/entities/address.dart';
import 'package:checkfood_client/modules/restaurant/domain/entities/cuisine_type.dart';
import 'package:checkfood_client/modules/restaurant/domain/entities/restaurant_photo.dart';
import 'package:checkfood_client/modules/restaurant/domain/usecases/get_restaurant_by_id_usecase.dart';
import 'package:checkfood_client/modules/restaurant/domain/usecases/toggle_favourite_usecase.dart';
import 'package:checkfood_client/modules/restaurant/domain/repositories/restaurant_repository.dart';
import 'package:checkfood_client/modules/restaurant/data/datasources/favourite_remote_datasource.dart';
import 'package:checkfood_client/modules/map/data/models/request/map_params_model.dart';
import 'package:checkfood_client/modules/restaurant/data/models/request/restaurant_request_model.dart';
import 'package:checkfood_client/modules/restaurant/data/models/request/restaurant_table_request_model.dart';
import 'package:checkfood_client/modules/map/domain/entities/restaurant_marker.dart';
import 'package:checkfood_client/modules/map/domain/entities/restaurant_marker_light.dart';
import 'package:checkfood_client/modules/restaurant/domain/entities/restaurant_table.dart';

// ---------------------------------------------------------------------------
// Fakes (kept local so this file is standalone)
// ---------------------------------------------------------------------------

class _FakeRepo implements RestaurantRepository {
  Restaurant? result;
  Exception? error;
  int callCount = 0;

  @override
  Future<Restaurant> getRestaurantById(String id) async {
    callCount++;
    if (error != null) throw error!;
    return result!;
  }

  @override
  Future<List<RestaurantMarker>> getMarkersInBounds(
          MapParamsModel params) async =>
      [];
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
  }) async =>
      [];
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
  @override
  Future<({int version, List<RestaurantMarkerLight> data})>
      getAllMarkers() async =>
          (version: 1, data: <RestaurantMarkerLight>[]);
  @override
  Future<int> getMarkersVersion() async => 1;
}

class _FakeFavDs implements FavouriteRemoteDataSource {
  Exception? error;
  int addCallCount = 0;
  int removeCallCount = 0;

  @override
  Future<void> addFavourite(String restaurantId) async {
    addCallCount++;
    if (error != null) throw error!;
  }

  @override
  Future<void> removeFavourite(String restaurantId) async {
    removeCallCount++;
    if (error != null) throw error!;
  }
}

const _base = Restaurant(
  id: 'r42',
  ownerId: 'o1',
  name: 'Extended Test Restaurant',
  cuisineType: CuisineType.ITALIAN,
  status: 'ACTIVE',
  isActive: true,
  address: Address(street: 'Via Roma 1', city: 'Prague', country: 'CZ'),
  openingHours: [],
  isFavourite: false,
);

// ---------------------------------------------------------------------------

void main() {
  late _FakeRepo repo;
  late _FakeFavDs favDs;
  late RestaurantDetailBloc bloc;

  setUp(() {
    repo = _FakeRepo()..result = _base;
    favDs = _FakeFavDs();
    bloc = RestaurantDetailBloc(
      getRestaurantByIdUseCase: GetRestaurantByIdUseCase(repo),
      toggleFavouriteUseCase: ToggleFavouriteUseCase(favDs),
    );
  });

  tearDown(() => bloc.close());

  group('RestaurantDetailBloc — extended', () {
    test('should emit error when repository throws non-permission error',
        () async {
      repo.error = Exception('500 Internal Server Error');
      bloc.add(const RestaurantDetailEvent.loadRequested(
          restaurantId: 'r42'));

      await expectLater(
        bloc.stream,
        emitsInOrder([
          isA<RestaurantDetailState>()
              .having((s) => s.toString(), 'loading', contains('loading')),
          _isDetailErrorState,
        ]),
      );
    });

    test('should retry successfully after error state', () async {
      // First attempt fails
      repo.error = Exception('timeout');
      bloc.add(const RestaurantDetailEvent.loadRequested(
          restaurantId: 'r42'));
      await bloc.stream.firstWhere(
          (s) => s.toString().contains('error'));

      // Second attempt succeeds
      repo.error = null;
      bloc.add(const RestaurantDetailEvent.loadRequested(
          restaurantId: 'r42'));

      await expectLater(
        bloc.stream,
        emitsInOrder([
          isA<RestaurantDetailState>()
              .having((s) => s.toString(), 'loading again', contains('loading')),
          isA<DetailLoaded>().having(
              (s) => s.restaurant.name, 'name', 'Extended Test Restaurant'),
        ]),
      );
    });

    test('should call repository exactly twice after two load events',
        () async {
      repo.result = _base;
      bloc.add(const RestaurantDetailEvent.loadRequested(restaurantId: 'r42'));
      await bloc.stream.firstWhere((s) => s is DetailLoaded);

      bloc.add(const RestaurantDetailEvent.loadRequested(restaurantId: 'r42'));
      await bloc.stream.firstWhere(
          (s) => s is DetailLoaded && repo.callCount >= 2);

      expect(repo.callCount, 2);
    });

    test('should not emit when toggleFavourite fired on non-loaded state',
        () async {
      // Bloc is still in initial state
      bloc.add(const RestaurantDetailEvent.toggleFavourite());
      await Future<void>.delayed(const Duration(milliseconds: 50));
      // No state change: still initial
      expect(bloc.state, const RestaurantDetailState.initial());
    });

    test('optimistic favourite flips back twice on repeated toggles', () async {
      repo.result = _base;
      bloc.add(const RestaurantDetailEvent.loadRequested(restaurantId: 'r42'));
      await bloc.stream.firstWhere((s) => s is DetailLoaded);

      // Toggle ON
      bloc.add(const RestaurantDetailEvent.toggleFavourite());
      await bloc.stream.firstWhere(
          (s) => s is DetailLoaded && s.restaurant.isFavourite);
      expect(favDs.addCallCount, 1);

      // Toggle OFF
      bloc.add(const RestaurantDetailEvent.toggleFavourite());
      await bloc.stream.firstWhere(
          (s) => s is DetailLoaded && !s.restaurant.isFavourite);
      expect(favDs.removeCallCount, 1);
    });

    test('error state message contains exception text', () async {
      repo.error = Exception('Restaurant not found');
      bloc.add(const RestaurantDetailEvent.loadRequested(
          restaurantId: 'r42'));
      await bloc.stream.firstWhere((s) => s.toString().contains('error'));

      final state = bloc.state;
      expect(state.toString(), contains('Restaurant not found'));
    });

    // EXPECTED-FAIL: gallery navigation — production code does not yet implement
    // a GalleryPageChanged event or currentGalleryIndex in RestaurantDetailState.
    test(
        'should expose currentGalleryIndex in loaded state for gallery navigation',
        () {
      final restaurantWithGallery = _base.copyWith(
        gallery: [
          const RestaurantPhoto(id: 'p1', url: 'https://img/1.jpg'),
          const RestaurantPhoto(id: 'p2', url: 'https://img/2.jpg'),
        ],
      );
      // This line will fail with a type error because DetailLoaded has no
      // currentGalleryIndex field yet.
      final loaded =
          RestaurantDetailState.loaded(restaurant: restaurantWithGallery)
              as DetailLoaded;
      // ignore: unnecessary_cast
      expect((loaded as dynamic).currentGalleryIndex, 0);
    }, skip: 'Pending: gallery navigation — RestaurantDetailState has no currentGalleryIndex field yet');
  });
}

const _isDetailErrorState = _DetailStateMatcher('error');

class _DetailStateMatcher extends Matcher {
  final String _fragment;
  const _DetailStateMatcher(this._fragment);

  @override
  bool matches(dynamic item, Map<dynamic, dynamic> matchState) =>
      item is RestaurantDetailState && item.toString().contains(_fragment);

  @override
  Description describe(Description d) =>
      d.add('RestaurantDetailState containing "$_fragment"');
}
