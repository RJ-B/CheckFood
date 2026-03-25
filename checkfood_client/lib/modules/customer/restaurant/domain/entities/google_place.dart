import 'package:google_maps_flutter/google_maps_flutter.dart';

class GooglePlace {
  final String id;
  final String name;
  final double latitude;
  final double longitude;
  final double? rating;
  final int? userRatingCount;
  final String? address;
  final String? photoUrl;
  final bool isOpen;

  const GooglePlace({
    required this.id,
    required this.name,
    required this.latitude,
    required this.longitude,
    this.rating,
    this.userRatingCount,
    this.address,
    this.photoUrl,
    this.isOpen = false,
  });

  LatLng get latLng => LatLng(latitude, longitude);
}
