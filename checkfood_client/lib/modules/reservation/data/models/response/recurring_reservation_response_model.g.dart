// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recurring_reservation_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$RecurringReservationResponseModelImpl
_$$RecurringReservationResponseModelImplFromJson(Map<String, dynamic> json) =>
    _$RecurringReservationResponseModelImpl(
      id: json['id'] as String,
      restaurantId: json['restaurantId'] as String,
      tableId: json['tableId'] as String,
      restaurantName: json['restaurantName'] as String?,
      tableLabel: json['tableLabel'] as String?,
      dayOfWeek: json['dayOfWeek'] as String,
      startTime: json['startTime'] as String,
      partySize: (json['partySize'] as num?)?.toInt() ?? 2,
      status: json['status'] as String,
      repeatUntil: json['repeatUntil'] as String?,
      createdAt: json['createdAt'] as String,
      instanceCount: (json['instanceCount'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$$RecurringReservationResponseModelImplToJson(
  _$RecurringReservationResponseModelImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'restaurantId': instance.restaurantId,
  'tableId': instance.tableId,
  'restaurantName': instance.restaurantName,
  'tableLabel': instance.tableLabel,
  'dayOfWeek': instance.dayOfWeek,
  'startTime': instance.startTime,
  'partySize': instance.partySize,
  'status': instance.status,
  'repeatUntil': instance.repeatUntil,
  'createdAt': instance.createdAt,
  'instanceCount': instance.instanceCount,
};
