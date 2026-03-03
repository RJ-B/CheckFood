import 'package:freezed_annotation/freezed_annotation.dart';

part 'order_item_request_model.freezed.dart';
part 'order_item_request_model.g.dart';

@freezed
class OrderItemRequestModel with _$OrderItemRequestModel {
  const factory OrderItemRequestModel({
    required String menuItemId,
    required int quantity,
  }) = _OrderItemRequestModel;

  factory OrderItemRequestModel.fromJson(Map<String, dynamic> json) =>
      _$OrderItemRequestModelFromJson(json);
}
