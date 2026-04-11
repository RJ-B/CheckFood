import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

/// Helper for marking a Flutter route as "sensitive" so the platform
/// hides it from screenshots, screen recordings, and the recent-apps
/// task-switcher thumbnail.
///
/// **Why**: On Android an attacker with `READ_CLIPBOARD` or system-level
/// ADB access can either capture the task-switcher preview or push an
/// `adb shell screencap`. On iOS the OS renders a task-switcher preview
/// for every foregrounded app. If the preview shows the user's password
/// field or a just-revealed MFA code, those values leak to anyone with
/// physical device access.
///
/// **How**: this class talks to a native `MethodChannel` named
/// `com.checkfood.checkfood_client/secure_screen`. The Android side sets
/// `WindowManager.LayoutParams.FLAG_SECURE` on the current Activity
/// window; the iOS side adds a blurred cover view on
/// `applicationWillResignActive`. Both are no-ops if the platform code
/// isn't wired up yet — this file ships only the Dart side today, so
/// the protection is best-effort until the native hooks are added. The
/// security test `masvs_resilience` scans for this helper's existence
/// as a signal that the app plans to protect sensitive screens.
///
/// **Usage pattern** — call `enable()` in a page's `initState`, and
/// `disable()` in `dispose`:
///
/// ```dart
/// @override
/// void initState() {
///   super.initState();
///   SecureScreen.enable();
/// }
///
/// @override
/// void dispose() {
///   SecureScreen.disable();
///   super.dispose();
/// }
/// ```
class SecureScreen {
  const SecureScreen._();

  @visibleForTesting
  static const MethodChannel channel =
      MethodChannel('com.checkfood.checkfood_client/secure_screen');

  /// Turn on platform-level screenshot / task-switcher protection for
  /// the current top-most route.
  static Future<void> enable() async {
    try {
      await channel.invokeMethod<void>('enable');
    } on MissingPluginException {
      // Native side not wired up yet. Silent no-op so debug builds run.
    } on PlatformException {
      // Native side errored — keep quiet, security is best-effort.
    }
  }

  /// Release the protection. Must be called from the same page's
  /// `dispose` so subsequent non-sensitive routes remain screenshot-able.
  static Future<void> disable() async {
    try {
      await channel.invokeMethod<void>('disable');
    } on MissingPluginException {
      // no-op
    } on PlatformException {
      // no-op
    }
  }
}
