import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../domain/entities/user_profile.dart';

part 'user_state.freezed.dart';

@freezed
class UserState with _$UserState {
  const factory UserState.initial() = _Initial;
  const factory UserState.loading() = _Loading;

  /// Profil byl úspěšně načten nebo aktualizován.
  const factory UserState.loaded(UserProfile profile) = _Loaded;

  /// Heslo bylo úspěšně změněno (jednorázový signál pro UI).
  const factory UserState.passwordChangeSuccess() = _PasswordChangeSuccess;

  /// Zařízení byla úspěšně odhlášena.
  const factory UserState.devicesLogoutSuccess() = _DevicesLogoutSuccess;

  /// Selhání operace.
  const factory UserState.failure(String message) = _Failure;
}
