import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../l10n/generated/app_localizations.dart';
import '../../../../navigation/app_router.dart';
import '../../bloc/auth/auth_bloc.dart';
import '../../bloc/auth/auth_state.dart';
import '../../widgets/auth/register_form.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Použití Theme pro konzistentní barvy
    final theme = Theme.of(context);

    final l = S.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(l.registerTitle),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: theme.colorScheme.onSurface,
      ),
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          state.maybeWhen(
            registerSuccess: () {
              FocusScope.of(context).unfocus();

              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(l.registerSuccess),
                  backgroundColor: Colors.green.shade600,
                  behavior: SnackBarBehavior.floating,
                ),
              );
              Navigator.of(context).pushReplacementNamed(AppRouter.verifyEmail);
            },
            // 2. CHYBA -> Zobrazení hlášky
            failure: (error) {
              FocusScope.of(
                context,
              ).unfocus(); // Skrýt klávesnici pro lepší viditelnost chyby

              ScaffoldMessenger.of(context).removeCurrentSnackBar();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  // Zde se zobrazí lokalizovaná hláška, pokud ji backend/mapper připravil
                  content: Text(error.message),
                  backgroundColor: theme.colorScheme.error,
                  behavior: SnackBarBehavior.floating,
                ),
              );
            },
            orElse: () {},
          );
        },
        // Použijeme Stack pro zobrazení Loading Overlay přes celou obrazovku
        child: Stack(
          children: [
            // --- Hlavní obsah ---
            SafeArea(
              child: Center(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24.0,
                    vertical: 20.0,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Icon(
                        Icons.person_add_rounded,
                        size: 80,
                        color:
                            theme.colorScheme.primary, // Použití primární barvy
                      ),
                      const SizedBox(height: 24),
                      Text(
                        l.createAccount,
                        textAlign: TextAlign.center,
                        style: theme.textTheme.headlineMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: theme.colorScheme.onSurface,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        l.registerSubtitle,
                        textAlign: TextAlign.center,
                        style: theme.textTheme.bodyLarge?.copyWith(
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                      ),
                      const SizedBox(height: 40),

                      // --- Formulář ---
                      const RegisterForm(),

                      const SizedBox(height: 24),

                      // --- Patička (Login link) ---
                      // Obalíme do BlocBuilderu, abychom tento odkaz deaktivovali při načítání
                      BlocBuilder<AuthBloc, AuthState>(
                        builder: (context, state) {
                          final isLoading = state.maybeWhen(
                            loading: () => true,
                            orElse: () => false,
                          );

                          return Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                l.alreadyHaveAccount,
                                style: TextStyle(
                                  color: theme.colorScheme.onSurfaceVariant,
                                ),
                              ),
                              TextButton(
                                onPressed:
                                    isLoading
                                        ? null
                                        : () {
                                          if (Navigator.of(context).canPop()) {
                                            Navigator.of(context).pop();
                                          } else {
                                            Navigator.of(
                                              context,
                                            ).pushReplacementNamed(
                                              AppRouter.login,
                                            );
                                          }
                                        },
                                child: Text(
                                  l.loginAction,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color:
                                        isLoading
                                            ? theme.disabledColor
                                            : theme.colorScheme.primary,
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // --- Loading Overlay ---
            // Překryje celou obrazovku poloprůhlednou vrstvou, když se načítá
            BlocBuilder<AuthBloc, AuthState>(
              builder: (context, state) {
                return state.maybeWhen(
                  loading:
                      () => Container(
                        color: Colors.black.withOpacity(0.3),
                        child: const Center(child: CircularProgressIndicator()),
                      ),
                  orElse: () => const SizedBox.shrink(),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
