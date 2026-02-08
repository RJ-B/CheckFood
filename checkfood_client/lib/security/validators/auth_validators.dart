/// Centrální třída pro validaci vstupů v autentizačním modulu.
class AuthValidators {
  /// Validace e-mailu pomocí regulárního výrazu.
  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Zadejte e-mailovou adresu';
    }

    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
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

    // Zde můžeš přidat další pravidla (číslice, velká písmena atd.)
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
