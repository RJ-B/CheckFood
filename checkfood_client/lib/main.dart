// TODO(T-0004): Aktivovat až bude google-services.json z Firebase Console
// import 'package:firebase_core/firebase_core.dart';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'app.dart';
import 'core/di/injection_container.dart' as di;
import 'core/locale/locale_cubit.dart';

// Importy BLoCů a Eventů
import 'security/presentation/bloc/auth/auth_bloc.dart';
import 'security/presentation/bloc/auth/auth_event.dart';
import 'security/presentation/bloc/user/user_bloc.dart';

/// Zkusí připojení na lokální backend. Vrací true pokud odpovídá.
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
/// Zajišťuje sekvenční inicializaci asynchronních služeb a konfigurace.
void main() async {
  try {
    // 1. Zajištění inicializace vazeb Flutteru
    WidgetsFlutterBinding.ensureInitialized();

    // TODO(T-0004): Aktivovat až bude google-services.json z Firebase Console
    // await Firebase.initializeApp();

    // 2. Auto-detekce prostředí: zkusí lokální backend, jinak Render server
    const forceEnv = String.fromEnvironment('ENV');
    String envFile;
    if (forceEnv == 'prod') {
      envFile = '.env.prod';
    } else if (forceEnv == 'local') {
      envFile = '.env.local';
    } else {
      // Auto-detekce: ping lokální backend
      final localReachable = await _isLocalBackendReachable();
      envFile = localReachable ? '.env.local' : '.env.prod';
      debugPrint('ENV auto-detect: ${localReachable ? "LOCAL" : "PROD (Render)"}');
    }
    await dotenv.load(fileName: envFile);

    // 3. Spuštění Dependency Injection (Service Locator)
    await di.init();

    // 4. Spuštění aplikace
    runApp(const AppBootstrapper());
  } catch (e, stackTrace) {
    debugPrint('FATAL_ERROR_STARTUP: $e');
    debugPrint('STACK_TRACE: $stackTrace');
  }
}

/// Wrapper widget pro inicializaci globálních BLoC providerů.
/// Odděluje logiku vkládání závislostí od samotné definice aplikace.
class AppBootstrapper extends StatelessWidget {
  const AppBootstrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        // LocaleCubit: Spravuje aktuální jazyk aplikace.
        BlocProvider<LocaleCubit>(create: (context) => LocaleCubit()),

        // AuthBloc: Zpracovává persistence tokenů a globální stav přihlášení.
        BlocProvider<AuthBloc>(
          create:
              (context) => di.sl<AuthBloc>()..add(const AuthEvent.appStarted()),
        ),

        // UserBloc: Spravuje data aktuálně přihlášeného uživatele.
        BlocProvider<UserBloc>(create: (context) => di.sl<UserBloc>()),
      ],
      child: const CheckFoodApp(),
    );
  }
}
