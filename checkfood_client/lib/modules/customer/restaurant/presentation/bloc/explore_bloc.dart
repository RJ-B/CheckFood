import 'dart:math' as math;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:stream_transform/stream_transform.dart';
import 'dart:developer' as dev;

import '../../../../../core/services/google_places_service.dart';
import '../../domain/entities/explore_data.dart';
import '../../domain/entities/google_place.dart';
import '../../domain/entities/restaurant_marker.dart';
import '../../domain/usecases/explore_usecases.dart';
import 'explore_event.dart';
import 'explore_state.dart';

class ExploreBloc extends Bloc<ExploreEvent, ExploreState> {
  final GetLocationUseCase _getLocationUseCase;
  final GooglePlacesService _placesService;

  ExploreBloc({
    required GetLocationUseCase getLocationUseCase,
    required GooglePlacesService placesService,
  })  : _getLocationUseCase = getLocationUseCase,
        _placesService = placesService,
        super(const ExploreState.initial()) {
    on<InitializeRequested>(_onInitializeRequested);
    on<PermissionResultReceived>(_onPermissionResultReceived);
    on<RefreshRequested>(_onRefreshRequested);
    on<MarkerSelected>(_onMarkerSelected);

    on<MapBoundsChanged>(
      _onMapBoundsChanged,
      transformer: (events, mapper) =>
          events.debounce(const Duration(milliseconds: 300)).switchMap(mapper),
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
      final places = await _placesService.searchNearby(
        latitude: position.latitude,
        longitude: position.longitude,
        radiusMeters: 3000,
      );

      final markers = _clusterPlaces(places, 15);

      emit(ExploreState.loaded(
        data: ExploreData.initial().copyWith(
          userPosition: position,
          places: places,
          markers: markers,
        ),
      ));
    } catch (e) {
      if (e.toString().contains('denied')) {
        emit(const ExploreState.permissionRequired());
      } else {
        emit(ExploreState.error(message: e.toString()));
      }
    }
  }

  Future<void> _onMapBoundsChanged(
    MapBoundsChanged event,
    Emitter<ExploreState> emit,
  ) async {
    if (state is! Loaded) return;
    final currentState = state as Loaded;
    final data = currentState.data;

    try {
      emit(ExploreState.loaded(
        data: data.copyWith(isMapLoading: true),
      ));

      final bounds = event.params.bounds;
      final zoom = event.params.zoom;

      final centerLat =
          (bounds.southwest.latitude + bounds.northeast.latitude) / 2;
      final centerLng =
          (bounds.southwest.longitude + bounds.northeast.longitude) / 2;

      final radius = Geolocator.distanceBetween(
        centerLat,
        centerLng,
        bounds.northeast.latitude,
        bounds.northeast.longitude,
      );

      final sw = Stopwatch()..start();

      List<GooglePlace> places;
      if (data.searchQuery != null && data.searchQuery!.isNotEmpty) {
        places = await _placesService.searchText(
          query: data.searchQuery!,
          latitude: centerLat,
          longitude: centerLng,
          radiusMeters: radius,
        );
      } else {
        places = await _placesService.searchNearby(
          latitude: centerLat,
          longitude: centerLng,
          radiusMeters: radius,
        );
      }

      final markers = _clusterPlaces(places, zoom);
      sw.stop();

      dev.log(
        'places zoom=$zoom total=${places.length} '
        'markers=${markers.length} ms=${sw.elapsedMilliseconds}',
        name: 'CheckFood.Map',
      );

      emit(ExploreState.loaded(
        data: data.copyWith(
          places: places,
          markers: markers,
          isMapLoading: false,
          // Deselect if selected place is no longer in results
          selectedPlaceId: data.selectedPlaceId != null &&
                  places.any((p) => p.id == data.selectedPlaceId)
              ? data.selectedPlaceId
              : null,
          selectedPlace: data.selectedPlaceId != null &&
                  places.any((p) => p.id == data.selectedPlaceId)
              ? data.selectedPlace
              : null,
        ),
      ));
    } catch (e) {
      dev.log('Map Update Error: $e', error: e, name: 'CheckFood.Explore');
      emit(ExploreState.loaded(
        data: data.copyWith(isMapLoading: false),
      ));
    }
  }

