import 'package:freezed_annotation/freezed_annotation.dart';
import 'onboarding_menu_item.dart';

part 'onboarding_menu_category.freezed.dart';

@freezed
class OnboardingMenuCategory with _$OnboardingMenuCategory {
  const factory OnboardingMenuCategory({
    required String id,
    required String name,
    @Default([]) List<OnboardingMenuItem> items,
  }) = _OnboardingMenuCategory;
}
