import 'package:freezed_annotation/freezed_annotation.dart';
import 'order_item_request_model.dart';

part 'create_order_request_model.freezed.dart';
part 'create_order_request_model.g.dart';

@freezed
class CreateOrderRequestModel with _$CreateOrderRequestModel {
  const factory CreateOrderRequestModel({
    required List<OrderItemRequestModel> items,
    String? note,
  }) = _CreateOrderRequestModel;

  factory CreateOrderRequestModel.fromJson(Map<String, dynamic> json) =>
      _$CreateOrderRequestModelFromJson(json);
}
