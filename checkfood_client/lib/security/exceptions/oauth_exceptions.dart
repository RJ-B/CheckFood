import 'auth_exceptions.dart';

/// Základní třída pro všechny OAuth výjimky.
/// Dědí z tvé SecurityException, aby byla zachována kompatibilita s BLoC. [cite: 2026-01-25]
abstract class OAuthException extends SecurityException {
  const OAuthException(super.message, {super.errorModel});
}

/// 1. Zrušení uživatelem
/// Vyhozeno, pokud uživatel zavře přihlašovací okno dříve, než dokončí proces.
class OAuthCanceledException extends OAuthException {
  const OAuthCanceledException([
    super.message = 'Přihlášení bylo zrušeno uživatelem.',
  ]);
}

/// 2. Neplatný nebo expirovaný Token (401)
/// Vyhozeno, pokud backend odmítne ID Token od Googlu/Applu jako nevalidní. [cite: 2026-01-23]
class OAuthInvalidTokenException extends OAuthException {
  const OAuthInvalidTokenException([
    super.message =
        'Ověření identity u poskytovatele selhalo (neplatný token).',
  ]);
}

/// 3. Konflikt účtů (409)
/// Vyhozeno, pokud se uživatel zkouší přihlásit přes sociální síť, ale daný email
/// je již v systému registrován přes LOCAL (email/heslo). [cite: 2026-01-23]
class OAuthAccountLinkException extends OAuthException {
  const OAuthAccountLinkException([
    super.message = 'Tento email je již registrován jiným způsobem přihlášení.',
  ]);
}

/// 4. Zablokovaný účet (403)
/// Vyhozeno, pokud je účet uživatele spojený se sociální sítí v systému deaktivován. [cite: 2026-01-24]
class OAuthAccountDisabledException extends OAuthException {
  const OAuthAccountDisabledException([
    super.message = 'Váš účet je deaktivován. Kontaktujte prosím podporu.',
  ]);
}

/// 5. Neautorizovaná aplikace
/// Vyhozeno, pokud konfigurace na Google Cloud Console / Apple Developer neodpovídá
/// požadavkům (např. chybějící Client ID). [cite: 2026-01-23]
class OAuthAppNotAuthorizedException extends OAuthException {
  const OAuthAppNotAuthorizedException([
    super.message = 'Tato aplikace není autorizována pro sociální přihlášení.',
  ]);
}

/// 6. Obecná chyba poskytovatele
/// Vyhozeno při chybách na straně Googlu/Applu nebo při neznámé chybě serveru. [cite: 2026-01-25]
class OAuthProviderException extends OAuthException {
  const OAuthProviderException(super.message, {super.errorModel});
}

/// 7. Chybějící email v profilu
/// Vyhozeno, pokud sociální síť neposkytne emailovou adresu (např. u Applu při odmítnutí sdílení).
class OAuthMissingEmailException extends OAuthException {
  const OAuthMissingEmailException([
    super.message = 'Nepodařilo se získat emailovou adresu z vašeho profilu.',
  ]);
}
