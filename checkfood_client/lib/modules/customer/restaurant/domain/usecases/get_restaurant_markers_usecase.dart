import '../../data/models/request/map_params_model.dart'; // ✅ Import modelu pro parametry
import '../entities/restaurant_marker.dart';
import '../repositories/restaurant_repository.dart';

/// UseCase pro získání lehkých markerů (nebo shluků) ve viditelném výřezu mapy.
/// Využívá MapParamsModel pro zapouzdření souřadnic i výpočtu vzdálenosti pro shlukování.
class GetRestaurantMarkersUseCase {
  final RestaurantRepository _repository;

  GetRestaurantMarkersUseCase(this._repository);

  /// Spouští proces získání markerů na základě parametrů výřezu mapy.
  ///
  /// Přijímá [MapParamsModel] params, který obsahuje LatLngBounds a distance.
  Future<List<RestaurantMarker>> execute(MapParamsModel params) {
    // ✅ Volá aktualizovanou metodu v repository s celým modelem
    return _repository.getMarkersInBounds(params);
  }
}
