import 'package:freezed_annotation/freezed_annotation.dart';

part 'restaurant_table_request_model.freezed.dart';
part 'restaurant_table_request_model.g.dart';

/// Request payload for creating or updating a restaurant table.
@freezed
class RestaurantTableRequestModel with _$RestaurantTableRequestModel {
  const factory RestaurantTableRequestModel({
    required String label,
    required int capacity,
    @Default(true) bool active,
  }) = _RestaurantTableRequestModel;

  factory RestaurantTableRequestModel.fromJson(Map<String, dynamic> json) =>
      _$RestaurantTableRequestModelFromJson(json);
}
