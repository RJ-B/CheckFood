import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:geolocator/geolocator.dart';
import 'restaurant.dart';
import 'restaurant_marker.dart';

part 'explore_data.freezed.dart';

@freezed
class ExploreData with _$ExploreData {
  const factory ExploreData({
    required List<Restaurant> restaurants,
    required List<RestaurantMarker> markers,
    required Position userPosition,
    @Default(false) bool isMapLoading,
    @Default(null) String? selectedRestaurantId,
    @Default(null) Restaurant? selectedRestaurant,
    @Default(null) String? searchQuery,
    @Default(false) bool clusterEngineReady,
  }) = _ExploreData;

  factory ExploreData.initial() => ExploreData(
        restaurants: [],
        markers: [],
        userPosition: Position(
          longitude: 0,
          latitude: 0,
          timestamp: DateTime.now(),
          accuracy: 0,
          altitude: 0,
          heading: 0,
          speed: 0,
          speedAccuracy: 0,
          altitudeAccuracy: 0,
          headingAccuracy: 0,
        ),
      );
}
