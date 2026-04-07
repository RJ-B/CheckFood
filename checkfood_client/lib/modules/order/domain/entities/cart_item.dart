import 'package:freezed_annotation/freezed_annotation.dart';

part 'cart_item.freezed.dart';

/// Položka uložená v lokálním košíku před odesláním objednávky.
@freezed
class CartItem with _$CartItem {
  const CartItem._();

  const factory CartItem({
    required String menuItemId,
    required String itemName,
    required int unitPriceMinor,
    required int quantity,
    required String currency,
  }) = _CartItem;

  int get totalPriceMinor => unitPriceMinor * quantity;

  String get formattedUnitPrice {
    final crowns = unitPriceMinor ~/ 100;
    final hellers = unitPriceMinor % 100;
    if (hellers == 0) return '$crowns Kč';
    return '${crowns}.${hellers.toString().padLeft(2, '0')} Kč';
  }

  String get formattedTotalPrice {
    final crowns = totalPriceMinor ~/ 100;
    final hellers = totalPriceMinor % 100;
    if (hellers == 0) return '$crowns Kč';
    return '${crowns}.${hellers.toString().padLeft(2, '0')} Kč';
  }
}
