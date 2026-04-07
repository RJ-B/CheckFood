import 'package:freezed_annotation/freezed_annotation.dart';
import 'order_item_request_model.dart';

part 'create_order_request_model.freezed.dart';
part 'create_order_request_model.g.dart';

/// Tělo požadavku pro odeslání nové objednávky se seznamem položek menu.
@freezed
class CreateOrderRequestModel with _$CreateOrderRequestModel {
  const factory CreateOrderRequestModel({
    required List<OrderItemRequestModel> items,
    String? note,
  }) = _CreateOrderRequestModel;

  factory CreateOrderRequestModel.fromJson(Map<String, dynamic> json) =>
      _$CreateOrderRequestModelFromJson(json);
}
