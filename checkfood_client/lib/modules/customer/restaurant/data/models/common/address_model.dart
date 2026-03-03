import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../domain/entities/address.dart';

part 'address_model.freezed.dart';
part 'address_model.g.dart';

@freezed
class AddressModel with _$AddressModel {
  const AddressModel._();

  const factory AddressModel({
    String? street,
    String? streetNumber,
    String? city,
    String? postalCode,
    String? country,
    double? latitude,
    double? longitude,
    String? googlePlaceId,
  }) = _AddressModel;

  factory AddressModel.fromJson(Map<String, dynamic> json) =>
      _$AddressModelFromJson(json);

  /// Převod na doménovou entitu s ošetřením null hodnot
  Address toEntity() => Address(
    street: street ?? '',
    streetNumber: streetNumber,
    city: city ?? '',
    postalCode: postalCode,
    country: country ?? '',
    latitude: latitude,
    longitude: longitude,
    googlePlaceId: googlePlaceId,
  );

  factory AddressModel.fromEntity(Address entity) => AddressModel(
    street: entity.street,
    streetNumber: entity.streetNumber,
    city: entity.city,
    postalCode: entity.postalCode,
    country: entity.country,
    latitude: entity.latitude,
    longitude: entity.longitude,
    googlePlaceId: entity.googlePlaceId,
  );
}
