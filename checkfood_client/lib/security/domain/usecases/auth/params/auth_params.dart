class LoginParams {
  final String email;
  final String password;

  const LoginParams({required this.email, required this.password});
}

class RegisterParams {
  final String email;
  final String password;
  final String firstName;
  final String lastName;

  const RegisterParams({
    required this.email,
    required this.password,
    required this.firstName,
    required this.lastName,
  });
}
