/// Základní třída pro všechny výjimky v modulu security.
abstract class SecurityException implements Exception {
  final String message;
  const SecurityException(this.message);

  @override
  String toString() => message;
}

/// Výjimka vyhozená při zadání neplatných přihlašovacích údajů (401).
class InvalidCredentialsException extends SecurityException {
  const InvalidCredentialsException([
    super.message = 'Neplatný email nebo heslo.',
  ]);
}

/// Výjimka vyhozená, pokud je účet uživatele zablokován nebo neaktivní.
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
  const AuthServerException([
    super.message = 'Došlo k chybě při komunikaci se serverem.',
  ]);
}

/// Výjimka vyhozená, pokud účet existuje, ale není ověřený (403).
class AccountNotVerifiedException extends SecurityException {
  const AccountNotVerifiedException([
    super.message = 'Účet není aktivní. Zkontrolujte prosím svůj e-mail.',
  ]);
}
