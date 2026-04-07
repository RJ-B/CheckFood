import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:stream_transform/stream_transform.dart';
import 'dart:developer' as dev;

import '../../data/models/request/map_params_model.dart';
import '../../data/services/marker_data_service.dart';
import '../../domain/entities/explore_data.dart';
import '../../domain/entities/restaurant.dart';
import '../../domain/entities/restaurant_filters.dart';
import '../../domain/entities/restaurant_marker.dart';
import '../../domain/repositories/restaurant_repository.dart';
import '../../domain/usecases/explore_usecases.dart';
import '../../domain/usecases/get_all_markers_usecase.dart';
import '../utils/client_cluster_manager.dart';
import 'explore_event.dart';
import 'explore_state.dart';

/// BLoC that manages the map explore flow: location permission, client-side
/// clustering, background marker sync, restaurant search, and marker selection.
class ExploreBloc extends Bloc<ExploreEvent, ExploreState> {
  final GetLocationUseCase _getLocationUseCase;
  final GetRestaurantMarkersUseCase _getMarkersUseCase;
  final GetNearestRestaurantsUseCase _getNearestUseCase;
  final RestaurantRepository _restaurantRepository;
  final GetAllMarkersUseCase _getAllMarkersUseCase;
  final MarkerDataService _markerDataService;

  final ClientClusterManager clusterManager = ClientClusterManager();

  ViewportChanged? _lastViewport;

  ExploreBloc({
    required GetLocationUseCase getLocationUseCase,
    required GetRestaurantMarkersUseCase getMarkersUseCase,
    required GetNearestRestaurantsUseCase getNearestUseCase,
    required RestaurantRepository restaurantRepository,
    required GetAllMarkersUseCase getAllMarkersUseCase,
    required MarkerDataService markerDataService,
  })  : _getLocationUseCase = getLocationUseCase,
        _getMarkersUseCase = getMarkersUseCase,
        _getNearestUseCase = getNearestUseCase,
        _restaurantRepository = restaurantRepository,
        _getAllMarkersUseCase = getAllMarkersUseCase,
        _markerDataService = markerDataService,
        super(const ExploreState.initial()) {
    on<InitializeRequested>(_onInitializeRequested);
    on<PermissionResultReceived>(_onPermissionResultReceived);
    on<RefreshRequested>(_onRefreshRequested);
    on<MarkerSelected>(_onMarkerSelected);
    on<MarkersRefreshed>(_onMarkersRefreshed);

    on<MapBoundsChanged>(
      _onMapBoundsChanged,
      transformer: (events, mapper) =>
          events.debounce(const Duration(milliseconds: 300)).switchMap(mapper),
    );

    on<ViewportChanged>(
      _onViewportChanged,
      transformer: (events, mapper) =>
          events.debounce(const Duration(milliseconds: 200)).switchMap(mapper),
    );

    on<SearchChanged>(
      _onSearchChanged,
      transformer: (events, mapper) =>
          events.debounce(const Duration(milliseconds: 400)).switchMap(mapper),
    );
  }

  Future<void> _onInitializeRequested(
    InitializeRequested event,
    Emitter<ExploreState> emit,
  ) async {
    emit(const ExploreState.loading());
    await _startFlow(emit);
  }

  Future<void> _onPermissionResultReceived(
    PermissionResultReceived event,
    Emitter<ExploreState> emit,
  ) async {
    if (event.granted) {
      emit(const ExploreState.loading());
      await _startFlow(emit);
    } else {
      emit(const ExploreState.permissionRequired());
    }
  }

  Future<void> _onRefreshRequested(
    RefreshRequested event,
    Emitter<ExploreState> emit,
  ) async {
    emit(const ExploreState.loading());
    await _startFlow(emit);
  }

  Future<void> _startFlow(Emitter<ExploreState> emit) async {
    try {
      final position = await _getLocationUseCase.execute();

      bool engineReady = false;
      final cached = await _markerDataService.loadFromDisk();
      if (cached != null) {
        clusterManager.load(cached.data);
        engineReady = true;
        dev.log(
          'Cluster engine loaded from disk: ${cached.data.length} pts, '
          'version=${cached.version}',
          name: 'CheckFood.Map',
        );
      }

      final restaurants = await _getNearestUseCase.execute(
        lat: position.latitude,
        lng: position.longitude,
        page: 0,
      );

      emit(ExploreState.loaded(
        data: ExploreData.initial().copyWith(
          userPosition: position,
          restaurants: restaurants,
          markers: [],
          clusterEngineReady: engineReady,
        ),
      ));

      _syncMarkerData();
    } catch (e) {
      if (e.toString().contains('denied')) {
        emit(const ExploreState.permissionRequired());
      } else {
        emit(ExploreState.error(message: e.toString()));
      }
    }
  }

