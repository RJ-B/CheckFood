// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pending_change_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PendingChangeModelImpl _$$PendingChangeModelImplFromJson(
  Map<String, dynamic> json,
) => _$PendingChangeModelImpl(
  id: json['id'] as String?,
  reservationId: json['reservationId'] as String?,
  restaurantName: json['restaurantName'] as String?,
  proposedStartTime: json['proposedStartTime'] as String?,
  proposedTableId: json['proposedTableId'] as String?,
  proposedTableLabel: json['proposedTableLabel'] as String?,
  originalStartTime: json['originalStartTime'] as String?,
  originalTableId: json['originalTableId'] as String?,
  originalTableLabel: json['originalTableLabel'] as String?,
  reservationDate: json['reservationDate'] as String?,
  status: json['status'] as String?,
  createdAt: json['createdAt'] as String?,
);

Map<String, dynamic> _$$PendingChangeModelImplToJson(
  _$PendingChangeModelImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'reservationId': instance.reservationId,
  'restaurantName': instance.restaurantName,
  'proposedStartTime': instance.proposedStartTime,
  'proposedTableId': instance.proposedTableId,
  'proposedTableLabel': instance.proposedTableLabel,
  'originalStartTime': instance.originalStartTime,
  'originalTableId': instance.originalTableId,
  'originalTableLabel': instance.originalTableLabel,
  'reservationDate': instance.reservationDate,
  'status': instance.status,
  'createdAt': instance.createdAt,
};
