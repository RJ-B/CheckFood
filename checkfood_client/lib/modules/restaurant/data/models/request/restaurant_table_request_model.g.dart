// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'restaurant_table_request_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$RestaurantTableRequestModelImpl _$$RestaurantTableRequestModelImplFromJson(
  Map<String, dynamic> json,
) => _$RestaurantTableRequestModelImpl(
  label: json['label'] as String,
  capacity: (json['capacity'] as num).toInt(),
  active: json['active'] as bool? ?? true,
);

Map<String, dynamic> _$$RestaurantTableRequestModelImplToJson(
  _$RestaurantTableRequestModelImpl instance,
) => <String, dynamic>{
  'label': instance.label,
  'capacity': instance.capacity,
  'active': instance.active,
};
