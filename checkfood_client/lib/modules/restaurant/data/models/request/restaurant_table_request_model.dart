import 'package:freezed_annotation/freezed_annotation.dart';

part 'restaurant_table_request_model.freezed.dart';
part 'restaurant_table_request_model.g.dart';

/// Tělo požadavku pro vytvoření nebo aktualizaci stolu restaurace.
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
