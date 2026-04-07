// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'all_markers_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AllMarkersResponseModelImpl _$$AllMarkersResponseModelImplFromJson(
  Map<String, dynamic> json,
) => _$AllMarkersResponseModelImpl(
  version: (json['version'] as num).toInt(),
  data:
      (json['data'] as List<dynamic>)
          .map((e) => RestaurantMarkerLight.fromJson(e as Map<String, dynamic>))
          .toList(),
);

Map<String, dynamic> _$$AllMarkersResponseModelImplToJson(
  _$AllMarkersResponseModelImpl instance,
) => <String, dynamic>{'version': instance.version, 'data': instance.data};
