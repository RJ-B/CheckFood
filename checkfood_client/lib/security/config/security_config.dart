/// Konfigurace bezpečnostního modulu — klíče pro Flutter Secure Storage
/// a nastavení expirace tokenů.
///
/// Klíče jsou záměrně prefixovány `checkfood_`, aby nedocházelo ke kolizi
/// s ostatními projekty sdílejícími stejné úložiště.
class SecurityConfig {
  SecurityConfig._();

  static const String accessTokenKey = 'checkfood_access_token';
  static const String refreshTokenKey = 'checkfood_refresh_token';
  static const String userRoleKey = 'checkfood_user_role';
  static const String userIdKey = 'checkfood_user_id';

  static const Duration refreshThreshold = Duration(minutes: 5);
  static const bool useBiometricsIfAvailable = true;
}
