import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../navigation/app_router.dart';
import '../../bloc/auth/auth_bloc.dart';
import '../../bloc/auth/auth_state.dart';
import '../../widgets/auth/login_form.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // Lokální stav pro ovládání viditelnosti tlačítka pro znovuzaslání
  bool _showResendButton = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          state.maybeWhen(
            authenticated: (user) {
              // Vyčistíme staré hlášky a jdeme dál
              ScaffoldMessenger.of(context).removeCurrentSnackBar();
              Navigator.of(
                context,
              ).pushNamedAndRemoveUntil(AppRouter.main, (route) => false);
            },
            failure: (message, email) {
              // <-- email nyní přichází ze stavu
              final isNotVerified = message.toLowerCase().contains('aktivní');
              final isExpired = message.toLowerCase().contains('vypršel');

              ScaffoldMessenger.of(context).removeCurrentSnackBar();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(message),
                  backgroundColor:
                      (isNotVerified || isExpired)
                          ? Colors.orange.shade900
                          : Colors.red,
                  behavior: SnackBarBehavior.floating,
                ),
              );

              if (isNotVerified || isExpired) {
                setState(() {
                  _showResendButton = true;
                  _lastAttemptedEmail =
                      email ?? ''; // ✅ Uložíme si email pro pozdější resend
                });
              }
            },
            orElse: () {},
          );
        },
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(
                horizontal: 24.0,
                vertical: 40.0,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // --- Branding ---
                  const Icon(
                    Icons.restaurant_menu_rounded,
                    size: 80,
                    color: Colors.green,
                  ),
                  const SizedBox(height: 24),
                  const Text(
                    'CheckFood',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.w900,
                      color: Colors.black87,
                      letterSpacing: -1,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Přihlaste se ke svému účtu',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16, color: Colors.grey.shade600),
                  ),
                  const SizedBox(height: 48),

                  // --- Autentizační formulář ---
                  const LoginForm(),

                  // ✅ DYNAMICKÉ TLAČÍTKO: Objeví se jen při chybě verifikace
                  if (_showResendButton) ...[
                    const SizedBox(height: 16),
                    OutlinedButton.icon(
                      onPressed: () {
                        // Tlačítko po kliknutí zmizí
                        setState(() {
                          _showResendButton = false;
                        });

                        // Přesuneme uživatele na screen pro verifikaci
                        Navigator.of(context).pushNamed(AppRouter.verifyEmail);
                      },
                      icon: const Icon(Icons.mail_outline),
                      label: const Text('VYŘEŠIT AKTIVACI ÚČTU'),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: Colors.orange.shade900,
                        side: BorderSide(color: Colors.orange.shade900),
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                  ],

                  const SizedBox(height: 32),

                  // --- Vizuální oddělovač ---
                  Row(
                    children: [
                      const Expanded(child: Divider()),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Text(
                          "NEBO",
                          style: TextStyle(
                            color: Colors.grey.shade400,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const Expanded(child: Divider()),
                    ],
                  ),

                  const SizedBox(height: 40),

                  // --- Navigace k registraci ---
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Ještě nemáte účet?",
                        style: TextStyle(color: Colors.grey.shade700),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pushNamed(AppRouter.register);
                        },
                        child: const Text(
                          'Zaregistrujte se',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.green,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
