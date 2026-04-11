import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:checkfood_client/l10n/generated/app_localizations.dart';

/// Pumps [child] wrapped in a localised, themed [MaterialApp].
///
/// Set [locale] to 'cs' or 'en'.
/// Set [themeMode] to [ThemeMode.light] or [ThemeMode.dark].
Future<void> pumpApp(
  WidgetTester tester,
  Widget child, {
  String locale = 'en',
  ThemeMode themeMode = ThemeMode.light,
  Size? screenSize,
}) async {
  if (screenSize != null) {
    tester.view.physicalSize = screenSize;
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.resetPhysicalSize);
  }

  await tester.pumpWidget(
    MaterialApp(
      locale: Locale(locale),
      themeMode: themeMode,
      theme: ThemeData.light(useMaterial3: true),
      darkTheme: ThemeData.dark(useMaterial3: true),
      localizationsDelegates: const [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: S.supportedLocales,
      home: child,
    ),
  );
}
