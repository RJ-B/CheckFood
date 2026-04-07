import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../domain/entities/restaurant_marker.dart';

part 'restaurant_marker_response_model.freezed.dart';
part 'restaurant_marker_response_model.g.dart';

/// API response model for a map marker representing one restaurant or a cluster of restaurants.
@freezed
class RestaurantMarkerResponseModel with _$RestaurantMarkerResponseModel {
  const RestaurantMarkerResponseModel._();

  const factory RestaurantMarkerResponseModel({
    String? id,
    required double latitude,
    required double longitude,
    required int count,
    String? name,
    @JsonKey(name: 'logoUrl') String? logoUrl,
  }) = _RestaurantMarkerResponseModel;

  factory RestaurantMarkerResponseModel.fromJson(Map<String, dynamic> json) =>
      _$RestaurantMarkerResponseModelFromJson(json);

  RestaurantMarker toEntity() => RestaurantMarker(
    id: id,
    latitude: latitude,
    longitude: longitude,
    count: count,
    name: name,
    logoUrl: logoUrl,
  );

  /// Converts a raw JSON list into a list of [RestaurantMarker] entities.
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
