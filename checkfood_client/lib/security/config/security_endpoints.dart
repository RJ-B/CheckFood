/// Konstanty URL cest pro všechny backendové REST endpointy.
///
/// Cesty jsou relativní vůči `baseUrl` Dio klienta, který již obsahuje `/api`.
/// Dynamické segmenty jsou generovány metodami (např. [logoutDevice]).
class SecurityEndpoints {
  SecurityEndpoints._();

  static const String login = '/auth/login';
  static const String register = '/auth/register';
  static const String registerOwner = '/auth/register-owner';
  static const String refreshToken = '/auth/refresh';
  static const String logout = '/auth/logout';
  static const String verifyEmail = '/auth/verify';
  static const String resendVerification = '/auth/resend-code';

  static const String forgotPassword = '/auth/forgot-password';
  static const String resetPassword = '/auth/reset-password';

  static const String oauthLogin = '/oauth/login';

  static const String profileMe = '/user/me';
  static const String updateProfile = '/user/profile';
  static const String changePassword = '/user/change-password';

  static const String devices = '/user/devices';
  static const String logoutAllDevices = '/user/logout-all';
  static const String deleteAllDevices = '/user/devices/all';

  /// Vrátí cestu pro odhlášení konkrétního zařízení.
  static String logoutDevice(int deviceId) => '/user/devices/$deviceId/logout';

  /// Vrátí cestu pro smazání konkrétního zařízení.
  static String deleteDevice(int deviceId) => '/user/devices/$deviceId';

  static const String ownerRestaurant = '/v1/owner/restaurant/me';
  static const String ownerRestaurantInfo = '/v1/owner/restaurant/me/info';
  static const String ownerRestaurantHours = '/v1/owner/restaurant/me/hours';
  static const String ownerRestaurantTables = '/v1/owner/restaurant/me/tables';

  /// Vrátí cestu pro konkrétní stůl restaurace.
  static String ownerRestaurantTable(String id) => '/v1/owner/restaurant/me/tables/$id';
  static const String ownerOnboardingStatus = '/v1/owner/restaurant/me/onboarding-status';
  static const String ownerPublish = '/v1/owner/restaurant/me/publish';

  static const String ownerMenu = '/v1/owner/restaurant/me/menu';
  static const String ownerMenuCategories = '/v1/owner/restaurant/me/menu/categories';

  /// Vrátí cestu pro konkrétní kategorii menu.
  static String ownerMenuCategory(String id) => '/v1/owner/restaurant/me/menu/categories/$id';

  /// Vrátí cestu pro položky konkrétní kategorie menu.
  static String ownerMenuCategoryItems(String catId) => '/v1/owner/restaurant/me/menu/categories/$catId/items';

  /// Vrátí cestu pro konkrétní položku menu.
  static String ownerMenuItem(String id) => '/v1/owner/restaurant/me/menu/items/$id';

  static const String ownerPanoramaSessions = '/v1/owner/restaurant/me/panorama/sessions';

  /// Vrátí cestu pro konkrétní panoramatickou session.
  static String ownerPanoramaSession(String id) => '/v1/owner/restaurant/me/panorama/sessions/$id';

  /// Vrátí cestu pro nahrávání fotografií do session.
  static String ownerPanoramaPhotos(String sessionId) => '/v1/owner/restaurant/me/panorama/sessions/$sessionId/photos';

  /// Vrátí cestu pro finalizaci panoramatické session.
  static String ownerPanoramaFinalize(String sessionId) => '/v1/owner/restaurant/me/panorama/sessions/$sessionId/finalize';

  /// Vrátí cestu pro aktivaci panoramatu.
  static String ownerPanoramaActivate(String sessionId) => '/v1/owner/restaurant/me/panorama/sessions/$sessionId/activate';

  // ---------- MEDIA UPLOADS (typed endpointy nahrazující generický /v1/uploads) ----------

  /// Avatar přihlášeného uživatele (privátní GCS bucket, vrací signed URL).
  static const String userAvatar = '/user/me/avatar';

  /// Logo restaurace (veřejný GCS bucket).
  static String ownerRestaurantLogo(String restaurantId) =>
      '/v1/owner/restaurants/$restaurantId/logo';

  /// Cover obrázek restaurace (veřejný GCS bucket).
  static String ownerRestaurantCover(String restaurantId) =>
      '/v1/owner/restaurants/$restaurantId/cover';

  /// Galerie restaurace — POST přidává, GET vrací seznam (anonymně).
  static String ownerRestaurantGallery(String restaurantId) =>
      '/v1/owner/restaurants/$restaurantId/gallery';

  static String publicRestaurantGallery(String restaurantId) =>
      '/v1/restaurants/$restaurantId/gallery';

  /// Smazání konkrétní fotky z galerie podle photoId.
  static String ownerRestaurantGalleryPhoto(String restaurantId, String photoId) =>
      '/v1/owner/restaurants/$restaurantId/gallery/$photoId';

  /// Obrázek konkrétní položky menu (POST nahrazuje, DELETE maže).
  static String ownerMenuItemImage(String restaurantId, String itemId) =>
      '/v1/owner/restaurants/$restaurantId/menu-items/$itemId/image';

  static const String notificationPreference = '/user/devices/notifications';

  static const String deleteAccount = '/user/account';
}
