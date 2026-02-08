import 'auth_exceptions.dart';

/// Výjimka vyhozená při zadání nesprávného stávajícího hesla při změně.
class IncorrectPasswordException extends SecurityException {
  const IncorrectPasswordException([
    super.message = 'Současné heslo není správné.',
  ]);
}

/// Výjimka vyhozená, pokud uživatelský profil neexistuje nebo k němu není přístup.
class ProfileNotFoundException extends SecurityException {
  const ProfileNotFoundException([
    super.message = 'Uživatelský profil nebyl nalezen.',
  ]);
}

/// Výjimka pro chyby validace dat na straně serveru (např. příliš krátké jméno).
class UserValidationException extends SecurityException {
  const UserValidationException(super.message);
}
