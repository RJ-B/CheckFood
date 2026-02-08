import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../security/presentation/bloc/auth/auth_bloc.dart';
import '../security/presentation/bloc/auth/auth_state.dart';
import '../features/onboarding/onboarding_screen.dart';
import 'main_shell.dart';

/// Inteligentní rozcestník, který rozhoduje o úvodní obrazovce aplikace.
/// Naslouchá stavu AuthBloc a dynamicky mění widget bez nutnosti manuální navigace.
class RootGuard extends StatelessWidget {
  const RootGuard({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        return state.maybeWhen(
          // Stav: Uživatel je přihlášen (token je platný)
          authenticated: (user) => const MainShell(),

          // Stav: Aplikace právě čte tokeny z paměti nebo ověřuje relaci
          loading:
              () => const Scaffold(
                body: Center(child: CircularProgressIndicator()),
              ),

          // Stav: Uživatel není přihlášen nebo se odhlásil
          unauthenticated: () => const OnboardingScreen(),

          // Výchozí stav (např. initial) - pro jistotu vracíme Onboarding
          orElse: () => const OnboardingScreen(),
        );
      },
    );
  }
}
