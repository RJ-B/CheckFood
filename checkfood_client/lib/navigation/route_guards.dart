import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../features/onboarding/onboarding_screen.dart';
import '../features/splash/splash_screen.dart';
import '../../security/presentation/bloc/auth/auth_bloc.dart';
import '../../security/presentation/bloc/auth/auth_state.dart';
import '../../security/domain/enums/user_role.dart';
import '../modules/owner/presentation/pages/claim_restaurant_page.dart';
import '../modules/owner/onboarding/presentation/pages/onboarding_wizard_page.dart';
import 'main_shell.dart';

/// Guard kořenové route — kontroluje stav [AuthBloc] a přesměrovává na
/// příslušnou obrazovku (onboarding, claim flow, wizard nebo hlavní shell).
class RootGuard extends StatelessWidget {
  const RootGuard({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        return state.maybeWhen(
          authenticated: (user) {
            if (user.role == UserRole.owner && user.needsRestaurantClaim) {
              return const ClaimRestaurantPage();
            }
            if (user.role == UserRole.owner && user.needsOnboarding) {
              return const OnboardingWizardPage();
            }
            return const MainShell();
          },
          loading: () => const SplashScreen(),
          initial: () => const SplashScreen(),
          unauthenticated: () => const OnboardingScreen(),
          orElse: () => const OnboardingScreen(),
        );
      },
    );
  }
}
