import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/onboarding_menu_category.dart';
import 'menu_item_response_model.dart';

part 'menu_category_response_model.freezed.dart';
part 'menu_category_response_model.g.dart';

/// API response model for a menu category including its items.
@freezed
class OwnerMenuCategoryResponseModel with _$OwnerMenuCategoryResponseModel {
  const OwnerMenuCategoryResponseModel._();

  const factory OwnerMenuCategoryResponseModel({
    String? id,
    String? name,
    @Default([]) List<OwnerMenuItemResponseModel> items,
  }) = _OwnerMenuCategoryResponseModel;

  factory OwnerMenuCategoryResponseModel.fromJson(Map<String, dynamic> json) =>
      _$OwnerMenuCategoryResponseModelFromJson(json);

  OnboardingMenuCategory toEntity() => OnboardingMenuCategory(
        id: id ?? '',
        name: name ?? '',
        items: items.map((i) => i.toEntity()).toList(),
      );
}
