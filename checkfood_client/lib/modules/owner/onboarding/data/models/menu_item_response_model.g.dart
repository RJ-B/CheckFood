// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'menu_item_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$OwnerMenuItemResponseModelImpl _$$OwnerMenuItemResponseModelImplFromJson(
  Map<String, dynamic> json,
) => _$OwnerMenuItemResponseModelImpl(
  id: json['id'] as String?,
  name: json['name'] as String?,
  description: json['description'] as String?,
  priceMinor: (json['priceMinor'] as num?)?.toInt() ?? 0,
  currency: json['currency'] as String? ?? 'CZK',
  imageUrl: json['imageUrl'] as String?,
  available: json['available'] as bool? ?? true,
);

Map<String, dynamic> _$$OwnerMenuItemResponseModelImplToJson(
  _$OwnerMenuItemResponseModelImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'description': instance.description,
  'priceMinor': instance.priceMinor,
  'currency': instance.currency,
  'imageUrl': instance.imageUrl,
  'available': instance.available,
};
