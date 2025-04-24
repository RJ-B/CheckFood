import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/auth_provider.dart';
import 'screens/login_screen.dart';
import 'screens/register_screen.dart';
import 'screens/home_screen.dart';
import 'screens/profile/user_settings_screen.dart';
import 'screens/profile/edit_profile_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => AuthProvider()..checkLoginStatus(),
      child: MaterialApp(
        title: 'CheckFood',
        theme: ThemeData(primarySwatch: Colors.green),
        home: const LoginScreen(),
        routes: {
          '/login': (context) => const LoginScreen(),
          '/register': (context) => const RegisterScreen(),
          '/home': (context) => const HomeScreen(),
          '/map': (context) => const PlaceholderScreen(title: 'Mapa'),
          '/user': (context) => const UserSettingsScreen(),
          '/edit-profile': (context) => const EditProfileScreen(),
        },
      ),
    );
  }
}

/// Pomocná stránka, dokud nevytvoříme reálné obrazovky
class PlaceholderScreen extends StatelessWidget {
  final String title;
  const PlaceholderScreen({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Center(
        child: Text(
          '$title – zatím prázdné',
          style: const TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
