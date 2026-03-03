import 'package:freezed_annotation/freezed_annotation.dart';

part 'restaurant_marker.freezed.dart';

@freezed
class RestaurantMarker with _$RestaurantMarker {
  // Potřebujeme privátní konstruktor pro přidání getterů
  const RestaurantMarker._();

  const factory RestaurantMarker({
    /// ID je null, pokud se jedná o shluk (cluster).
    /// Pokud count == 1, obsahuje reálné ID restaurace.
    String? id,
    required double latitude,
    required double longitude,

    /// Počet restaurací v tomto bodě.
    /// 1 = samostatná restaurace
    /// >1 = shluk
    required int count,
  }) = _RestaurantMarker;

  /// Pomocný getter: Je to shluk?
  bool get isCluster => count > 1;

  /// Display label for the cluster marker.
  /// Pure UI cap: counts above 99 show "99+", but the real count is preserved
  /// in the [count] field for density-proportional decisions (icon sizing etc.).
  String get clusterLabel => count > 99 ? '99+' : count.toString();
}
