import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../../config/security_json_keys.dart';
import '../../../../domain/entities/user.dart';
import '../../../../domain/enums/user_role.dart';

part 'user_response_model.freezed.dart';
part 'user_response_model.g.dart';

/// Datový model uživatele vrácený při přihlášení nebo registraci.
@freezed
class UserResponseModel with _$UserResponseModel {
  const UserResponseModel._();

  const factory UserResponseModel({
    @JsonKey(name: SecurityJsonKeys.id) required int id,
    @JsonKey(name: SecurityJsonKeys.email) required String email,
    @JsonKey(name: SecurityJsonKeys.role) required String role,
    @JsonKey(name: SecurityJsonKeys.isActive) required bool isActive,
    @JsonKey(name: SecurityJsonKeys.authorities)
    @Default([])
    List<String> authorities,
    @JsonKey(name: 'needsRestaurantClaim')
    @Default(false)
    bool needsRestaurantClaim,
    @JsonKey(name: 'needsOnboarding')
    @Default(false)
    bool needsOnboarding,
    @Default('') String firstName,
    @Default('') String lastName,
    @Default('') String phone,
  }) = _UserResponseModel;

  factory UserResponseModel.fromJson(Map<String, dynamic> json) =>
      _$UserResponseModelFromJson(json);

  User toEntity() {
    return User(
      id: id,
      email: email,
      role: UserRole.fromString(role),
      isActive: isActive,
      permissions: authorities,
      needsRestaurantClaim: needsRestaurantClaim,
      needsOnboarding: needsOnboarding,
      firstName: firstName,
      lastName: lastName,
      phone: phone,
    );
  }
}
