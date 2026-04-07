// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_order_request_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CreateOrderRequestModelImpl _$$CreateOrderRequestModelImplFromJson(
  Map<String, dynamic> json,
) => _$CreateOrderRequestModelImpl(
  items:
      (json['items'] as List<dynamic>)
          .map((e) => OrderItemRequestModel.fromJson(e as Map<String, dynamic>))
          .toList(),
  note: json['note'] as String?,
);

Map<String, dynamic> _$$CreateOrderRequestModelImplToJson(
  _$CreateOrderRequestModelImpl instance,
) => <String, dynamic>{'items': instance.items, 'note': instance.note};
