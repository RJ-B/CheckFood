import '../../../../../customer/restaurant/data/models/common/address_model.dart';
import '../../../../../customer/restaurant/data/models/common/opening_hours_model.dart';
import '../../../../../customer/restaurant/domain/entities/address.dart';
import '../../../../../customer/restaurant/domain/entities/special_day.dart';
import '../../../domain/entities/my_restaurant.dart';

/// API response model pro detail restaurace z pohledu majitele.
class MyRestaurantResponseModel {
  final String? id;
  final String? name;
  final String? description;
  final String? phone;
  final String? contactEmail;
  final AddressModel? address;
  final List<OpeningHoursModel> openingHours;
  final String? status;
  final bool? isActive;
  final String? panoramaUrl;
  final String? coverImageUrl;
  final int? defaultReservationDurationMinutes;
  final List<SpecialDay> specialDays;

  const MyRestaurantResponseModel({
    this.id,
    this.name,
    this.description,
    this.phone,
    this.contactEmail,
    this.address,
    this.openingHours = const [],
    this.specialDays = const [],
    this.status,
    this.isActive,
    this.panoramaUrl,
    this.coverImageUrl,
    this.defaultReservationDurationMinutes,
  });

  factory MyRestaurantResponseModel.fromJson(Map<String, dynamic> json) {
    return MyRestaurantResponseModel(
      id: json['id'] as String?,
      name: json['name'] as String?,
      description: json['description'] as String?,
      phone: json['phone'] as String?,
      contactEmail: json['contactEmail'] as String?,
      address: json['address'] != null
          ? AddressModel.fromJson(json['address'] as Map<String, dynamic>)
          : null,
      openingHours: (json['openingHours'] as List<dynamic>?)
              ?.map((e) => OpeningHoursModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      status: json['status'] as String?,
      isActive: json['active'] as bool?,
      panoramaUrl: json['panoramaUrl'] as String?,
      coverImageUrl: json['coverImageUrl'] as String?,
      defaultReservationDurationMinutes: json['defaultReservationDurationMinutes'] as int?,
      specialDays: (json['specialDays'] as List<dynamic>?)
              ?.map((e) => SpecialDay.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );
  }

  MyRestaurant toEntity() => MyRestaurant(
        id: id ?? '',
        name: name ?? '',
        description: description,
        phone: phone,
        contactEmail: contactEmail,
        address: address?.toEntity() ?? const Address(street: '', city: '', country: ''),
        openingHours: openingHours.map((e) => e.toEntity()).toList(),
        status: status ?? 'INACTIVE',
        isActive: isActive ?? false,
        panoramaUrl: panoramaUrl,
        coverImageUrl: coverImageUrl,
        defaultReservationDurationMinutes: defaultReservationDurationMinutes ?? 60,
        specialDays: specialDays,
      );
}
