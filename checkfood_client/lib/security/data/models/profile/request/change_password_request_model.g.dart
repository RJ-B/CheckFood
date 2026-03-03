// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'change_password_request_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ChangePasswordRequestModelImpl _$$ChangePasswordRequestModelImplFromJson(
  Map<String, dynamic> json,
) => _$ChangePasswordRequestModelImpl(
  currentPassword: json['currentPassword'] as String,
  newPassword: json['newPassword'] as String,
  confirmPassword: json['confirmPassword'] as String,
);

Map<String, dynamic> _$$ChangePasswordRequestModelImplToJson(
  _$ChangePasswordRequestModelImpl instance,
) => <String, dynamic>{
  'currentPassword': instance.currentPassword,
  'newPassword': instance.newPassword,
  'confirmPassword': instance.confirmPassword,
};
