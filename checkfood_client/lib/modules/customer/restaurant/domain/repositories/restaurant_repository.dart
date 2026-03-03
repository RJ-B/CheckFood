import '../../data/models/request/map_params_model.dart'; // ✅ Přidán chybějící import modelu
import '../../data/models/request/restaurant_request_model.dart';
import '../../data/models/request/restaurant_table_request_model.dart';
import '../entities/restaurant.dart';
import '../entities/restaurant_marker.dart';
import '../entities/restaurant_table.dart';

/// Rozhraní pro repozitář modulu restaurací.
/// Definuje kontrakt pro získávání dat nezávisle na konkrétní implementaci (např. Dio).
abstract class RestaurantRepository {
  // --- OPTIMALIZOVANÉ METODY PRO EXPLORE SCREEN ---

  /// Získá lehké markery (nebo shluky) pro zobrazení na mapě v daném výřezu.
  /// Parametry jsou zapouzdřeny v dedikovaném požadavkovém modelu.
  Future<List<RestaurantMarker>> getMarkersInBounds(MapParamsModel params);

  /// Získá seznam restaurací seřazený podle vzdálenosti od uživatele se stránkováním.
  Future<List<Restaurant>> getNearestRestaurants({
    required double lat,
    required double lng,
    required int page,
    required int size,
    String? searchQuery,
    List<String>? cuisineTypes,
    double? minRating,
    bool? openNow,
  });

  // --- SPRÁVA RESTAURACÍ (PUBLIC & OWNER) ---

  /// Načte kompletní detail jedné restaurace podle jejího ID.
  Future<Restaurant> getRestaurantById(String id);

  /// Vytvoří novou restauraci (vyžaduje roli OWNER).
  Future<Restaurant> createRestaurant(RestaurantRequestModel request);

  /// Vrátí seznam restaurací vlastněných aktuálně přihlášeným uživatelem.
  Future<List<Restaurant>> getMyRestaurants();

  /// Aktualizuje údaje existující restaurace.
  Future<Restaurant> updateRestaurant(
    String id,
    RestaurantRequestModel request,
  );

  /// Deaktivuje restauraci (soft-delete).
  Future<void> deleteRestaurant(String id);

  // --- SPRÁVA STOLŮ ---

  /// Přidá nový stůl do inventáře konkrétní restaurace.
  Future<RestaurantTable> addTable(
    String restaurantId,
    RestaurantTableRequestModel request,
  );

  /// Načte seznam všech stolů pro danou restauraci.
  Future<List<RestaurantTable>> getTables(String restaurantId);
}
