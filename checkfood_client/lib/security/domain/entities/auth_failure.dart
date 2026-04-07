import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_failure.freezed.dart';

/// Doménová entita reprezentující chybu autentizace vrácenou serverem.
///
/// Obsahuje zprávu pro uživatele, volitelný email (pro přesměrování na verifikaci)
/// a příznak [isExpired] indikující expiraci verifikačního kódu.
@freezed
class AuthFailure with _$AuthFailure {
  const factory AuthFailure({
    required String message,
    String? email,
    @Default(false) bool isExpired,
  }) = _AuthFailure;
}
