import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../domain/entities/order_summary.dart';

part 'order_summary_response_model.freezed.dart';
part 'order_summary_response_model.g.dart';

@freezed
class OrderSummaryResponseModel with _$OrderSummaryResponseModel {
  const OrderSummaryResponseModel._();

  const factory OrderSummaryResponseModel({
    String? id,
    String? status,
    int? totalPriceMinor,
    String? currency,
    int? itemCount,
    String? createdAt,
  }) = _OrderSummaryResponseModel;

  factory OrderSummaryResponseModel.fromJson(Map<String, dynamic> json) =>
      _$OrderSummaryResponseModelFromJson(json);

  OrderSummary toEntity() => OrderSummary(
        id: id ?? '',
        status: status ?? 'PENDING',
        totalPriceMinor: totalPriceMinor ?? 0,
        currency: currency ?? 'CZK',
        itemCount: itemCount ?? 0,
        createdAt: createdAt ?? '',
      );
}
