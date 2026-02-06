import 'package:freezed_annotation/freezed_annotation.dart';

// Ujisti se, že importuješ správnou entitu User/UserEntity podle tvého projektu
import '../../../domain/entities/user.dart';

part 'auth_state.freezed.dart';

@freezed
class AuthState with _$AuthState {
  const factory AuthState.initial() = _Initial;
  const factory AuthState.loading() = _Loading;
  const factory AuthState.authenticated(User user) = _Authenticated;
  const factory AuthState.unauthenticated() = _Unauthenticated;
  const factory AuthState.verificationRequired(String email) =
      _VerificationRequired;
  const factory AuthState.registerSuccess() = _RegisterSuccess;

  // Standardní chyby (špatné heslo, server nedostupný)
  const factory AuthState.failure(String message) = _Failure;

  // ✅ NOVÝ STAV: Specifický pro neaktivní účet nebo expirovaný odkaz
  const factory AuthState.unverifiedFailure({
    required String message,
    required String email,
    @Default(false) bool isExpired,
  }) = _UnverifiedFailure;
}
