// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'restaurant_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$OwnerRestaurantResponseModelImpl _$$OwnerRestaurantResponseModelImplFromJson(
  Map<String, dynamic> json,
) => _$OwnerRestaurantResponseModelImpl(
  id: json['id'] as String?,
  name: json['name'] as String?,
  description: json['description'] as String?,
  cuisineType: json['cuisineType'] as String?,
  logoUrl: json['logoUrl'] as String?,
  coverImageUrl: json['coverImageUrl'] as String?,
  panoramaUrl: json['panoramaUrl'] as String?,
  status: json['status'] as String?,
  active: json['active'] as bool? ?? false,
  rating: (json['rating'] as num?)?.toDouble(),
  address:
      json['address'] == null
          ? null
          : AddressModel.fromJson(json['address'] as Map<String, dynamic>),
  openingHours:
      (json['openingHours'] as List<dynamic>?)
          ?.map((e) => OpeningHoursModel.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  tags:
      (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList() ??
      const [],
  onboardingCompleted: json['onboardingCompleted'] as bool? ?? false,
);

Map<String, dynamic> _$$OwnerRestaurantResponseModelImplToJson(
  _$OwnerRestaurantResponseModelImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'description': instance.description,
  'cuisineType': instance.cuisineType,
  'logoUrl': instance.logoUrl,
  'coverImageUrl': instance.coverImageUrl,
  'panoramaUrl': instance.panoramaUrl,
  'status': instance.status,
  'active': instance.active,
  'rating': instance.rating,
  'address': instance.address,
  'openingHours': instance.openingHours,
  'tags': instance.tags,
  'onboardingCompleted': instance.onboardingCompleted,
};
