import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../../config/security_json_keys.dart';
import '../../../../domain/entities/user_profile.dart';

part 'user_profile_response_model.freezed.dart';
part 'user_profile_response_model.g.dart';

/// Datový model pro detailní profil uživatele vrácený z backendu.
@freezed
class UserProfileResponseModel with _$UserProfileResponseModel {
  const UserProfileResponseModel._();

  const factory UserProfileResponseModel({
    @JsonKey(name: SecurityJsonKeys.id) required int id,
    @JsonKey(name: SecurityJsonKeys.email) required String email,
    @JsonKey(name: SecurityJsonKeys.firstName) String? firstName,
    @JsonKey(name: SecurityJsonKeys.lastName) String? lastName,
    @JsonKey(name: SecurityJsonKeys.profileImageUrl) String? profileImageUrl,
    @Default('') String phone,
    @JsonKey(name: 'addressStreet') @Default('') String addressStreet,
    @JsonKey(name: 'addressCity') @Default('') String addressCity,
    @JsonKey(name: 'addressPostalCode') @Default('') String addressPostalCode,
    @JsonKey(name: 'addressCountry') @Default('') String addressCountry,
    @JsonKey(name: SecurityJsonKeys.isActive) @Default(false) bool isActive,
    @JsonKey(name: SecurityJsonKeys.lastLogin) DateTime? lastLogin,
    @JsonKey(name: SecurityJsonKeys.createdAt) required DateTime createdAt,
    @JsonKey(name: SecurityJsonKeys.role) required String role,
    @JsonKey(name: SecurityJsonKeys.authProvider) @Default('LOCAL') String authProvider,
  }) = _UserProfileResponseModel;

  factory UserProfileResponseModel.fromJson(Map<String, dynamic> json) =>
      _$UserProfileResponseModelFromJson(json);

  UserProfile toEntity() {
    return UserProfile(
      id: id,
      email: email,
      firstName: firstName ?? '',
      lastName: lastName ?? '',
      profileImageUrl: profileImageUrl,
      phone: phone,
      addressStreet: addressStreet,
      addressCity: addressCity,
      addressPostalCode: addressPostalCode,
      addressCountry: addressCountry,
      isActive: isActive,
      lastLogin: lastLogin,
      createdAt: createdAt,
      roleName: role,
      authProvider: authProvider,
    );
  }
}
