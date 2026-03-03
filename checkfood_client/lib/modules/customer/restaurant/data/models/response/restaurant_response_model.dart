import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../domain/entities/address.dart';
import '../../../domain/entities/cuisine_type.dart';
import '../../../domain/entities/restaurant.dart';
import '../common/address_model.dart';
import '../common/opening_hours_model.dart';

part 'restaurant_response_model.freezed.dart';
part 'restaurant_response_model.g.dart';

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
  }) = _RestaurantResponseModel;

  factory RestaurantResponseModel.fromJson(Map<String, dynamic> json) =>
      _$RestaurantResponseModelFromJson(json);

  /// Mapování na entitu s ošetřením null hodnot (Null-safety fallback)
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
  );
}
