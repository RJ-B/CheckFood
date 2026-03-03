import 'package:freezed_annotation/freezed_annotation.dart';

part 'order_summary.freezed.dart';

@freezed
class OrderSummary with _$OrderSummary {
  const OrderSummary._();

  const factory OrderSummary({
    required String id,
    required String status,
    required int totalPriceMinor,
    required String currency,
    required int itemCount,
    required String createdAt,
  }) = _OrderSummary;

  String get formattedTotal {
    final crowns = totalPriceMinor ~/ 100;
    final hellers = totalPriceMinor % 100;
    if (hellers == 0) return '$crowns Kč';
    return '${crowns}.${hellers.toString().padLeft(2, '0')} Kč';
  }

  String get statusLabel {
    switch (status) {
      case 'PENDING':
        return 'Čeká na potvrzení';
      case 'CONFIRMED':
        return 'Potvrzeno';
      case 'PREPARING':
        return 'Připravuje se';
      case 'READY':
        return 'Připraveno';
      case 'DELIVERED':
        return 'Doručeno';
      case 'CANCELLED':
        return 'Zrušeno';
      default:
        return status;
    }
  }
}
