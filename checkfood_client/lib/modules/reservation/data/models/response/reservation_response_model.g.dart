// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reservation_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ReservationResponseModelImpl _$$ReservationResponseModelImplFromJson(
  Map<String, dynamic> json,
) => _$ReservationResponseModelImpl(
  id: json['id'] as String?,
  restaurantId: json['restaurantId'] as String?,
  tableId: json['tableId'] as String?,
  restaurantName: json['restaurantName'] as String?,
  tableLabel: json['tableLabel'] as String?,
  date: json['date'] as String?,
  startTime: json['startTime'] as String?,
  endTime: json['endTime'] as String?,
  status: json['status'] as String?,
  partySize: (json['partySize'] as num?)?.toInt(),
  canEdit: json['canEdit'] as bool? ?? false,
  canCancel: json['canCancel'] as bool? ?? false,
  pendingChange: json['pendingChange'] as Map<String, dynamic>?,
);

Map<String, dynamic> _$$ReservationResponseModelImplToJson(
  _$ReservationResponseModelImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'restaurantId': instance.restaurantId,
  'tableId': instance.tableId,
  'restaurantName': instance.restaurantName,
  'tableLabel': instance.tableLabel,
  'date': instance.date,
  'startTime': instance.startTime,
  'endTime': instance.endTime,
  'status': instance.status,
  'partySize': instance.partySize,
  'canEdit': instance.canEdit,
  'canCancel': instance.canCancel,
  'pendingChange': instance.pendingChange,
};
