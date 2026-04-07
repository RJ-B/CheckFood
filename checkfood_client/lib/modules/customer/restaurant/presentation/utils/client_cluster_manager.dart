import 'dart:math';
import '../../domain/entities/restaurant_marker.dart';
import '../../domain/entities/restaurant_marker_light.dart';

/// Client-side grid-based clustering engine.
///
/// Replaces server-side PostGIS DBSCAN with instant in-memory queries.
/// Data is loaded once from backend and queried per-viewport locally.
class ClientClusterManager {
  List<RestaurantMarkerLight> _points = [];
  double? radiusOverride; // Debug: override dynamic radius with fixed value

  /// Load restaurant data into the clustering engine.
  void load(List<RestaurantMarkerLight> points) {
    _points = points;
  }

  /// Query clusters and individual markers for a given viewport and zoom.
  ///
  /// Returns [RestaurantMarker] list compatible with existing marker rendering.
  List<RestaurantMarker> getClusters({
    required double minLng,
    required double minLat,
    required double maxLng,
    required double maxLat,
    required int zoom,
  }) {
    final padLat = (maxLat - minLat) * 0.05;
    final padLng = (maxLng - minLng) * 0.05;
    final visible = _points.where((p) =>
      p.latitude >= minLat - padLat && p.latitude <= maxLat + padLat &&
      p.longitude >= minLng - padLng && p.longitude <= maxLng + padLng,
    ).toList();

    if (zoom >= 17) {
      return visible.map((p) => RestaurantMarker(
        id: p.id,
        latitude: p.latitude,
        longitude: p.longitude,
        count: 1,
        name: p.name,
        logoUrl: p.logoUrl,
      )).toList();
    }

    final cellSize = _cellSizeForZoom(zoom);
    final Map<String, List<RestaurantMarkerLight>> grid = {};

    for (final p in visible) {
      final cellX = (p.longitude / cellSize).floor();
      final cellY = (p.latitude / cellSize).floor();
      final key = '${cellX}_$cellY';
      grid.putIfAbsent(key, () => []).add(p);
    }

    return grid.values.map((cell) {
      if (cell.length == 1) {
        final p = cell.first;
        return RestaurantMarker(
          id: p.id,
          latitude: p.latitude,
          longitude: p.longitude,
          count: 1,
          name: p.name,
          logoUrl: p.logoUrl,
        );
      }
      final lat = cell.map((p) => p.latitude).reduce((a, b) => a + b) / cell.length;
      final lng = cell.map((p) => p.longitude).reduce((a, b) => a + b) / cell.length;
      return RestaurantMarker(
        id: null,
        latitude: lat,
        longitude: lng,
        count: cell.length,
        name: null,
        logoUrl: null,
      );
    }).toList();
  }

  /// Cell size in degrees for a given zoom level.
  /// Uses the same Gaussian curve as the backend for visual consistency.
  double _cellSizeForZoom(int zoom) {
    final radiusPx = radiusOverride ?? dynamicRadiusPx(zoom.toDouble());
    return radiusPx * 360.0 / (256.0 * pow(2, zoom));
  }

  /// Default cluster radius in pixels (industry standard).
  static const double defaultRadius = 150.0;

  /// Returns the effective radius for a given zoom level.
  /// Currently constant (standard), but can be overridden via [radiusOverride].
  double dynamicRadiusPx(double zoom) {
    return defaultRadius;
  }

  bool get isLoaded => _points.isNotEmpty;
  int get pointCount => _points.length;
}
