import 'package:freezed_annotation/freezed_annotation.dart';

part 'address_model.freezed.dart';
part 'address_model.g.dart';

/// API model pro fyzickou adresu restaurace, včetně souřadnic
/// a volitelného Google Place ID.
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
