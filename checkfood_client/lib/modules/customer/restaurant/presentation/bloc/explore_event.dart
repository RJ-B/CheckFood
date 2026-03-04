import 'package:freezed_annotation/freezed_annotation.dart';
import '../../data/models/request/map_params_model.dart';
import '../../domain/entities/restaurant_filters.dart';

part 'explore_event.freezed.dart';

@freezed
class ExploreEvent with _$ExploreEvent {
  const factory ExploreEvent.initializeRequested() = InitializeRequested;

  const factory ExploreEvent.permissionResultReceived({required bool granted}) =
      PermissionResultReceived;

  const factory ExploreEvent.mapBoundsChanged({
    required MapParamsModel params,
  }) = MapBoundsChanged;

  const factory ExploreEvent.loadMoreRequested() = LoadMoreRequested;

  const factory ExploreEvent.refreshRequested() = RefreshRequested;

  /// Search query changed (debounced in bloc)
  const factory ExploreEvent.searchChanged({required String query}) =
      SearchChanged;

  /// Filters changed (cuisine, rating, openNow, favouritesOnly)
  const factory ExploreEvent.filtersChanged({
    required RestaurantFilters filters,
  }) = FiltersChanged;
}
