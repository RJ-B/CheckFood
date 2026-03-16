import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/theme/colors.dart';
import '../../../../l10n/generated/app_localizations.dart';
import '../../../../navigation/app_router.dart';
import '../../bloc/auth/auth_bloc.dart';
import '../../bloc/auth/auth_state.dart';
import '../../bloc/auth/auth_event.dart';

class EmailVerificationScreen extends StatelessWidget {
  final String? email;

  const EmailVerificationScreen({super.key, this.email});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: AppColors.textPrimary,
      ),
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          final l = S.of(context);
          state.maybeWhen(
            authenticated: (user) {
              ScaffoldMessenger.of(context).removeCurrentSnackBar();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(l.emailVerified),
                  backgroundColor: AppColors.success,
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

              final String? effectiveEmail = email ?? error.email;

              ScaffoldMessenger.of(context).removeCurrentSnackBar();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(error.message),
                  backgroundColor: AppColors.error,
                  behavior: SnackBarBehavior.floating,
                  duration: const Duration(seconds: 6),
                  action:
                      isExpired && effectiveEmail != null
                          ? SnackBarAction(
                            label: l.resendCode,
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
            final l = S.of(context);
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
                      color: AppColors.primary,
                    ),
                    const SizedBox(height: 32),
                    Text(
                      l.checkEmail,
                      style: const TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      l.verificationEmailSent(email ?? 'email'),
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
                        backgroundColor: AppColors.primary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Text(l.backToLogin),
                    ),
                    const SizedBox(height: 24),
                    Text(
                      l.emailNotReceived,
                      style: const TextStyle(color: AppColors.textSecondary),
                    ),
                    const SizedBox(height: 8),
                    if (isLoading)
                      const CircularProgressIndicator(color: AppColors.primary)
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
                        child: Text(
                          l.resend,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: AppColors.primaryDark,
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
