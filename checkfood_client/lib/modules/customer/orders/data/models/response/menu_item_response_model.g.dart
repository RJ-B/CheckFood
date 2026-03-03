// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'menu_item_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$MenuItemResponseModelImpl _$$MenuItemResponseModelImplFromJson(
  Map<String, dynamic> json,
) => _$MenuItemResponseModelImpl(
  id: json['id'] as String?,
  name: json['name'] as String?,
  description: json['description'] as String?,
  priceMinor: (json['priceMinor'] as num?)?.toInt(),
  currency: json['currency'] as String?,
  imageUrl: json['imageUrl'] as String?,
  available: json['available'] as bool? ?? true,
);

Map<String, dynamic> _$$MenuItemResponseModelImplToJson(
  _$MenuItemResponseModelImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'description': instance.description,
  'priceMinor': instance.priceMinor,
  'currency': instance.currency,
  'imageUrl': instance.imageUrl,
  'available': instance.available,
};
