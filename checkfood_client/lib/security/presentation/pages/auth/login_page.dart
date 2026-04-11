import 'dart:io' show Platform;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/theme/colors.dart';
import '../../../../l10n/generated/app_localizations.dart';
import '../../../../navigation/app_router.dart';
import '../../bloc/auth/auth_bloc.dart';
import '../../bloc/auth/auth_event.dart';
import '../../bloc/auth/auth_state.dart';
import '../../../domain/entities/user.dart';
import '../../../data/models/profile/request/update_profile_request_model.dart';
import '../../bloc/user/user_bloc.dart';
import '../../bloc/user/user_event.dart';
import '../../utils/secure_screen.dart';
import '../../widgets/auth/login_form.dart';
import '../../widgets/profile_completion_dialog.dart';

/// Hlavní přihlašovací stránka aplikace.
///
/// Zajišťuje orchestraci mezi formulářem, sociálními providery a navigací.
/// Zpracovává také výsledky verifikace účtu předané skrze [AppRouter].
class LoginPage extends StatefulWidget {
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
    // Sensitive screen: protect the password + email form against
    // screenshots / task-switcher previews. See SecureScreen docstring.
    SecureScreen.enable();
    if (widget.verificationStatus != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _handleVerificationFeedback();
      });
    }
  }

  @override
  void dispose() {
    SecureScreen.disable();
    super.dispose();
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
        backgroundColor: isSuccess ? AppColors.success : AppColors.error,
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
              if (user.needsProfileCompletion) {
                _showProfileCompletionDialog(context, user);
              } else {
                Navigator.of(
                  context,
                ).pushNamedAndRemoveUntil(AppRouter.main, (route) => false);
              }
            },
            verificationRequired: (email) {
              ScaffoldMessenger.of(context).removeCurrentSnackBar();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(S.of(context).accountNotVerified),
                  backgroundColor: AppColors.warning,
                  behavior: SnackBarBehavior.floating,
                  duration: const Duration(seconds: 5),
                ),
              );
              setState(() {
                _showResendButton = true;
                _lastAttemptedEmail = email;
              });
            },
            failure: (error) {
              ScaffoldMessenger.of(context).removeCurrentSnackBar();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(_localizeAuthError(context, error.message)),
                  backgroundColor: AppColors.error,
                  behavior: SnackBarBehavior.floating,
                ),
              );
            },
            orElse: () {},
          );
        },
        child: SafeArea(
          child: LayoutBuilder(
            builder: (context, constraints) {
              return SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: ConstrainedBox(
                  constraints: BoxConstraints(minHeight: constraints.maxHeight),
                  child: IntrinsicHeight(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const Spacer(flex: 2),
                        const Icon(
                          Icons.restaurant_menu_rounded,
                          size: 64,
                          color: AppColors.primary,
                        ),
                        const SizedBox(height: 12),
                        Text(
                          S.of(context).appTitle,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.w900,
                            color: AppColors.textPrimary,
                            letterSpacing: -1,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          S.of(context).loginSubtitle,
                          textAlign: TextAlign.center,
                          style: const TextStyle(fontSize: 14, color: AppColors.textSecondary),
                        ),
                        const SizedBox(height: 24),

                        const LoginForm(),

                        if (_showResendButton) ...[
                          const SizedBox(height: 8),
                          _buildResendAction(),
                        ],

                        const SizedBox(height: 16),
                        _buildDivider(),
                        const SizedBox(height: 16),
                        _buildSocialLoginSection(context),
                        const Spacer(),
                        _buildRegisterLink(),
                        const SizedBox(height: 8),
                      ],
                    ),
                  ),
                ),
              );
            },
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
            style: const TextStyle(
              color: AppColors.textMuted,
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
          textColor: AppColors.textPrimary,
          onPressed:
              () => context.read<AuthBloc>().add(
                const AuthEvent.googleLoginRequested(),
              ),
        ),
        if (Platform.isIOS) ...[
          const SizedBox(height: 12),
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
        foregroundColor: AppColors.warning,
        side: const BorderSide(color: AppColors.warning),
        padding: const EdgeInsets.symmetric(vertical: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );
  }

  Widget _buildRegisterLink() {
    final l = S.of(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          l.noAccountYet,
          style: const TextStyle(color: AppColors.textSecondary),
        ),
        TextButton(
          onPressed: () =>
              Navigator.of(context).pushNamed(AppRouter.register),
          child: Text(
            l.signUp,
            style:
                const TextStyle(fontWeight: FontWeight.bold, color: AppColors.primaryDark),
          ),
        ),
      ],
    );
  }

  void _showProfileCompletionDialog(BuildContext context, User user) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => ProfileCompletionDialog(
        initialFirstName: user.firstName.isNotEmpty ? user.firstName : null,
        initialLastName: user.lastName.isNotEmpty ? user.lastName : null,
        onSave: (firstName, lastName, phone) {
          context.read<UserBloc>().add(
                UserEvent.profileUpdated(
                  UpdateProfileRequestModel(
                    firstName: firstName,
                    lastName: lastName,
                    phone: phone.isNotEmpty ? phone : null,
                  ),
                ),
              );
          Navigator.of(context)
              .pushNamedAndRemoveUntil(AppRouter.main, (route) => false);
        },
      ),
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
      'error_forgot_password' => l.errorForgotPassword,
      'error_reset_password' => l.errorResetPassword,
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
                    ? const BorderSide(color: AppColors.border)
                    : BorderSide.none,
          ),
          textStyle: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
        ),
      ),
    );
  }
}
