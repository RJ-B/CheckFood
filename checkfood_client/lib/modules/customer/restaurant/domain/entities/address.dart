import 'package:freezed_annotation/freezed_annotation.dart';

part 'address.freezed.dart';

@freezed
class Address with _$Address {
  const Address._();

  const factory Address({
    required String street,
    String? streetNumber,
    required String city,
    String? postalCode,
    required String country,
    double? latitude,
    double? longitude,
    String? googlePlaceId,
  }) = _Address;

  factory Address.empty() => const Address(street: '', city: '', country: '');

  String get fullAddress {
    final streetPart = streetNumber != null ? '$street $streetNumber' : street;
    return '$streetPart, $city';
  }
}
