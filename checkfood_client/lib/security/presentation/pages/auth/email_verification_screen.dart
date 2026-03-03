import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../navigation/app_router.dart';
import '../../bloc/auth/auth_bloc.dart';
import '../../bloc/auth/auth_state.dart';
import '../../bloc/auth/auth_event.dart';

// ... importy zůstávají stejné

class EmailVerificationScreen extends StatelessWidget {
  final String? email;

  const EmailVerificationScreen({super.key, this.email});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Colors.black87,
      ),
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          state.maybeWhen(
            authenticated: (user) {
              ScaffoldMessenger.of(context).removeCurrentSnackBar();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('E-mail byl úspěšně ověřen!'),
                  backgroundColor: Colors.green,
                  behavior: SnackBarBehavior.floating,
                ),
              );
              Navigator.of(
                context,
              ).pushNamedAndRemoveUntil(AppRouter.main, (route) => false);
            },
            failure: (error) {
              final isExpired =
                  error.isExpired ||
                  error.message.toLowerCase().contains('vypršel');

              // ✅ Bezpečné získání e-mailu pro resend
              final String? effectiveEmail = email ?? error.email;

              ScaffoldMessenger.of(context).removeCurrentSnackBar();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(error.message),
                  backgroundColor: Colors.red,
                  behavior: SnackBarBehavior.floating,
                  duration: const Duration(seconds: 6),
                  action:
                      isExpired && effectiveEmail != null
                          ? SnackBarAction(
                            label: 'ZNOVU ODESLAT',
                            textColor: Colors.white,
                            onPressed: () {
                              context.read<AuthBloc>().add(
                                AuthEvent.resendCodeRequested(email: effectiveEmail),
                              );
                            },
                          )
                          : null,
                ),
              );
            },
            orElse: () {},
          );
        },
        child: BlocBuilder<AuthBloc, AuthState>(
          builder: (context, state) {
            // ✅ Přidán indikátor načítání, pokud se právě odesílá nová žádost
            final isLoading = state.maybeWhen(
              loading: () => true,
              orElse: () => false,
            );

            return SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.mark_email_read_rounded,
                      size: 100,
                      color: Colors.green,
                    ),
                    const SizedBox(height: 32),
                    const Text(
                      "Zkontrolujte si e-mail",
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      "Na adresu ${email ?? 'vaši e-mailovou adresu'} jsme odeslali potvrzovací odkaz.",
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.black54,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 48),
                    FilledButton(
                      onPressed:
                          isLoading
                              ? null
                              : () {
                                Navigator.of(context).pushNamedAndRemoveUntil(
                                  AppRouter.login,
                                  (route) => false,
                                );
                              },
                      style: FilledButton.styleFrom(
                        minimumSize: const Size.fromHeight(50),
                        backgroundColor: Colors.green,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text("Zpět na přihlášení"),
                    ),
                    const SizedBox(height: 24),
                    Text(
                      "Nedostal jste e-mail nebo odkaz vypršel?",
                      style: TextStyle(color: Colors.grey.shade600),
                    ),
                    const SizedBox(height: 8),
                    if (isLoading)
                      const CircularProgressIndicator(color: Colors.green)
                    else
                      TextButton(
                        onPressed:
                            email != null
                                ? () {
                                  context.read<AuthBloc>().add(
                                    AuthEvent.resendCodeRequested(email: email!),
                                  );
                                }
                                : null,
                        child: const Text(
                          "Odeslat znovu",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.green,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
