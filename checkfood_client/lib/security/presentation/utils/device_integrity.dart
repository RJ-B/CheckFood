import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

/// Light-weight root / jailbreak detection.
///
/// **Warn-only policy (E2)** — this helper does NOT block startup or
/// refuse to persist tokens. Per the architectural decision recorded
/// in the project memory, CheckFood only surfaces a warning banner to
/// the user if their device looks compromised, so we don't alienate
/// the 2–5 % of users running rooted dev devices in CZ and a broken
/// emulator doesn't kill dev workflow.
///
/// **Detection mechanism** — talks to the native side via a method
/// channel `com.checkfood.checkfood_client/device_integrity`. The
/// native handler returns `true` if any of the heuristics fire:
///
///   Android: `Build.TAGS` contains "test-keys"; or one of the common
///            root package paths (`/system/app/Superuser.apk`,
///            `/sbin/su`, `/system/xbin/su`, `/data/local/tmp/magisk`)
///            exists.
///   iOS:     `/Applications/Cydia.app`, `/Library/MobileSubstrate`,
///            `/bin/bash` or `/usr/sbin/sshd` exist; or a write to
///            `/private/jailbreak.txt` succeeds (sandbox escape).
///
/// Returns `false` on platforms without a handler (desktop, web,
/// tests) so dev builds don't false-positive.
class DeviceIntegrity {
  const DeviceIntegrity._();

  @visibleForTesting
  static const MethodChannel channel =
      MethodChannel('com.checkfood.checkfood_client/device_integrity');

  /// `true` if the current device shows any signal of being rooted or
  /// jailbroken. Warn-only — use the result to display a soft banner,
  /// never to reject the user.
  static Future<bool> isCompromised() async {
    try {
      final result = await channel.invokeMethod<bool>('isCompromised');
      return result ?? false;
    } on MissingPluginException {
      // No native handler wired up — treat as clean.
      return false;
    } on PlatformException {
      // Native threw — fail open to not block legit users.
      return false;
    }
  }
}
