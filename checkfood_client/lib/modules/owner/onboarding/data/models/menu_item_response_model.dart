import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/onboarding_menu_item.dart';

part 'menu_item_response_model.freezed.dart';
part 'menu_item_response_model.g.dart';

@freezed
class OwnerMenuItemResponseModel with _$OwnerMenuItemResponseModel {
  const OwnerMenuItemResponseModel._();

  const factory OwnerMenuItemResponseModel({
    String? id,
    String? name,
    String? description,
    @Default(0) int priceMinor,
    @Default('CZK') String currency,
    String? imageUrl,
    @Default(true) bool available,
  }) = _OwnerMenuItemResponseModel;

  factory OwnerMenuItemResponseModel.fromJson(Map<String, dynamic> json) =>
      _$OwnerMenuItemResponseModelFromJson(json);

  OnboardingMenuItem toEntity() => OnboardingMenuItem(
        id: id ?? '',
        name: name ?? '',
        description: description,
        priceMinor: priceMinor,
        currency: currency,
        imageUrl: imageUrl,
        available: available,
      );
}
