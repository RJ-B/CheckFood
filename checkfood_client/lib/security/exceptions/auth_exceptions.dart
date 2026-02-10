import '../data/models/auth/response/auth_error_response_model.dart';

/// Základní třída pro všechny výjimky v modulu security.
abstract class SecurityException implements Exception {
  final String message;
  // Přidáváme volitelný model pro případy, kdy server vrátí detailní data
  final AuthErrorResponseModel? errorModel;

  const SecurityException(this.message, {this.errorModel});

  @override
  String toString() => message;
}

/// Výjimka vyhozená při zadání neplatných přihlašovacích údajů (401).
class InvalidCredentialsException extends SecurityException {
  const InvalidCredentialsException([
    super.message = 'Neplatný email nebo heslo.',
  ]);
}

/// Výjimka vyhozená, pokud je účet uživatele zablokován nebo deaktivován.
class AccountDisabledException extends SecurityException {
  const AccountDisabledException([super.message = 'Váš účet byl deaktivován.']);
}

/// Výjimka vyhozená při pokusu o registraci s již existujícím emailem (409).
class EmailAlreadyExistsException extends SecurityException {
  const EmailAlreadyExistsException([
    super.message = 'Uživatel s tímto emailem již existuje.',
  ]);
}

/// Výjimka vyhozená při vypršení platnosti refresh tokenu.
class SessionExpiredException extends SecurityException {
  const SessionExpiredException([
    super.message = 'Vaše relace vypršela. Přihlaste se prosím znovu.',
  ]);
}

/// Obecná výjimka pro chyby serveru nebo sítě.
class AuthServerException extends SecurityException {
  const AuthServerException(super.message, {super.errorModel});
}

/// ✅ KLÍČOVÁ ZMĚNA: Výjimka vyhozená, pokud účet není ověřený (403/410).
/// Vyžaduje AuthErrorResponseModel, který nese zprávu, email a příznak expirace.
class AccountNotVerifiedException extends SecurityException {
  AccountNotVerifiedException(AuthErrorResponseModel model)
    : super(model.message, errorModel: model);
}
