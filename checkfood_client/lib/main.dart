import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'app.dart';
import 'core/di/injection_container.dart' as di;

// Importy BLoCů a Eventů
import 'security/presentation/bloc/auth/auth_bloc.dart';
import 'security/presentation/bloc/auth/auth_event.dart';
import 'security/presentation/bloc/user/user_bloc.dart';

/// Hlavní vstupní bod aplikace.
/// Zajišťuje sekvenční inicializaci asynchronních služeb a konfigurace.
void main() async {
  try {
    // 1. Zajištění inicializace vazeb Flutteru
    // Nutné pro volání nativních pluginů a asynchronních operací před runApp.
    WidgetsFlutterBinding.ensureInitialized();

    // 1b. Inicializace Firebase (nutne pred DI a FCM)
    await Firebase.initializeApp();

    // 2. Načtení konfigurace z .env souboru
    // Tato operace musí předcházet inicializaci DI, protože DI využívá
    // tyto proměnné pro nastavení BaseOptions u Dio klienta.
    await dotenv.load(fileName: ".env");

    // 3. Spuštění Dependency Injection (Service Locator)
    // Registruje všechnyRepository, UseCases, BLoCs a externí klienty.
    await di.init();

    // 4. Spuštění aplikace
    runApp(const AppBootstrapper());
  } catch (e, stackTrace) {
    // Diagnostické logování fatální chyby při startu aplikace
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
        // AuthBloc: Zpracovává persistence tokenů a globální stav přihlášení.
        // Událost appStarted iniciuje kontrolu uloženého JWT v Secure Storage.
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
