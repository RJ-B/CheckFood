import 'package:geolocator/geolocator.dart';

/// Servis pro správu polohových služeb a získávání GPS souřadnic.
class LocationService {
  /// Ověří oprávnění a získá aktuální polohu zařízení.
  ///
  /// Throws:
  /// - {@code LocationServiceDisabledException} — user vypnul location služby.
  /// - {@code PermissionDeniedException} — uživatel odepřel (ať už dočasně
  ///   nebo natrvalo) permission. Volající {@code ExploreBloc} rozlišuje
  ///   tyto dva stavy podle typu, ne podle textu message (text byl dřív
  ///   česky "Oprávnění pro polohu byla zamítnuta" a `string.contains('denied')`
  ///   to nechytil → geo chyby padaly do generic error stavu).
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
        throw const PermissionDeniedException('Permission denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      throw const PermissionDeniedException('Permission denied forever');
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
