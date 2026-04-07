import '../../domain/entities/restaurant_marker_light.dart';
import '../../domain/repositories/restaurant_repository.dart';

/// Downloads all active restaurant markers from the backend for client-side clustering.
class GetAllMarkersUseCase {
  final RestaurantRepository _repository;

  GetAllMarkersUseCase(this._repository);

  Future<({int version, List<RestaurantMarkerLight> data})> execute() {
    return _repository.getAllMarkers();
  }
}
