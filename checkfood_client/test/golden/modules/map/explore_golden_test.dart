// Golden tests for the ExploreShell (the UI shell of ExplorePage without GoogleMap).
// Run: flutter test --update-goldens test/golden/modules/map/explore_golden_test.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:geolocator/geolocator.dart';

import 'package:checkfood_client/l10n/generated/app_localizations.dart';
import 'package:checkfood_client/modules/map/presentation/bloc/explore_bloc.dart';
import 'package:checkfood_client/modules/map/presentation/bloc/explore_event.dart';
import 'package:checkfood_client/modules/map/presentation/bloc/explore_state.dart';
import 'package:checkfood_client/modules/map/domain/usecases/explore_usecases.dart';
import 'package:checkfood_client/modules/map/domain/usecases/get_all_markers_usecase.dart';
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

// Fakes -----------------------------------------------------------------------

Position _pos() => Position(
      latitude: 50.0, longitude: 14.0, timestamp: DateTime(2024),
      accuracy: 1, altitude: 0, heading: 0, speed: 0,
      speedAccuracy: 0, altitudeAccuracy: 0, headingAccuracy: 0);

const _r = Restaurant(
  id: 'r1', ownerId: 'o1', name: 'Golden Bistro',
  cuisineType: CuisineType.CZECH, status: 'ACTIVE', isActive: true,
  address: Address(street: 'Main St', city: 'Prague', country: 'CZ'),
  openingHours: []);

class _Loc implements LocationService {
  Exception? error;
  @override Future<Position> getCurrentLocation() async { if(error!=null)throw error!; return _pos(); }
  @override double calculateDistance(double a,double b,double c,double d)=>0;
}

class _Repo implements RestaurantRepository {
  List<Restaurant> restaurants;
  _Repo({this.restaurants = const [_r]});
  @override Future<List<Restaurant>> getNearestRestaurants({required double lat,required double lng,required int page,required int size,String? searchQuery,List<String>? cuisineTypes,double? minRating,bool? openNow,bool? favouritesOnly}) async => restaurants;
  @override Future<List<RestaurantMarker>> getMarkersInBounds(MapParamsModel p) async => [];
  @override Future<Restaurant> getRestaurantById(String id) async => _r;
  @override Future<({int version, List<RestaurantMarkerLight> data})> getAllMarkers() async => (version:1, data:<RestaurantMarkerLight>[]);
  @override Future<int> getMarkersVersion() async => 1;
  @override Future<Restaurant> createRestaurant(RestaurantRequestModel r) => throw UnimplementedError();
  @override Future<List<Restaurant>> getMyRestaurants() async => [];
  @override Future<Restaurant> updateRestaurant(String id, RestaurantRequestModel r) => throw UnimplementedError();
  @override Future<void> deleteRestaurant(String id) async {}
  @override Future<RestaurantTable> addTable(String rid, RestaurantTableRequestModel r) => throw UnimplementedError();
  @override Future<List<RestaurantTable>> getTables(String rid) async => [];
}

class _MrkSvc implements MarkerDataService {
  @override Future<({int version, List<RestaurantMarkerLight> data})?> loadFromDisk() async => null;
  @override Future<int?> getLocalVersion() async => null;
  @override Future<void> saveToDisk(int v, List<RestaurantMarkerLight> d) async {}
}

// Shell -----------------------------------------------------------------------

class _Shell extends StatelessWidget {
  const _Shell();
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ExploreBloc, ExploreState>(
      builder: (ctx, state) => state.maybeWhen(
        loading: () => const Scaffold(body: Center(child: CircularProgressIndicator())),
        error: (msg) => Scaffold(
          body: Center(
            child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              const Icon(Icons.error_outline, size: 48),
              Text(msg),
              ElevatedButton(
                onPressed: () => ctx.read<ExploreBloc>().add(const ExploreEvent.initializeRequested()),
                child: Text(S.of(ctx).retry),
              ),
            ]),
          ),
        ),
        loaded: (data) => Scaffold(
          body: Column(children: [
            TextField(decoration: InputDecoration(hintText: S.of(ctx).searchRestaurants)),
            Expanded(
              child: data.restaurants.isEmpty
                  ? const Center(child: Text('Žádné restaurace nenalezeny.'))
                  : ListView(children: data.restaurants.map((r) => ListTile(title: Text(r.name))).toList()),
            ),
          ]),
        ),
        orElse: () => const SizedBox.shrink(),
      ),
    );
  }
}

