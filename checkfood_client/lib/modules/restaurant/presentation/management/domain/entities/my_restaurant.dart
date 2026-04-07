import '../../../../domain/entities/address.dart';
import '../../../../domain/entities/opening_hours.dart';
import '../../../../domain/entities/special_day.dart';

/// Plný management pohled na restauraci vlastněnou přihlášeným uživatelem.
class MyRestaurant {
  final String id;
  final String name;
  final String? description;
  final String? phone;
  final String? contactEmail;
  final Address address;
  final List<OpeningHours> openingHours;
  final List<SpecialDay> specialDays;
  final String status;
  final bool isActive;
  final String? panoramaUrl;
  final String? coverImageUrl;
  final int defaultReservationDurationMinutes;

  const MyRestaurant({
    required this.id,
    required this.name,
    this.description,
    this.phone,
    this.contactEmail,
    required this.address,
    required this.openingHours,
    this.specialDays = const [],
    required this.status,
    required this.isActive,
    this.panoramaUrl,
    this.coverImageUrl,
    this.defaultReservationDurationMinutes = 60,
  });
}
