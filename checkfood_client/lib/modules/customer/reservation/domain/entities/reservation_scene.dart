import 'package:freezed_annotation/freezed_annotation.dart';

part 'reservation_scene.freezed.dart';

/// Konfigurace panoramatické scény restaurace, včetně pozic stolů
/// používaných v interaktivním půdorysu.
@freezed
class ReservationScene with _$ReservationScene {
  const ReservationScene._();

  const factory ReservationScene({
    required String restaurantId,
    String? panoramaUrl,
    required List<SceneTable> tables,
  }) = _ReservationScene;
}

/// Stůl umístěný v panoramatické scéně na konkrétní pozici yaw/pitch.
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
