// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_item_request_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$OrderItemRequestModelImpl _$$OrderItemRequestModelImplFromJson(
  Map<String, dynamic> json,
) => _$OrderItemRequestModelImpl(
  menuItemId: json['menuItemId'] as String,
  quantity: (json['quantity'] as num).toInt(),
);

Map<String, dynamic> _$$OrderItemRequestModelImplToJson(
  _$OrderItemRequestModelImpl instance,
) => <String, dynamic>{
  'menuItemId': instance.menuItemId,
  'quantity': instance.quantity,
};
