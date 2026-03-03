import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../domain/entities/user_profile.dart';
import '../../../domain/entities/device.dart';

part 'user_state.freezed.dart';

@freezed
class UserState with _$UserState {
  const factory UserState.initial() = _Initial;
  const factory UserState.loading() = _Loading;

  const factory UserState.loaded({
    required UserProfile profile,
    @Default([]) List<Device> devices,
  }) = _Loaded;

  const factory UserState.failure(String message) = _Failure;

  // Speciální stavy pro jednorázové akce (Toast/Snackbar)
  const factory UserState.passwordChangeSuccess() = _PasswordChangeSuccess;
  const factory UserState.devicesLogoutSuccess() = _DevicesLogoutSuccess;
}
