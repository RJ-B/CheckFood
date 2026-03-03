import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:geolocator/geolocator.dart';
import 'restaurant.dart';
import 'restaurant_marker.dart';

part 'explore_data.freezed.dart';

@freezed
class ExploreData with _$ExploreData {
  const factory ExploreData({
    /// Markery pro mapu (shluky nebo restaurace)
    required List<RestaurantMarker> markers,

    /// Seznam nejbližších restaurací (pod mapou)
    required List<Restaurant> nearestRestaurants,

    /// Aktuální poloha uživatele
    required Position userPosition,

    /// Aktuální stránka pro pagination
    required int currentPage,

    /// Zda je k dispozici další stránka
    required bool hasMore,

    /// Zda se načítá další stránka (aby se nevolalo 2x)
    required bool isPaginationLoading,

    /// Zda probíhá aktualizace markerů na mapě (pro plynulé UI)
    @Default(false) bool isMapLoading, // ✅ NOVÉ
  }) = _ExploreData;

  // Defaultní stav pro init
  factory ExploreData.initial() => ExploreData(
    markers: [],
    nearestRestaurants: [],
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
    currentPage: 0,
    hasMore: true,
    isPaginationLoading: false,
    isMapLoading: false, // ✅ NOVÉ
  );
}
