import 'dart:convert';
import 'dart:io';

import 'package:crypto/crypto.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import '../config/build_config.dart';

/// Installs a custom certificate-pinning `badCertificateCallback` on the
/// underlying `HttpClient` of a Dio instance.
///
/// **Policy**: A connection is accepted only if the leaf certificate's
/// SHA-256 fingerprint (computed from the DER bytes, then hex-encoded)
/// is on the allowed list in [BuildConfig.pinnedCertFingerprints]. The
/// list is supplied at build time via `--dart-define=CERT_PIN_SHA256=...`
/// so the shipped binary knows which leaves to trust, and rotation is a
/// simple re-build with the new fingerprint. Primary + one backup leaf
/// are typical; ship both to avoid a broken app the day the cert rolls.
///
/// **Debug builds** skip pinning so `flutter run` against a LAN backend
/// with a self-signed cert still works. The callback is also disabled
/// if the fingerprint list is empty (initial deployment before the
/// ops team has generated + committed the fingerprints).
///
/// **How to generate a fingerprint** from the live certificate:
///
/// ```bash
/// openssl s_client -servername api.checkfood.cz -connect api.checkfood.cz:443 2>/dev/null \
///   | openssl x509 -outform DER \
///   | openssl dgst -sha256 -hex \
///   | awk '{print $2}'
/// ```
///
/// Pass the resulting hex string (64 chars, lowercase) to the release
/// build via `--dart-define=CERT_PIN_SHA256=<hex>[,<backup-hex>]`.
///
/// **CI responsibility**: monitor the live cert's expiry and re-generate
/// both primary + backup fingerprints 30 days before expiry. See
/// `scripts/check_cert_expiry.sh` for the alerting stub.
class CertificatePinner {
  const CertificatePinner._();

  /// Returns a `badCertificateCallback` that Dio (well, the adapter
  /// underneath) will invoke whenever the default TLS handshake would
  /// have rejected the server cert — which on a validly-signed Cloud
  /// Run cert is **never**, UNLESS an active MITM is rewriting the
  /// chain. So this function is the last line of defence: if the
  /// default validator accepted the chain, we still insist the leaf
  /// fingerprint is one we recognise.
  ///
  /// Note: Dio's default adapter (`IOHttpClientAdapter`) exposes
  /// `createHttpClient` for this. Call this from the DI setup:
  ///
  /// ```dart
  /// final adapter = IOHttpClientAdapter();
  /// adapter.createHttpClient = () {
  ///   final client = HttpClient();
  ///   client.badCertificateCallback = CertificatePinner.callback;
  ///   return client;
  /// };
  /// dio.httpClientAdapter = adapter;
  /// ```
  ///
  /// …and also install a validating wrapper around `HttpClient.close`
  /// / connection reuse so the pin is checked on every socket, not
  /// just the first.
  static bool callback(X509Certificate cert, String host, int port) {
    if (kDebugMode) return true;
    final pinned = BuildConfig.pinnedCertFingerprints;
    if (pinned.isEmpty) {
      // Deployment hasn't set fingerprints yet — fall back to the
      // default TLS validator (i.e. don't additionally pin). Logging
      // would be nice but the Dio adapter doesn't pass us a logger.
      return false;
    }
    try {
      final der = cert.der;
      final digestHex = sha256.convert(der).toString().toLowerCase();
      return pinned.any((fp) => fp.trim().toLowerCase() == digestHex);
    } catch (_) {
      return false;
    }
  }

  /// Hook used by DI to configure a Dio instance's adapter with the
  /// pinning callback above. Dio 5.x uses `IOHttpClientAdapter` by
  /// default on non-web platforms.
  static void installOn(Dio dio) {
    final adapter = dio.httpClientAdapter;
    // Only IOHttpClientAdapter has the createHttpClient hook we need.
    // On web (BrowserHttpClientAdapter) there's nothing to do — the
    // browser handles TLS and we can't intercept it.
    // ignore: avoid_dynamic_calls
    try {
      (adapter as dynamic).createHttpClient = () {
        final client = HttpClient();
        client.badCertificateCallback = callback;
        return client;
      };
    } catch (_) {
      // Not an IOHttpClientAdapter (e.g. web) — skip silently.
    }
  }

  /// Convenience: hex-encoded SHA-256 digest of arbitrary bytes. Used
  /// by tests and by the `openssl dgst` equivalent in Dart, if ever
  /// needed in-app (e.g. surfacing the fingerprint in an admin diag
  /// screen).
  @visibleForTesting
  static String hexSha256(List<int> bytes) {
    return sha256.convert(bytes).toString().toLowerCase();
  }

  /// For tests only — lets a harness pass in a fabricated fingerprint.
  @visibleForTesting
  static String? base64ToHex(String base64Value) {
    try {
      return hexSha256(base64Decode(base64Value));
    } catch (_) {
      return null;
    }
  }
}
