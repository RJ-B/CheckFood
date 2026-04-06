import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../domain/entities/auth_failure.dart';
import '../../../domain/entities/user.dart';

part 'auth_state.freezed.dart';

@freezed
class AuthState with _$AuthState {
  const factory AuthState.initial() = _Initial;

  const factory AuthState.loading() = _Loading;

  /// Uživatel je úspěšně ověřen a máme jeho entitu.
  const factory AuthState.authenticated(User user) = _Authenticated;

  /// Uživatel není přihlášen.
  const factory AuthState.unauthenticated() = _Unauthenticated;

  /// Uživatel zadal správné údaje, ale účet ještě není verifikován.
  const factory AuthState.verificationRequired(String email) =
      _VerificationRequired;

  /// Registrace proběhla úspěšně (UI může zobrazit info o odeslaném emailu).
  const factory AuthState.registerSuccess() = _RegisterSuccess;

  /// Jednotný stav pro jakékoliv selhání s doménovou entitou AuthFailure.
  const factory AuthState.failure(AuthFailure failure) = _Failure;

  /// Email s odkazem pro obnovu hesla byl odeslán.
  const factory AuthState.passwordResetEmailSent(String email) = _PasswordResetEmailSent;

  /// Heslo bylo úspěšně změněno přes reset token.
  const factory AuthState.passwordResetSuccess() = _PasswordResetSuccess;
}
