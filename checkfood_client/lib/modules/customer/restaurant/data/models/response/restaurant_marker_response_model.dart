import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../domain/entities/restaurant_marker.dart';

part 'restaurant_marker_response_model.freezed.dart';
part 'restaurant_marker_response_model.g.dart';

@freezed
class RestaurantMarkerResponseModel with _$RestaurantMarkerResponseModel {
  const RestaurantMarkerResponseModel._();

  const factory RestaurantMarkerResponseModel({
    /// Může přijít null z backendu, pokud jde o agregovaný bod
    String? id,
    required double latitude,
    required double longitude,

    /// Backend nyní vrací počet prvků
    required int count,
  }) = _RestaurantMarkerResponseModel;

  factory RestaurantMarkerResponseModel.fromJson(Map<String, dynamic> json) =>
      _$RestaurantMarkerResponseModelFromJson(json);

  RestaurantMarker toEntity() => RestaurantMarker(
    id: id,
    latitude: latitude,
    longitude: longitude,
    count: count,
  );

  /// Bezpečná transformace seznamu
  static List<RestaurantMarker> toEntityList(List<dynamic>? jsonList) {
    if (jsonList == null) return [];
    return jsonList
        .map(
          (json) =>
              RestaurantMarkerResponseModel.fromJson(
                json as Map<String, dynamic>,
              ).toEntity(),
        )
        .toList();
  }
}
