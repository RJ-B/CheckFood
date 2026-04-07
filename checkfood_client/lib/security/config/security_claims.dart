/// Názvy klíčů (claims) používaných v JWT tokenech vydávaných backendem.
class SecurityClaims {
  SecurityClaims._();

  /// Klíč pro ID uživatele v JWT (Spring Security standardně používá 'sub')
  static const String userId = 'sub';

  /// Klíč pro email uživatele v JWT
  static const String email = 'email';

  /// Klíč, kde backend posílá role v JWT
  static const String roles = 'roles';

  /// Klíč pro unikátní identifikátor zařízení uložený v tokenu
  static const String deviceIdentifier = 'deviceIdentifier';

  /// Prefix, který backend přidává k rolím (Spring Boot standard)
  static const String rolePrefix = 'ROLE_';
}
