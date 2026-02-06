import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../../domain/entities/user.dart';

part 'user_response_model.freezed.dart';
part 'user_response_model.g.dart';

@freezed
class UserResponseModel with _$UserResponseModel {
  const UserResponseModel._(); // Nutné pro metodu toEntity()

  const factory UserResponseModel({
    @JsonKey(name: 'id') required int id,
    @JsonKey(name: 'email') required String email,
    @JsonKey(name: 'role') required String role,
    @JsonKey(name: 'isActive') required bool isActive,
    // firstName a lastName zde již nefigurují, jsou v UserProfileResponseModel
  }) = _UserResponseModel;

  factory UserResponseModel.fromJson(Map<String, dynamic> json) =>
      _$UserResponseModelFromJson(json);

  /// Mapování na odlehčenou Freezed entitu User
  User toEntity() {
    return User(id: id, email: email, role: role, isActive: isActive);
  }
}
