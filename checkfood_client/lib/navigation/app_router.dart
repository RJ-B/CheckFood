import 'package:flutter/material.dart';

// Importy
import 'route_guards.dart';
import '../security/presentation/pages/auth/login_page.dart';
import '../security/presentation/pages/auth/register_page.dart';
import '../security/presentation/pages/auth/email_verification_screen.dart';

// Zkontrolujte, zda máte MainShell v této složce, nebo upravte cestu!
// Pokud je MainShell v lib/navigation/main_shell.dart:
import 'main_shell.dart';

class AppRouter {
  static const String root = '/';
  static const String login = '/login';
  static const String register = '/register';
  static const String verifyEmail = '/verify-email';

  // TOTO JE ONA - Cesta, kterou router nemůže najít
  static const String main = '/main';

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    // 👇 DEBUG VÝPISY - Sledujte konzoli po přihlášení 👇
    print('--- ROUTER DEBUG ---');
    print('Požadovaná cesta (settings.name): ${settings.name}');

    final uri = Uri.parse(settings.name ?? '/');
    print('Rozparsovaná cesta (uri.path): ${uri.path}');

    switch (uri.path) {
      case root:
        return MaterialPageRoute(builder: (_) => const RootGuard());

      case login:
        final status = uri.queryParameters['status'];
        final message = uri.queryParameters['message'];
        return MaterialPageRoute(
          builder: (context) {
            if (status == 'error' && message != null) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Chyba: $message'),
                    backgroundColor: Colors.red,
                  ),
                );
              });
            } else if (status == 'success') {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Účet ověřen!'),
                    backgroundColor: Colors.green,
                  ),
                );
              });
            }
            return const LoginPage();
          },
        );

      case register:
        return MaterialPageRoute(builder: (_) => const RegisterPage());

      case verifyEmail:
        return MaterialPageRoute(
          builder: (_) => const EmailVerificationScreen(),
        );

      // 👇 TOTO JE KLÍČOVÁ ČÁST 👇
      case main:
        print('✅ Router: Našel jsem shodu pro MAIN, otevírám MainShell');
        return MaterialPageRoute(builder: (_) => const MainShell());

      default:
        print(
          '❌ Router: Nenašel jsem shodu pro ${uri.path}, vracím ErrorRoute',
        );
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