  Future<void> _onSearchChanged(
    SearchChanged event,
    Emitter<ExploreState> emit,
  ) async {
    if (state is! Loaded) return;
    final currentState = state as Loaded;
    final data = currentState.data;

    emit(ExploreState.loaded(
      data: data.copyWith(
        searchQuery: event.query.isEmpty ? null : event.query,
        isMapLoading: true,
      ),
    ));

    try {
      List<GooglePlace> places;
      if (event.query.isNotEmpty) {
        places = await _placesService.searchText(
          query: event.query,
          latitude: data.userPosition.latitude,
          longitude: data.userPosition.longitude,
          radiusMeters: 5000,
        );
      } else {
        places = await _placesService.searchNearby(
          latitude: data.userPosition.latitude,
          longitude: data.userPosition.longitude,
          radiusMeters: 3000,
        );
      }

      final markers = _clusterPlaces(places, 15);

      emit(ExploreState.loaded(
        data: data.copyWith(
          searchQuery: event.query.isEmpty ? null : event.query,
          places: places,
          markers: markers,
          isMapLoading: false,
          selectedPlaceId: null,
          selectedPlace: null,
        ),
      ));
    } catch (e) {
      dev.log('Search Error: $e', error: e, name: 'CheckFood.Explore');
      emit(ExploreState.loaded(
        data: data.copyWith(isMapLoading: false),
      ));
    }
  }

  Future<void> _onMarkerSelected(
    MarkerSelected event,
    Emitter<ExploreState> emit,
  ) async {
    if (state is! Loaded) return;
    final currentState = state as Loaded;
    final data = currentState.data;

    if (event.placeId == null) {
      emit(ExploreState.loaded(
        data: data.copyWith(selectedPlaceId: null, selectedPlace: null),
      ));
      return;
    }

    final found =
        data.places.where((p) => p.id == event.placeId).firstOrNull;

    emit(ExploreState.loaded(
      data: data.copyWith(
        selectedPlaceId: event.placeId,
        selectedPlace: found,
      ),
    ));
  }

  // ---------------------------------------------------------------------------
  // Grid-based clustering
  // ---------------------------------------------------------------------------

  List<RestaurantMarker> _clusterPlaces(List<GooglePlace> places, int zoom) {
    if (places.isEmpty) return [];

    // No clustering at street level
    if (zoom >= 17) {
      return places
          .map((p) => RestaurantMarker(
                id: p.id,
                latitude: p.latitude,
                longitude: p.longitude,
                count: 1,
              ))
          .toList();
    }

    // Grid cell size in degrees — proportional to zoom
    final cellSize = 360.0 / (256 * math.pow(2, zoom)) * 60;

    final Map<String, List<GooglePlace>> grid = {};
    for (final place in places) {
      final cellX = (place.longitude / cellSize).floor();
      final cellY = (place.latitude / cellSize).floor();
      final key = '${cellX}_$cellY';
      grid.putIfAbsent(key, () => []).add(place);
    }

    return grid.values.map((group) {
      if (group.length == 1) {
        final p = group.first;
        return RestaurantMarker(
          id: p.id,
          latitude: p.latitude,
          longitude: p.longitude,
          count: 1,
        );
      }

      // Cluster: centroid of group
      final lat =
          group.map((p) => p.latitude).reduce((a, b) => a + b) / group.length;
      final lng =
          group.map((p) => p.longitude).reduce((a, b) => a + b) / group.length;

      return RestaurantMarker(
        id: null,
        latitude: lat,
        longitude: lng,
        count: group.length,
      );
    }).toList();
  }
}
