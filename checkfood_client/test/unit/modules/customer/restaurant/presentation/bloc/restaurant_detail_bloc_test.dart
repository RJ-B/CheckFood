import 'package:flutter_test/flutter_test.dart';
import 'package:checkfood_client/modules/customer/restaurant/presentation/bloc/restaurant_detail_bloc.dart';
import 'package:checkfood_client/modules/customer/restaurant/presentation/bloc/restaurant_detail_event.dart';
import 'package:checkfood_client/modules/customer/restaurant/presentation/bloc/restaurant_detail_state.dart';
import 'package:checkfood_client/modules/customer/restaurant/domain/entities/restaurant.dart';
import 'package:checkfood_client/modules/customer/restaurant/domain/entities/address.dart';
import 'package:checkfood_client/modules/customer/restaurant/domain/entities/cuisine_type.dart';
import 'package:checkfood_client/modules/customer/restaurant/domain/usecases/get_restaurant_by_id_usecase.dart';
import 'package:checkfood_client/modules/customer/restaurant/domain/usecases/toggle_favourite_usecase.dart';
import 'package:checkfood_client/modules/customer/restaurant/domain/repositories/restaurant_repository.dart';
import 'package:checkfood_client/modules/customer/restaurant/data/datasources/favourite_remote_datasource.dart';
import 'package:checkfood_client/modules/customer/restaurant/data/models/request/map_params_model.dart';
import 'package:checkfood_client/modules/customer/restaurant/data/models/request/restaurant_request_model.dart';
import 'package:checkfood_client/modules/customer/restaurant/data/models/request/restaurant_table_request_model.dart';
import 'package:checkfood_client/modules/customer/restaurant/domain/entities/restaurant_marker.dart';
import 'package:checkfood_client/modules/customer/restaurant/domain/entities/restaurant_marker_light.dart';
import 'package:checkfood_client/modules/customer/restaurant/domain/entities/restaurant_table.dart';

// --- Fakes ---

class FakeRestaurantRepository implements RestaurantRepository {
  Restaurant? result;
  Exception? error;

  @override
  Future<Restaurant> getRestaurantById(String id) async {
    if (error != null) throw error!;
    return result!;
  }

  @override
  Future<List<RestaurantMarker>> getMarkersInBounds(MapParamsModel params) async => [];
  @override
  Future<List<Restaurant>> getNearestRestaurants({
    required double lat, required double lng, required int page, required int size,
    String? searchQuery, List<String>? cuisineTypes, double? minRating, bool? openNow, bool? favouritesOnly,
  }) async => [];
  @override
  Future<Restaurant> createRestaurant(RestaurantRequestModel request) => throw UnimplementedError();
  @override
  Future<List<Restaurant>> getMyRestaurants() async => [];
  @override
  Future<Restaurant> updateRestaurant(String id, RestaurantRequestModel request) => throw UnimplementedError();
  @override
  Future<void> deleteRestaurant(String id) async {}
  @override
  Future<RestaurantTable> addTable(String restaurantId, RestaurantTableRequestModel request) => throw UnimplementedError();
  @override
  Future<List<RestaurantTable>> getTables(String restaurantId) async => [];
  @override
  Future<({int version, List<RestaurantMarkerLight> data})> getAllMarkers() async => (version: 1, data: <RestaurantMarkerLight>[]);
  @override
  Future<int> getMarkersVersion() async => 1;
}

class FakeFavouriteDataSource implements FavouriteRemoteDataSource {
  bool addCalled = false;
  bool removeCalled = false;
  Exception? error;

  @override
  Future<void> addFavourite(String restaurantId) async {
    addCalled = true;
    if (error != null) throw error!;
  }

  @override
  Future<void> removeFavourite(String restaurantId) async {
    removeCalled = true;
    if (error != null) throw error!;
  }
}

