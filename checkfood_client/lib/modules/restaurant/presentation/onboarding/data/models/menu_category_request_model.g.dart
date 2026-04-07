// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'menu_category_request_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$MenuCategoryRequestModelImpl _$$MenuCategoryRequestModelImplFromJson(
  Map<String, dynamic> json,
) => _$MenuCategoryRequestModelImpl(
  name: json['name'] as String,
  sortOrder: (json['sortOrder'] as num?)?.toInt() ?? 0,
);

Map<String, dynamic> _$$MenuCategoryRequestModelImplToJson(
  _$MenuCategoryRequestModelImpl instance,
) => <String, dynamic>{'name': instance.name, 'sortOrder': instance.sortOrder};
