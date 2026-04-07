import 'auth_exceptions.dart';

/// Základní třída pro všechny OAuth výjimky.
///
/// Dědí z [SecurityException], aby byla zachována kompatibilita s BLoC.
abstract class OAuthException extends SecurityException {
  const OAuthException(super.message, {super.errorModel});
}

/// Výjimka vyhozená, pokud uživatel zavře přihlašovací okno dříve, než dokončí proces.
class OAuthCanceledException extends OAuthException {
  const OAuthCanceledException([
    super.message = 'Přihlášení bylo zrušeno uživatelem.',
  ]);
}

/// Výjimka vyhozená, pokud backend odmítne ID Token od Googlu/Applu jako nevalidní (401).
class OAuthInvalidTokenException extends OAuthException {
  const OAuthInvalidTokenException([
    super.message =
        'Ověření identity u poskytovatele selhalo (neplatný token).',
  ]);
}

/// Výjimka vyhozená při konfliktu účtů (409) — email je registrován přes LOCAL
/// (email/heslo), ale uživatel se pokouší přihlásit přes sociální síť.
class OAuthAccountLinkException extends OAuthException {
  const OAuthAccountLinkException([
    super.message = 'Tento email je již registrován jiným způsobem přihlášení.',
  ]);
}

/// Výjimka vyhozená, pokud je účet uživatele spojený se sociální sítí deaktivován (403).
class OAuthAccountDisabledException extends OAuthException {
  const OAuthAccountDisabledException([
    super.message = 'Váš účet je deaktivován. Kontaktujte prosím podporu.',
  ]);
}

/// Výjimka vyhozená, pokud konfigurace na Google Cloud Console / Apple Developer
/// neodpovídá požadavkům (např. chybějící Client ID).
class OAuthAppNotAuthorizedException extends OAuthException {
  const OAuthAppNotAuthorizedException([
    super.message = 'Tato aplikace není autorizována pro sociální přihlášení.',
  ]);
}

/// Výjimka vyhozená při chybách na straně Googlu/Applu nebo při neznámé chybě serveru.
class OAuthProviderException extends OAuthException {
  const OAuthProviderException(super.message, {super.errorModel});
}

/// Výjimka vyhozená, pokud sociální síť neposkytne emailovou adresu
/// (např. u Applu při odmítnutí sdílení).
class OAuthMissingEmailException extends OAuthException {
  const OAuthMissingEmailException([
    super.message = 'Nepodařilo se získat emailovou adresu z vašeho profilu.',
  ]);
}
