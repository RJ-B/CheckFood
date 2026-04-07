import '../entities/reservation_scene.dart';
import '../repositories/reservation_repository.dart';

/// Načte konfiguraci panoramatické scény (pozice stolů) pro restauraci.
class GetReservationSceneUseCase {
  final ReservationRepository _repository;

  GetReservationSceneUseCase(this._repository);

  Future<ReservationScene> call(String restaurantId) async {
    return await _repository.getReservationScene(restaurantId);
  }
}
