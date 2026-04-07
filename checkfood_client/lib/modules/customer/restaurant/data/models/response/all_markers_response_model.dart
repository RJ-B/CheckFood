import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../domain/entities/restaurant_marker_light.dart';

part 'all_markers_response_model.freezed.dart';
part 'all_markers_response_model.g.dart';

/// API response model pro endpoint GET /restaurants/all-markers, obsahující verzi snapshotu a úplný seznam lehkých markerů restaurací.
@freezed
class AllMarkersResponseModel with _$AllMarkersResponseModel {
  const factory AllMarkersResponseModel({
    required int version,
    required List<RestaurantMarkerLight> data,
  }) = _AllMarkersResponseModel;

  factory AllMarkersResponseModel.fromJson(Map<String, dynamic> json) =>
      _$AllMarkersResponseModelFromJson(json);
}
