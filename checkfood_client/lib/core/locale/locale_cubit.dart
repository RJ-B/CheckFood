import 'dart:ui';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocaleCubit extends Cubit<Locale> {
  static const _key = 'app_locale';

  LocaleCubit() : super(const Locale('cs', 'CZ')) {
    _load();
  }

  Future<void> _load() async {
    final prefs = await SharedPreferences.getInstance();
    final code = prefs.getString(_key);
    if (code != null) {
      emit(_fromCode(code));
    }
  }

  Future<void> setLocale(Locale locale) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_key, locale.languageCode);
    emit(locale);
  }

  void toggleLocale() {
    final next = state.languageCode == 'cs'
        ? const Locale('en', 'US')
        : const Locale('cs', 'CZ');
    setLocale(next);
  }

  Locale _fromCode(String code) {
    switch (code) {
      case 'en':
        return const Locale('en', 'US');
      default:
        return const Locale('cs', 'CZ');
    }
  }
}
