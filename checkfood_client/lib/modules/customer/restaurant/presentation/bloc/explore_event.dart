import 'package:freezed_annotation/freezed_annotation.dart';
import '../../data/models/request/map_params_model.dart';

part 'explore_event.freezed.dart';

@freezed
class ExploreEvent with _$ExploreEvent {
  const factory ExploreEvent.initializeRequested() = InitializeRequested;

  const factory ExploreEvent.permissionResultReceived({required bool granted}) =
      PermissionResultReceived;

  const factory ExploreEvent.mapBoundsChanged({
    required MapParamsModel params,
  }) = MapBoundsChanged;

  const factory ExploreEvent.refreshRequested() = RefreshRequested;

  const factory ExploreEvent.searchChanged({required String query}) =
      SearchChanged;

  const factory ExploreEvent.markerSelected({
    String? restaurantId,
  }) = MarkerSelected;

  const factory ExploreEvent.viewportChanged({
    required double minLat,
    required double maxLat,
    required double minLng,
    required double maxLng,
    required int zoom,
  }) = ViewportChanged;

  const factory ExploreEvent.markersRefreshed({
    required int version,
  }) = MarkersRefreshed;
}
