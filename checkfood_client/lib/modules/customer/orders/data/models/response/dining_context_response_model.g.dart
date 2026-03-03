// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dining_context_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$DiningContextResponseModelImpl _$$DiningContextResponseModelImplFromJson(
  Map<String, dynamic> json,
) => _$DiningContextResponseModelImpl(
  restaurantId: json['restaurantId'] as String?,
  tableId: json['tableId'] as String?,
  reservationId: json['reservationId'] as String?,
  sessionId: json['sessionId'] as String?,
  contextType: json['contextType'] as String?,
  restaurantName: json['restaurantName'] as String?,
  tableLabel: json['tableLabel'] as String?,
  validFrom: json['validFrom'] as String?,
  validTo: json['validTo'] as String?,
);

Map<String, dynamic> _$$DiningContextResponseModelImplToJson(
  _$DiningContextResponseModelImpl instance,
) => <String, dynamic>{
  'restaurantId': instance.restaurantId,
  'tableId': instance.tableId,
  'reservationId': instance.reservationId,
  'sessionId': instance.sessionId,
  'contextType': instance.contextType,
  'restaurantName': instance.restaurantName,
  'tableLabel': instance.tableLabel,
  'validFrom': instance.validFrom,
  'validTo': instance.validTo,
};
