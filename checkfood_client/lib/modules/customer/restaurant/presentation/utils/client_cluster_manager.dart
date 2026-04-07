import 'dart:math';
import '../../domain/entities/restaurant_marker.dart';
import '../../domain/entities/restaurant_marker_light.dart';

/// Klientský clusterovací engine na základě mřížky.
///
/// Nahrazuje serverové PostGIS DBSCAN okamžitými in-memory dotazy.
/// Data se načtou jednou z backendu a dotazují se lokálně pro každý viewport.
class ClientClusterManager {
  List<RestaurantMarkerLight> _points = [];
  double? radiusOverride; // Debug: přepsat dynamický radius pevnou hodnotou

  /// Načte data restaurací do clusterovacího enginu.
  void load(List<RestaurantMarkerLight> points) {
    _points = points;
  }

  /// Vrátí clustery a jednotlivé markery pro zadaný viewport a úroveň přiblížení.
  ///
  /// Vrací seznam [RestaurantMarker] kompatibilní se stávajícím vykreslováním markerů.
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

  /// Velikost buňky ve stupních pro danou úroveň přiblížení.
  /// Používá stejnou Gaussovu křivku jako backend pro vizuální konzistenci.
  double _cellSizeForZoom(int zoom) {
    final radiusPx = radiusOverride ?? dynamicRadiusPx(zoom.toDouble());
    return radiusPx * 360.0 / (256.0 * pow(2, zoom));
  }

  /// Výchozí poloměr clusteru v pixelech (průmyslový standard).
  static const double defaultRadius = 150.0;

  /// Vrátí efektivní poloměr pro danou úroveň přiblížení.
  /// Momentálně konstantní (standard), lze přepsat přes [radiusOverride].
  double dynamicRadiusPx(double zoom) {
    return defaultRadius;
  }

  bool get isLoaded => _points.isNotEmpty;
  int get pointCount => _points.length;
}
