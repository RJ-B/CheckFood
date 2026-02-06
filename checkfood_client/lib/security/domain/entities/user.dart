import 'package:freezed_annotation/freezed_annotation.dart';

part 'user.freezed.dart';

@freezed
class User with _$User {
  const factory User({
    required int id,
    required String email,
    required String role, // Role pro řízení přístupu v UI
    required bool isActive,
  }) = _User;
}
