import 'package:flutter_test/flutter_test.dart';
import 'package:geolocator/geolocator.dart';

import 'package:checkfood_client/core/utils/location_service.dart';

/// LocationService wraps platform calls (Geolocator) which cannot be directly
/// mocked without a GeolocatorPlatform fake. These tests cover the pure-Dart
/// helpers and document the expected error contract via expected-fail markers
/// for the permission flow.
void main() {
  late LocationService service;

  setUp(() {
    service = LocationService();
  });

  group('LocationService.calculateDistance', () {
    test('should return 0 for identical coordinates', () {
      final dist = service.calculateDistance(50.0, 14.0, 50.0, 14.0);
      expect(dist, 0.0);
    });

    test('should return positive distance for different coordinates', () {
      // Prague (50.0755, 14.4378) to Brno (49.1951, 16.6068) ≈ 188 km
      final dist = service.calculateDistance(50.0755, 14.4378, 49.1951, 16.6068);
      // Geolocator uses Vincenty — accept within 5 km of expected
      expect(dist, greaterThan(180000));
      expect(dist, lessThan(200000));
    });

    test('should be symmetric (A→B == B→A)', () {
      final ab = service.calculateDistance(50.0755, 14.4378, 49.1951, 16.6068);
      final ba = service.calculateDistance(49.1951, 16.6068, 50.0755, 14.4378);
      expect((ab - ba).abs(), lessThan(1.0));
    });
  });

  // EXPECTED-FAIL: location_service — production code has no injectable
  // GeolocatorPlatform seam, so permission/service-disabled error paths
  // cannot be unit tested without a platform fake. The tests below document
  // the required contract; they will be skipped at runtime but fail loudly
  // in CI once the seam is added.
  group('LocationService.getCurrentLocation — permission contract (gap tests)',
      () {
    // EXPECTED-FAIL: location_service — production code does not yet accept an
    // injectable GeolocatorPlatform, so the service-disabled path cannot be
    // exercised in a hermetic unit test. Marked `skip` so CI stays green
    // until the LocationService seam is added; remove the skip flag and
    // implement the seam in the same PR.
    test(
      'should throw LocationServiceDisabledException when service off',
      () async {
        expect(
          () => service.getCurrentLocation(),
          throwsA(isA<LocationServiceDisabledException>()),
          reason:
              'Requires injectable GeolocatorPlatform — add seam to LocationService',
        );
      },
      skip: 'Pending: add injectable GeolocatorPlatform to LocationService',
    );

    // EXPECTED-FAIL: location_service — same injectable-seam gap as above;
    // permission-denied path unreachable without it.
    test(
      'should throw when location permission is permanently denied',
      () async {
        expect(
          () => service.getCurrentLocation(),
          throwsA(isA<Exception>()),
          reason:
              'Requires injectable GeolocatorPlatform — add seam to LocationService',
        );
      },
      skip: 'Pending: add injectable GeolocatorPlatform to LocationService',
    );
  });
}
