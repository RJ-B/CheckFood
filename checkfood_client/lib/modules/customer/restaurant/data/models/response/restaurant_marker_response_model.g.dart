// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'restaurant_marker_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$RestaurantMarkerResponseModelImpl
_$$RestaurantMarkerResponseModelImplFromJson(Map<String, dynamic> json) =>
    _$RestaurantMarkerResponseModelImpl(
      id: json['id'] as String?,
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
      count: (json['count'] as num).toInt(),
      name: json['name'] as String?,
      logoUrl: json['logoUrl'] as String?,
    );

Map<String, dynamic> _$$RestaurantMarkerResponseModelImplToJson(
  _$RestaurantMarkerResponseModelImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'latitude': instance.latitude,
  'longitude': instance.longitude,
  'count': instance.count,
  'name': instance.name,
  'logoUrl': instance.logoUrl,
};
