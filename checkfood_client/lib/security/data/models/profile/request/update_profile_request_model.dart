import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../../config/security_json_keys.dart';

part 'update_profile_request_model.freezed.dart';
part 'update_profile_request_model.g.dart';

/// Datový model pro požadavek aktualizace profilu uživatele.
@freezed
class UpdateProfileRequestModel with _$UpdateProfileRequestModel {
  const factory UpdateProfileRequestModel({
    @JsonKey(name: SecurityJsonKeys.firstName) required String firstName,
    @JsonKey(name: SecurityJsonKeys.lastName) required String lastName,
    @JsonKey(name: SecurityJsonKeys.profileImageUrl) String? profileImageUrl,
    String? phone,
    @JsonKey(name: 'addressStreet') String? addressStreet,
    @JsonKey(name: 'addressCity') String? addressCity,
    @JsonKey(name: 'addressPostalCode') String? addressPostalCode,
    @JsonKey(name: 'addressCountry') String? addressCountry,
  }) = _UpdateProfileRequestModel;

  factory UpdateProfileRequestModel.fromJson(Map<String, dynamic> json) =>
      _$UpdateProfileRequestModelFromJson(json);
}
