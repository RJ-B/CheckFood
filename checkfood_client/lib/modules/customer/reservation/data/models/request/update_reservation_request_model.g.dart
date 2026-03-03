// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_reservation_request_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UpdateReservationRequestModelImpl
_$$UpdateReservationRequestModelImplFromJson(Map<String, dynamic> json) =>
    _$UpdateReservationRequestModelImpl(
      tableId: json['tableId'] as String,
      date: json['date'] as String,
      startTime: json['startTime'] as String,
      partySize: (json['partySize'] as num).toInt(),
    );

Map<String, dynamic> _$$UpdateReservationRequestModelImplToJson(
  _$UpdateReservationRequestModelImpl instance,
) => <String, dynamic>{
  'tableId': instance.tableId,
  'date': instance.date,
  'startTime': instance.startTime,
  'partySize': instance.partySize,
};
