// TODO(T-0004): Aktivovat až bude google-services.json z Firebase Console
// import 'package:firebase_core/firebase_core.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'app.dart';
import 'core/di/injection_container.dart' as di;
import 'core/locale/locale_cubit.dart';

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
  try {
    WidgetsFlutterBinding.ensureInitialized();
    await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

    // TODO(T-0004): Aktivovat až bude google-services.json z Firebase Console
    // await Firebase.initializeApp();

    await di.init();

    runApp(const AppBootstrapper());
  } catch (e, stack) {
    debugPrint('CRITICAL STARTUP ERROR: $e\n$stack');
    runApp(const MaterialApp(
      home: Scaffold(
        body: Center(
          child: Padding(
            padding: EdgeInsets.all(32),
            child: Text(
              'Aplikaci se nepodařilo spustit.\nZkuste ji restartovat.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16),
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
class AppBootstrapper extends StatelessWidget {
  const AppBootstrapper({super.key});

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
      child: const CheckFoodApp(),
    );
  }
}
