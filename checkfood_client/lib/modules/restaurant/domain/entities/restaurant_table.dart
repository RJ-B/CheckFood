import 'package:freezed_annotation/freezed_annotation.dart';

part 'restaurant_table.freezed.dart';

@freezed
class RestaurantTable with _$RestaurantTable {
  const RestaurantTable._();

  const factory RestaurantTable({
    required String id,
    required String restaurantId,
    required String label,
    required int capacity,
    required bool isActive,
    double? yaw,
    double? pitch,
  }) = _RestaurantTable;
}
