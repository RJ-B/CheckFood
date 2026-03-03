class PasswordValidator {
  static const int minLength = 8;
  static const int maxLength = 64;

  /// Regex pro silné heslo:
  /// - Minimálně jedno velké písmeno
  /// - Minimálně jedno malé písmeno
  /// - Minimálně jedna číslice
  /// - Minimálně jeden speciální znak (@$!%*?&)
  static final RegExp _passwordRegex = RegExp(
    r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$',
  );

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
