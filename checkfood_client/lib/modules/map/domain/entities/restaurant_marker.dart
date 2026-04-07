import 'package:freezed_annotation/freezed_annotation.dart';

part 'restaurant_marker.freezed.dart';

@freezed
class RestaurantMarker with _$RestaurantMarker {
  const RestaurantMarker._();

  const factory RestaurantMarker({
    String? id,
    required double latitude,
    required double longitude,
    required int count,
    String? name,
    String? logoUrl,
  }) = _RestaurantMarker;

  bool get isCluster => count > 1;

  /// Zobrazovací popisek cluster markeru.
  /// Čistě UI omezení: počty nad 99 zobrazují "99+", skutečný počet je však uchován
  /// v poli [count] pro rozhodnutí závislá na hustotě (velikost ikony apod.).
  String get clusterLabel => count > 99 ? '99+' : count.toString();
}
