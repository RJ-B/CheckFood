import 'package:freezed_annotation/freezed_annotation.dart';
import 'address_model.dart';
import 'opening_hours_model.dart';

part 'restaurant_response_model.freezed.dart';
part 'restaurant_response_model.g.dart';

@freezed
class OwnerRestaurantResponseModel with _$OwnerRestaurantResponseModel {
  const factory OwnerRestaurantResponseModel({
    String? id,
    String? name,
    String? description,
    String? cuisineType,
    String? logoUrl,
    String? coverImageUrl,
    String? panoramaUrl,
    String? status,
    @Default(false) bool active,
    double? rating,
    AddressModel? address,
    @Default([]) List<OpeningHoursModel> openingHours,
    @Default([]) List<String> tags,
    @Default(false) bool onboardingCompleted,
  }) = _OwnerRestaurantResponseModel;

  factory OwnerRestaurantResponseModel.fromJson(Map<String, dynamic> json) =>
      _$OwnerRestaurantResponseModelFromJson(json);
}
