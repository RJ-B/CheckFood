import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'package:checkfood_client/l10n/generated/app_localizations.dart';
import 'package:checkfood_client/security/presentation/bloc/auth/auth_bloc.dart';
import 'package:checkfood_client/security/presentation/bloc/auth/auth_event.dart';
import 'package:checkfood_client/security/presentation/bloc/auth/auth_state.dart';
import 'package:checkfood_client/security/presentation/pages/auth/forgot_password_page.dart';
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
        home: const ForgotPasswordPage(),
      ),
    ),
  );
  await tester.pumpAndSettle();
}

void main() {
  late _FakeAuthBloc bloc;

  setUp(() => bloc = _FakeAuthBloc());
  tearDown(() async => bloc.close());

  group('ForgotPasswordPage — form view', () {
    testWidgets('should render email TextFormField', (tester) async {
      await _pump(tester, bloc);
      expect(find.byType(TextFormField), findsOneWidget);
    });

    testWidgets('should render submit ElevatedButton', (tester) async {
      await _pump(tester, bloc);
      expect(find.byType(ElevatedButton), findsOneWidget);
    });

    testWidgets('should not dispatch when email is empty', (tester) async {
      await _pump(tester, bloc);
      await tester.tap(find.byType(ElevatedButton));
      await tester.pumpAndSettle();
      expect(
        bloc.addedEvents.whereType<ForgotPasswordRequested>(),
        isEmpty,
      );
    });

    testWidgets('should dispatch ForgotPasswordRequested with valid email', (tester) async {
      await _pump(tester, bloc);
      await tester.enterText(find.byType(TextFormField), 'user@example.com');
      await tester.tap(find.byType(ElevatedButton));
      await tester.pumpAndSettle();
      expect(
        bloc.addedEvents.whereType<ForgotPasswordRequested>(),
        isNotEmpty,
      );
    });
  });

  group('ForgotPasswordPage — loading state', () {
    testWidgets('shows spinner when loading', (tester) async {
      await _pump(tester, bloc);
      bloc.emit(const AuthState.loading());
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 50));
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('hides form when loading', (tester) async {
      await _pump(tester, bloc);
      bloc.emit(const AuthState.loading());
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 50));
      expect(find.byType(TextFormField), findsNothing);
    });
  });

  group('ForgotPasswordPage — success state', () {
    testWidgets('shows success view with sent email when passwordResetEmailSent', (tester) async {
      await _pump(tester, bloc);
      bloc.emit(const AuthState.passwordResetEmailSent('user@example.com'));
      await tester.pumpAndSettle();
      // Success icon and email text are shown
      expect(find.byIcon(Icons.mark_email_read_outlined), findsOneWidget);
      expect(find.textContaining('user@example.com'), findsAtLeastNWidgets(1));
    });

    testWidgets('back to login button present in success view', (tester) async {
      await _pump(tester, bloc);
      bloc.emit(const AuthState.passwordResetEmailSent('user@example.com'));
      await tester.pumpAndSettle();
      expect(find.byType(OutlinedButton), findsOneWidget);
    });
  });

  group('ForgotPasswordPage — error state', () {
    testWidgets('shows error SnackBar on failure', (tester) async {
      await _pump(tester, bloc);
      bloc.emit(const AuthState.failure(AuthFailure(message: 'error_forgot_password')));
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 50));
      expect(find.byType(SnackBar), findsAtLeastNWidgets(1));
    });
  });

  group('ForgotPasswordPage — multi-size', () {
    testWidgets('phone 390x844', (tester) async {
      await _pump(tester, bloc, size: const Size(390, 844));
      expect(tester.takeException(), isNull);
    });

    testWidgets('small phone 360x640', (tester) async {
      await _pump(tester, bloc, size: const Size(360, 640));
      expect(tester.takeException(), isNull);
    });

    testWidgets('tablet 820x1180', (tester) async {
      await _pump(tester, bloc, size: const Size(820, 1180));
      expect(tester.takeException(), isNull);
    });
  });

  group('ForgotPasswordPage — locale', () {
    testWidgets('renders in cs', (tester) async {
      await _pump(tester, bloc, locale: 'cs');
      expect(find.byType(ForgotPasswordPage), findsOneWidget);
    });

    testWidgets('renders in en', (tester) async {
      await _pump(tester, bloc, locale: 'en');
      expect(find.byType(ForgotPasswordPage), findsOneWidget);
    });
  });

  group('ForgotPasswordPage — theme', () {
    testWidgets('dark theme — no crash', (tester) async {
      await _pump(tester, bloc, themeMode: ThemeMode.dark);
      expect(tester.takeException(), isNull);
    });
  });
}
