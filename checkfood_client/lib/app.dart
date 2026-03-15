import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'core/theme/app_theme.dart';
import 'navigation/app_router.dart';

// ✅ PŘIDEJ IMPORT SPLASH SCREENU
import 'features/splash/splash_screen.dart';

class CheckFoodApp extends StatelessWidget {
  const CheckFoodApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CheckFood',
      debugShowCheckedModeBanner: false,

      // Lokalizace — potřebné pro showDatePicker s českou locale
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('cs', 'CZ'),
        Locale('en', 'US'),
      ],
      locale: const Locale('cs', 'CZ'),

      // Použití tvého definovaného tématu
      theme: AppTheme.light(),

      // ⚠️ ZMĚNA: Jako startovací bod nastavíme SplashScreen.
      // Ten obsahuje BlocListener, který rozhodne, kam dál (Login/Home/Onboarding).
      home: const SplashScreen(),

      // Zapojení centrálního generátoru cest pro Navigator.pushNamed
      onGenerateRoute: AppRouter.onGenerateRoute,
    );
  }
}
