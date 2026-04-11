import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../domain/entities/restaurant_photo.dart';

part 'restaurant_photo_response_model.freezed.dart';
part 'restaurant_photo_response_model.g.dart';

/// API response model pro jednu fotku v galerii restaurace.
@freezed
class RestaurantPhotoResponseModel with _$RestaurantPhotoResponseModel {
  const RestaurantPhotoResponseModel._();

  const factory RestaurantPhotoResponseModel({
    required String id,
    required String url,
    @Default(0) int sortOrder,
  }) = _RestaurantPhotoResponseModel;

  factory RestaurantPhotoResponseModel.fromJson(Map<String, dynamic> json) =>
      _$RestaurantPhotoResponseModelFromJson(json);

  RestaurantPhoto toEntity() => RestaurantPhoto(
        id: id,
        url: url,
        sortOrder: sortOrder,
      );
}
