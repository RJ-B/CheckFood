// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'menu_item_request_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$MenuItemRequestModelImpl _$$MenuItemRequestModelImplFromJson(
  Map<String, dynamic> json,
) => _$MenuItemRequestModelImpl(
  name: json['name'] as String,
  description: json['description'] as String?,
  priceMinor: (json['priceMinor'] as num?)?.toInt() ?? 0,
  currency: json['currency'] as String? ?? 'CZK',
  imageUrl: json['imageUrl'] as String?,
  available: json['available'] as bool? ?? true,
  sortOrder: (json['sortOrder'] as num?)?.toInt() ?? 0,
);

Map<String, dynamic> _$$MenuItemRequestModelImplToJson(
  _$MenuItemRequestModelImpl instance,
) => <String, dynamic>{
  'name': instance.name,
  'description': instance.description,
  'priceMinor': instance.priceMinor,
  'currency': instance.currency,
  'imageUrl': instance.imageUrl,
  'available': instance.available,
  'sortOrder': instance.sortOrder,
};
