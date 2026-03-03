import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/ares_company.dart';

part 'ares_lookup_response_model.freezed.dart';
part 'ares_lookup_response_model.g.dart';

@freezed
class AresLookupResponseModel with _$AresLookupResponseModel {
  const AresLookupResponseModel._();

  const factory AresLookupResponseModel({
    required String ico,
    required String companyName,
    String? restaurantId,
    @Default(true) bool requiresIdentityVerification,
    @Default([]) List<String> statutoryPersons,
  }) = _AresLookupResponseModel;

  factory AresLookupResponseModel.fromJson(Map<String, dynamic> json) =>
      _$AresLookupResponseModelFromJson(json);

  AresCompany toEntity() {
    return AresCompany(
      ico: ico,
      companyName: companyName,
      restaurantId: restaurantId,
      statutoryPersons: statutoryPersons,
    );
  }
}
