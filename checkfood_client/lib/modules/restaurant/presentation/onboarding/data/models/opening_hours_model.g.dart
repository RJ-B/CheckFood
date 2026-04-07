// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'opening_hours_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$OpeningHoursModelImpl _$$OpeningHoursModelImplFromJson(
  Map<String, dynamic> json,
) => _$OpeningHoursModelImpl(
  dayOfWeek: json['dayOfWeek'] as String,
  openAt: json['openAt'] as String?,
  closeAt: json['closeAt'] as String?,
  closed: json['closed'] as bool? ?? false,
);

Map<String, dynamic> _$$OpeningHoursModelImplToJson(
  _$OpeningHoursModelImpl instance,
) => <String, dynamic>{
  'dayOfWeek': instance.dayOfWeek,
  'openAt': instance.openAt,
  'closeAt': instance.closeAt,
  'closed': instance.closed,
};
