class SecurityJsonKeys {
  SecurityJsonKeys._();

  // --- Společné klíče ---
  static const String id = 'id';
  static const String email = 'email';
  static const String role = 'role';
  static const String isActive = 'isActive';

  // --- Auth Requesty ---
  static const String password = 'password';
  static const String deviceIdentifier = 'deviceIdentifier';
  static const String deviceName = 'deviceName';
  static const String deviceType = 'deviceType';
  static const String token = 'token';

  // --- Auth & Token Response ---
  static const String accessToken = 'accessToken';
  static const String refreshToken = 'refreshToken';
  static const String expiresIn = 'expiresIn';
  static const String user = 'user';
  static const String authorities = 'authorities';

  // --- Profile Persona ---
  static const String firstName = 'firstName';
  static const String lastName = 'lastName';
  static const String profileImageUrl = 'profileImageUrl';
  static const String lastLogin = 'lastLogin';
  static const String createdAt = 'createdAt';

  // --- Error Response ---
  static const String message = 'message';
  static const String isExpired = 'isExpired';

  static const String isCurrentDevice = 'currentDevice';

  static const String idToken = 'idToken';
  static const String provider = 'provider';

  static const String currentPassword = 'currentPassword';
  static const String newPassword = 'newPassword';
  static const String confirmPassword = 'confirmPassword';
}
