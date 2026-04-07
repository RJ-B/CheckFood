import '../entities/restaurant_marker_light.dart';
import '../../../restaurant/domain/repositories/restaurant_repository.dart';

/// Stáhne všechny aktivní markery restaurací z backendu pro klientské clusterování.
class GetAllMarkersUseCase {
  final RestaurantRepository _repository;

  GetAllMarkersUseCase(this._repository);

  Future<({int version, List<RestaurantMarkerLight> data})> execute() {
    return _repository.getAllMarkers();
  }
}
