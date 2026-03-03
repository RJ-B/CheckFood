import 'package:freezed_annotation/freezed_annotation.dart';

part 'ares_company.freezed.dart';

@freezed
class AresCompany with _$AresCompany {
  const factory AresCompany({
    required String ico,
    required String companyName,
    String? restaurantId,
    @Default([]) List<String> statutoryPersons,
  }) = _AresCompany;
}
