import 'package:flutter/services.dart';

/// Utilita pro hygienu schránky po odeslání citlivých formulářů
/// (heslo, OTP, reset token).
///
/// Proč: po submitu je přihlašovací údaj uložen v TextFormField controlleru,
/// ale kdokoli mezitím mohl použít "Paste" (nebo uživatel sám zkopíroval
/// heslo z password manageru). Systémová schránka zůstává čitelná pro
/// jiné aplikace s oprávněním READ_CLIPBOARD. Po úspěšném odeslání
/// přepíšeme obsah schránky prázdným stringem, čímž minimalizujeme
/// časové okno, kdy by heslo mohlo být v systémové schránce.
///
/// Volá se z onSubmit handlerů v [LoginPage], [RegisterPage],
/// [ResetPasswordPage], [EmailVerificationScreen], [ChangePasswordDialog]
/// atd.
class ClipboardHygiene {
  const ClipboardHygiene._();

  /// Přepíše systémovou schránku prázdným stringem. Bezpečná operace —
  /// `Clipboard.setData` je no-op, pokud se nepovede (např. headless test
  /// prostředí, iOS simulátor bez klávesnice).
  static Future<void> clearSensitive() async {
    try {
      // Note: not using `const` prefix here — the masvs_platform_test
      // static scan matches `Clipboard\.setData\s*\(\s*ClipboardData` and
      // can't skip over a `const` keyword. Keeping the call non-const is
      // negligible allocation overhead for a one-shot clearance.
      // ignore: prefer_const_constructors
      await Clipboard.setData(ClipboardData(text: ''));
    } catch (_) {
      // Schválně spolknuto — pokud platform channel selže (test prostředí,
      // chybějící klávesnice), nemá smysl rušit celý auth flow.
    }
  }
}
