import 'package:freezed_annotation/freezed_annotation.dart';

part 'menu_item.freezed.dart';

@freezed
class MenuItem with _$MenuItem {
  const MenuItem._();

  const factory MenuItem({
    required String id,
    required String name,
    String? description,
    required int priceMinor,
    required String currency,
    String? imageUrl,
    required bool available,
  }) = _MenuItem;

  String get formattedPrice {
    final crowns = priceMinor ~/ 100;
    final hellers = priceMinor % 100;
    if (hellers == 0) return '$crowns Kč';
    return '${crowns}.${hellers.toString().padLeft(2, '0')} Kč';
  }
}
