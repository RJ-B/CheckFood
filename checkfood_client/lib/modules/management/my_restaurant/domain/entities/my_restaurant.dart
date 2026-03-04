import '../../../../customer/restaurant/domain/entities/address.dart';
import '../../../../customer/restaurant/domain/entities/opening_hours.dart';

class MyRestaurant {
  final String id;
  final String name;
  final String? description;
  final String? phone;
  final String? contactEmail;
  final Address address;
  final List<OpeningHours> openingHours;
  final String status;
  final bool isActive;
  final String? panoramaUrl;

  const MyRestaurant({
    required this.id,
    required this.name,
    this.description,
    this.phone,
    this.contactEmail,
    required this.address,
    required this.openingHours,
    required this.status,
    required this.isActive,
    this.panoramaUrl,
  });
}
