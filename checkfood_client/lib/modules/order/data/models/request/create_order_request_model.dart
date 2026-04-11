import 'package:freezed_annotation/freezed_annotation.dart';
import 'order_item_request_model.dart';

part 'create_order_request_model.freezed.dart';
part 'create_order_request_model.g.dart';

/// Tělo požadavku pro odeslání nové objednávky se seznamem položek menu.
///
/// `explicitToJson: true` je kritické — bez něj `toJson()` emituje nested
/// `OrderItemRequestModel` objekty jako Dart instance (což se při serializaci
/// Dio requestu projeví jako `Instance of '_$OrderItemRequestModelImpl'` stringy)
/// místo plain map, a backend parse request body selže.
@freezed
class CreateOrderRequestModel with _$CreateOrderRequestModel {
  @JsonSerializable(explicitToJson: true)
  const factory CreateOrderRequestModel({
    required List<OrderItemRequestModel> items,
    String? note,
  }) = _CreateOrderRequestModel;

  factory CreateOrderRequestModel.fromJson(Map<String, dynamic> json) =>
      _$CreateOrderRequestModelFromJson(json);
}
