import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/claim_result.dart';

part 'claim_result_response_model.freezed.dart';
part 'claim_result_response_model.g.dart';

@freezed
class ClaimResultResponseModel with _$ClaimResultResponseModel {
  const ClaimResultResponseModel._();

  const factory ClaimResultResponseModel({
    @Default(false) bool success,
    @Default(false) bool matched,
    @Default(false) bool membershipCreated,
    @Default(false) bool emailFallbackAvailable,
    String? emailHint,
  }) = _ClaimResultResponseModel;

  factory ClaimResultResponseModel.fromJson(Map<String, dynamic> json) =>
      _$ClaimResultResponseModelFromJson(json);

  ClaimResult toEntity() {
    return ClaimResult(
      success: success,
      matched: matched,
      membershipCreated: membershipCreated,
      emailFallbackAvailable: emailFallbackAvailable,
      emailHint: emailHint,
    );
  }
}
