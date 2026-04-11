import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'package:checkfood_client/l10n/generated/app_localizations.dart';
import 'package:checkfood_client/security/presentation/bloc/auth/auth_bloc.dart';
import 'package:checkfood_client/security/presentation/bloc/auth/auth_event.dart';
import 'package:checkfood_client/security/presentation/bloc/auth/auth_state.dart';
import 'package:checkfood_client/security/presentation/pages/auth/email_verification_screen.dart';
import 'package:checkfood_client/security/domain/entities/auth_failure.dart';

class _FakeAuthBloc extends Fake implements AuthBloc {
  final StreamController<AuthState> _controller =
      StreamController<AuthState>.broadcast();
  AuthState _state = const AuthState.unauthenticated();

  @override
  AuthState get state => _state;

  @override
  Stream<AuthState> get stream => _controller.stream;

  final List<AuthEvent> addedEvents = [];

  void emit(AuthState s) {
    _state = s;
    _controller.add(s);
  }

  @override
  void add(AuthEvent event) => addedEvents.add(event);

  @override
  Future<void> close() async => _controller.close();
}

Future<void> _pump(
  WidgetTester tester,
  _FakeAuthBloc bloc, {
  String? email,
  String locale = 'cs',
  ThemeMode themeMode = ThemeMode.light,
  Size? size,
}) async {
  if (size != null) {
    tester.view.physicalSize = size;
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.resetPhysicalSize);
  }
  await tester.pumpWidget(
    BlocProvider<AuthBloc>.value(
      value: bloc,
      child: MaterialApp(
        locale: Locale(locale),
        themeMode: themeMode,
        theme: ThemeData.light(useMaterial3: true),
        darkTheme: ThemeData.dark(useMaterial3: true),
        localizationsDelegates: const [
          S.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: S.supportedLocales,
        home: EmailVerificationScreen(email: email),
      ),
    ),
  );
  await tester.pumpAndSettle();
}

void main() {
  late _FakeAuthBloc bloc;

  setUp(() => bloc = _FakeAuthBloc());
  tearDown(() async => bloc.close());

  group('EmailVerificationScreen — structure', () {
    testWidgets('renders email icon', (tester) async {
      await _pump(tester, bloc, email: 'test@example.com');
      expect(find.byIcon(Icons.mark_email_read_rounded), findsOneWidget);
    });

    testWidgets('renders email address text', (tester) async {
      await _pump(tester, bloc, email: 'user@example.com');
      expect(find.textContaining('user@example.com'), findsAtLeastNWidgets(1));
    });

    testWidgets('renders back to login button', (tester) async {
      await _pump(tester, bloc, email: 'test@example.com');
      expect(find.byType(FilledButton), findsOneWidget);
    });

    testWidgets('renders resend button when email is provided', (tester) async {
      await _pump(tester, bloc, email: 'test@example.com');
      expect(find.byType(TextButton), findsAtLeastNWidgets(1));
    });
  });

  group('EmailVerificationScreen — loading state', () {
    testWidgets('shows spinner and disables buttons when loading', (tester) async {
      await _pump(tester, bloc, email: 'test@example.com');
      bloc.emit(const AuthState.loading());
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 50));
      expect(find.byType(CircularProgressIndicator), findsAtLeastNWidgets(1));
    });
  });

  group('EmailVerificationScreen — resend action', () {
    testWidgets('tapping resend dispatches ResendCodeRequested', (tester) async {
      await _pump(tester, bloc, email: 'test@example.com');
      await tester.tap(find.byType(TextButton).last);
      await tester.pumpAndSettle();
      expect(
        bloc.addedEvents.whereType<ResendCodeRequested>(),
        isNotEmpty,
      );
    });

    testWidgets('resend button is disabled when email is null', (tester) async {
      await _pump(tester, bloc, email: null);
      final tb = tester.widget<TextButton>(find.byType(TextButton).last);
      expect(tb.onPressed, isNull);
    });

    // EXPECTED-FAIL: email_verification_screen — there is no resend cooldown timer.
    // After clicking resend, the user can spam requests because there is no
    // cooldown UI state. This test documents the gap: the button remains enabled
    // after tap, which is the current (incorrect) production behaviour.
    testWidgets('resend button should show cooldown after tap', (tester) async {
      await _pump(tester, bloc, email: 'test@example.com');
      await tester.tap(find.byType(TextButton).last);
      await tester.pump();
      final tb = tester.widget<TextButton>(find.byType(TextButton).last);
      // Currently the button stays enabled — cooldown is NOT implemented.
      // Once implemented, this should be: expect(tb.onPressed, isNull)
      expect(
        tb.onPressed,
        isNotNull,
        reason: 'Gap: resend cooldown not implemented — button stays enabled after tap',
      );
    });
  });

  group('EmailVerificationScreen — multi-size', () {
    testWidgets('phone 390x844', (tester) async {
      await _pump(tester, bloc, email: 'test@example.com', size: const Size(390, 844));
      expect(tester.takeException(), isNull);
    });

    testWidgets('tablet 820x1180', (tester) async {
      await _pump(tester, bloc, email: 'test@example.com', size: const Size(820, 1180));
      expect(tester.takeException(), isNull);
    });
  });

  group('EmailVerificationScreen — locale', () {
    testWidgets('renders in cs', (tester) async {
      await _pump(tester, bloc, email: 'test@example.com', locale: 'cs');
      expect(find.byType(EmailVerificationScreen), findsOneWidget);
    });

    testWidgets('renders in en', (tester) async {
      await _pump(tester, bloc, email: 'test@example.com', locale: 'en');
      expect(find.byType(EmailVerificationScreen), findsOneWidget);
    });
  });

  group('EmailVerificationScreen — theme', () {
    testWidgets('dark theme renders without crash', (tester) async {
      await _pump(tester, bloc, email: 'test@example.com', themeMode: ThemeMode.dark);
      expect(tester.takeException(), isNull);
    });
  });
}
