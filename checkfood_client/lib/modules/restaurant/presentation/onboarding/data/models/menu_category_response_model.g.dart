// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'menu_category_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$OwnerMenuCategoryResponseModelImpl
_$$OwnerMenuCategoryResponseModelImplFromJson(Map<String, dynamic> json) =>
    _$OwnerMenuCategoryResponseModelImpl(
      id: json['id'] as String?,
      name: json['name'] as String?,
      items:
          (json['items'] as List<dynamic>?)
              ?.map(
                (e) => OwnerMenuItemResponseModel.fromJson(
                  e as Map<String, dynamic>,
                ),
              )
              .toList() ??
          const [],
    );

Map<String, dynamic> _$$OwnerMenuCategoryResponseModelImplToJson(
  _$OwnerMenuCategoryResponseModelImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'items': instance.items,
};
