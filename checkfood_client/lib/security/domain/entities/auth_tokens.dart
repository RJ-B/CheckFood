import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_tokens.freezed.dart';

/// Doménová entita pro dvojici autentizačních tokenů (access + refresh) a jejich expiraci.
@freezed
class AuthTokens with _$AuthTokens {
  const factory AuthTokens({
    required String accessToken,
    required String refreshToken,
    required Duration expiresIn,
  }) = _AuthTokens;
}
