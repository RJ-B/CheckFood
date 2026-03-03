import 'package:freezed_annotation/freezed_annotation.dart';

part 'onboarding_menu_item.freezed.dart';

@freezed
class OnboardingMenuItem with _$OnboardingMenuItem {
  const factory OnboardingMenuItem({
    required String id,
    required String name,
    String? description,
    @Default(0) int priceMinor,
    @Default('CZK') String currency,
    String? imageUrl,
    @Default(true) bool available,
  }) = _OnboardingMenuItem;
}
