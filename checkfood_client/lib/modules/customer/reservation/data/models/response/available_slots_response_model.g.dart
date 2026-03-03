// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'available_slots_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AvailableSlotsResponseModelImpl _$$AvailableSlotsResponseModelImplFromJson(
  Map<String, dynamic> json,
) => _$AvailableSlotsResponseModelImpl(
  date: json['date'] as String?,
  tableId: json['tableId'] as String?,
  slotMinutes: (json['slotMinutes'] as num?)?.toInt(),
  durationMinutes: (json['durationMinutes'] as num?)?.toInt(),
  availableStartTimes:
      (json['availableStartTimes'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      const [],
);

Map<String, dynamic> _$$AvailableSlotsResponseModelImplToJson(
  _$AvailableSlotsResponseModelImpl instance,
) => <String, dynamic>{
  'date': instance.date,
  'tableId': instance.tableId,
  'slotMinutes': instance.slotMinutes,
  'durationMinutes': instance.durationMinutes,
  'availableStartTimes': instance.availableStartTimes,
};
