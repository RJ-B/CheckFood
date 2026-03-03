import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../domain/entities/restaurant_table.dart';

part 'restaurant_table_response_model.freezed.dart';
part 'restaurant_table_response_model.g.dart';

@freezed
class RestaurantTableResponseModel with _$RestaurantTableResponseModel {
  const RestaurantTableResponseModel._();

  const factory RestaurantTableResponseModel({
    required String id,
    required String restaurantId,
    required String label,
    required int capacity,
    @JsonKey(name: 'active') required bool isActive,
    double? yaw,
    double? pitch,
  }) = _RestaurantTableResponseModel;

  factory RestaurantTableResponseModel.fromJson(Map<String, dynamic> json) =>
      _$RestaurantTableResponseModelFromJson(json);

  RestaurantTable toEntity() => RestaurantTable(
    id: id,
    restaurantId: restaurantId,
    label: label,
    capacity: capacity,
    isActive: isActive,
    yaw: yaw,
    pitch: pitch,
  );
}
