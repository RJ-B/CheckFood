import 'package:freezed_annotation/freezed_annotation.dart';
import 'device.dart';

part 'user_profile.freezed.dart';

@freezed
class UserProfile with _$UserProfile {
  // Prázdný interní konstruktor je nutný, abychom mohli definovat vlastní gettery
  const UserProfile._();

  const factory UserProfile({
    required int id,
    required String email,
    required String firstName,
    required String lastName,
    required bool isActive,
    required DateTime createdAt,
    required List<String> roles,
    required List<Device> devices,
  }) = _UserProfile;

  /// Getter pro zobrazení celého jména
  String get fullName => '$firstName $lastName'.trim();
}
