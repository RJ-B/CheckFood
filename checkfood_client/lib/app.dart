import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'core/locale/locale_cubit.dart';
import 'core/theme/app_theme.dart';
import 'l10n/generated/app_localizations.dart';
import 'navigation/app_router.dart';
import 'features/splash/splash_screen.dart';

class CheckFoodApp extends StatelessWidget {
  const CheckFoodApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LocaleCubit, Locale>(
      builder: (context, locale) {
        return MaterialApp(
          title: 'CheckFood',
          debugShowCheckedModeBanner: false,

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
