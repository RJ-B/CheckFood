import 'package:freezed_annotation/freezed_annotation.dart';

part 'menu_category_request_model.freezed.dart';
part 'menu_category_request_model.g.dart';

/// Request payload pro vytvoření nebo aktualizaci kategorie menu.
@freezed
class MenuCategoryRequestModel with _$MenuCategoryRequestModel {
  const factory MenuCategoryRequestModel({
    required String name,
    @Default(0) int sortOrder,
  }) = _MenuCategoryRequestModel;

  factory MenuCategoryRequestModel.fromJson(Map<String, dynamic> json) =>
      _$MenuCategoryRequestModelFromJson(json);
}
