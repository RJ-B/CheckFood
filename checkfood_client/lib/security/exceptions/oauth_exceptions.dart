import 'auth_exceptions.dart';

/// Výjimka vyhozená při zrušení OAuth procesu uživatelem.
class OAuthCancelledException extends SecurityException {
  const OAuthCancelledException([super.message = 'Přihlášení bylo zrušeno.']);
}

/// Výjimka vyhozená při chybě komunikace s poskytovatelem (Google/Apple).
class OAuthProviderException extends SecurityException {
  const OAuthProviderException([
    super.message = 'Nepodařilo se spojit s poskytovatelem přihlášení.',
  ]);
}

/// Výjimka vyhozená, pokud ID token nebo autorizační kód není platný.
class InvalidOAuthTokenException extends SecurityException {
  const InvalidOAuthTokenException([
    super.message = 'Ověření u poskytovatele nebylo úspěšné.',
  ]);
}
