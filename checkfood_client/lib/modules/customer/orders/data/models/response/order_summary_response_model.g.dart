// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_summary_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$OrderSummaryResponseModelImpl _$$OrderSummaryResponseModelImplFromJson(
  Map<String, dynamic> json,
) => _$OrderSummaryResponseModelImpl(
  id: json['id'] as String?,
  status: json['status'] as String?,
  totalPriceMinor: (json['totalPriceMinor'] as num?)?.toInt(),
  currency: json['currency'] as String?,
  itemCount: (json['itemCount'] as num?)?.toInt(),
  createdAt: json['createdAt'] as String?,
);

Map<String, dynamic> _$$OrderSummaryResponseModelImplToJson(
  _$OrderSummaryResponseModelImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'status': instance.status,
  'totalPriceMinor': instance.totalPriceMinor,
  'currency': instance.currency,
  'itemCount': instance.itemCount,
  'createdAt': instance.createdAt,
};
