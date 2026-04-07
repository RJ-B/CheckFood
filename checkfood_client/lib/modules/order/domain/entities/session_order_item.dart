import 'package:freezed_annotation/freezed_annotation.dart';

part 'session_order_item.freezed.dart';

/// A single ordered item within a shared dining session, including payment state.
@freezed
class SessionOrderItem with _$SessionOrderItem {
  const factory SessionOrderItem({
    required String id,
    required String orderId,
    required String name,
    required int unitPriceMinor,
    required int quantity,
    int? orderedByUserId,
    String? orderedByName,
    int? paidByUserId,
    String? paidByName,
    @Default('UNPAID') String paymentStatus,
  }) = _SessionOrderItem;

  const SessionOrderItem._();

  bool get isPaid => paymentStatus == 'PAID';
  bool get isPaying => paymentStatus == 'PAYING';
  bool get isUnpaid => paymentStatus == 'UNPAID';

  int get totalPriceMinor => unitPriceMinor * quantity;

  String get formattedPrice {
    final crowns = totalPriceMinor ~/ 100;
    final hellers = totalPriceMinor % 100;
    if (hellers == 0) return '$crowns Kč';
    return '$crowns,${hellers.toString().padLeft(2, '0')} Kč';
  }

  String get formattedUnitPrice {
    final crowns = unitPriceMinor ~/ 100;
    final hellers = unitPriceMinor % 100;
    if (hellers == 0) return '$crowns Kč';
    return '$crowns,${hellers.toString().padLeft(2, '0')} Kč';
  }
}
