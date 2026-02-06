// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'token_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TokenResponseModelImpl _$$TokenResponseModelImplFromJson(
  Map<String, dynamic> json,
) => _$TokenResponseModelImpl(
  accessToken: json['accessToken'] as String,
  refreshToken: json['refreshToken'] as String,
  expiresIn: const DurationEpochConverter().fromJson(
    (json['expiresIn'] as num?)?.toInt(),
  ),
);

Map<String, dynamic> _$$TokenResponseModelImplToJson(
  _$TokenResponseModelImpl instance,
) => <String, dynamic>{
  'accessToken': instance.accessToken,
  'refreshToken': instance.refreshToken,
  'expiresIn': const DurationEpochConverter().toJson(instance.expiresIn),
};
