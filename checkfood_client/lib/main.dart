// TODO(T-0004): Aktivovat až bude google-services.json z Firebase Console
// import 'package:firebase_core/firebase_core.dart';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'app.dart';
import 'core/di/injection_container.dart' as di;
import 'core/locale/locale_cubit.dart';

import 'security/presentation/bloc/auth/auth_bloc.dart';
import 'security/presentation/bloc/auth/auth_event.dart';
import 'security/presentation/bloc/user/user_bloc.dart';

/// Pokusí se o HTTP ping na lokální backend.
///
/// Vrací `true`, pokud server odpoví se stavovým kódem nižším než 500.
Future<bool> _isLocalBackendReachable() async {
  try {
    final client = HttpClient()
      ..connectionTimeout = const Duration(seconds: 2);
    final request = await client.getUrl(
      Uri.parse('http://192.168.1.199:8081/actuator/health'),
    );
    final response = await request.close();
    client.close();
    return response.statusCode < 500;
  } catch (_) {
    return false;
  }
}

/// Hlavní vstupní bod aplikace.
///
/// Zajišťuje sekvenční inicializaci: Flutter bindings, výběr .env souboru,
/// dependency injection a spuštění widget stromu.
void main() async {
  try {
    WidgetsFlutterBinding.ensureInitialized();

    // TODO(T-0004): Aktivovat až bude google-services.json z Firebase Console
    // await Firebase.initializeApp();

    const forceEnv = String.fromEnvironment('ENV');
    String envFile;
    if (forceEnv == 'prod') {
      envFile = '.env.prod';
    } else if (forceEnv == 'local') {
      envFile = '.env.local';
    } else {
      final localReachable = await _isLocalBackendReachable();
      envFile = localReachable ? '.env.local' : '.env.prod';
    }
    await dotenv.load(fileName: envFile);

    await di.init();

    runApp(const AppBootstrapper());
  } catch (e) {
    // Kritická chyba při startu — aplikaci nelze spustit.
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
