/// Parametry pro UseCase přihlášení.
class LoginParams {
  final String email;
  final String password;

  const LoginParams({required this.email, required this.password});
}

/// Parametry pro UseCase registrace nového uživatele.
class RegisterParams {
  final String email;
  final String password;
  final String firstName;
  final String lastName;
  final bool ownerRegistration;
  final double? latitude;
  final double? longitude;

  const RegisterParams({
    required this.email,
    required this.password,
    required this.firstName,
    required this.lastName,
    this.ownerRegistration = false,
    this.latitude,
    this.longitude,
  });
}
