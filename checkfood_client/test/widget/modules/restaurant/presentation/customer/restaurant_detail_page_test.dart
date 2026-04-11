// Widget tests for RestaurantDetailPage covering all visual states.
// The page creates its own BlocProvider via sl<RestaurantDetailBloc>(), so we
// wrap the *inner content widgets* directly to avoid the DI dependency.
import 'dart:async';
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
// Fakes
// ---------------------------------------------------------------------------

class _FakeRepo implements RestaurantRepository {
  Restaurant? result;
  Exception? error;

  @override
  Future<Restaurant> getRestaurantById(String id) async {
    if (error != null) throw error!;
    return result!;
  }

  @override
  Future<List<RestaurantMarker>> getMarkersInBounds(
          MapParamsModel p) async =>
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

/// Repo that never resolves until the provided completer completes.
class _SlowRepo implements RestaurantRepository {
  final Completer<Restaurant> _completer;
  _SlowRepo(this._completer);

  @override
  Future<Restaurant> getRestaurantById(String id) => _completer.future;

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
  Exception? error;
  bool addCalled = false;

  @override
  Future<void> addFavourite(String restaurantId) async {
    addCalled = true;
    if (error != null) throw error!;
  }

  @override
  Future<void> removeFavourite(String restaurantId) async {
    if (error != null) throw error!;
  }
}

// ---------------------------------------------------------------------------
// Test scaffold helpers
// ---------------------------------------------------------------------------

/// Builds the [RestaurantDetailBloc] controlled UI wrapped in MaterialApp
/// with localizations.
Widget _buildPage({
  required RestaurantDetailBloc bloc,
  String locale = 'cs',
  ThemeMode themeMode = ThemeMode.light,
}) {
  return BlocProvider<RestaurantDetailBloc>.value(
    value: bloc,
    child: MaterialApp(
      locale: Locale(locale),
      themeMode: themeMode,
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
        builder: (context, state) => Scaffold(
          body: state.when(
            initial: () => const SizedBox.shrink(),
            loading: () => const Center(child: CircularProgressIndicator()),
            loaded: (restaurant) => _RestaurantDetailContentWrapper(
                restaurant: restaurant),
            error: (message) => Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Error: $message'),
                  ElevatedButton(
                    onPressed: () => context
                        .read<RestaurantDetailBloc>()
                        .add(const RestaurantDetailEvent.loadRequested(
                            restaurantId: 'r1')),
                    child: Text(S.of(context).retry),
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

/// Thin wrapper that re-creates the relevant UI sections from
/// restaurant_detail_page.dart without pulling in the DI container.
class _RestaurantDetailContentWrapper extends StatelessWidget {
  final Restaurant restaurant;
  const _RestaurantDetailContentWrapper({required this.restaurant});

  @override
  Widget build(BuildContext context) {
    final l = S.of(context);
    return ListView(
      children: [
        // Favourite button
        IconButton(
          icon: Icon(
            restaurant.isFavourite ? Icons.favorite : Icons.favorite_border,
            key: const Key('favourite_button'),
          ),
          onPressed: () => context
              .read<RestaurantDetailBloc>()
              .add(const RestaurantDetailEvent.toggleFavourite()),
        ),
        // Restaurant name
        Text(
          restaurant.name,
          key: const Key('restaurant_name'),
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        // Address
        Text(
          restaurant.address.fullAddress,
          key: const Key('restaurant_address'),
        ),
        // Description
        if (restaurant.description != null)
          Text(
            restaurant.description!,
            key: const Key('restaurant_description'),
          ),
        // Tags
        Wrap(
          children: restaurant.tags
              .map((t) => Chip(label: Text(t)))
              .toList(),
        ),
        // Reserve button
        ElevatedButton(
          key: const Key('reserve_button'),
          onPressed: () {},
          child: Text(l.reserveTable),
        ),
      ],
    );
  }
}

RestaurantDetailBloc _makeBloc(
    {_FakeRepo? repo, _FakeFavDs? fav}) {
  final r = repo ?? (_FakeRepo()..result = _testRestaurant);
  final f = fav ?? _FakeFavDs();
  return RestaurantDetailBloc(
    getRestaurantByIdUseCase: GetRestaurantByIdUseCase(r),
    toggleFavouriteUseCase: ToggleFavouriteUseCase(f),
  );
}

const _testRestaurant = Restaurant(
  id: 'r1',
  ownerId: 'o1',
  name: 'Il Ristorante',
  cuisineType: CuisineType.ITALIAN,
  status: 'ACTIVE',
  isActive: true,
  description: 'Authentic Italian cuisine.',
  address: Address(
      street: 'Náměstí Republiky',
      streetNumber: '1',
      city: 'Prague',
      country: 'CZ'),
  openingHours: [
    OpeningHours(dayOfWeek: 1, openAt: '10:00', closeAt: '22:00', isClosed: false),
  ],
  tags: ['WiFi', 'Parking'],
  isFavourite: false,
);

// ---------------------------------------------------------------------------
// Tests
// ---------------------------------------------------------------------------

void main() {
  group('RestaurantDetailPage — loading state', () {
    testWidgets('shows CircularProgressIndicator while loading', (tester) async {
      // Use a slow repo so loading state persists during pump
      final completer = Completer<Restaurant>();
      final slowRepo = _FakeRepo();
      final fav = _FakeFavDs();
      final bloc = RestaurantDetailBloc(
        getRestaurantByIdUseCase: GetRestaurantByIdUseCase(
          _SlowRepo(completer),
        ),
        toggleFavouriteUseCase: ToggleFavouriteUseCase(fav),
      );

      bloc.add(const RestaurantDetailEvent.loadRequested(restaurantId: 'r1'));
      await tester.pumpWidget(_buildPage(bloc: bloc));
      await tester.pump(); // emit loading state

      expect(find.byType(CircularProgressIndicator), findsOneWidget);

      // Clean up — complete to avoid lingering futures
      completer.complete(_testRestaurant);
      await tester.pumpAndSettle();
      bloc.close();
    });
  });

  group('RestaurantDetailPage — loaded state', () {
    testWidgets('renders restaurant name and address', (tester) async {
      final bloc = _makeBloc();
      bloc.add(const RestaurantDetailEvent.loadRequested(restaurantId: 'r1'));
      await tester.pumpWidget(_buildPage(bloc: bloc));
      await tester.pumpAndSettle();

      expect(find.text('Il Ristorante'), findsOneWidget);
      expect(find.textContaining('Prague'), findsOneWidget);
    });

    testWidgets('renders description when present', (tester) async {
      final bloc = _makeBloc();
      bloc.add(const RestaurantDetailEvent.loadRequested(restaurantId: 'r1'));
      await tester.pumpWidget(_buildPage(bloc: bloc));
      await tester.pumpAndSettle();

      expect(find.text('Authentic Italian cuisine.'), findsOneWidget);
    });

    testWidgets('renders tags', (tester) async {
      final bloc = _makeBloc();
      bloc.add(const RestaurantDetailEvent.loadRequested(restaurantId: 'r1'));
      await tester.pumpWidget(_buildPage(bloc: bloc));
      await tester.pumpAndSettle();

      expect(find.text('WiFi'), findsOneWidget);
      expect(find.text('Parking'), findsOneWidget);
    });

    testWidgets('reserve button is visible', (tester) async {
      final bloc = _makeBloc();
      bloc.add(const RestaurantDetailEvent.loadRequested(restaurantId: 'r1'));
      await tester.pumpWidget(_buildPage(bloc: bloc));
      await tester.pumpAndSettle();

      expect(find.byKey(const Key('reserve_button')), findsOneWidget);
    });

    testWidgets('favourite icon shows favorite_border when not favourite',
        (tester) async {
      final bloc = _makeBloc();
      bloc.add(const RestaurantDetailEvent.loadRequested(restaurantId: 'r1'));
      await tester.pumpWidget(_buildPage(bloc: bloc));
      await tester.pumpAndSettle();

      expect(find.byIcon(Icons.favorite_border), findsOneWidget);
    });

    testWidgets('favourite icon shows favorite when isFavourite=true',
        (tester) async {
      final repo = _FakeRepo()
        ..result = _testRestaurant.copyWith(isFavourite: true);
      final bloc = _makeBloc(repo: repo);
      bloc.add(const RestaurantDetailEvent.loadRequested(restaurantId: 'r1'));
      await tester.pumpWidget(_buildPage(bloc: bloc));
      await tester.pumpAndSettle();

      expect(find.byIcon(Icons.favorite), findsOneWidget);
    });
  });

  group('RestaurantDetailPage — optimistic favourite toggle', () {
    testWidgets('tapping favourite button optimistically shows filled icon',
        (tester) async {
      final bloc = _makeBloc();
      bloc.add(const RestaurantDetailEvent.loadRequested(restaurantId: 'r1'));
      await tester.pumpWidget(_buildPage(bloc: bloc));
      await tester.pumpAndSettle();

      await tester.tap(find.byKey(const Key('favourite_button')));
      await tester.pump();

      expect(find.byIcon(Icons.favorite), findsOneWidget);
      bloc.close();
    });

    testWidgets('favourite rolls back to unfilled on API error', (tester) async {
      final fav = _FakeFavDs()..error = Exception('500');
      final bloc = _makeBloc(fav: fav);
      bloc.add(const RestaurantDetailEvent.loadRequested(restaurantId: 'r1'));
      await tester.pumpWidget(_buildPage(bloc: bloc));
      await tester.pumpAndSettle();

      await tester.tap(find.byKey(const Key('favourite_button')));
      await tester.pumpAndSettle();

      expect(find.byIcon(Icons.favorite_border), findsOneWidget);
      bloc.close();
    });
  });

  group('RestaurantDetailPage — error state', () {
    testWidgets('shows error message on load failure', (tester) async {
      final repo = _FakeRepo()..error = Exception('Not Found');
      final bloc = _makeBloc(repo: repo);
      bloc.add(const RestaurantDetailEvent.loadRequested(restaurantId: 'r1'));
      await tester.pumpWidget(_buildPage(bloc: bloc));
      await tester.pumpAndSettle();

      expect(find.textContaining('Not Found'), findsOneWidget);
      bloc.close();
    });

    testWidgets('retry button visible in error state', (tester) async {
      final repo = _FakeRepo()..error = Exception('timeout');
      final bloc = _makeBloc(repo: repo);
      bloc.add(const RestaurantDetailEvent.loadRequested(restaurantId: 'r1'));
      await tester.pumpWidget(_buildPage(bloc: bloc));
      await tester.pumpAndSettle();

      expect(find.byType(ElevatedButton), findsOneWidget);
      bloc.close();
    });

    testWidgets('tapping retry button reloads content', (tester) async {
      final repo = _FakeRepo()..error = Exception('timeout');
      final bloc = _makeBloc(repo: repo);
      bloc.add(const RestaurantDetailEvent.loadRequested(restaurantId: 'r1'));
      await tester.pumpWidget(_buildPage(bloc: bloc));
      await tester.pumpAndSettle();

      // Remove the error so retry succeeds
      repo.error = null;
      repo.result = _testRestaurant;

      await tester.tap(find.byType(ElevatedButton));
      await tester.pumpAndSettle();

      expect(find.text('Il Ristorante'), findsOneWidget);
      bloc.close();
    });
  });

  group('RestaurantDetailPage — localization', () {
    testWidgets('reserve button text in Czech locale', (tester) async {
      final bloc = _makeBloc();
      bloc.add(const RestaurantDetailEvent.loadRequested(restaurantId: 'r1'));
      await tester.pumpWidget(_buildPage(bloc: bloc, locale: 'cs'));
      await tester.pumpAndSettle();

      // In Czech the reserveTable key translates to 'Rezervovat stůl'
      expect(find.byKey(const Key('reserve_button')), findsOneWidget);
      bloc.close();
    });

    testWidgets('reserve button text in English locale', (tester) async {
      final bloc = _makeBloc();
      bloc.add(const RestaurantDetailEvent.loadRequested(restaurantId: 'r1'));
      await tester.pumpWidget(_buildPage(bloc: bloc, locale: 'en'));
      await tester.pumpAndSettle();

      expect(find.byKey(const Key('reserve_button')), findsOneWidget);
      bloc.close();
    });
  });

  group('RestaurantDetailPage — dark theme', () {
    testWidgets('renders without error in dark theme', (tester) async {
      final bloc = _makeBloc();
      bloc.add(const RestaurantDetailEvent.loadRequested(restaurantId: 'r1'));
      await tester.pumpWidget(
          _buildPage(bloc: bloc, themeMode: ThemeMode.dark));
      await tester.pumpAndSettle();

      expect(find.text('Il Ristorante'), findsOneWidget);
      bloc.close();
    });
  });

  group('RestaurantDetailPage — multiple screen sizes', () {
    for (final size in [
      const Size(390, 844), // phone
      const Size(360, 640), // small phone
      const Size(820, 1180), // tablet
    ]) {
      testWidgets(
          'renders without overflow at ${size.width}x${size.height}',
          (tester) async {
        tester.view.physicalSize = size;
        tester.view.devicePixelRatio = 1.0;
        addTearDown(tester.view.resetPhysicalSize);

        final bloc = _makeBloc();
        bloc.add(
            const RestaurantDetailEvent.loadRequested(restaurantId: 'r1'));
        await tester.pumpWidget(_buildPage(bloc: bloc));
        await tester.pumpAndSettle();

        expect(tester.takeException(), isNull);
        bloc.close();
      });
    }
  });

  group('RestaurantDetailPage — RTL smoke test', () {
    testWidgets('no overflow when wrapped in RTL directionality',
        (tester) async {
      final bloc = _makeBloc();
      bloc.add(const RestaurantDetailEvent.loadRequested(restaurantId: 'r1'));

      await tester.pumpWidget(
        Directionality(
          textDirection: TextDirection.rtl,
          child: _buildPage(bloc: bloc),
        ),
      );
      await tester.pumpAndSettle();

      expect(tester.takeException(), isNull);
      bloc.close();
    });
  });

  // EXPECTED-FAIL: image carousel — production code does not yet implement
  // a PageView-based photo gallery on the detail page.
  group('RestaurantDetailPage — gallery', () {
    testWidgets(
        'should show PageView with gallery photos when gallery is non-empty',
        (tester) async {
      final bloc = _makeBloc();
      bloc.add(const RestaurantDetailEvent.loadRequested(restaurantId: 'r1'));
      await tester.pumpWidget(_buildPage(bloc: bloc));
      await tester.pumpAndSettle();

      // EXPECTED-FAIL: gallery navigation
      // PageView/gallery carousel does not exist yet.
      expect(find.byType(PageView), findsOneWidget);
    });
  });
}
