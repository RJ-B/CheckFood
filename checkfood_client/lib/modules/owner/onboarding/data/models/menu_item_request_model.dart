import 'package:freezed_annotation/freezed_annotation.dart';

part 'menu_item_request_model.freezed.dart';
part 'menu_item_request_model.g.dart';

@freezed
class MenuItemRequestModel with _$MenuItemRequestModel {
  const factory MenuItemRequestModel({
    required String name,
    String? description,
    @Default(0) int priceMinor,
    @Default('CZK') String currency,
    String? imageUrl,
    @Default(true) bool available,
    @Default(0) int sortOrder,
  }) = _MenuItemRequestModel;

  factory MenuItemRequestModel.fromJson(Map<String, dynamic> json) =>
      _$MenuItemRequestModelFromJson(json);
}
