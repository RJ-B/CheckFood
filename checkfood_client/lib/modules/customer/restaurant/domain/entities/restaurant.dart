import 'package:freezed_annotation/freezed_annotation.dart';
import 'address.dart';
import 'cuisine_type.dart';
import 'opening_hours.dart';

part 'restaurant.freezed.dart';

@freezed
class Restaurant with _$Restaurant {
  const Restaurant._();

  const factory Restaurant({
    required String id,
    required String ownerId,
    required String name,
    String? description,
    required CuisineType cuisineType,
    String? logoUrl,
    String? coverImageUrl,
    required String status,
    required bool isActive,
    double? rating,
    required Address address,
    required List<OpeningHours> openingHours,
    @Default([]) List<String> tags,
    @Default(false) bool isFavourite,
  }) = _Restaurant;
}