ExploreBloc _bloc({_Loc? loc, _Repo? repo}) {
  final r = repo ?? _Repo();
  return ExploreBloc(
    getLocationUseCase: GetLocationUseCase(loc ?? _Loc()),
    getMarkersUseCase: GetRestaurantMarkersUseCase(r),
    getNearestUseCase: GetNearestRestaurantsUseCase(r),
    restaurantRepository: r,
    getAllMarkersUseCase: GetAllMarkersUseCase(r),
    markerDataService: _MrkSvc(),
  );
}

Widget _wrap(ExploreBloc bloc, {ThemeMode mode = ThemeMode.light}) =>
    BlocProvider<ExploreBloc>.value(
      value: bloc,
      child: MaterialApp(
        locale: const Locale('cs'),
        themeMode: mode,
        theme: ThemeData.light(useMaterial3: true),
        darkTheme: ThemeData.dark(useMaterial3: true),
        localizationsDelegates: const [S.delegate, GlobalMaterialLocalizations.delegate, GlobalWidgetsLocalizations.delegate, GlobalCupertinoLocalizations.delegate],
        supportedLocales: S.supportedLocales,
        home: const _Shell(),
      ),
    );

// Tests -----------------------------------------------------------------------

void main() {
  const phoneSize = Size(390, 844);

  group('Explore golden', () {
    testWidgets('explore_loading_light.png', (tester) async {
      tester.view.physicalSize = phoneSize;
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);
      final bloc = _bloc();
      bloc.add(const ExploreEvent.initializeRequested());
      await tester.pumpWidget(_wrap(bloc));
      await tester.pump();
      await expectLater(find.byType(MaterialApp), matchesGoldenFile('goldens/explore_loading_light.png'));
      bloc.close();
    });

    testWidgets('explore_loaded_light.png', (tester) async {
      tester.view.physicalSize = phoneSize;
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);
      final bloc = _bloc();
      bloc.add(const ExploreEvent.initializeRequested());
      await tester.pumpWidget(_wrap(bloc));
      await tester.pumpAndSettle();
      await expectLater(find.byType(MaterialApp), matchesGoldenFile('goldens/explore_loaded_light.png'));
      bloc.close();
    });

    testWidgets('explore_loaded_dark.png', (tester) async {
      tester.view.physicalSize = phoneSize;
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);
      final bloc = _bloc();
      bloc.add(const ExploreEvent.initializeRequested());
      await tester.pumpWidget(_wrap(bloc, mode: ThemeMode.dark));
      await tester.pumpAndSettle();
      await expectLater(find.byType(MaterialApp), matchesGoldenFile('goldens/explore_loaded_dark.png'));
      bloc.close();
    });

    testWidgets('explore_empty_light.png', (tester) async {
      tester.view.physicalSize = phoneSize;
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);
      final bloc = _bloc(repo: _Repo(restaurants: []));
      bloc.add(const ExploreEvent.initializeRequested());
      await tester.pumpWidget(_wrap(bloc));
      await tester.pumpAndSettle();
      await expectLater(find.byType(MaterialApp), matchesGoldenFile('goldens/explore_empty_light.png'));
      bloc.close();
    });

    testWidgets('explore_error_light.png', (tester) async {
      tester.view.physicalSize = phoneSize;
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);
      final loc = _Loc()..error = Exception('GPS timeout');
      final bloc = _bloc(loc: loc);
      bloc.add(const ExploreEvent.initializeRequested());
      await tester.pumpWidget(_wrap(bloc));
      await tester.pumpAndSettle();
      await expectLater(find.byType(MaterialApp), matchesGoldenFile('goldens/explore_error_light.png'));
      bloc.close();
    });

    testWidgets('explore_error_dark.png', (tester) async {
      tester.view.physicalSize = phoneSize;
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);
      final loc = _Loc()..error = Exception('GPS timeout');
      final bloc = _bloc(loc: loc);
      bloc.add(const ExploreEvent.initializeRequested());
      await tester.pumpWidget(_wrap(bloc, mode: ThemeMode.dark));
      await tester.pumpAndSettle();
      await expectLater(find.byType(MaterialApp), matchesGoldenFile('goldens/explore_error_dark.png'));
      bloc.close();
    });
  });
}
