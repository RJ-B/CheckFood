// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_recurring_reservation_request_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CreateRecurringReservationRequestModelImpl
_$$CreateRecurringReservationRequestModelImplFromJson(
  Map<String, dynamic> json,
) => _$CreateRecurringReservationRequestModelImpl(
  restaurantId: json['restaurantId'] as String,
  tableId: json['tableId'] as String,
  dayOfWeek: json['dayOfWeek'] as String,
  startTime: json['startTime'] as String,
  partySize: (json['partySize'] as num?)?.toInt() ?? 2,
);

Map<String, dynamic> _$$CreateRecurringReservationRequestModelImplToJson(
  _$CreateRecurringReservationRequestModelImpl instance,
) => <String, dynamic>{
  'restaurantId': instance.restaurantId,
  'tableId': instance.tableId,
  'dayOfWeek': instance.dayOfWeek,
  'startTime': instance.startTime,
  'partySize': instance.partySize,
};
