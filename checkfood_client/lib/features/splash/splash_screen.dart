import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart'; // ✅ Nutné pro kontrolu onboardingu

// Theme importy
import '../../core/theme/colors.dart';
import '../../core/theme/spacing.dart';
import '../../core/theme/typography.dart';

// Importy obrazovek
import '../../navigation/main_shell.dart';
import '../../security/presentation/bloc/auth/auth_bloc.dart';
import '../../security/presentation/bloc/auth/auth_state.dart';
import '../onboarding/onboarding_screen.dart';
import '../../security/presentation/pages/auth/login_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool showText = false;

  @override
  void initState() {
    super.initState();
    // Spustíme animaci textu s malým zpožděním
    _startAnimation();
  }

  void _startAnimation() {
    Future.delayed(const Duration(milliseconds: 300), () {
      if (mounted) {
        setState(() => showText = true);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // ✅ BlocListener poslouchá změny stavu přihlášení
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) async {
        // Necháme logo chvíli svítit (UX), aby jen neprobliklo
        await Future.delayed(const Duration(milliseconds: 1500));

        if (!mounted) return;

        // Rozhodovací logika kam dál
        await state.maybeMap(
          authenticated: (_) async {
            // 🎉 Uživatel je přihlášen (má platný token) -> Jdeme na DOMOVSKOU OBRAZOVKU
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (_) => const MainShell()),
            );
          },
          unauthenticated: (_) async {
            // 🔒 Uživatel není přihlášen -> Zjistíme, jestli už viděl onboarding
            final prefs = await SharedPreferences.getInstance();
            final bool seenOnboarding =
                prefs.getBool('onboarding_seen') ?? false;

            if (!mounted) return;

            if (seenOnboarding) {
              // Už to viděl -> Jdeme na LOGIN
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (_) => const LoginPage()),
              );
            } else {
              // Je tu poprvé -> Jdeme na ONBOARDING
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (_) => const OnboardingScreen()),
              );
            }
          },
          orElse: () {
            // Čekáme na inicializaci AuthBlocu...
          },
        );
      },
      child: Scaffold(
        backgroundColor: AppColors.primary,
        body: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Animované Logo
                AnimatedScale(
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.easeOutBack,
                  scale: 1,
                  child: const Icon(
                    Icons.restaurant,
                    size: 120,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: AppSpacing.lg),

                // Animovaný Text
                AnimatedOpacity(
                  opacity: showText ? 1 : 0,
                  duration: const Duration(milliseconds: 500),
                  child: Text(
                    'CheckFood',
                    style: AppTypography.display.copyWith(color: Colors.white),
                  ),
                ),

                const SizedBox(height: 40),

                // Indikátor načítání (zobrazíme ho, pokud to trvá déle)
                BlocBuilder<AuthBloc, AuthState>(
                  builder: (context, state) {
                    // Pokud je stav 'initial' nebo 'loading', ukážeme točící kolečko
                    return state.maybeWhen(
                      initial:
                          () => const SizedBox(
                            height: 24,
                            width: 24,
                            child: CircularProgressIndicator(
                              color: Colors.white,
                              strokeWidth: 2,
                            ),
                          ),
                      loading:
                          () => const SizedBox(
                            height: 24,
                            width: 24,
                            child: CircularProgressIndicator(
                              color: Colors.white,
                              strokeWidth: 2,
                            ),
                          ),
                      orElse: () => const SizedBox.shrink(),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
