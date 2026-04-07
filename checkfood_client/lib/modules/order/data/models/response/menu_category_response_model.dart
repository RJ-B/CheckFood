import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../domain/entities/menu_category.dart';
import 'menu_item_response_model.dart';

part 'menu_category_response_model.freezed.dart';
part 'menu_category_response_model.g.dart';

/// API response model for a menu category containing a list of items.
@freezed
class MenuCategoryResponseModel with _$MenuCategoryResponseModel {
  const MenuCategoryResponseModel._();

  const factory MenuCategoryResponseModel({
    String? id,
    String? name,
    @Default([]) List<MenuItemResponseModel> items,
  }) = _MenuCategoryResponseModel;

  factory MenuCategoryResponseModel.fromJson(Map<String, dynamic> json) =>
      _$MenuCategoryResponseModelFromJson(json);

  MenuCategory toEntity() => MenuCategory(
        id: id ?? '',
        name: name ?? '',
        items: items.map((i) => i.toEntity()).toList(),
      );
}
