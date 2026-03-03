import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../domain/entities/cuisine_type.dart';
import '../common/address_model.dart';
import '../common/opening_hours_model.dart';

part 'restaurant_request_model.freezed.dart';
part 'restaurant_request_model.g.dart';

@freezed
class RestaurantRequestModel with _$RestaurantRequestModel {
  const factory RestaurantRequestModel({
    required String name,
    String? description,
    required CuisineType cuisineType,
    String? logoUrl,
    String? coverImageUrl,
    required AddressModel address,
    List<OpeningHoursModel>? openingHours,
    List<String>? tags,
  }) = _RestaurantRequestModel;

  factory RestaurantRequestModel.fromJson(Map<String, dynamic> json) =>
      _$RestaurantRequestModelFromJson(json);
}
