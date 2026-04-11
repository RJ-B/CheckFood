/// Centrální třída pro validaci vstupů v autentizačním modulu.
class AuthValidators {
  /// Validace e-mailu. Vrací {@code null} pro validní vstup, jinak
  /// lokalizovanou chybovou zprávu.
  ///
  /// Pravidla:
  /// - Povolené znaky v local-partu: písmena, čísla, podtržítko, pomlčka,
  ///   tečka a plus (RFC 5321 tag addressing — `user+tag@example.com`).
  /// - Tečka nesmí stát na začátku, na konci local-partu, ani dvě za sebou.
  /// - Domain-part: jeden nebo více segmentů oddělených tečkou, TLD min 2 znaky.
  ///
  /// Starý regex {@code r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$'} měl dvě chyby:
  /// neomezil consecutive dots ({@code a..b@example.com} byl akceptován) a
  /// blokoval plus ({@code user+tag@example.com} odmítnut).
  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Zadejte e-mailovou adresu';
    }

    // Local-part: alphanumeric + _ - + (one segment) followed by zero or more
    // `.segment` groups, so dots are only allowed between non-empty segments
    // — no leading/trailing dot, no consecutive dots.
    // Domain-part: one or more subdomain segments then a TLD of 2+ letters.
    final emailRegex = RegExp(
      r'^[A-Za-z0-9_+\-]+(?:\.[A-Za-z0-9_+\-]+)*@'
      r'[A-Za-z0-9](?:[A-Za-z0-9\-]*[A-Za-z0-9])?'
      r'(?:\.[A-Za-z0-9](?:[A-Za-z0-9\-]*[A-Za-z0-9])?)*'
      r'\.[A-Za-z]{2,}$',
    );
    if (!emailRegex.hasMatch(value)) {
      return 'Zadejte platný formát e-mailu';
    }

    return null;
  }

  /// Validace hesla (minimální délka 8 znaků).
  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Zadejte heslo';
    }

    if (value.length < 8) {
      return 'Heslo musí mít alespoň 8 znaků';
    }

    return null;
  }

  /// Obecná validace pro povinná textová pole (Jméno, Příjmení).
  static String? validateRequired(String? value, String fieldName) {
    if (value == null || value.trim().isEmpty) {
      return 'Pole $fieldName nesmí být prázdné';
    }
    return null;
  }

  /// Validace shody hesel.
  static String? validateConfirmPassword(String? value, String password) {
    if (value == null || value.isEmpty) {
      return 'Zadejte potvrzení hesla';
    }

    if (value != password) {
      return 'Hesla se neshodují';
    }

    return null;
  }
}
