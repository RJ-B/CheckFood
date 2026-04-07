import 'package:flutter/material.dart';

import 'route_guards.dart';
import 'main_shell.dart';
import '../security/presentation/pages/auth/login_page.dart';
import '../security/presentation/pages/auth/register_page.dart';
import '../security/presentation/pages/auth/email_verification_screen.dart';
import '../security/presentation/pages/auth/forgot_password_page.dart';
import '../security/presentation/pages/auth/reset_password_page.dart';
import '../modules/restaurant/presentation/onboarding/presentation/pages/owner_register_page.dart';
import '../l10n/generated/app_localizations.dart';

/// Centrální konfigurace route pomocí [Navigator.onGenerateRoute].
///
/// Mapuje URL cesty na page widgety a předává potřebné argumenty.
class AppRouter {
  static const String root = '/';
  static const String login = '/login';
  static const String register = '/register';
  static const String registerOwner = '/register-owner';
  static const String verifyEmail = '/verify-email';
  static const String main = '/main';
  static const String forgotPassword = '/forgot-password';
  static const String resetPassword = '/reset-password';

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    final uri = Uri.parse(settings.name ?? '/');

    switch (uri.path) {
      case root:
        return MaterialPageRoute(builder: (_) => const RootGuard());

      case login:
        final String? status = uri.queryParameters['status'];
        final String? message = uri.queryParameters['message'];

        return MaterialPageRoute(
          builder:
              (_) => LoginPage(
                verificationStatus: status,
                verificationMessage: message,
              ),
        );

      case register:
        return MaterialPageRoute(builder: (_) => const RegisterPage());

      case registerOwner:
        return MaterialPageRoute(builder: (_) => const OwnerRegisterPage());

      case verifyEmail:
        final String? email = settings.arguments as String?;
        return MaterialPageRoute(
          builder: (_) => EmailVerificationScreen(email: email),
        );

      case main:
        return MaterialPageRoute(builder: (_) => const MainShell());

      case forgotPassword:
        return MaterialPageRoute(builder: (_) => const ForgotPasswordPage());

      case resetPassword:
        final String? token = uri.queryParameters['token'];
        if (token == null || token.isEmpty) {
          return _errorRoute();
        }
        return MaterialPageRoute(
          builder: (_) => ResetPasswordPage(token: token),
        );

      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(
      builder: (context) => Scaffold(
        body: Center(
          child: Builder(
            builder: (context) => Text(S.of(context).routeNotFound),
          ),
        ),
      ),
    );
  }
}
