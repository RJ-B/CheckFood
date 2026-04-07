import '../../data/models/request/map_params_model.dart';
import '../../data/models/request/restaurant_request_model.dart';
import '../../data/models/request/restaurant_table_request_model.dart';
import '../entities/restaurant.dart';
import '../entities/restaurant_marker.dart';
import '../entities/restaurant_marker_light.dart';
import '../entities/restaurant_table.dart';

/// Abstraktní kontrakt pro datový zdroj modulu restaurací, nezávislý na konkrétní HTTP implementaci.
abstract class RestaurantRepository {
  /// Vrátí markery na mapě (jednotlivé restaurace nebo clustery) viditelné v zadaném výřezu.
  Future<List<RestaurantMarker>> getMarkersInBounds(MapParamsModel params);

  /// Vrátí stránkovaný seznam restaurací seřazených podle vzdálenosti od polohy uživatele.
  Future<List<Restaurant>> getNearestRestaurants({
    required double lat,
    required double lng,
    required int page,
    required int size,
    String? searchQuery,
    List<String>? cuisineTypes,
    double? minRating,
    bool? openNow,
    bool? favouritesOnly,
  });

  /// Načte úplný detail jedné restaurace podle jejího ID.
  Future<Restaurant> getRestaurantById(String id);

  /// Vytvoří nový záznam restaurace (vyžaduje roli OWNER).
  Future<Restaurant> createRestaurant(RestaurantRequestModel request);

  /// Vrátí všechny restaurace vlastněné aktuálně přihlášeným uživatelem.
  Future<List<Restaurant>> getMyRestaurants();

  /// Aktualizuje detaily existující restaurace.
  Future<Restaurant> updateRestaurant(
    String id,
    RestaurantRequestModel request,
  );

  /// Provede soft-delete (deaktivaci) restaurace.
  Future<void> deleteRestaurant(String id);

  /// Přidá nový stůl do evidence sezení restaurace.
  Future<RestaurantTable> addTable(
    String restaurantId,
    RestaurantTableRequestModel request,
  );

  /// Vrátí všechny stoly dané restaurace.
  Future<List<RestaurantTable>> getTables(String restaurantId);

  /// Stáhne všechny aktivní restaurace s verzí snapshotu pro klientské clusterování.
  Future<({int version, List<RestaurantMarkerLight> data})> getAllMarkers();

  /// Vrátí aktuální verzi snapshotu markerů na straně serveru.
  Future<int> getMarkersVersion();
}
