import '../../data/models/request/map_params_model.dart';
import '../../data/models/request/restaurant_request_model.dart';
import '../../data/models/request/restaurant_table_request_model.dart';
import '../entities/restaurant.dart';
import '../entities/restaurant_marker.dart';
import '../entities/restaurant_marker_light.dart';
import '../entities/restaurant_table.dart';

/// Abstract contract for the restaurant module data source, independent of any concrete HTTP implementation.
abstract class RestaurantRepository {
  /// Returns map markers (individual restaurants or clusters) visible within the given viewport.
  Future<List<RestaurantMarker>> getMarkersInBounds(MapParamsModel params);

  /// Returns a paginated list of restaurants sorted by distance from the user's location.
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

  /// Fetches the full detail of a single restaurant by its ID.
  Future<Restaurant> getRestaurantById(String id);

  /// Creates a new restaurant listing (requires OWNER role).
  Future<Restaurant> createRestaurant(RestaurantRequestModel request);

  /// Returns all restaurants owned by the currently authenticated user.
  Future<List<Restaurant>> getMyRestaurants();

  /// Updates the details of an existing restaurant.
  Future<Restaurant> updateRestaurant(
    String id,
    RestaurantRequestModel request,
  );

  /// Soft-deletes (deactivates) a restaurant.
  Future<void> deleteRestaurant(String id);

  /// Adds a new table to the seating inventory of a restaurant.
  Future<RestaurantTable> addTable(
    String restaurantId,
    RestaurantTableRequestModel request,
  );

  /// Returns all tables for a given restaurant.
  Future<List<RestaurantTable>> getTables(String restaurantId);

  /// Downloads all active restaurants with a snapshot version for client-side clustering.
  Future<({int version, List<RestaurantMarkerLight> data})> getAllMarkers();

  /// Returns the current server-side version of the markers snapshot.
  Future<int> getMarkersVersion();
}
