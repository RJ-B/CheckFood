import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../data/models/auth/response/auth_error_response_model.dart';
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

  /// ✅ Jednotný chybový stav nesoucí komplexní informaci z backendu
  const factory AuthState.failure(AuthErrorResponseModel error) = _Failure;
}
