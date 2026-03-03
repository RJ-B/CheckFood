// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reservation_scene_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ReservationSceneResponseModelImpl
_$$ReservationSceneResponseModelImplFromJson(Map<String, dynamic> json) =>
    _$ReservationSceneResponseModelImpl(
      restaurantId: json['restaurantId'] as String?,
      panoramaUrl: json['panoramaUrl'] as String?,
      tables:
          (json['tables'] as List<dynamic>?)
              ?.map((e) => SceneTableModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$$ReservationSceneResponseModelImplToJson(
  _$ReservationSceneResponseModelImpl instance,
) => <String, dynamic>{
  'restaurantId': instance.restaurantId,
  'panoramaUrl': instance.panoramaUrl,
  'tables': instance.tables,
};

_$SceneTableModelImpl _$$SceneTableModelImplFromJson(
  Map<String, dynamic> json,
) => _$SceneTableModelImpl(
  tableId: json['tableId'] as String?,
  label: json['label'] as String?,
  yaw: (json['yaw'] as num?)?.toDouble(),
  pitch: (json['pitch'] as num?)?.toDouble(),
  capacity: (json['capacity'] as num?)?.toInt(),
);

Map<String, dynamic> _$$SceneTableModelImplToJson(
  _$SceneTableModelImpl instance,
) => <String, dynamic>{
  'tableId': instance.tableId,
  'label': instance.label,
  'yaw': instance.yaw,
  'pitch': instance.pitch,
  'capacity': instance.capacity,
};
