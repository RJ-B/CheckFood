import 'package:freezed_annotation/freezed_annotation.dart';

part 'address_model.freezed.dart';
part 'address_model.g.dart';

/// API model for a restaurant's physical address, including coordinates and
/// an optional Google Place ID.
@freezed
class AddressModel with _$AddressModel {
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
}
