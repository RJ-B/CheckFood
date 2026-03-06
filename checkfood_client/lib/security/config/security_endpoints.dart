class SecurityEndpoints {
  SecurityEndpoints._();

  // --- AUTH ---
  static const String login = '/auth/login';
  static const String register = '/auth/register';
  static const String registerOwner = '/auth/register-owner';
  static const String refreshToken = '/auth/refresh';
  static const String logout = '/auth/logout';
  static const String verifyEmail = '/auth/verify';
  static const String resendVerification = '/auth/resend-code';

  // --- OAUTH ---
  static const String oauthLogin = '/oauth/login';

  // --- PROFILE & USER ---
  static const String profileMe = '/user/me';
  static const String updateProfile = '/user/profile';
  static const String changePassword = '/user/change-password';

  // --- DEVICES ---
  static const String devices = '/user/devices';
  static const String logoutAllDevices = '/user/logout-all';
  static String logoutDevice(int deviceId) => '/user/devices/$deviceId';

  // --- OWNER CLAIM ---
  // Note: Dio baseUrl already includes /api, so paths start from /v1/...
  static const String ownerClaimAres = '/v1/owner/claim/ares';
  static const String ownerClaimBankId = '/v1/owner/claim/bankid';
  static const String ownerClaimEmailStart = '/v1/owner/claim/email/start';
  static const String ownerClaimEmailConfirm = '/v1/owner/claim/email/confirm';

  // --- OWNER ONBOARDING ---
  static const String ownerRestaurant = '/v1/owner/restaurant/me';
  static const String ownerRestaurantInfo = '/v1/owner/restaurant/me/info';
  static const String ownerRestaurantHours = '/v1/owner/restaurant/me/hours';
  static const String ownerRestaurantTables = '/v1/owner/restaurant/me/tables';
  static String ownerRestaurantTable(String id) => '/v1/owner/restaurant/me/tables/$id';
  static const String ownerOnboardingStatus = '/v1/owner/restaurant/me/onboarding-status';
  static const String ownerPublish = '/v1/owner/restaurant/me/publish';

  // --- OWNER MENU ---
  static const String ownerMenu = '/v1/owner/restaurant/me/menu';
  static const String ownerMenuCategories = '/v1/owner/restaurant/me/menu/categories';
  static String ownerMenuCategory(String id) => '/v1/owner/restaurant/me/menu/categories/$id';
  static String ownerMenuCategoryItems(String catId) => '/v1/owner/restaurant/me/menu/categories/$catId/items';
  static String ownerMenuItem(String id) => '/v1/owner/restaurant/me/menu/items/$id';

  // --- OWNER PANORAMA ---
  static const String ownerPanoramaSessions = '/v1/owner/restaurant/me/panorama/sessions';
  static String ownerPanoramaSession(String id) => '/v1/owner/restaurant/me/panorama/sessions/$id';
  static String ownerPanoramaPhotos(String sessionId) => '/v1/owner/restaurant/me/panorama/sessions/$sessionId/photos';
  static String ownerPanoramaFinalize(String sessionId) => '/v1/owner/restaurant/me/panorama/sessions/$sessionId/finalize';
  static String ownerPanoramaActivate(String sessionId) => '/v1/owner/restaurant/me/panorama/sessions/$sessionId/activate';

  // --- UPLOADS ---
  static const String upload = '/v1/uploads';

  // --- NOTIFICATIONS ---
  static const String notificationPreference = '/user/devices/notifications';
}
