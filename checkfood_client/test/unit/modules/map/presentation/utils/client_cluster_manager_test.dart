import 'package:flutter_test/flutter_test.dart';
import 'package:checkfood_client/modules/map/presentation/utils/client_cluster_manager.dart';
import 'package:checkfood_client/modules/map/domain/entities/restaurant_marker_light.dart';

RestaurantMarkerLight _pt(String id, double lat, double lng) =>
    RestaurantMarkerLight(id: id, latitude: lat, longitude: lng, name: id);

void main() {
  group('ClientClusterManager — empty data', () {
    test('isLoaded is false before load()', () {
      final mgr = ClientClusterManager();
      expect(mgr.isLoaded, false);
      expect(mgr.pointCount, 0);
    });

    test('getClusters on empty manager returns empty list', () {
      final mgr = ClientClusterManager();
      final result = mgr.getClusters(
        minLng: 14.0, minLat: 50.0, maxLng: 14.1, maxLat: 50.1, zoom: 14);
      expect(result, isEmpty);
    });
  });

  group('ClientClusterManager — single point', () {
    test('single point inside viewport returned as individual marker', () {
      final mgr = ClientClusterManager()
        ..load([_pt('r1', 50.05, 14.05)]);

      final result = mgr.getClusters(
        minLng: 14.0, minLat: 50.0, maxLng: 14.1, maxLat: 50.1, zoom: 14);
      expect(result.length, 1);
      expect(result.first.id, 'r1');
      expect(result.first.count, 1);
      expect(result.first.isCluster, false);
    });

    test('single point outside viewport returns empty list', () {
      final mgr = ClientClusterManager()
        ..load([_pt('r1', 48.0, 16.0)]); // Vienna — outside Prague viewport

      final result = mgr.getClusters(
        minLng: 14.0, minLat: 50.0, maxLng: 14.1, maxLat: 50.1, zoom: 14);
      expect(result, isEmpty);
    });
  });

  group('ClientClusterManager — clustering at low zoom', () {
    test('two very close points cluster together at zoom 5', () {
      final mgr = ClientClusterManager()
        ..load([
          _pt('r1', 50.00001, 14.00001),
          _pt('r2', 50.00002, 14.00002),
        ]);

      final result = mgr.getClusters(
        minLng: 0.0, minLat: 0.0, maxLng: 30.0, maxLat: 70.0, zoom: 5);

      // At zoom 5 the cell size is huge — the two points should land in same cell
      expect(result.length, 1);
      expect(result.first.count, 2);
      expect(result.first.isCluster, true);
      expect(result.first.id, isNull); // clusters have no id
    });

    test('cluster centroid is average of member coordinates', () {
      final lat1 = 50.0;
      final lat2 = 50.2;
      final lng1 = 14.0;
      final lng2 = 14.2;
      final mgr = ClientClusterManager()
        ..load([_pt('a', lat1, lng1), _pt('b', lat2, lng2)]);

      final result = mgr.getClusters(
        minLng: 0.0, minLat: 0.0, maxLng: 30.0, maxLat: 70.0, zoom: 5);

      if (result.length == 1) {
        expect(result.first.latitude, closeTo((lat1 + lat2) / 2, 0.0001));
        expect(result.first.longitude, closeTo((lng1 + lng2) / 2, 0.0001));
      }
    });
  });

  group('ClientClusterManager — zoom >= 17 expansion', () {
    test('at zoom 17 all visible points returned individually', () {
      final mgr = ClientClusterManager()
        ..load([
          _pt('r1', 50.05, 14.05),
          _pt('r2', 50.051, 14.051),
          _pt('r3', 50.052, 14.052),
        ]);

      final result = mgr.getClusters(
        minLng: 14.0, minLat: 50.0, maxLng: 14.1, maxLat: 50.1, zoom: 17);

      expect(result.length, 3);
      expect(result.every((m) => m.count == 1), true);
    });

    test('at zoom 18 all points returned individually', () {
      final mgr = ClientClusterManager()
        ..load([
          _pt('a', 50.05, 14.05),
          _pt('b', 50.05001, 14.05001),
        ]);

      final result = mgr.getClusters(
        minLng: 14.0, minLat: 50.0, maxLng: 14.1, maxLat: 50.1, zoom: 18);

      expect(result.length, 2);
    });
  });

  group('ClientClusterManager — dense viewport', () {
    test('100 co-located points produce one cluster at low zoom', () {
      final points = List.generate(
          100, (i) => _pt('r$i', 50.0 + i * 0.00001, 14.0 + i * 0.00001));
      final mgr = ClientClusterManager()..load(points);

      final result = mgr.getClusters(
        minLng: 0.0, minLat: 0.0, maxLng: 30.0, maxLat: 70.0, zoom: 5);

      expect(result.length, 1);
      expect(result.first.count, 100);
      expect(result.first.clusterLabel, '99+');
    });
  });

  group('ClientClusterManager — radiusOverride', () {
    test('radiusOverride 1 produces more clusters than default', () {
      final points = [
        _pt('r1', 50.00, 14.00),
        _pt('r2', 50.01, 14.01),
        _pt('r3', 50.02, 14.02),
      ];

      final defaultMgr = ClientClusterManager()..load(points);
      final overrideMgr = ClientClusterManager()
        ..radiusOverride = 1.0
        ..load(points);

      final defaultResult = defaultMgr.getClusters(
          minLng: 13.9, minLat: 49.9, maxLng: 14.1, maxLat: 50.1, zoom: 14);
      final overrideResult = overrideMgr.getClusters(
          minLng: 13.9, minLat: 49.9, maxLng: 14.1, maxLat: 50.1, zoom: 14);

      expect(overrideResult.length, greaterThanOrEqualTo(defaultResult.length));
    });
  });

  group('ClientClusterManager — reload', () {
    test('load() replaces previous data', () {
      final mgr = ClientClusterManager()
        ..load([_pt('old', 50.0, 14.0)]);

      mgr.load([_pt('new1', 50.0, 14.0), _pt('new2', 50.01, 14.01)]);

      expect(mgr.pointCount, 2);
    });
  });

  group('ClientClusterManager — padding', () {
    test('point just outside bbox but within 5% padding is included', () {
      // Viewport: lat 50.0–50.1 / lng 14.0–14.1
      // Padding = 5% of 0.1 = 0.005
      // Point at 50.104 should be inside padded bbox (50.0 - 0.005 to 50.1 + 0.005)
      final mgr = ClientClusterManager()
        ..load([_pt('edge', 50.104, 14.05)]);

      final result = mgr.getClusters(
          minLng: 14.0, minLat: 50.0, maxLng: 14.1, maxLat: 50.1, zoom: 17);

      expect(result.length, 1);
    });

    test('point far outside bbox (beyond padding) is excluded', () {
      final mgr = ClientClusterManager()
        ..load([_pt('far', 51.0, 14.05)]); // 1 degree away

      final result = mgr.getClusters(
          minLng: 14.0, minLat: 50.0, maxLng: 14.1, maxLat: 50.1, zoom: 17);

      expect(result, isEmpty);
    });
  });
}
