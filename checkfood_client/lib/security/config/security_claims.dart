class SecurityClaims {
  SecurityClaims._();

  /// Klíč pro ID uživatele v JWT (Spring Security standardně používá 'sub')
  static const String userId = 'sub';

  /// Klíč pro email uživatele v JWT
  static const String email = 'email';

  /// Klíč, kde backend posílá role (Spring Security standardně 'authorities')
  static const String roles = 'authorities';

  /// Klíč pro unikátní identifikátor zařízení uložený v tokenu
  static const String deviceIdentifier = 'deviceIdentifier';

  /// Prefix, který backend přidává k rolím (Spring Boot standard)
  static const String rolePrefix = 'ROLE_';
}
