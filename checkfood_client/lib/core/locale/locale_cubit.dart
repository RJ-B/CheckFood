import 'dart:ui';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Cubit spravující aktuální jazyk aplikace.
///
/// Výchozí jazyk je čeština. Volba se persistuje přes [SharedPreferences].
class LocaleCubit extends Cubit<Locale> {
  static const _key = 'app_locale';

  LocaleCubit() : super(const Locale('cs', 'CZ')) {
    _load();
  }

  /// Načte uložený jazyk z [SharedPreferences] a emituje ho jako počáteční stav.
  Future<void> _load() async {
    final prefs = await SharedPreferences.getInstance();
    final code = prefs.getString(_key);
    if (code != null) {
      emit(_fromCode(code));
    }
  }

  /// Nastaví nový jazyk, uloží ho do [SharedPreferences] a emituje nový stav.
  Future<void> setLocale(Locale locale) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_key, locale.languageCode);
    emit(locale);
  }

  /// Přepne jazyk mezi češtinou a angličtinou.
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
