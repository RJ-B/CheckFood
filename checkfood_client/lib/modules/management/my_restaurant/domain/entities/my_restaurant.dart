import '../../../../customer/restaurant/domain/entities/address.dart';
import '../../../../customer/restaurant/domain/entities/opening_hours.dart';
import '../../../../customer/restaurant/domain/entities/special_day.dart';

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
    this.defaultReservationDurationMinutes = 60,
  });
}
