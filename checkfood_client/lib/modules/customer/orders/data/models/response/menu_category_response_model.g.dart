// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'menu_category_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$MenuCategoryResponseModelImpl _$$MenuCategoryResponseModelImplFromJson(
  Map<String, dynamic> json,
) => _$MenuCategoryResponseModelImpl(
  id: json['id'] as String?,
  name: json['name'] as String?,
  items:
      (json['items'] as List<dynamic>?)
          ?.map(
            (e) => MenuItemResponseModel.fromJson(e as Map<String, dynamic>),
          )
          .toList() ??
      const [],
);

Map<String, dynamic> _$$MenuCategoryResponseModelImplToJson(
  _$MenuCategoryResponseModelImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'items': instance.items,
};
