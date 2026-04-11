import 'dart:ui';

import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:checkfood_client/core/locale/locale_cubit.dart';

void main() {
  group('LocaleCubit', () {
    setUp(() {
      // Reset SharedPreferences between tests using the in-memory mock.
      SharedPreferences.setMockInitialValues({});
    });

    test('initial state is Czech locale', () {
      final cubit = LocaleCubit();
      expect(cubit.state, const Locale('cs', 'CZ'));
      cubit.close();
    });

    test('setLocale emits the provided locale', () async {
      final cubit = LocaleCubit();

      final future = expectLater(
        cubit.stream,
        emitsInOrder([const Locale('en', 'US')]),
      );

      await cubit.setLocale(const Locale('en', 'US'));
      await future;
      cubit.close();
    });

    test('setLocale persists locale so next cubit hydrates to it', () async {
      final cubit1 = LocaleCubit();
      await cubit1.setLocale(const Locale('en', 'US'));
      await cubit1.close();

      // Give the async _load() time to complete
      final cubit2 = LocaleCubit();
      await Future.delayed(const Duration(milliseconds: 50));

      expect(cubit2.state, const Locale('en', 'US'));
      cubit2.close();
    });

    test('toggleLocale switches from cs to en', () async {
      SharedPreferences.setMockInitialValues({'app_locale': 'cs'});
      final cubit = LocaleCubit();
      await Future.delayed(const Duration(milliseconds: 50));

      final future = expectLater(
        cubit.stream,
        emits(const Locale('en', 'US')),
      );

      cubit.toggleLocale();
      await future;
      cubit.close();
    });

    test('toggleLocale switches from en back to cs', () async {
      SharedPreferences.setMockInitialValues({'app_locale': 'en'});
      final cubit = LocaleCubit();
      await Future.delayed(const Duration(milliseconds: 50));

      final future = expectLater(
        cubit.stream,
        emits(const Locale('cs', 'CZ')),
      );

      cubit.toggleLocale();
      await future;
      cubit.close();
    });

    test('unknown locale code defaults to Czech on hydration', () async {
      SharedPreferences.setMockInitialValues({'app_locale': 'fr'});
      final cubit = LocaleCubit();
      await Future.delayed(const Duration(milliseconds: 50));

      expect(cubit.state, const Locale('cs', 'CZ'));
      cubit.close();
    });

    test('missing stored locale defaults to Czech on hydration', () async {
      SharedPreferences.setMockInitialValues({});
      final cubit = LocaleCubit();
      await Future.delayed(const Duration(milliseconds: 50));

      expect(cubit.state, const Locale('cs', 'CZ'));
      cubit.close();
    });
  });
}
