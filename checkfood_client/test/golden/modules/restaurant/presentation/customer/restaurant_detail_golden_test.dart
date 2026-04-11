// Golden tests for RestaurantDetailPage-equivalent shell.
// Run with: flutter test --update-goldens test/golden/...
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'package:checkfood_client/l10n/generated/app_localizations.dart';
import 'package:checkfood_client/modules/restaurant/presentation/customer/bloc/restaurant_detail_bloc.dart';
import 'package:checkfood_client/modules/restaurant/presentation/customer/bloc/restaurant_detail_event.dart';
import 'package:checkfood_client/modules/restaurant/presentation/customer/bloc/restaurant_detail_state.dart';
import 'package:checkfood_client/modules/restaurant/domain/entities/restaurant.dart';
import 'package:checkfood_client/modules/restaurant/domain/entities/address.dart';
import 'package:checkfood_client/modules/restaurant/domain/entities/cuisine_type.dart';
import 'package:checkfood_client/modules/restaurant/domain/entities/opening_hours.dart';
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
// Fakes (duplicated here to keep golden test file self-contained)
// ---------------------------------------------------------------------------

class _FakeRepo implements RestaurantRepository {
  Restaurant? result;
  Exception? error;
  @override
  Future<Restaurant> getRestaurantById(String id) async {
    if (error != null) throw error!;
    return result!;
  }
  @override Future<List<RestaurantMarker>> getMarkersInBounds(MapParamsModel p) async => [];
  @override Future<List<Restaurant>> getNearestRestaurants({required double lat, required double lng, required int page, required int size, String? searchQuery, List<String>? cuisineTypes, double? minRating, bool? openNow, bool? favouritesOnly}) async => [];
  @override Future<Restaurant> createRestaurant(RestaurantRequestModel r) => throw UnimplementedError();
  @override Future<List<Restaurant>> getMyRestaurants() async => [];
  @override Future<Restaurant> updateRestaurant(String id, RestaurantRequestModel r) => throw UnimplementedError();
  @override Future<void> deleteRestaurant(String id) async {}
  @override Future<RestaurantTable> addTable(String rid, RestaurantTableRequestModel r) => throw UnimplementedError();
  @override Future<List<RestaurantTable>> getTables(String rid) async => [];
  @override Future<({int version, List<RestaurantMarkerLight> data})> getAllMarkers() async => (version: 1, data: <RestaurantMarkerLight>[]);
  @override Future<int> getMarkersVersion() async => 1;
}

class _FakeFavDs implements FavouriteRemoteDataSource {
  @override Future<void> addFavourite(String id) async {}
  @override Future<void> removeFavourite(String id) async {}
}

// ---------------------------------------------------------------------------
// Fixtures
// ---------------------------------------------------------------------------

const _restaurant = Restaurant(
  id: 'r1',
  ownerId: 'o1',
  name: 'Golden Test Restaurant',
  cuisineType: CuisineType.ITALIAN,
  status: 'ACTIVE',
  isActive: true,
  description: 'A beautiful Italian restaurant.',
  address: Address(
      street: 'Náměstí Republiky',
      streetNumber: '1',
      city: 'Prague',
      country: 'CZ'),
  openingHours: [
    OpeningHours(
        dayOfWeek: 1,
        openAt: '10:00',
        closeAt: '22:00',
        isClosed: false),
  ],
  tags: ['WiFi', 'Terasa'],
  isFavourite: false,
);

// ---------------------------------------------------------------------------
// Helpers
// ---------------------------------------------------------------------------