const _testRestaurant = Restaurant(
  id: 'r1',
  ownerId: 'o1',
  name: 'Test Restaurant',
  cuisineType: CuisineType.CZECH,
  status: 'ACTIVE',
  isActive: true,
  address: Address(street: 'Test St 1', city: 'Prague', country: 'CZ'),
  openingHours: [],
  isFavourite: false,
);

void main() {
  late FakeRestaurantRepository fakeRepo;
  late FakeFavouriteDataSource fakeFavDs;
  late RestaurantDetailBloc bloc;

  setUp(() {
    fakeRepo = FakeRestaurantRepository();
    fakeRepo.result = _testRestaurant;
    fakeFavDs = FakeFavouriteDataSource();
    bloc = RestaurantDetailBloc(
      getRestaurantByIdUseCase: GetRestaurantByIdUseCase(fakeRepo),
      toggleFavouriteUseCase: ToggleFavouriteUseCase(fakeFavDs),
    );
  });

  tearDown(() => bloc.close());

  group('RestaurantDetailBloc', () {
    test('initial state is initial', () {
      expect(bloc.state, const RestaurantDetailState.initial());
    });

    test('loadRequested emits loading then loaded', () async {
      bloc.add(const RestaurantDetailEvent.loadRequested(restaurantId: 'r1'));

      await expectLater(
        bloc.stream,
        emitsInOrder([
          isA<RestaurantDetailState>().having(
            (s) => s.toString(), 'is loading', contains('loading'),
          ),
          isA<DetailLoaded>().having(
            (s) => s.restaurant.name, 'restaurant name', 'Test Restaurant',
          ),
        ]),
      );
    });

    test('loadRequested with error emits loading then error', () async {
      fakeRepo.error = Exception('Network error');
      bloc.add(const RestaurantDetailEvent.loadRequested(restaurantId: 'r1'));

      await expectLater(
        bloc.stream,
        emitsInOrder([
          isA<RestaurantDetailState>(), // loading
          isA<RestaurantDetailState>().having(
            (s) => s.toString(), 'contains error', contains('error'),
          ),
        ]),
      );
    });

    test('toggleFavourite optimistically flips isFavourite to true', () async {
      // Load first
      bloc.add(const RestaurantDetailEvent.loadRequested(restaurantId: 'r1'));
      await bloc.stream.firstWhere((s) => s is DetailLoaded);

      // Toggle
      bloc.add(const RestaurantDetailEvent.toggleFavourite());

      final rawState = await bloc.stream.firstWhere(
        (s) => s is DetailLoaded && s.restaurant.isFavourite,
      );
      final state = rawState as DetailLoaded;

      expect(state.restaurant.isFavourite, true);
      expect(fakeFavDs.addCalled, true);
    });

    test('toggleFavourite rolls back on API error', () async {
      // Load
      bloc.add(const RestaurantDetailEvent.loadRequested(restaurantId: 'r1'));
      await bloc.stream.firstWhere((s) => s is DetailLoaded);

      // Set error for the favourite call
      fakeFavDs.error = Exception('Server error');

      // Toggle — will optimistically flip then rollback
      bloc.add(const RestaurantDetailEvent.toggleFavourite());

      // Wait for the rollback (isFavourite back to false)
      await Future.delayed(const Duration(milliseconds: 100));

      final state = bloc.state as DetailLoaded;
      expect(state.restaurant.isFavourite, false);
    });

    test('toggleFavourite on already favourite calls removeFavourite', () async {
      // Load with isFavourite=true
      fakeRepo.result = _testRestaurant.copyWith(isFavourite: true);
      bloc.add(const RestaurantDetailEvent.loadRequested(restaurantId: 'r1'));
      await bloc.stream.firstWhere((s) => s is DetailLoaded);

      // Toggle
      bloc.add(const RestaurantDetailEvent.toggleFavourite());

      final rawState = await bloc.stream.firstWhere(
        (s) => s is DetailLoaded && !s.restaurant.isFavourite,
      );
      final state = rawState as DetailLoaded;

      expect(state.restaurant.isFavourite, false);
      expect(fakeFavDs.removeCalled, true);
    });
  });
}
