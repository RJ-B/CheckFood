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

  /// Display label for the cluster marker.
  /// Pure UI cap: counts above 99 show "99+", but the real count is preserved
  /// in the [count] field for density-proportional decisions (icon sizing etc.).
  String get clusterLabel => count > 99 ? '99+' : count.toString();
}
