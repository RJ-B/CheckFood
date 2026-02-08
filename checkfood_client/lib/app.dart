import 'package:checkfood_client/navigation/route_guards.dart';
import 'package:flutter/material.dart';
import 'core/theme/app_theme.dart';
import 'navigation/app_router.dart';

class CheckFoodApp extends StatelessWidget {
  const CheckFoodApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CheckFood',
      debugShowCheckedModeBanner: false,

      // Použití tvého definovaného tématu
      theme: AppTheme.light(),

      // Hlavní vstupní bod aplikace spravovaný Guardem
      home: const RootGuard(),

      // Zapojení centrálního generátoru cest pro Navigator.pushNamed
      onGenerateRoute: AppRouter.onGenerateRoute,
    );
  }
}
