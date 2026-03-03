import 'package:freezed_annotation/freezed_annotation.dart';
import 'menu_item.dart';

part 'menu_category.freezed.dart';

@freezed
class MenuCategory with _$MenuCategory {
  const MenuCategory._();

  const factory MenuCategory({
    required String id,
    required String name,
    required List<MenuItem> items,
  }) = _MenuCategory;
}
