// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'opening_hours_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$OpeningHoursModelImpl _$$OpeningHoursModelImplFromJson(
  Map<String, dynamic> json,
) => _$OpeningHoursModelImpl(
  dayString: json['dayOfWeek'] as String,
  openAt: json['openAt'] as String?,
  closeAt: json['closeAt'] as String?,
  isClosed: json['closed'] as bool,
);

Map<String, dynamic> _$$OpeningHoursModelImplToJson(
  _$OpeningHoursModelImpl instance,
) => <String, dynamic>{
  'dayOfWeek': instance.dayString,
  'openAt': instance.openAt,
  'closeAt': instance.closeAt,
  'closed': instance.isClosed,
};
