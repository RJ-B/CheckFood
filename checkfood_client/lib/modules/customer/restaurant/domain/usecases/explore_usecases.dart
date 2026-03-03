import 'package:geolocator/geolocator.dart';
import '../../../../../core/utils/location_service.dart';
import '../../data/models/request/map_params_model.dart';
import '../entities/restaurant.dart';
import '../entities/restaurant_filters.dart';
import '../entities/restaurant_marker.dart';
import '../repositories/restaurant_repository.dart';

/// Získá aktuální GPS polohu a řeší oprávnění.
class GetLocationUseCase {
  final LocationService _locationService;
  GetLocationUseCase(this._locationService);

  Future<Position> execute() => _locationService.getCurrentLocation();
}

/// Získá lehké markery pro mapu s využitím dedikovaného modelu parametrů.
class GetRestaurantMarkersUseCase {
  final RestaurantRepository _repository;
  GetRestaurantMarkersUseCase(this._repository);

  /// ✅ OPRAVA: Metoda nyní přijímá MapParamsModel namísto jednotlivých souřadnic.
  Future<List<RestaurantMarker>> execute(MapParamsModel params) {
    return _repository.getMarkersInBounds(params);
  }
}

/// Získá stránkovaný seznam nejbližších restaurací s volitelným vyhledáváním a filtry.
class GetNearestRestaurantsUseCase {
  final RestaurantRepository _repository;
  GetNearestRestaurantsUseCase(this._repository);

  /// Získá data seřazená podle vzdálenosti s fixní velikostí stránky.
  Future<List<Restaurant>> execute({
    required double lat,
    required double lng,
    required int page,
    RestaurantFilters? filters,
  }) {
    return _repository.getNearestRestaurants(
      lat: lat,
      lng: lng,
      page: page,
      size: 10,
      searchQuery: filters?.searchQuery,
      cuisineTypes: filters?.cuisineTypes.map((e) => e.name).toList(),
      minRating: filters?.minRating,
      openNow: filters?.openNow,
    );
  }
}
