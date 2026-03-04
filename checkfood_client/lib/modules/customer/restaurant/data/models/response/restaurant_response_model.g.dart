// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'restaurant_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$RestaurantResponseModelImpl _$$RestaurantResponseModelImplFromJson(
  Map<String, dynamic> json,
) => _$RestaurantResponseModelImpl(
  id: json['id'] as String?,
  ownerId: json['ownerId'] as String?,
  name: json['name'] as String?,
  description: json['description'] as String?,
  cuisineType: $enumDecodeNullable(_$CuisineTypeEnumMap, json['cuisineType']),
  logoUrl: json['logoUrl'] as String?,
  coverImageUrl: json['coverImageUrl'] as String?,
  status: json['status'] as String?,
  isActive: json['active'] as bool?,
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
  isFavourite: json['isFavourite'] as bool? ?? false,
);

Map<String, dynamic> _$$RestaurantResponseModelImplToJson(
  _$RestaurantResponseModelImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'ownerId': instance.ownerId,
  'name': instance.name,
  'description': instance.description,
  'cuisineType': _$CuisineTypeEnumMap[instance.cuisineType],
  'logoUrl': instance.logoUrl,
  'coverImageUrl': instance.coverImageUrl,
  'status': instance.status,
  'active': instance.isActive,
  'rating': instance.rating,
  'address': instance.address,
  'openingHours': instance.openingHours,
  'tags': instance.tags,
  'isFavourite': instance.isFavourite,
};

const _$CuisineTypeEnumMap = {
  CuisineType.ITALIAN: 'ITALIAN',
  CuisineType.CZECH: 'CZECH',
  CuisineType.ASIAN: 'ASIAN',
  CuisineType.VIETNAMESE: 'VIETNAMESE',
  CuisineType.INDIAN: 'INDIAN',
  CuisineType.FRENCH: 'FRENCH',
  CuisineType.MEXICAN: 'MEXICAN',
  CuisineType.AMERICAN: 'AMERICAN',
  CuisineType.MEDITERRANEAN: 'MEDITERRANEAN',
  CuisineType.JAPANESE_SUSHI: 'JAPANESE_SUSHI',
  CuisineType.BURGER: 'BURGER',
  CuisineType.PIZZA: 'PIZZA',
  CuisineType.VEGAN_VEGETARIAN: 'VEGAN_VEGETARIAN',
  CuisineType.INTERNATIONAL: 'INTERNATIONAL',
  CuisineType.STREET_FOOD: 'STREET_FOOD',
  CuisineType.KEBAB: 'KEBAB',
  CuisineType.CAFE_DESSERT: 'CAFE_DESSERT',
  CuisineType.OTHER: 'OTHER',
};
