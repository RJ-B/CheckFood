import '../entities/reservation_scene.dart';
import '../repositories/reservation_repository.dart';

/// Loads the panorama scene configuration (table positions) for a restaurant.
class GetReservationSceneUseCase {
  final ReservationRepository _repository;

  GetReservationSceneUseCase(this._repository);

  Future<ReservationScene> call(String restaurantId) async {
    return await _repository.getReservationScene(restaurantId);
  }
}
