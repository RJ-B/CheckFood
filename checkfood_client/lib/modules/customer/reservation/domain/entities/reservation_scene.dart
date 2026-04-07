import 'package:freezed_annotation/freezed_annotation.dart';

part 'reservation_scene.freezed.dart';

/// The panorama scene configuration for a restaurant, including the table
/// positions used in the interactive floor plan.
@freezed
class ReservationScene with _$ReservationScene {
  const ReservationScene._();

  const factory ReservationScene({
    required String restaurantId,
    String? panoramaUrl,
    required List<SceneTable> tables,
  }) = _ReservationScene;
}

/// A table placed in the panorama scene at a specific yaw/pitch position.
@freezed
class SceneTable with _$SceneTable {
  const SceneTable._();

  const factory SceneTable({
    required String tableId,
    required String label,
    required double yaw,
    required double pitch,
    required int capacity,
  }) = _SceneTable;
}
