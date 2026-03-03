import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

part 'map_params_model.freezed.dart';

@freezed
class MapParamsModel with _$MapParamsModel {
  const MapParamsModel._(); // Nutné pro vlastní metody

  const factory MapParamsModel({
    required LatLngBounds bounds,
    required int zoom,
  }) = _MapParamsModel;

  /// Převede parametry na mapu pro query parametry Dio požadavku
  Map<String, dynamic> toQueryParameters() {
    return {
      'minLat': bounds.southwest.latitude,
      'maxLat': bounds.northeast.latitude,
      'minLng': bounds.southwest.longitude,
      'maxLng': bounds.northeast.longitude,
      'zoom': zoom,
    };
  }
}
