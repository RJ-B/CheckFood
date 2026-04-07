import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

part 'map_params_model.freezed.dart';

/// Parameters describing the current map viewport, used to query visible restaurant markers.
@freezed
class MapParamsModel with _$MapParamsModel {
  const MapParamsModel._();

  const factory MapParamsModel({
    required LatLngBounds bounds,
    required int zoom,
    double? clusterRadius,
  }) = _MapParamsModel;

  /// Converts the viewport parameters into Dio query parameters.
  Map<String, dynamic> toQueryParameters() {
    final params = <String, dynamic>{
      'minLat': bounds.southwest.latitude,
      'maxLat': bounds.northeast.latitude,
      'minLng': bounds.southwest.longitude,
      'maxLng': bounds.northeast.longitude,
      'zoom': zoom,
    };
    if (clusterRadius != null) {
      params['clusterRadius'] = clusterRadius;
    }
    return params;
  }
}
