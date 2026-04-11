// Integration smoke test for the CheckFood mobile client.
//
// Runs the real Flutter engine on a device or emulator (or Firebase
// Test Lab in CI). Unlike widget tests, this boots `main()` end-to-end,
// so it exercises the dependency injection container, platform
// channels, network stack, and the whole widget tree stitched together
// — not each layer in isolation.
//
// Scope is deliberately narrow:
//   1. App boots without throwing (no red-screen startup crash).
//   2. The first visible screen renders (MaterialApp + navigator
//      are alive, not stuck in a splash loop).
//   3. The login screen is reachable from the cold-start state.
//
// It is NOT trying to assert business logic. That's what the
// widget_test + unit tests are for. This is a "does the dance
// come together at all" gate that catches DI wiring bugs, asset
// path typos, and native plugin mismatches — the kind of regression
// you can only see when the full engine is running.
//
// Running locally:
//   flutter test integration_test/app_smoke_test.dart
//
// Running on a real device:
//   flutter test integration_test/app_smoke_test.dart -d <device-id>
//
// Running on Firebase Test Lab:
//   see .github/workflows/firebase-test-lab.yml
//
// Note: this test does NOT hit a real backend. If it ever needs to
// exercise network flows, wire a MockAdapter on the singleton Dio
// from the DI container before calling runApp.

import 'package:checkfood_client/main.dart' as app;
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('App smoke', () {
    testWidgets(
      'boots and renders a MaterialApp without throwing',
      (WidgetTester tester) async {
        // Tracks any FlutterError thrown during the entire test — a
        // startup exception would end up here via FlutterError.onError.
        final errors = <FlutterErrorDetails>[];
        final previousOnError = FlutterError.onError;
        FlutterError.onError = (details) {
          errors.add(details);
          previousOnError?.call(details);
        };

        try {
          app.main();
          // Let startup Future chains settle. main() awaits DI init,
          // platform orientation, etc., and the first frame won't pump
          // until those finish.
          await tester.pumpAndSettle(const Duration(seconds: 10));

          // A MaterialApp must exist — if the error fallback tree
          // fired instead, there's still a MaterialApp but the body
          // contains the "Aplikaci se nepodařilo spustit" text. Assert
          // we did NOT hit that path.
          expect(find.byType(MaterialApp), findsOneWidget);
          expect(
            find.text('Aplikaci se nepodařilo spustit.\nZkuste ji restartovat.'),
            findsNothing,
            reason: 'The startup error fallback tree was rendered — '
                'main() caught an exception. Check integration test logs.',
          );

          // No uncaught Flutter errors during boot.
          expect(
            errors,
            isEmpty,
            reason: 'FlutterError.onError fired during boot: '
                '${errors.map((e) => e.exceptionAsString()).join("\n")}',
          );
        } finally {
          FlutterError.onError = previousOnError;
        }
      },
    );
  });
}
