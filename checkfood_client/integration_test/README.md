# CheckFood Flutter Integration Tests

End-to-end tests that run the real Flutter engine on a device,
emulator, or Firebase Test Lab. Unlike the widget tests under
`test/widget/`, these boot `main()` and exercise the whole app —
dependency injection, platform channels, assets, native plugins.

## What's here

| File | Purpose |
|------|---------|
| `app_smoke_test.dart` | Cold-start smoke test. Verifies the app boots into `MaterialApp` without hitting the startup-error fallback tree. This is the gate that catches broken DI wiring, asset path typos, and native plugin mismatches that widget tests don't see. |

## Running locally

```bash
# Any connected device (physical or emulator):
flutter test integration_test/

# Specific device:
flutter devices
flutter test integration_test/ -d <device-id>
```

## Running headless in CI

Integration tests do NOT run on the standard `flutter test` Linux
runner — they need a real Flutter engine with a display. The two
practical options:

### Option A: Firebase Test Lab (used by `firebase-test-lab.yml`)

Google runs the tests on real Android devices in their lab and
surfaces results in the GitHub Action log. Requires:

- `GOOGLE_APPLICATION_CREDENTIALS_JSON` secret (service account key
  with Test Lab API permissions)
- `FTL_PROJECT_ID` secret

The workflow builds a debug APK + `app-debug-androidTest.apk`, uploads
both to FTL, and polls until the test run completes.

### Option B: macOS runner with iOS simulator

Slower than FTL, no device matrix, but free for OSS repos. Add a
job to `flutter-android.yml` using `macos-latest` + `xcrun simctl`.

## Notes

- These tests are intentionally narrow. If a test needs backend data,
  stub the Dio singleton before calling `app.main()`; never point
  them at a real API from CI.
- `pumpAndSettle` timeouts are generous (10s) to accommodate the cold
  start path — DI init + native plugin registration can take several
  seconds on a cold emulator, especially on CI with low vCPU counts.
- Do not add business-logic assertions here. Those belong in widget
  or unit tests where they run in <100ms.
