// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'restaurant_marker_light.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$RestaurantMarkerLightImpl _$$RestaurantMarkerLightImplFromJson(
  Map<String, dynamic> json,
) => _$RestaurantMarkerLightImpl(
  id: json['id'] as String,
  latitude: (json['latitude'] as num).toDouble(),
  longitude: (json['longitude'] as num).toDouble(),
  name: json['name'] as String?,
  logoUrl: json['logoUrl'] as String?,
);

Map<String, dynamic> _$$RestaurantMarkerLightImplToJson(
  _$RestaurantMarkerLightImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'latitude': instance.latitude,
  'longitude': instance.longitude,
  'name': instance.name,
  'logoUrl': instance.logoUrl,
};
