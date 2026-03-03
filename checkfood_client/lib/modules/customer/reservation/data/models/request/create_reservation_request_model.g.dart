// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_reservation_request_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CreateReservationRequestModelImpl
_$$CreateReservationRequestModelImplFromJson(Map<String, dynamic> json) =>
    _$CreateReservationRequestModelImpl(
      restaurantId: json['restaurantId'] as String,
      tableId: json['tableId'] as String,
      date: json['date'] as String,
      startTime: json['startTime'] as String,
      partySize: (json['partySize'] as num?)?.toInt() ?? 2,
    );

Map<String, dynamic> _$$CreateReservationRequestModelImplToJson(
  _$CreateReservationRequestModelImpl instance,
) => <String, dynamic>{
  'restaurantId': instance.restaurantId,
  'tableId': instance.tableId,
  'date': instance.date,
  'startTime': instance.startTime,
  'partySize': instance.partySize,
};
