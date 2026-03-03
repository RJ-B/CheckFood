import 'package:freezed_annotation/freezed_annotation.dart';
import '../enums/user_role.dart';

part 'user.freezed.dart';

@freezed
class User with _$User {
  const User._();

  const factory User({
    required int id,
    required String email,
    required UserRole role,
    required bool isActive,
    @Default([]) List<String> permissions,
    @Default(false) bool needsRestaurantClaim,
    @Default(false) bool needsOnboarding,
  }) = _User;

  bool hasPermission(String permission) => permissions.contains(permission);
}
