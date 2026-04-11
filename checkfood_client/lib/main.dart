// TODO(T-0004): Aktivovat až bude google-services.json z Firebase Console
// import 'package:firebase_core/firebase_core.dart';

import 'dart:async';

import 'package:app_links/app_links.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'app.dart';
import 'core/di/injection_container.dart' as di;
import 'core/locale/locale_cubit.dart';
import 'navigation/app_router.dart';

import 'security/domain/usecases/auth/verify_email_usecase.dart';
import 'security/presentation/bloc/auth/auth_bloc.dart';
import 'security/presentation/bloc/auth/auth_event.dart';
import 'security/presentation/bloc/user/user_bloc.dart';

/// Hlavní vstupní bod aplikace.
///
/// Build-time konfigurace je poskytována přes [BuildConfig] (viz
/// `lib/core/config/build_config.dart`), které čte `--dart-define` hodnoty.
/// Runtime `.env` loading byl odstraněn (bezpečnostní audit, Apr 2026) —
/// secrets se už nepřibalí jako Flutter assety.
void main() async {
  // Global Flutter error handler so widget-tree exceptions thrown during
  // AppBootstrapper.build (e.g. di.sl<AuthBloc>() failing) become visible
  // instead of being swallowed by the framework in release mode.
  FlutterError.onError = (FlutterErrorDetails details) {
    debugPrint('FLUTTER ERROR: ${details.exception}\n${details.stack}');
    FlutterError.presentError(details);
  };

  try {
    WidgetsFlutterBinding.ensureInitialized();
    await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

    // TODO(T-0004): Aktivovat až bude google-services.json z Firebase Console
    // await Firebase.initializeApp();

    await di.init();

    runApp(const AppBootstrapper());
  } catch (e, stack) {
    // STARTUP CRASH DIAGNOSTIC: surface the real error on screen so the
    // user can paste it back to a developer. Without this, a crash inside
    // di.init() leaves the user staring at the native iOS splash forever
    // (release builds don't print debugPrint to any reachable console).
    debugPrint('CRITICAL STARTUP ERROR: $e\n$stack');
    final errorText = '$e\n\n${stack.toString()}';
    runApp(MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('CheckFood — startup error'),
          backgroundColor: Colors.red,
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Aplikaci se nepodařilo spustit. Pošli tento výpis vývojářům:',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 12),
                  SelectableText(
                    errorText,
                    style: const TextStyle(
                      fontFamily: 'Courier',
                      fontSize: 11,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    ));
  }
}

/// Kořenový widget zajišťující globální BLoC providery.
///
/// Odděluje inicializaci závislostí od samotné definice aplikace [CheckFoodApp].
///
/// Apr 2026 — bootstrap byl převeden na [StatefulWidget] kvůli iOS Universal
/// Links (bug #2): poslouchá globální stream z `app_links` a po obdržení
/// `https://<api>/api/auth/verify?token=...` zavolá [VerifyEmailUseCase]
/// a naviguje na `/login?status=...`. Cold-start vs warm-start je řešen
/// zvlášť přes [AppLinks.getInitialLink] resp. [AppLinks.uriLinkStream].
class AppBootstrapper extends StatefulWidget {
  const AppBootstrapper({super.key});

  @override
  State<AppBootstrapper> createState() => _AppBootstrapperState();
}

class _AppBootstrapperState extends State<AppBootstrapper> {
  /// Sdílený navigator key — propagujeme ho do [CheckFoodApp] a používáme
  /// k navigaci z mimo widget tree (callback z `AppLinks.uriLinkStream`).
  final GlobalKey<NavigatorState> _navigatorKey = GlobalKey<NavigatorState>();

  late final AppLinks _appLinks;
  StreamSubscription<Uri>? _linkSub;

  @override
  void initState() {
    super.initState();
    _appLinks = AppLinks();
    // Zpracujeme cold-start link (uživatel ťukl na odkaz se zhasnutou
    // appkou) i warm-start (appka už běžela). Použití addPostFrameCallback
    // zaručí, že _navigatorKey je už připojený k MaterialApp v okamžiku
    // navigace — jinak bychom navigovali na null Navigator a tichý fail.
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      try {
        final initial = await _appLinks.getInitialLink();
        if (initial != null) {
          await _handleIncomingUri(initial);
        }
      } catch (e) {
        debugPrint('AppLinks initial link error: $e');
      }
      _linkSub = _appLinks.uriLinkStream.listen(
        _handleIncomingUri,
        onError: (Object e) => debugPrint('AppLinks stream error: $e'),
      );
    });
  }

  @override
  void dispose() {
    _linkSub?.cancel();
    super.dispose();
  }

  /// Rozhoduje co s příchozí URI udělat. Aktuálně podporujeme pouze
  /// verifikaci účtu — ostatní paths jsou bezpečně ignorovány.
  ///
  /// Bezpečnostní poznámky:
  /// - URL se přijme jen pokud path je `/api/auth/verify` (whitelist), aby
  ///   útočník nemohl přes Universal Link spustit libovolný flow.
  /// - Token se nikam nelogguje (může jít o platný token útočníka, který
  ///   se snaží osedlat účet oběti — viz OWASP ASVS V3.5).
  Future<void> _handleIncomingUri(Uri uri) async {
    if (uri.path != '/api/auth/verify' && uri.path != '/api/auth/verify/') {
      return;
    }
    final token = uri.queryParameters['token'];
    if (token == null || token.isEmpty) {
      _navigateToLogin('error');
      return;
    }
    try {
      await di.sl<VerifyEmailUseCase>().call(token);
      _navigateToLogin('success');
    } catch (e) {
      // Nekonkretizujeme — lokalizovaný text se rozliší jen podle status,
      // viz `LoginPage.verificationStatus` whitelist v `app_router.dart`.
      _navigateToLogin('expired');
    }
  }

  void _navigateToLogin(String status) {
    final navigator = _navigatorKey.currentState;
    if (navigator == null) return;
    navigator.pushNamedAndRemoveUntil(
      '${AppRouter.login}?status=$status',
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<LocaleCubit>(create: (context) => LocaleCubit()),
        BlocProvider<AuthBloc>(
          create:
              (context) => di.sl<AuthBloc>()..add(const AuthEvent.appStarted()),
        ),
        BlocProvider<UserBloc>(create: (context) => di.sl<UserBloc>()),
      ],
      child: CheckFoodApp(navigatorKey: _navigatorKey),
    );
  }
}
