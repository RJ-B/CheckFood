/// Základní třída pro všechny serverové výjimky.
abstract class AppException implements Exception {
  final String message;
  const AppException(this.message);

  @override
  String toString() => message;
}

/// Chyba při připojení k serveru (timeout, žádná síť).
class ConnectionException extends AppException {
  const ConnectionException([
    super.message = 'Nepodařilo se připojit k serveru. Zkontrolujte připojení k internetu.',
  ]);
}

/// Obecná serverová chyba (5xx nebo neznámá).
class ServerException extends AppException {
  const ServerException([super.message = 'Došlo k chybě serveru. Zkuste to prosím později.']);
}

/// Chyba validace vstupu (400).
class ValidationException extends AppException {
  const ValidationException([super.message = 'Neplatný požadavek.']);
}

/// Uživatel není přihlášen nebo token vypršel (401).
class UnauthorizedException extends AppException {
  const UnauthorizedException([super.message = 'Nejste přihlášeni.']);
}

/// Přístup odepřen (403).
class ForbiddenException extends AppException {
  const ForbiddenException([super.message = 'Nemáte oprávnění k této akci.']);
}

/// Zdroj nebyl nalezen (404).
class NotFoundException extends AppException {
  const NotFoundException([super.message = 'Požadovaný zdroj nebyl nalezen.']);
}

/// Konflikt (409).
class ConflictException extends AppException {
  const ConflictException([super.message = 'Požadavek je v konfliktu s aktuálním stavem.']);
}

/// Příliš mnoho požadavků (429).
class RateLimitException extends AppException {
  const RateLimitException([super.message = 'Příliš mnoho pokusů. Zkuste to prosím později.']);
}
