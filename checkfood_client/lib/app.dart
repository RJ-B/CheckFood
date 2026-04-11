import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'core/locale/locale_cubit.dart';
import 'core/theme/app_theme.dart';
import 'l10n/generated/app_localizations.dart';
import 'navigation/app_router.dart';
import 'features/splash/splash_screen.dart';

/// Kořenová aplikace CheckFood.
///
/// Reaguje na změny [LocaleCubit] a překreslí [MaterialApp] při přepnutí jazyka.
///
/// [navigatorKey] je předaná z [main.dart] aby Universal Link listener
/// (`AppBootstrapper`) mohl navigovat na `/login?status=...` po zpracování
/// verifikačního tokenu, který přijde z Mail.app mimo widget tree.
class CheckFoodApp extends StatelessWidget {
  final GlobalKey<NavigatorState> navigatorKey;

  const CheckFoodApp({super.key, required this.navigatorKey});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LocaleCubit, Locale>(
      builder: (context, locale) {
        return MaterialApp(
          title: 'CheckFood',
          debugShowCheckedModeBanner: false,
          navigatorKey: navigatorKey,

          localizationsDelegates: S.localizationsDelegates,
          supportedLocales: S.supportedLocales,
          locale: locale,

          theme: AppTheme.light(),
          home: const SplashScreen(),
          onGenerateRoute: AppRouter.onGenerateRoute,
        );
      },
    );
  }
}
