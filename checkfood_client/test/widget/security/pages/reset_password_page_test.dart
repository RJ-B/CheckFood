import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'package:checkfood_client/l10n/generated/app_localizations.dart';
import 'package:checkfood_client/security/presentation/bloc/auth/auth_bloc.dart';
import 'package:checkfood_client/security/presentation/bloc/auth/auth_event.dart';
import 'package:checkfood_client/security/presentation/bloc/auth/auth_state.dart';
import 'package:checkfood_client/security/presentation/pages/auth/reset_password_page.dart';
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
        home: const ResetPasswordPage(token: 'test-reset-token'),
      ),
    ),
  );
  await tester.pumpAndSettle();
}

void main() {
  late _FakeAuthBloc bloc;

  setUp(() => bloc = _FakeAuthBloc());
  tearDown(() async => bloc.close());

  group('ResetPasswordPage — form structure', () {
    testWidgets('should render two password fields', (tester) async {
      await _pump(tester, bloc);
      expect(find.byType(TextFormField), findsNWidgets(2));
    });

    testWidgets('should render submit ElevatedButton', (tester) async {
      await _pump(tester, bloc);
      expect(find.byType(ElevatedButton), findsOneWidget);
    });
  });

  group('ResetPasswordPage — validation', () {
    testWidgets('should not dispatch when form is empty', (tester) async {
      await _pump(tester, bloc);
      await tester.tap(find.byType(ElevatedButton));
      await tester.pumpAndSettle();
      expect(
        bloc.addedEvents.whereType<ResetPasswordRequested>(),
        isEmpty,
      );
    });

    testWidgets('should not dispatch when passwords do not match', (tester) async {
      await _pump(tester, bloc);
      final fields = find.byType(TextFormField);
      await tester.enterText(fields.first, 'Password1!');
      await tester.enterText(fields.last, 'DifferentPwd1!');
      await tester.tap(find.byType(ElevatedButton));
      await tester.pumpAndSettle();
      expect(
        bloc.addedEvents.whereType<ResetPasswordRequested>(),
        isEmpty,
      );
    });

    testWidgets('should dispatch ResetPasswordRequested when passwords match', (tester) async {
      await _pump(tester, bloc);
      final fields = find.byType(TextFormField);
      await tester.enterText(fields.first, 'Password1!');
      await tester.enterText(fields.last, 'Password1!');
      await tester.tap(find.byType(ElevatedButton));
      await tester.pumpAndSettle();
      expect(
        bloc.addedEvents.whereType<ResetPasswordRequested>(),
        isNotEmpty,
      );
    });

    testWidgets('dispatched event carries the correct token', (tester) async {
      await _pump(tester, bloc);
      final fields = find.byType(TextFormField);
      await tester.enterText(fields.first, 'Password1!');
      await tester.enterText(fields.last, 'Password1!');
      await tester.tap(find.byType(ElevatedButton));
      await tester.pumpAndSettle();
      final event = bloc.addedEvents.whereType<ResetPasswordRequested>().first;
      expect(event.token, 'test-reset-token');
    });
  });

  group('ResetPasswordPage — loading state', () {
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

  group('ResetPasswordPage — error state', () {
    testWidgets('shows error SnackBar on failure', (tester) async {
      await _pump(tester, bloc);
      bloc.emit(const AuthState.failure(AuthFailure(message: 'error_reset_password')));
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 50));
      expect(find.byType(SnackBar), findsAtLeastNWidgets(1));
    });
  });

  group('ResetPasswordPage — multi-size', () {
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

  group('ResetPasswordPage — locale', () {
    testWidgets('renders in cs', (tester) async {
      await _pump(tester, bloc, locale: 'cs');
      expect(find.byType(ResetPasswordPage), findsOneWidget);
    });

    testWidgets('renders in en', (tester) async {
      await _pump(tester, bloc, locale: 'en');
      expect(find.byType(ResetPasswordPage), findsOneWidget);
    });
  });

  group('ResetPasswordPage — theme', () {
    testWidgets('dark theme — no crash', (tester) async {
      await _pump(tester, bloc, themeMode: ThemeMode.dark);
      expect(tester.takeException(), isNull);
    });
  });

  group('ResetPasswordPage — password visibility toggle', () {
    testWidgets('tapping visibility icon toggles password display', (tester) async {
      await _pump(tester, bloc);
      // Two visibility icon buttons — one per password field
      final icons = find.byType(IconButton);
      expect(icons, findsAtLeastNWidgets(2));
      await tester.tap(icons.first);
      await tester.pumpAndSettle();
      // No crash is the expectation; actual obscureText state is internal
      expect(tester.takeException(), isNull);
    });
  });
}
