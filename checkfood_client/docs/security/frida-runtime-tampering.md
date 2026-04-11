# Runtime Tampering Tests with Frida

This doc covers how to run manual runtime-attack simulations against
the CheckFood Android app using [Frida](https://frida.re). These
tests are **not** wired into CI — they require a rooted device, a
Frida server running as root, and physical access. They're for
periodic (quarterly) security review, not for PR gates.

The goal is to verify that the Phase 5 hardening actually resists
a determined attacker with runtime code-injection, not just the
OWASP MASVS static checklist.

## Why not CI?

Three reasons:

1. **Rooted device required.** Frida's `frida-server` needs to run
   as root on the target device. No CI runner (including FTL) gives
   you root on the VM, and Flutter's Android Test harness does not
   expose the required `/data/local/tmp` write permissions.
2. **Attack scripts are destructive by nature.** A typical Frida
   hook rewrites method bodies or intercepts native calls. Running
   them on CI devices would leave the emulator in an unknown state
   and risk cross-contaminating parallel jobs.
3. **Frida detection is intentionally best-effort.** The Apr-2026
   audit concluded that a determined attacker with root will always
   get code execution; our defense is *detection + warning banner*
   (via `DeviceIntegrity`), not prevention. Automating "verify
   detection catches Frida" is valuable but the value-per-minute
   of CI cost is low.

## Prerequisites

```bash
# macOS host
brew install frida

# Device (rooted Android, API 30+)
adb push frida-server /data/local/tmp/
adb shell "chmod 755 /data/local/tmp/frida-server"
adb shell "su -c '/data/local/tmp/frida-server &'"

# Verify from host
frida-ps -U  # should list running processes
```

Match the `frida-server` binary version to the host `frida` version
exactly — version skew causes silent "target not responding" errors.

## Test scenarios

### T1: Cert pinning bypass

Verifies that the Dio `badCertificateCallback` (see
`lib/core/network/certificate_pinner.dart`) actually rejects a
forged cert. Run `mitmproxy` as the TLS interceptor, inject the
mitmproxy CA into the device, and watch for the app to *refuse* the
connection.

```bash
# Terminal 1 — proxy
mitmproxy --mode transparent --showhost

# Terminal 2 — route device traffic through proxy
adb shell settings put global http_proxy <host-ip>:8080

# Terminal 3 — run the app, watch for network failure
frida -U -l scripts/log-network.js -f com.checkfood.checkfood_client
```

**Expected**: All Dio requests fail with a certificate pinning
exception. The mobile app shows the "connection error" screen.
**Fail mode**: if any request reaches mitmproxy in clear-text form,
pinning is broken.

### T2: Keychain/Keystore dump

Verifies that `flutter_secure_storage` values are NOT readable
from a rooted shell. The Apr-2026 fix switched iOS Keychain
accessibility to `first_unlock_this_device`.

```bash
# Android Keystore — try to dump the alias
adb shell "su -c 'keystore_cli_v2 list'"

# iOS Keychain — device must NOT be pinned to unlocked; test under
# lock screen to verify `first_unlock_this_device` behaves.
```

**Expected**: JWT access token, refresh token, and MFA secret are
all inaccessible on a locked device. The `SecureStorage` wrapper
falls back to its error path gracefully.

### T3: SSL_CTX_set_verify hook

Classic pinning bypass via Frida's Java hook. Overrides OkHttp /
SSLContext trust manager.

```js
// scripts/bypass-ssl.js
Java.perform(() => {
  const TrustManager = Java.registerClass({
    name: 'com.example.TrustAll',
    implements: [Java.use('javax.net.ssl.X509TrustManager')],
    methods: {
      checkClientTrusted(chain, authType) {},
      checkServerTrusted(chain, authType) {},
      getAcceptedIssuers() { return []; }
    }
  });
  // ... wire it into SSLContext.init
});
```

**Expected**: On a device with `DeviceIntegrity` warning enabled,
a visible warning banner appears on app start. Network traffic may
still succeed (we don't prevent, we detect), but the user has been
informed.

### T4: Dart VM inspector attach

Release builds must NOT allow attaching `dart --observe`. Verify
by launching the app and running:

```bash
adb shell "su -c 'netstat -an'" | grep 800
```

**Expected**: No observer port listening. In debug builds, Dart VM
service listens on a dynamic port; in release mode it must be
fully disabled.

## Reporting findings

Runtime-tamper findings go into the security issue tracker under
the **runtime-attack** label. Include:

1. The Frida script that triggered the finding (paste as a code
   block in the issue).
2. Device model, Android version, and whether Magisk/KernelSU was
   in use.
3. Whether the attack succeeded silently or the app's
   `DeviceIntegrity` warning banner fired.

## Related code

- `lib/security/presentation/utils/device_integrity.dart` —
  root/Frida detection helper.
- `lib/core/network/certificate_pinner.dart` — Dio pinning.
- `lib/security/presentation/utils/secure_screen.dart` —
  FLAG_SECURE + iOS blur overlay.
- `android/app/src/main/AndroidManifest.xml` — debuggable flag
  must be `false` in release, enforced by Gradle manifest merge.

## References

- [OWASP MASVS V8: Resilience](https://mas.owasp.org/MASVS/08-MASVS-RESILIENCE/)
- [Frida Handbook — Android Instrumentation](https://learnfrida.info/)
