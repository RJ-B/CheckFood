import 'package:flutter/material.dart';

import 'route_guards.dart';
import 'main_shell.dart';
import '../security/presentation/pages/auth/login_page.dart';
import '../security/presentation/pages/auth/register_page.dart';
import '../security/presentation/pages/auth/email_verification_screen.dart';
import '../modules/owner/presentation/pages/owner_register_page.dart';
import '../modules/owner/presentation/pages/claim_restaurant_page.dart';

class AppRouter {
  static const String root = '/';
  static const String login = '/login';
  static const String register = '/register';
  static const String registerOwner = '/register-owner';
  static const String claimRestaurant = '/claim-restaurant';
  static const String verifyEmail = '/verify-email';
  static const String main = '/main';

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

      case claimRestaurant:
        return MaterialPageRoute(builder: (_) => const ClaimRestaurantPage());

      case verifyEmail:
        final String? email = settings.arguments as String?;
        return MaterialPageRoute(
          builder: (_) => EmailVerificationScreen(email: email),
        );

      case main:
        return MaterialPageRoute(builder: (_) => const MainShell());

      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(
      builder:
          (_) => const Scaffold(
            body: Center(child: Text('Chyba: cesta nenalezena')),
          ),
    );
  }
}
