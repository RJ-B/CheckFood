import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../../security/data/models/auth/request/login_request_model.dart';
import '../../../../security/data/models/auth/request/register_request_model.dart';
import '../../../../security/data/models/auth/request/verify_email_request_model.dart';

part 'auth_event.freezed.dart';

@freezed
class AuthEvent with _$AuthEvent {
  /// Inicializace aplikace a kontrola persistence tokenů
  const factory AuthEvent.appStarted() = AppStarted;

  /// Požadavek na přihlášení uživatele
  const factory AuthEvent.loginRequested(LoginRequestModel request) =
      LoginRequested;

  /// Požadavek na registraci nového uživatele
  const factory AuthEvent.registerRequested(RegisterRequestModel request) =
      RegisterRequested;

  /// Požadavek na verifikaci e-mailu pomocí tokenu
  const factory AuthEvent.verifyEmailRequested(
    VerifyEmailRequestModel request,
  ) = VerifyEmailRequested;

  /// Požadavek na znovuodeslání verifikačního e-mailu
  const factory AuthEvent.resendCodeRequested(String email) =
      ResendCodeRequested;

  /// Požadavek na bezpečné odhlášení a zneplatnění relace
  const factory AuthEvent.logoutRequested() = LogoutRequested;
}
