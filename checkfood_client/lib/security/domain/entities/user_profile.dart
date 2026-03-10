import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_profile.freezed.dart';

@freezed
class UserProfile with _$UserProfile {
  const UserProfile._();

  const factory UserProfile({
    required int id,
    required String email,
    required String firstName,
    required String lastName,
    String? profileImageUrl,
    required bool isActive,
    DateTime? lastLogin,
    required DateTime createdAt,
    required String roleName,
    @Default('LOCAL') String authProvider,
  }) = _UserProfile;

  String get fullName => '$firstName $lastName'.trim();
}
