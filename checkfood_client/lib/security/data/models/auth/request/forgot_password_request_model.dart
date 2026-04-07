/// Datový model pro požadavek zahájení obnovy hesla.
class ForgotPasswordRequestModel {
  final String email;

  const ForgotPasswordRequestModel({required this.email});

  Map<String, dynamic> toJson() => {'email': email};
}