Widget _shell(RestaurantDetailBloc bloc,
    {ThemeMode mode = ThemeMode.light}) {
  return BlocProvider<RestaurantDetailBloc>.value(
    value: bloc,
    child: MaterialApp(
      locale: const Locale('cs'),
      themeMode: mode,
      theme: ThemeData.light(useMaterial3: true),
      darkTheme: ThemeData.dark(useMaterial3: true),
      localizationsDelegates: const [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: S.supportedLocales,
      home: BlocBuilder<RestaurantDetailBloc, RestaurantDetailState>(
        builder: (ctx, state) => Scaffold(
          body: state.when(
            initial: () => const SizedBox.shrink(),
            loading: () =>
                const Center(child: CircularProgressIndicator()),
            loaded: (r) => ListView(
              children: [
                Text(r.name,
                    style:
                        Theme.of(ctx).textTheme.headlineSmall),
                if (r.description != null) Text(r.description!),
                Text(r.address.fullAddress),
                Wrap(
                    children: r.tags
                        .map((t) => Chip(label: Text(t)))
                        .toList()),
                ElevatedButton(
                    onPressed: () {},
                    child: Text(S.of(ctx).reserveTable)),
              ],
            ),
            error: (msg) => Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error_outline, size: 48),
                  Text(msg),
                  ElevatedButton(
                    onPressed: () => ctx
                        .read<RestaurantDetailBloc>()
                        .add(const RestaurantDetailEvent.loadRequested(
                            restaurantId: 'r1')),
                    child: Text(S.of(ctx).retry),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    ),
  );
}

RestaurantDetailBloc _makeBloc({_FakeRepo? repo}) {
  final r = repo ?? (_FakeRepo()..result = _restaurant);
  return RestaurantDetailBloc(
    getRestaurantByIdUseCase: GetRestaurantByIdUseCase(r),
    toggleFavouriteUseCase: ToggleFavouriteUseCase(_FakeFavDs()),
  );
}

// ---------------------------------------------------------------------------
// Goldens
// ---------------------------------------------------------------------------

void main() {
  group('RestaurantDetail golden', () {
    testWidgets('restaurant_detail_loading_light.png', (tester) async {
      tester.view.physicalSize = const Size(390, 844);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);

      final bloc = _makeBloc();
      // Fire load but do not settle — stay in loading
      bloc.add(const RestaurantDetailEvent.loadRequested(restaurantId: 'r1'));
      await tester.pumpWidget(_shell(bloc));
      await tester.pump();

      await expectLater(
        find.byType(MaterialApp),
        matchesGoldenFile(
            'goldens/restaurant_detail_loading_light.png'),
      );
      bloc.close();
    });

    testWidgets('restaurant_detail_loaded_light.png', (tester) async {
      tester.view.physicalSize = const Size(390, 844);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);

      final bloc = _makeBloc();
      bloc.add(const RestaurantDetailEvent.loadRequested(restaurantId: 'r1'));
      await tester.pumpWidget(_shell(bloc));
      await tester.pumpAndSettle();

      await expectLater(
        find.byType(MaterialApp),
        matchesGoldenFile(
            'goldens/restaurant_detail_loaded_light.png'),
      );
      bloc.close();
    });

    testWidgets('restaurant_detail_loaded_dark.png', (tester) async {
      tester.view.physicalSize = const Size(390, 844);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);

      final bloc = _makeBloc();
      bloc.add(const RestaurantDetailEvent.loadRequested(restaurantId: 'r1'));
      await tester.pumpWidget(_shell(bloc, mode: ThemeMode.dark));
      await tester.pumpAndSettle();

      await expectLater(
        find.byType(MaterialApp),
        matchesGoldenFile(
            'goldens/restaurant_detail_loaded_dark.png'),
      );
      bloc.close();
    });

    testWidgets('restaurant_detail_error_light.png', (tester) async {
      tester.view.physicalSize = const Size(390, 844);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);

      final repo = _FakeRepo()..error = Exception('Server error');
      final bloc = _makeBloc(repo: repo);
      bloc.add(const RestaurantDetailEvent.loadRequested(restaurantId: 'r1'));
      await tester.pumpWidget(_shell(bloc));
      await tester.pumpAndSettle();

      await expectLater(
        find.byType(MaterialApp),
        matchesGoldenFile(
            'goldens/restaurant_detail_error_light.png'),
      );
      bloc.close();
    });

    testWidgets('restaurant_detail_error_dark.png', (tester) async {
      tester.view.physicalSize = const Size(390, 844);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);

      final repo = _FakeRepo()..error = Exception('Server error');
      final bloc = _makeBloc(repo: repo);
      bloc.add(const RestaurantDetailEvent.loadRequested(restaurantId: 'r1'));
      await tester.pumpWidget(_shell(bloc, mode: ThemeMode.dark));
      await tester.pumpAndSettle();

      await expectLater(
        find.byType(MaterialApp),
        matchesGoldenFile(
            'goldens/restaurant_detail_error_dark.png'),
      );
      bloc.close();
    });
  });
}
