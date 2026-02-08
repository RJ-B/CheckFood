class PasswordValidator {
  // Regex už nepotřebujeme
  // static final RegExp _passwordRegex = ...

  static String? validate(String? value) {
    if (value == null || value.isEmpty) {
      return 'Heslo je povinné';
    }

    // Změníme limit na 3 znaky, aby to sedělo s backendem
    if (value.length < 3) {
      return 'Heslo musí mít alespoň 3 znaky';
    }

    // Tuto přísnou kontrolu zakomentujeme/smažeme:
    /*
    if (!_passwordRegex.hasMatch(value)) {
      return 'Heslo musí obsahovat velké/malé písmeno...';
    }
    */

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
