import 'package:freezed_annotation/freezed_annotation.dart';

part 'onboarding_table.freezed.dart';

@freezed
class OnboardingTable with _$OnboardingTable {
  const factory OnboardingTable({
    required String id,
    required String label,
    @Default(0) int capacity,
    @Default(true) bool active,
    double? yaw,
    double? pitch,
  }) = _OnboardingTable;
}