  void _syncMarkerData() {
    _doSyncMarkerData().catchError((Object e) {
      dev.log('Background marker sync failed: $e', name: 'CheckFood.Map');
    });
  }

  Future<void> _doSyncMarkerData() async {
    final localVersion = await _markerDataService.getLocalVersion();

    int? serverVersion;
    try {
      serverVersion = await _restaurantRepository.getMarkersVersion();
    } catch (e) {
      dev.log('getMarkersVersion failed: $e', name: 'CheckFood.Map');
      if (localVersion != null) return;
    }

    final needsUpdate = serverVersion == null ||
        localVersion == null ||
        serverVersion != localVersion;

    if (!needsUpdate) {
      dev.log(
        'Marker data up to date (version=$localVersion)',
        name: 'CheckFood.Map',
      );
      return;
    }

    dev.log(
      'Fetching all markers from backend '
      '(local=$localVersion, server=$serverVersion)',
      name: 'CheckFood.Map',
    );

    final result = await _getAllMarkersUseCase.execute();
    await _markerDataService.saveToDisk(result.version, result.data);
    clusterManager.load(result.data);

    dev.log(
      'Cluster engine updated: ${result.data.length} pts, '
      'version=${result.version}',
      name: 'CheckFood.Map',
    );

    if (!isClosed) {
      add(ExploreEvent.markersRefreshed(version: result.version));
    }
  }

  Future<void> _onMarkersRefreshed(
    MarkersRefreshed event,
    Emitter<ExploreState> emit,
  ) async {
    if (state is! Loaded) return;
    final currentData = (state as Loaded).data;

    final vp = _lastViewport;
    final List<RestaurantMarker> newMarkers = vp != null
        ? clusterManager.getClusters(
            minLng: vp.minLng,
            minLat: vp.minLat,
            maxLng: vp.maxLng,
            maxLat: vp.maxLat,
            zoom: vp.zoom,
          )
        : currentData.markers;

    emit(ExploreState.loaded(
      data: currentData.copyWith(
        clusterEngineReady: true,
        markers: newMarkers,
      ),
    ));
  }

  Future<void> _onViewportChanged(
    ViewportChanged event,
    Emitter<ExploreState> emit,
  ) async {
    if (state is! Loaded) return;
    final currentData = (state as Loaded).data;

    _lastViewport = event;

    if (currentData.clusterEngineReady) {
      final sw = Stopwatch()..start();
      final markers = clusterManager.getClusters(
        minLng: event.minLng,
        minLat: event.minLat,
        maxLng: event.maxLng,
        maxLat: event.maxLat,
        zoom: event.zoom,
      );
      sw.stop();

      emit(ExploreState.loaded(
        data: currentData.copyWith(
          markers: markers,
          isMapLoading: false,
          selectedRestaurantId: currentData.selectedRestaurantId,
          selectedRestaurant: currentData.selectedRestaurant,
        ),
      ));
    } else {
      try {
        emit(ExploreState.loaded(
          data: currentData.copyWith(isMapLoading: true),
        ));

        final markers = await _getMarkersUseCase.execute(
          MapParamsModel(
            bounds: LatLngBounds(
              southwest: LatLng(event.minLat, event.minLng),
              northeast: LatLng(event.maxLat, event.maxLng),
            ),
            zoom: event.zoom,
          ),
        );

        dev.log(
          'Server cluster zoom=${event.zoom} markers=${markers.length}',
          name: 'CheckFood.Map',
        );

        emit(ExploreState.loaded(
          data: currentData.copyWith(
            markers: markers,
            isMapLoading: false,
            selectedRestaurantId: currentData.selectedRestaurantId,
            selectedRestaurant: currentData.selectedRestaurant,
          ),
        ));
      } catch (e) {
        dev.log('ViewportChanged server fallback error: $e',
            error: e, name: 'CheckFood.Explore');
        emit(ExploreState.loaded(
          data: currentData.copyWith(isMapLoading: false),
        ));
      }
    }
  }

