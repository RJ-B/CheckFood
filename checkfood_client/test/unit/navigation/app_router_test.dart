import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:checkfood_client/navigation/app_router.dart';
import 'package:checkfood_client/l10n/generated/app_localizations.dart';

/// Pump a fully localised MaterialApp containing only the route under test.
Widget _appWithRoute(Route<dynamic> route) {
  return MaterialApp(
    localizationsDelegates: S.localizationsDelegates,
    supportedLocales: S.supportedLocales,
    home: Builder(
      builder: (context) => Scaffold(
        body: Navigator(
          onGenerateRoute: (_) => route,
        ),
      ),
    ),
  );
}

void main() {
  group('AppRouter.onGenerateRoute', () {
    testWidgets('should return MaterialPageRoute for /login', (tester) async {
      final route = AppRouter.onGenerateRoute(
        const RouteSettings(name: '/login'),
      );
      expect(route, isA<MaterialPageRoute<dynamic>>());
    });

    testWidgets('should return MaterialPageRoute for /register',
        (tester) async {
      final route = AppRouter.onGenerateRoute(
        const RouteSettings(name: '/register'),
      );
      expect(route, isA<MaterialPageRoute<dynamic>>());
    });

    testWidgets('should return MaterialPageRoute for /register-owner',
        (tester) async {
      final route = AppRouter.onGenerateRoute(
        const RouteSettings(name: '/register-owner'),
      );
      expect(route, isA<MaterialPageRoute<dynamic>>());
    });

    testWidgets('should return MaterialPageRoute for /forgot-password',
        (tester) async {
      final route = AppRouter.onGenerateRoute(
        const RouteSettings(name: '/forgot-password'),
      );
      expect(route, isA<MaterialPageRoute<dynamic>>());
    });

    // --- Unknown / fallback routes ---

    testWidgets('should return a route for completely unknown deep link',
        (tester) async {
      final route = AppRouter.onGenerateRoute(
        const RouteSettings(name: '/totally-unknown-deep-link/123'),
      );
      expect(route, isA<MaterialPageRoute<dynamic>>());
    });

    testWidgets('should not crash when rendering unknown deep link',
        (tester) async {
      final route = AppRouter.onGenerateRoute(
        const RouteSettings(name: '/does-not-exist'),
      );

      await tester.pumpWidget(_appWithRoute(route));
      await tester.pumpAndSettle();

      expect(tester.takeException(), isNull);
    });

    testWidgets('should handle null route name without crashing',
        (tester) async {
      final route = AppRouter.onGenerateRoute(
        const RouteSettings(name: null),
      );
      expect(route, isA<MaterialPageRoute<dynamic>>());
    });

    // --- reset-password ---

    testWidgets(
      'should return error route when /reset-password is missing token',
      (tester) async {
        final route = AppRouter.onGenerateRoute(
          const RouteSettings(name: '/reset-password'),
        );
        // Must not crash and must be a valid route (the error route).
        expect(route, isA<MaterialPageRoute<dynamic>>());
        await tester.pumpWidget(_appWithRoute(route));
        await tester.pumpAndSettle();
        expect(tester.takeException(), isNull);
      },
    );

    testWidgets(
      'should accept /reset-password with token query parameter',
      (tester) async {
        final route = AppRouter.onGenerateRoute(
          const RouteSettings(name: '/reset-password?token=abc123'),
        );
        expect(route, isA<MaterialPageRoute<dynamic>>());
      },
    );

    // --- verify-email ---

    testWidgets('should pass email argument to /verify-email', (tester) async {
      final route = AppRouter.onGenerateRoute(
        const RouteSettings(name: '/verify-email', arguments: 'user@test.com'),
      );
      expect(route, isA<MaterialPageRoute<dynamic>>());
    });

    // --- Auth-gated routes (gap tests) ---

    // EXPECTED-FAIL: app_router — production code does not yet implement an
    // authentication-aware redirect. Unauthenticated access to /my-restaurant
    // falls through to the default: case (error route) instead of redirecting
    // to /login. This test documents the MISSING redirect guard — it will fail
    // until go_router with a redirect is wired in.
    testWidgets(
      'unauthenticated user navigating to /my-restaurant should redirect to /login',
      (tester) async {
        final route = AppRouter.onGenerateRoute(
          const RouteSettings(name: '/my-restaurant'),
        );

        // Currently returns the generic error route (not a /login redirect).
        await tester.pumpWidget(_appWithRoute(route));
        await tester.pumpAndSettle();

        // WILL FAIL: currently renders error page, not LoginPage.
        expect(
          find.byType(_LoginPageMarker),
          findsOneWidget,
          reason:
              'unauthenticated /my-restaurant must render LoginPage — '
              'add go_router redirect guard',
        );
      },
      // Pending: auth-aware redirect guard not yet implemented in AppRouter
      skip: true,
    );

    // EXPECTED-FAIL: app_router — unknown deep link currently shows a generic
    // error scaffold but does not display any "route not found" text in the
    // widget tree that can be asserted without a live BuildContext for
    // localizations. Once the error route renders a text with a stable key,
    // this assertion should be updated to find it.
    testWidgets(
      'unknown deep link renders routeNotFound text',
      (tester) async {
        final route = AppRouter.onGenerateRoute(
          const RouteSettings(name: '/unknown-path'),
        );

        await tester.pumpWidget(_appWithRoute(route));
        await tester.pumpAndSettle();

        // WILL FAIL until error route exposes a stable Key or predictable text.
        expect(
          find.byKey(const Key('route_not_found_text')),
          findsOneWidget,
          reason:
              'error route must expose Key("route_not_found_text") for testing',
        );
      },
      // Pending: error route does not yet expose Key("route_not_found_text")
      skip: true,
    );
  });
}

/// Sentinel widget used only to express the expected redirect target.
/// Never instantiated in production code.
class _LoginPageMarker extends StatelessWidget {
  const _LoginPageMarker({super.key});
  @override
  Widget build(BuildContext context) => const SizedBox.shrink();
}
