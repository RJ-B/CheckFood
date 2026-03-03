import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../domain/entities/menu_item.dart';

part 'menu_item_response_model.freezed.dart';
part 'menu_item_response_model.g.dart';

@freezed
class MenuItemResponseModel with _$MenuItemResponseModel {
  const MenuItemResponseModel._();

  const factory MenuItemResponseModel({
    String? id,
    String? name,
    String? description,
    int? priceMinor,
    String? currency,
    String? imageUrl,
    @Default(true) bool available,
  }) = _MenuItemResponseModel;

  factory MenuItemResponseModel.fromJson(Map<String, dynamic> json) =>
      _$MenuItemResponseModelFromJson(json);

  MenuItem toEntity() => MenuItem(
        id: id ?? '',
        name: name ?? '',
        description: description,
        priceMinor: priceMinor ?? 0,
        currency: currency ?? 'CZK',
        imageUrl: imageUrl,
        available: available,
      );
}
