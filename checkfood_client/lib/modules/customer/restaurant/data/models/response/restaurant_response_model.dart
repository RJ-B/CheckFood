import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../domain/entities/address.dart';
import '../../../domain/entities/cuisine_type.dart';
import '../../../domain/entities/restaurant.dart';
import '../common/address_model.dart';
import '../common/opening_hours_model.dart';

part 'restaurant_response_model.freezed.dart';
part 'restaurant_response_model.g.dart';

/// API response model for a restaurant listing, including address, opening hours, and metadata.
@freezed
class RestaurantResponseModel with _$RestaurantResponseModel {
  const RestaurantResponseModel._();

  const factory RestaurantResponseModel({
    String? id,
    String? ownerId,
    String? name,
    String? description,
    CuisineType? cuisineType,
    String? logoUrl,
    String? coverImageUrl,
    String? status,
    @JsonKey(name: 'active') bool? isActive,
    double? rating,
    AddressModel? address,
    @Default([]) List<OpeningHoursModel> openingHours,
    @Default([]) List<String> tags,
    @Default(false) bool isFavourite,
    @Default([]) List<Map<String, dynamic>> specialDays,
  }) = _RestaurantResponseModel;

  factory RestaurantResponseModel.fromJson(Map<String, dynamic> json) =>
      _$RestaurantResponseModelFromJson(json);

  /// Converts this model to a [Restaurant] domain entity, applying safe defaults for nullable fields.
  Restaurant toEntity() => Restaurant(
    id: id ?? '',
    ownerId: ownerId ?? '',
    name: name ?? 'Neznámá restaurace',
    description: description ?? '',
    cuisineType: cuisineType ?? CuisineType.OTHER,
    logoUrl: logoUrl,
    coverImageUrl: coverImageUrl,
    status: status ?? 'INACTIVE',
    isActive: isActive ?? false,
    rating: rating,
    address:
        address?.toEntity() ?? const Address(street: '', city: '', country: ''),
    openingHours: openingHours.map((e) => e.toEntity()).toList(),
    tags: tags,
    isFavourite: isFavourite,
    specialDays: specialDays,
  );
}
