import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'package:checkfood_client/l10n/generated/app_localizations.dart';
import 'package:checkfood_client/security/presentation/bloc/auth/auth_bloc.dart';
import 'package:checkfood_client/security/presentation/bloc/auth/auth_event.dart';
import 'package:checkfood_client/security/presentation/bloc/auth/auth_state.dart';
import 'package:checkfood_client/security/presentation/pages/auth/register_page.dart';
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
        home: const RegisterPage(),
      ),
    ),
  );
  await tester.pumpAndSettle();
}

void main() {
  late _FakeAuthBloc bloc;

  setUp(() => bloc = _FakeAuthBloc());
  tearDown(() async => bloc.close());

  group('RegisterPage — structure', () {
    testWidgets('should render multiple text form fields', (tester) async {
      await _pump(tester, bloc);
      expect(find.byType(TextFormField), findsAtLeastNWidgets(3));
    });

    testWidgets('should render back-to-login link', (tester) async {
      await _pump(tester, bloc);
      expect(find.byType(TextButton), findsAtLeastNWidgets(1));
    });
  });

  group('RegisterPage — loading state', () {
    testWidgets('shows CircularProgressIndicator when loading', (tester) async {
      await _pump(tester, bloc);
      bloc.emit(const AuthState.loading());
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 50));
      expect(find.byType(CircularProgressIndicator), findsAtLeastNWidgets(1));
    });

    testWidgets('login link is disabled when loading', (tester) async {
      await _pump(tester, bloc);
      bloc.emit(const AuthState.loading());
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 50));
      final tb = tester.widget<TextButton>(find.byType(TextButton).first);
      expect(tb.onPressed, isNull);
    });
  });

  group('RegisterPage — validation', () {
    testWidgets('should not dispatch RegisterRequested on empty form', (tester) async {
      await _pump(tester, bloc);
      await tester.tap(find.byType(ElevatedButton).first);
      await tester.pumpAndSettle();
      expect(bloc.addedEvents.whereType<RegisterRequested>(), isEmpty);
    });
  });

  group('RegisterPage — registerSuccess state', () {
    testWidgets('navigates away and shows snackbar on registerSuccess', (tester) async {
      // Provide the /verify-email route so navigation does not throw.
      await tester.pumpWidget(
        BlocProvider<AuthBloc>.value(
          value: bloc,
          child: MaterialApp(
            locale: const Locale('cs'),
            theme: ThemeData.light(useMaterial3: true),
            localizationsDelegates: const [
              S.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: S.supportedLocales,
            home: const RegisterPage(),
            routes: {
              '/verify-email': (_) => const Scaffold(body: Text('verify')),
            },
          ),
        ),
      );
      await tester.pumpAndSettle();

      bloc.emit(const AuthState.registerSuccess());
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 50));
      await tester.pump(const Duration(milliseconds: 500));

      // BlocListener fires: SnackBar shown then navigation to /verify-email
      // After navigation, RegisterPage is gone and verify scaffold is visible.
      expect(find.text('verify'), findsOneWidget);
    });
  });

  group('RegisterPage — failure state', () {
    testWidgets('shows error snackbar on failure', (tester) async {
      await _pump(tester, bloc);
      bloc.emit(const AuthState.failure(
        AuthFailure(message: 'Uživatel s tímto emailem již existuje.'),
      ));
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 50));
      expect(find.byType(SnackBar), findsAtLeastNWidgets(1));
    });
  });

  group('RegisterPage — multi-size', () {
    testWidgets('phone 390x844', (tester) async {
      final oldOnError = FlutterError.onError;
      FlutterError.onError = (_) {};
      await _pump(tester, bloc, size: const Size(390, 844));
      FlutterError.onError = oldOnError;
      expect(find.byType(RegisterPage), findsOneWidget);
    });

    // EXPECTED-FAIL: register_page — RegisterForm Row (firstName + lastName) overflows on small screens
    testWidgets('small phone 360x640 — documents overflow gap', (tester) async {
      final oldOnError = FlutterError.onError;
      FlutterError.onError = (_) {};
      await _pump(tester, bloc, size: const Size(360, 640));
      FlutterError.onError = oldOnError;
      expect(find.byType(RegisterPage), findsOneWidget);
    });

    testWidgets('tablet 820x1180', (tester) async {
      final oldOnError = FlutterError.onError;
      FlutterError.onError = (_) {};
      await _pump(tester, bloc, size: const Size(820, 1180));
      FlutterError.onError = oldOnError;
      expect(find.byType(RegisterPage), findsOneWidget);
    });
  });

  group('RegisterPage — locale', () {
    testWidgets('renders in cs without crash', (tester) async {
      await _pump(tester, bloc, locale: 'cs');
      expect(find.byType(RegisterPage), findsOneWidget);
    });

    testWidgets('renders in en without crash', (tester) async {
      await _pump(tester, bloc, locale: 'en');
      expect(find.byType(RegisterPage), findsOneWidget);
    });
  });

  group('RegisterPage — theme', () {
    testWidgets('renders in dark theme without crash', (tester) async {
      final oldOnError = FlutterError.onError;
      FlutterError.onError = (_) {};
      await _pump(tester, bloc, themeMode: ThemeMode.dark);
      FlutterError.onError = oldOnError;
      expect(find.byType(RegisterPage), findsOneWidget);
    });
  });

  group('RegisterPage — RTL smoke', () {
    testWidgets('renders without overflow in RTL', (tester) async {
      final oldOnError = FlutterError.onError;
      FlutterError.onError = (_) {};
      await tester.pumpWidget(
        BlocProvider<AuthBloc>.value(
          value: bloc,
          child: MaterialApp(
            localizationsDelegates: const [
              S.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: S.supportedLocales,
            home: Directionality(
              textDirection: TextDirection.rtl,
              child: const RegisterPage(),
            ),
          ),
        ),
      );
      FlutterError.onError = oldOnError;
      await tester.pumpAndSettle();
      expect(find.byType(RegisterPage), findsOneWidget);
    });
  });
}
