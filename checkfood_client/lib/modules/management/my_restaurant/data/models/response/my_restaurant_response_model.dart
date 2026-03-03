import '../../../../../customer/restaurant/data/models/common/address_model.dart';
import '../../../../../customer/restaurant/data/models/common/opening_hours_model.dart';
import '../../../../../customer/restaurant/domain/entities/address.dart';
import '../../../domain/entities/my_restaurant.dart';

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

  const MyRestaurantResponseModel({
    this.id,
    this.name,
    this.description,
    this.phone,
    this.contactEmail,
    this.address,
    this.openingHours = const [],
    this.status,
    this.isActive,
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
      );
}
