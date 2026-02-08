import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'app.dart';
import 'core/di/injection_container.dart' as di;

// Importy BLoCů a Eventů
import 'security/presentation/bloc/auth/auth_bloc.dart';
import 'security/presentation/bloc/auth/auth_event.dart';
import 'security/presentation/bloc/user/user_bloc.dart';

void main() async {
  try {
    // 1. Zajištění inicializace vazeb Flutteru
    WidgetsFlutterBinding.ensureInitialized();

    // 2. Spuštění Dependency Injection (Service Locator)
    await di.init();

    // 3. Spuštění aplikace obalené v MultiBlocProvider
    runApp(
      MultiBlocProvider(
        providers: [
          // AuthBloc: Inicializace a okamžitá kontrola stavu přihlášení
          BlocProvider<AuthBloc>(
            create: (_) => di.sl<AuthBloc>()..add(const AuthEvent.appStarted()),
          ),
          BlocProvider<UserBloc>(create: (_) => di.sl<UserBloc>()),
        ],
        child: const CheckFoodApp(),
      ),
    );
  } catch (e) {
    // Základní ošetření fatální chyby při startu aplikace
    debugPrint('Fatal error during initialization: $e');
  }
}
