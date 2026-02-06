import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../../domain/entities/user_profile.dart';
import '../../device/response/device_response_model.dart';

part 'user_profile_response_model.freezed.dart';
part 'user_profile_response_model.g.dart';

@freezed
class UserProfileResponseModel with _$UserProfileResponseModel {
  const UserProfileResponseModel._();

  const factory UserProfileResponseModel({
    @JsonKey(name: 'id') required int id,
    @JsonKey(name: 'email') required String email,
    @JsonKey(name: 'firstName') String? firstName,
    @JsonKey(name: 'lastName') String? lastName,
    @JsonKey(name: 'isActive') required bool isActive,
    @JsonKey(name: 'createdAt') required DateTime createdAt,
    @JsonKey(name: 'roles') required List<String> roles,
    // Používáme náš sjednocený DeviceResponseModel
    @JsonKey(name: 'devices') required List<DeviceResponseModel> devices,
  }) = _UserProfileResponseModel;

  factory UserProfileResponseModel.fromJson(Map<String, dynamic> json) =>
      _$UserProfileResponseModelFromJson(json);

  /// Mapování na doménovou entitu UserProfile.
  /// Tato metoda patří do Repository, ale mít ji zde jako helper je v pořádku.
  UserProfile toEntity() {
    return UserProfile(
      id: id,
      email: email,
      firstName: firstName ?? '',
      lastName: lastName ?? '',
      isActive: isActive,
      createdAt: createdAt,
      roles: roles,
      // Mapování vnořených modelů na entity
      devices: devices.map((device) => device.toEntity()).toList(),
    );
  }
}
