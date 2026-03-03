import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../domain/usecases/auth/params/auth_params.dart';

part 'auth_event.freezed.dart';

@freezed
class AuthEvent with _$AuthEvent {
  /// Inicializace aplikace a kontrola perzistentního přihlášení.
  const factory AuthEvent.appStarted() = AppStarted;

  /// Požadavek na login s využitím doménových parametrů.
  const factory AuthEvent.loginRequested(LoginParams params) = LoginRequested;

  /// Požadavek na registraci s využitím doménových parametrů.
  const factory AuthEvent.registerRequested(RegisterParams params) =
      RegisterRequested;

  /// Požadavek na registraci majitele restaurace (role OWNER).
  const factory AuthEvent.registerOwnerRequested(RegisterParams params) =
      RegisterOwnerRequested;

  /// Verifikace emailu (pojmenovaný parametr pro lepší čitelnost v Bloku).
  const factory AuthEvent.verifyEmailRequested({required String token}) =
      VerifyEmailRequested;

  /// Znovuodeslání kódu (pojmenovaný parametr).
  const factory AuthEvent.resendCodeRequested({required String email}) =
      ResendCodeRequested;

  /// OAuth události.
  const factory AuthEvent.googleLoginRequested() = GoogleLoginRequested;
  const factory AuthEvent.appleLoginRequested() = AppleLoginRequested;

  /// Odhlášení ze systému.
  const factory AuthEvent.logoutRequested() = LogoutRequested;
}
