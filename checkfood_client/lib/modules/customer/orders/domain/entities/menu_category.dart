import 'package:freezed_annotation/freezed_annotation.dart';
import 'menu_item.dart';

part 'menu_category.freezed.dart';

/// A named group of [MenuItem]s within a restaurant's menu.
@freezed
class MenuCategory with _$MenuCategory {
  const MenuCategory._();

  const factory MenuCategory({
    required String id,
    required String name,
    required List<MenuItem> items,
  }) = _MenuCategory;
}
