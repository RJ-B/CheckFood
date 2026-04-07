import 'package:geolocator/geolocator.dart';
import '../../../../../core/utils/location_service.dart';
import '../../data/models/request/map_params_model.dart';
import '../../../restaurant/domain/entities/restaurant.dart';
import '../entities/restaurant_filters.dart';
import '../entities/restaurant_marker.dart';
import '../../../restaurant/domain/repositories/restaurant_repository.dart';

/// Načte aktuální GPS pozici a zpracuje oprávnění pro polohu.
class GetLocationUseCase {
  final LocationService _locationService;
  GetLocationUseCase(this._locationService);

  Future<Position> execute() => _locationService.getCurrentLocation();
}

/// Načte viditelné markery restaurací pro aktuální výřez mapy.
class GetRestaurantMarkersUseCase {
  final RestaurantRepository _repository;
  GetRestaurantMarkersUseCase(this._repository);

  Future<List<RestaurantMarker>> execute(MapParamsModel params) {
    return _repository.getMarkersInBounds(params);
  }
}

/// Vrátí stránkovaný seznam restaurací v okolí, volitelně filtrovaný podle vyhledávacího dotazu a kritérií kuchyně/hodnocení.
class GetNearestRestaurantsUseCase {
  final RestaurantRepository _repository;
  GetNearestRestaurantsUseCase(this._repository);

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
      favouritesOnly: filters?.favouritesOnly,
    );
  }
}
