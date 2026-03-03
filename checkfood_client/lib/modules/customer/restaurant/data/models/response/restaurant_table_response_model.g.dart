// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'restaurant_table_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$RestaurantTableResponseModelImpl _$$RestaurantTableResponseModelImplFromJson(
  Map<String, dynamic> json,
) => _$RestaurantTableResponseModelImpl(
  id: json['id'] as String,
  restaurantId: json['restaurantId'] as String,
  label: json['label'] as String,
  capacity: (json['capacity'] as num).toInt(),
  isActive: json['active'] as bool,
  yaw: (json['yaw'] as num?)?.toDouble(),
  pitch: (json['pitch'] as num?)?.toDouble(),
);

Map<String, dynamic> _$$RestaurantTableResponseModelImplToJson(
  _$RestaurantTableResponseModelImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'restaurantId': instance.restaurantId,
  'label': instance.label,
  'capacity': instance.capacity,
  'active': instance.isActive,
  'yaw': instance.yaw,
  'pitch': instance.pitch,
};
