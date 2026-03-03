// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'restaurant_request_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$RestaurantRequestModelImpl _$$RestaurantRequestModelImplFromJson(
  Map<String, dynamic> json,
) => _$RestaurantRequestModelImpl(
  name: json['name'] as String,
  description: json['description'] as String?,
  cuisineType: $enumDecode(_$CuisineTypeEnumMap, json['cuisineType']),
  logoUrl: json['logoUrl'] as String?,
  coverImageUrl: json['coverImageUrl'] as String?,
  address: AddressModel.fromJson(json['address'] as Map<String, dynamic>),
  openingHours:
      (json['openingHours'] as List<dynamic>?)
          ?.map((e) => OpeningHoursModel.fromJson(e as Map<String, dynamic>))
          .toList(),
  tags: (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList(),
);

Map<String, dynamic> _$$RestaurantRequestModelImplToJson(
  _$RestaurantRequestModelImpl instance,
) => <String, dynamic>{
  'name': instance.name,
  'description': instance.description,
  'cuisineType': _$CuisineTypeEnumMap[instance.cuisineType]!,
  'logoUrl': instance.logoUrl,
  'coverImageUrl': instance.coverImageUrl,
  'address': instance.address,
  'openingHours': instance.openingHours,
  'tags': instance.tags,
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
