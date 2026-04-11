// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'restaurant_photo_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$RestaurantPhotoResponseModelImpl _$$RestaurantPhotoResponseModelImplFromJson(
  Map<String, dynamic> json,
) => _$RestaurantPhotoResponseModelImpl(
  id: json['id'] as String,
  url: json['url'] as String,
  sortOrder: (json['sortOrder'] as num?)?.toInt() ?? 0,
);

Map<String, dynamic> _$$RestaurantPhotoResponseModelImplToJson(
  _$RestaurantPhotoResponseModelImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'url': instance.url,
  'sortOrder': instance.sortOrder,
};
