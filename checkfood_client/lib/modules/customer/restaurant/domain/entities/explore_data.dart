import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:geolocator/geolocator.dart';
import 'google_place.dart';
import 'restaurant_marker.dart';

part 'explore_data.freezed.dart';

@freezed
class ExploreData with _$ExploreData {
  const factory ExploreData({
    /// Google Places z API
    required List<GooglePlace> places,

    /// Markery pro mapu (shluky nebo restaurace)
    required List<RestaurantMarker> markers,

    /// Aktualni poloha uzivatele
    required Position userPosition,

    /// Zda probiha aktualizace markeru na mape
    @Default(false) bool isMapLoading,

    /// ID vybraneho mista (null = zadny vyber)
    @Default(null) String? selectedPlaceId,

    /// Vybrane misto pro preview card
    @Default(null) GooglePlace? selectedPlace,

    /// Aktivni search query
    @Default(null) String? searchQuery,
  }) = _ExploreData;

  factory ExploreData.initial() => ExploreData(
        places: [],
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
