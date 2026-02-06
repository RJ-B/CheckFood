import 'auth_exceptions.dart';

/// Výjimka vyhozená při zadání neplatného nebo expirovaného MFA kódu.
class InvalidMfaCodeException extends SecurityException {
  const InvalidMfaCodeException([
    super.message =
        'Zadaný ověřovací kód je neplatný nebo jeho platnost vypršela.',
  ]);
}

/// Výjimka vyhozená, pokud se uživatel pokusí o operaci vyžadující MFA, ale nemá ho nastavené.
class MfaNotSetupException extends SecurityException {
  const MfaNotSetupException([
    super.message = 'Víceúrovňové ověřování není pro tento účet nastaveno.',
  ]);
}

/// Výjimka vyhozená při chybě během generování nového MFA setupu (např. QR kódu).
class MfaSetupException extends SecurityException {
  const MfaSetupException([
    super.message =
        'Nepodařilo se zahájit nastavení MFA. Zkuste to prosím znovu.',
  ]);
}

/// Výjimka vyhozená při neúspěšném pokusu o deaktivaci MFA (např. špatné heslo v MfaDisableRequest).
class MfaDisableException extends SecurityException {
  const MfaDisableException([
    super.message = 'MFA se nepodařilo vypnout. Ověřte své heslo.',
  ]);
}
