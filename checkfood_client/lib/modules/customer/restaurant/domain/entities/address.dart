import 'package:freezed_annotation/freezed_annotation.dart';

part 'address.freezed.dart';

@freezed
class Address with _$Address {
  // Tento soukromý konstruktor je NUTNÝ, abyste mohl definovat gettery nebo metody
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

  // Statická metoda pro prázdnou adresu (pro fallback v modelech)
  factory Address.empty() => const Address(street: '', city: '', country: '');

  // Getter pro formátovanou adresu (zde byly ty undefined_identifier chyby)
  String get fullAddress {
    final streetPart = streetNumber != null ? '$street $streetNumber' : street;
    return '$streetPart, $city';
  }
}
