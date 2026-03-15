import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../l10n/generated/app_localizations.dart';
import '../../../../navigation/app_router.dart';
import '../../bloc/auth/auth_bloc.dart';
import '../../bloc/auth/auth_event.dart';
import '../../bloc/auth/auth_state.dart';
import '../../widgets/auth/login_form.dart';

/**
 * Hlavní přihlašovací stránka aplikace.
 * Zajišťuje orchestraci mezi formulářem, sociálními providery a navigací.
 * Zpracovává také výsledky verifikace účtu předané skrze AppRouter.
 */
class LoginPage extends StatefulWidget {
  // ✅ PŘIDÁNO: Parametry z AppRouteru pro zobrazení výsledku verifikace
  final String? verificationStatus;
  final String? verificationMessage;

  const LoginPage({
    super.key,
    this.verificationStatus,
    this.verificationMessage,
  });

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _showResendButton = false;
  String? _lastAttemptedEmail;

  @override
  void initState() {
    super.initState();
    // ✅ Reakce na parametry z verifikace po sestavení widgetu
    if (widget.verificationStatus != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _handleVerificationFeedback();
      });
    }
  }

  /// Zobrazí SnackBar na základě výsledku verifikace z Deep Linku
  void _handleVerificationFeedback() {
    final isSuccess = widget.verificationStatus == 'success';
    final l = S.of(context);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          isSuccess
              ? l.accountActivated
              : (widget.verificationMessage ?? l.activationError),
        ),
        backgroundColor: isSuccess ? Colors.green : Colors.red,
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 5),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          state.maybeWhen(
            authenticated: (user) {
              ScaffoldMessenger.of(context).removeCurrentSnackBar();
              Navigator.of(
                context,
              ).pushNamedAndRemoveUntil(AppRouter.main, (route) => false);
            },
            failure: (error) {
              // ✅ Využití isExpired z modelu místo parsování textu
              final isNotVerified =
                  error.message.toLowerCase().contains('aktivní') ||
                  error.message.toLowerCase().contains('verified');
              final isExpired = error.isExpired;

              ScaffoldMessenger.of(context).removeCurrentSnackBar();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(_localizeAuthError(context, error.message)),
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
                  _lastAttemptedEmail = error.email;
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
                  const Icon(
                    Icons.restaurant_menu_rounded,
                    size: 80,
                    color: Colors.green,
                  ),
                  const SizedBox(height: 24),
                  Text(
                    S.of(context).appTitle,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.w900,
                      color: Colors.black87,
                      letterSpacing: -1,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    S.of(context).loginSubtitle,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16, color: Colors.grey.shade600),
                  ),
                  const SizedBox(height: 48),

                  const LoginForm(),

                  if (_showResendButton) ...[
                    const SizedBox(height: 16),
                    _buildResendAction(),
                  ],

                  const SizedBox(height: 32),
                  _buildDivider(),
                  const SizedBox(height: 32),
                  _buildSocialLoginSection(context),
                  const SizedBox(height: 40),
                  _buildRegisterLink(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // --- UI Komponenty (zůstávají víceméně stejné jako v tvém návrhu) ---

  Widget _buildDivider() {
    return Row(
      children: [
        const Expanded(child: Divider()),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            S.of(context).or,
            style: TextStyle(
              color: Colors.grey.shade400,
              fontSize: 11,
              fontWeight: FontWeight.bold,
              letterSpacing: 1,
            ),
          ),
        ),
        const Expanded(child: Divider()),
      ],
    );
  }

  Widget _buildSocialLoginSection(BuildContext context) {
    return Column(
      children: [
        _SocialButton(
          label: 'Google',
          icon: Icons.g_mobiledata_rounded,
          color: Colors.white,
          textColor: Colors.black87,
          onPressed:
              () => context.read<AuthBloc>().add(
                const AuthEvent.googleLoginRequested(),
              ),
        ),
        const SizedBox(height: 16),
        _SocialButton(
          label: 'Apple',
          icon: Icons.apple,
          color: Colors.black,
          textColor: Colors.white,
          onPressed:
              () => context.read<AuthBloc>().add(
                const AuthEvent.appleLoginRequested(),
              ),
        ),
      ],
    );
  }

  Widget _buildResendAction() {
    return OutlinedButton.icon(
      onPressed: () {
        setState(() => _showResendButton = false);
        Navigator.of(
          context,
        ).pushNamed(AppRouter.verifyEmail, arguments: _lastAttemptedEmail);
      },
      icon: const Icon(Icons.mail_outline),
      label: Text(S.of(context).resolveActivation),
      style: OutlinedButton.styleFrom(
        foregroundColor: Colors.orange.shade900,
        side: BorderSide(color: Colors.orange.shade900),
        padding: const EdgeInsets.symmetric(vertical: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );
  }

  Widget _buildRegisterLink() {
    final l = S.of(context);
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              l.noAccountYet,
              style: TextStyle(color: Colors.grey.shade700),
            ),
            TextButton(
              onPressed: () =>
                  Navigator.of(context).pushNamed(AppRouter.register),
              child: Text(
                l.signUp,
                style:
                    const TextStyle(fontWeight: FontWeight.bold, color: Colors.green),
              ),
            ),
          ],
        ),
        TextButton(
          onPressed: () =>
              Navigator.of(context).pushNamed(AppRouter.registerOwner),
          child: Text(
            l.registerAsOwner,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              color: Colors.grey.shade600,
            ),
          ),
        ),
      ],
    );
  }

  String _localizeAuthError(BuildContext context, String errorCode) {
    final l = S.of(context);
    return switch (errorCode) {
      'error_profile_load' => l.errorProfileLoad,
      'error_unexpected' => l.errorUnexpected,
      'error_register_failed' => l.errorRegisterFailed,
      'error_verification_failed' => l.errorVerificationFailed,
      'error_google_login' => l.errorGoogleLogin,
      'error_apple_login' => l.errorAppleLogin,
      _ => errorCode,
    };
  }
}

class _SocialButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final Color color;
  final Color textColor;
  final VoidCallback onPressed;

  const _SocialButton({
    required this.label,
    required this.icon,
    required this.color,
    required this.textColor,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton.icon(
        onPressed: onPressed,
        icon: Icon(icon, size: 28, color: textColor),
        label: Text(S.of(context).continueWith(label)),
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          foregroundColor: textColor,
          elevation: 0,
          padding: const EdgeInsets.symmetric(vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side:
                color == Colors.white
                    ? BorderSide(color: Colors.grey.shade300)
                    : BorderSide.none,
          ),
          textStyle: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
        ),
      ),
    );
  }
}
