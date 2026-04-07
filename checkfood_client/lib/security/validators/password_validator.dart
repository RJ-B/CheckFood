/// Validátor síly hesla pro registraci a změnu hesla.
///
/// Vyžaduje délku 8–64 znaků, alespoň jedno velké písmeno, malé písmeno,
/// číslici a speciální znak (`@$!%*?&`).
class PasswordValidator {
  static const int minLength = 8;
  static const int maxLength = 64;

  static final RegExp _passwordRegex = RegExp(
    r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$',
  );

  /// Vrátí chybovou zprávu, pokud [value] nesplňuje požadavky, nebo `null` při úspěchu.
  static String? validate(String? value) {
    if (value == null || value.isEmpty) {
      return 'Heslo je povinné';
    }

    if (value.length < minLength) {
      return 'Heslo musí mít alespoň $minLength znaků';
    }

    if (value.length > maxLength) {
      return 'Heslo může mít maximálně $maxLength znaků';
    }

    if (!_passwordRegex.hasMatch(value)) {
      return 'Heslo musí obsahovat velké písmeno, malé písmeno, číslici a speciální znak (@\$!%*?&)';
    }

    return null;
  }

  /// Vrátí chybovou zprávu, pokud se [confirmPassword] neshoduje s [originalPassword].
  static String? validateMatch(
    String? confirmPassword,
    String originalPassword,
  ) {
    if (confirmPassword == null || confirmPassword.isEmpty) {
      return 'Potvrzení hesla je povinné';
    }

    if (confirmPassword != originalPassword) {
      return 'Hesla se neshodují';
    }

    return null;
  }
}
