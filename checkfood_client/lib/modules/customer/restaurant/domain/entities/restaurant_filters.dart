import 'package:freezed_annotation/freezed_annotation.dart';
import 'cuisine_type.dart';

part 'restaurant_filters.freezed.dart';

@freezed
class RestaurantFilters with _$RestaurantFilters {
  const RestaurantFilters._();

  const factory RestaurantFilters({
    String? searchQuery,
    @Default([]) List<CuisineType> cuisineTypes,
    double? minRating,
    @Default(false) bool openNow,
  }) = _RestaurantFilters;

  bool get hasActiveFilters =>
      cuisineTypes.isNotEmpty || minRating != null || openNow;

  int get activeFilterCount =>
      (cuisineTypes.isNotEmpty ? 1 : 0) +
      (minRating != null ? 1 : 0) +
      (openNow ? 1 : 0);
}
