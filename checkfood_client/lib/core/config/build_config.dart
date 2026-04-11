/// Compile-time build configuration injected via `--dart-define`.
///
/// Replaces the previous `flutter_dotenv` runtime-loading approach which
/// shipped `.env`, `.env.local`, `.env.prod` inside the APK/IPA as plain-text
/// assets (any attacker could `unzip` the archive and read them).
///
/// **All values are `const`** — the compiler inlines them into the Dart
/// snapshot at build time. Secrets never touch the bundle filesystem.
///
/// Usage:
/// ```
/// flutter run \
///   --dart-define=API_BASE_URL=http://192.168.1.199:8081/api \
///   --dart-define=GOOGLE_WEB_CLIENT_ID=...apps.googleusercontent.com
/// ```
///
/// For the Google Maps native SDK API key (Android + iOS), see:
/// - Android: `android/local.properties` (`MAPS_API_KEY=...`) → gradle
///   propagates it via `manifestPlaceholders["mapsApiKey"]` into
///   `AndroidManifest.xml`.
/// - iOS: `ios/Flutter/Secrets.xcconfig` (`MAPS_API_KEY=...`) → xcconfig
///   variable substitution into `Info.plist` (`GMSApiKey` entry), read by
///   `AppDelegate.swift`.
///
/// The Dart side does **not** need the Maps key — it is only consumed by the
/// native Google Maps SDK on each platform.
class BuildConfig {
  const BuildConfig._();

  /// Spring Boot backend base URL (must include `/api` prefix).
  ///
  /// Defaults to the Android emulator host loopback (`10.0.2.2`) so an
  /// un-configured dev build points at a local backend instead of prod.
  static const String apiBaseUrl = String.fromEnvironment(
    'API_BASE_URL',
    defaultValue: 'http://10.0.2.2:8081/api',
  );

  /// Google OAuth Web Application client ID used for server-side token
  /// verification. Public information (visible in OAuth consent screen),
  /// but kept as a build-time constant so devs don't hardcode it in source.
  static const String googleWebClientId = String.fromEnvironment(
    'GOOGLE_WEB_CLIENT_ID',
  );

  /// Apple Sign-In client ID (matches app bundle identifier on iOS).
  static const String appleClientId = String.fromEnvironment(
    'APPLE_CLIENT_ID',
    defaultValue: 'com.checkfood.checkfood_client',
  );

  /// Apple Sign-In redirect URL for the Android flow.
  static const String appleRedirectUrl = String.fromEnvironment(
    'APPLE_REDIRECT_URL',
  );

  /// True when every required value has been supplied at build time.
  /// Useful for guarding OAuth features that would otherwise silently fail.
  static bool get oauthConfigured =>
      googleWebClientId.isNotEmpty && appleClientId.isNotEmpty;

  /// Comma-separated SHA-256 hex fingerprints of pinned leaf certificates
  /// used by [CertificatePinner]. Supply primary + backup. Empty in dev
  /// builds — the callback then falls back to standard TLS validation
  /// (still enforced by `network_security_config.xml` + `ATS`, just
  /// without the extra pin).
  ///
  /// Rotate by running `scripts/cert_fingerprint.sh` 30 days before the
  /// live Cloud Run certificate expires, then re-build with the new
  /// value.
  static const String _pinnedCertFingerprintsCsv = String.fromEnvironment(
    'CERT_PIN_SHA256',
  );

  static List<String> get pinnedCertFingerprints {
    if (_pinnedCertFingerprintsCsv.isEmpty) return const [];
    return _pinnedCertFingerprintsCsv
        .split(',')
        .map((s) => s.trim().toLowerCase())
        .where((s) => s.isNotEmpty)
        .toList(growable: false);
  }
}
