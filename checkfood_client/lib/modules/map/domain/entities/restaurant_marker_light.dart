import 'package:freezed_annotation/freezed_annotation.dart';

part 'restaurant_marker_light.freezed.dart';
part 'restaurant_marker_light.g.dart';

@freezed
class RestaurantMarkerLight with _$RestaurantMarkerLight {
  const factory RestaurantMarkerLight({
    required String id,
    required double latitude,
    required double longitude,
    String? name,
    @JsonKey(name: 'logoUrl') String? logoUrl,
  }) = _RestaurantMarkerLight;

  factory RestaurantMarkerLight.fromJson(Map<String, dynamic> json) =>
      _$RestaurantMarkerLightFromJson(json);
}