  Future<void> _onMapBoundsChanged(
    MapBoundsChanged event,
    Emitter<ExploreState> emit,
  ) async {
    if (state is! Loaded) return;
    final currentData = (state as Loaded).data;

    final p = event.params;
    final minLat = p.bounds.southwest.latitude;
    final maxLat = p.bounds.northeast.latitude;
    final minLng = p.bounds.southwest.longitude;
    final maxLng = p.bounds.northeast.longitude;

    _lastViewport = ExploreEvent.viewportChanged(
      minLat: minLat,
      maxLat: maxLat,
      minLng: minLng,
      maxLng: maxLng,
      zoom: p.zoom,
    ) as ViewportChanged;

    if (currentData.clusterEngineReady) {
      final markers = clusterManager.getClusters(
        minLng: minLng,
        minLat: minLat,
        maxLng: maxLng,
        maxLat: maxLat,
        zoom: p.zoom,
      );

      dev.log(
        'legacy client cluster zoom=${p.zoom} markers=${markers.length}',
        name: 'CheckFood.Map',
      );

      emit(ExploreState.loaded(
        data: currentData.copyWith(
          markers: markers,
          isMapLoading: false,
          selectedRestaurantId: currentData.selectedRestaurantId,
          selectedRestaurant: currentData.selectedRestaurant,
        ),
      ));
    } else {
      try {
        emit(ExploreState.loaded(
          data: currentData.copyWith(isMapLoading: true),
        ));

        final sw = Stopwatch()..start();

        final results = await Future.wait([
          _getMarkersUseCase.execute(event.params),
          _getNearestUseCase.execute(
            lat: currentData.userPosition.latitude,
            lng: currentData.userPosition.longitude,
            page: 0,
            filters: currentData.searchQuery != null &&
                    currentData.searchQuery!.isNotEmpty
                ? RestaurantFilters(searchQuery: currentData.searchQuery)
                : null,
          ),
        ]);

        final markers = results[0] as List<RestaurantMarker>;
        final restaurants = results[1] as List<Restaurant>;
        sw.stop();

        dev.log(
          'legacy api zoom=${p.zoom} markers=${markers.length} '
          'restaurants=${restaurants.length} ms=${sw.elapsedMilliseconds}',
          name: 'CheckFood.Map',
        );

        emit(ExploreState.loaded(
          data: currentData.copyWith(
            markers: markers,
            restaurants: restaurants,
            isMapLoading: false,
            selectedRestaurantId: currentData.selectedRestaurantId,
            selectedRestaurant: currentData.selectedRestaurant,
          ),
        ));
      } catch (e) {
        dev.log('Map Update Error: $e', error: e, name: 'CheckFood.Explore');
        emit(ExploreState.loaded(
          data: currentData.copyWith(isMapLoading: false),
        ));
      }
    }
  }

  Future<void> _onSearchChanged(
    SearchChanged event,
    Emitter<ExploreState> emit,
  ) async {
    if (state is! Loaded) return;
    final currentData = (state as Loaded).data;

    emit(ExploreState.loaded(
      data: currentData.copyWith(
        searchQuery: event.query.isEmpty ? null : event.query,
        isMapLoading: true,
      ),
    ));

    try {
      final restaurants = await _getNearestUseCase.execute(
        lat: currentData.userPosition.latitude,
        lng: currentData.userPosition.longitude,
        page: 0,
        filters: event.query.isNotEmpty
            ? RestaurantFilters(searchQuery: event.query)
            : null,
      );

      emit(ExploreState.loaded(
        data: currentData.copyWith(
          searchQuery: event.query.isEmpty ? null : event.query,
          restaurants: restaurants,
          isMapLoading: false,
          selectedRestaurantId: null,
          selectedRestaurant: null,
        ),
      ));
    } catch (e) {
      dev.log('Search Error: $e', error: e, name: 'CheckFood.Explore');
      emit(ExploreState.loaded(
        data: currentData.copyWith(isMapLoading: false),
      ));
    }
  }

  Future<void> _onMarkerSelected(
    MarkerSelected event,
    Emitter<ExploreState> emit,
  ) async {
    if (state is! Loaded) return;
    final currentData = (state as Loaded).data;

    if (event.restaurantId == null) {
      emit(ExploreState.loaded(
        data: currentData.copyWith(
          selectedRestaurantId: null,
          selectedRestaurant: null,
        ),
      ));
      return;
    }

    var found = currentData.restaurants
        .where((r) => r.id == event.restaurantId)
        .firstOrNull;

    if (found == null) {
      try {
        found = await _restaurantRepository
            .getRestaurantById(event.restaurantId!);
      } catch (e) {
        dev.log(
          'Failed to fetch restaurant ${event.restaurantId}: $e',
          name: 'CheckFood.Explore',
        );
      }
    }

    emit(ExploreState.loaded(
      data: currentData.copyWith(
        selectedRestaurantId: event.restaurantId,
        selectedRestaurant: found,
      ),
    ));
  }
}
