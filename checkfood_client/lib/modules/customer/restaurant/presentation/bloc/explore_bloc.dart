import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stream_transform/stream_transform.dart';
import 'dart:developer' as dev;

import '../../domain/entities/explore_data.dart';
import '../../domain/entities/restaurant_filters.dart';
import '../../domain/usecases/explore_usecases.dart';
import 'explore_event.dart';
import 'explore_state.dart';

class ExploreBloc extends Bloc<ExploreEvent, ExploreState> {
  final GetLocationUseCase _getLocationUseCase;
  final GetRestaurantMarkersUseCase _getMarkersUseCase;
  final GetNearestRestaurantsUseCase _getNearestUseCase;

  ExploreBloc({
    required GetLocationUseCase getLocationUseCase,
    required GetRestaurantMarkersUseCase getMarkersUseCase,
    required GetNearestRestaurantsUseCase getNearestUseCase,
  }) : _getLocationUseCase = getLocationUseCase,
       _getMarkersUseCase = getMarkersUseCase,
       _getNearestUseCase = getNearestUseCase,
       super(const ExploreState.initial()) {
    on<InitializeRequested>(_onInitializeRequested);
    on<PermissionResultReceived>(_onPermissionResultReceived);
    on<LoadMoreRequested>(_onLoadMoreRequested);
    on<RefreshRequested>(_onRefreshRequested);
    on<FiltersChanged>(_onFiltersChanged);

    on<MapBoundsChanged>(
      _onMapBoundsChanged,
      transformer:
          (events, mapper) => events
              .debounce(const Duration(milliseconds: 300))
              .switchMap(mapper),
    );

    on<SearchChanged>(
      _onSearchChanged,
      transformer:
          (events, mapper) => events
              .debounce(const Duration(milliseconds: 400))
              .switchMap(mapper),
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

  Future<void> _onMapBoundsChanged(
    MapBoundsChanged event,
    Emitter<ExploreState> emit,
  ) async {
    if (state is! Loaded) return;
    final currentState = state as Loaded;

    try {
      emit(
        ExploreState.loaded(
          data: currentState.data.copyWith(isMapLoading: true),
        ),
      );

      final sw = Stopwatch()..start();
      final markers = await _getMarkersUseCase.execute(event.params);
      sw.stop();

      final clusters = markers.where((m) => m.isCluster).length;
      final maxCount = markers.fold<int>(0, (prev, m) => m.count > prev ? m.count : prev);
      dev.log(
        'markers zoom=${event.params.zoom} '
        'total=${markers.length} clusters=$clusters points=${markers.length - clusters} '
        'maxCount=$maxCount ms=${sw.elapsedMilliseconds}',
        name: 'CheckFood.Map',
      );

      emit(
        ExploreState.loaded(
          data: currentState.data.copyWith(
            markers: markers,
            isMapLoading: false,
          ),
        ),
      );
    } catch (e) {
      dev.log('Map Update Error: $e', error: e, name: 'CheckFood.Explore');
      emit(
        ExploreState.loaded(
          data: currentState.data.copyWith(isMapLoading: false),
        ),
      );
    }
  }

  Future<void> _onSearchChanged(
    SearchChanged event,
    Emitter<ExploreState> emit,
  ) async {
    if (state is! Loaded) return;
    final currentState = state as Loaded;
    final data = currentState.data;

    final newFilters = data.filters.copyWith(
      searchQuery: event.query.isEmpty ? null : event.query,
    );

    await _reloadWithFilters(data, newFilters, emit);
  }

  Future<void> _onFiltersChanged(
    FiltersChanged event,
    Emitter<ExploreState> emit,
  ) async {
    if (state is! Loaded) return;
    final currentState = state as Loaded;
    final data = currentState.data;

    await _reloadWithFilters(data, event.filters, emit);
  }

  Future<void> _reloadWithFilters(
    ExploreData data,
    RestaurantFilters filters,
    Emitter<ExploreState> emit,
  ) async {
    emit(
      ExploreState.loaded(
        data: data.copyWith(
          filters: filters,
          isPaginationLoading: true,
          nearestRestaurants: [],
          currentPage: 0,
        ),
      ),
    );

    try {
      final restaurants = await _getNearestUseCase.execute(
        lat: data.userPosition.latitude,
        lng: data.userPosition.longitude,
        page: 0,
        filters: filters,
      );

      emit(
        ExploreState.loaded(
          data: data.copyWith(
            filters: filters,
            nearestRestaurants: restaurants,
            currentPage: 0,
            hasMore: restaurants.length >= 10,
            isPaginationLoading: false,
          ),
        ),
      );
    } catch (e) {
      dev.log('Filter Error: $e', error: e, name: 'CheckFood.Explore');
      emit(
        ExploreState.loaded(
          data: data.copyWith(
            filters: filters,
            isPaginationLoading: false,
          ),
        ),
      );
    }
  }

  Future<void> _onLoadMoreRequested(
    LoadMoreRequested event,
    Emitter<ExploreState> emit,
  ) async {
    if (state is! Loaded) return;
    final currentState = state as Loaded;
    final data = currentState.data;

    if (data.isPaginationLoading || !data.hasMore) return;

    emit(ExploreState.loaded(data: data.copyWith(isPaginationLoading: true)));

    try {
      final nextPage = data.currentPage + 1;
      final newRestaurants = await _getNearestUseCase.execute(
        lat: data.userPosition.latitude,
        lng: data.userPosition.longitude,
        page: nextPage,
        filters: data.filters,
      );

      emit(
        ExploreState.loaded(
          data: data.copyWith(
            nearestRestaurants: [...data.nearestRestaurants, ...newRestaurants],
            currentPage: nextPage,
            hasMore: newRestaurants.length >= 10,
            isPaginationLoading: false,
          ),
        ),
      );
    } catch (e) {
      emit(
        ExploreState.loaded(data: data.copyWith(isPaginationLoading: false)),
      );
    }
  }

  Future<void> _startFlow(Emitter<ExploreState> emit) async {
    try {
      final position = await _getLocationUseCase.execute();
      final restaurants = await _getNearestUseCase.execute(
        lat: position.latitude,
        lng: position.longitude,
        page: 0,
      );

      emit(
        ExploreState.loaded(
          data: ExploreData.initial().copyWith(
            userPosition: position,
            nearestRestaurants: restaurants,
            hasMore: restaurants.length >= 10,
          ),
        ),
      );
    } catch (e) {
      if (e.toString().contains('denied')) {
        emit(const ExploreState.permissionRequired());
      } else {
        emit(ExploreState.error(message: e.toString()));
      }
    }
  }

  Future<void> _onRefreshRequested(
    RefreshRequested event,
    Emitter<ExploreState> emit,
  ) async {
    emit(const ExploreState.loading());
    await _startFlow(emit);
  }
}
