import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../domain/entities/reservation_scene.dart';

part 'reservation_scene_response_model.freezed.dart';
part 'reservation_scene_response_model.g.dart';

@freezed
class ReservationSceneResponseModel with _$ReservationSceneResponseModel {
  const ReservationSceneResponseModel._();

  const factory ReservationSceneResponseModel({
    String? restaurantId,
    String? panoramaUrl,
    @Default([]) List<SceneTableModel> tables,
  }) = _ReservationSceneResponseModel;

  factory ReservationSceneResponseModel.fromJson(Map<String, dynamic> json) =>
      _$ReservationSceneResponseModelFromJson(json);

  ReservationScene toEntity() => ReservationScene(
        restaurantId: restaurantId ?? '',
        panoramaUrl: panoramaUrl,
        tables: tables.map((t) => t.toEntity()).toList(),
      );
}

@freezed
class SceneTableModel with _$SceneTableModel {
  const SceneTableModel._();

  const factory SceneTableModel({
    String? tableId,
    String? label,
    double? yaw,
    double? pitch,
    int? capacity,
  }) = _SceneTableModel;

  factory SceneTableModel.fromJson(Map<String, dynamic> json) =>
      _$SceneTableModelFromJson(json);

  SceneTable toEntity() => SceneTable(
        tableId: tableId ?? '',
        label: label ?? '',
        yaw: yaw ?? 0,
        pitch: pitch ?? 0,
        capacity: capacity ?? 2,
      );
}
