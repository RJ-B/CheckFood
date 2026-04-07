/// Datový model pro požadavek nastavení nového hesla pomocí reset tokenu.
class ResetPasswordRequestModel {
  final String token;
  final String newPassword;

  const ResetPasswordRequestModel({
    required this.token,
    required this.newPassword,
  });

  Map<String, dynamic> toJson() => {
    'token': token,
    'newPassword': newPassword,
  };
}
