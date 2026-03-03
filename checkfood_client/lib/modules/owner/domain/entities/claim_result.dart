import 'package:freezed_annotation/freezed_annotation.dart';

part 'claim_result.freezed.dart';

@freezed
class ClaimResult with _$ClaimResult {
  const factory ClaimResult({
    @Default(false) bool success,
    @Default(false) bool matched,
    @Default(false) bool membershipCreated,
    @Default(false) bool emailFallbackAvailable,
    String? emailHint,
  }) = _ClaimResult;
}
