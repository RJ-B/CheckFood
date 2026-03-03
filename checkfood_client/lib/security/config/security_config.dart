class SecurityConfig {
  SecurityConfig._();

  // Klíče pro Flutter Secure Storage
  // Pokud je změníte zde, modul v jiném projektu nebude sdílet tokeny s CheckFood
  static const String accessTokenKey = 'checkfood_access_token';
  static const String refreshTokenKey = 'checkfood_refresh_token';
  static const String userRoleKey = 'checkfood_user_role';
  static const String userIdKey = 'checkfood_user_id';

  // Nastavení expirace a bezpečnosti
  static const Duration refreshThreshold = Duration(minutes: 5);
  static const bool useBiometricsIfAvailable = true;
}
