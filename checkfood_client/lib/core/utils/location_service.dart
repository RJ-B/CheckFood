import 'package:geolocator/geolocator.dart';

/// Servis pro správu polohových služeb a získávání GPS souřadnic.
class LocationService {
  /// Ověří oprávnění a získá aktuální polohu zařízení.
  ///
  /// Vyhazuje výjimku, pokud jsou služby vypnuté nebo oprávnění zamítnuta.
  Future<Position> getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test, zda jsou polohové služby povoleny.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      throw const LocationServiceDisabledException();
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        throw Exception('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      throw Exception(
        'Location permissions are permanently denied, we cannot request permissions.',
      );
    }

    return await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
      timeLimit: const Duration(seconds: 5),
    );
  }

  /// Vypočítá vzdálenost mezi dvěma body v metrech (pomocná metoda).
  double calculateDistance(
    double startLat,
    double startLng,
    double endLat,
    double endLng,
  ) {
    return Geolocator.distanceBetween(startLat, startLng, endLat, endLng);
  }
}
