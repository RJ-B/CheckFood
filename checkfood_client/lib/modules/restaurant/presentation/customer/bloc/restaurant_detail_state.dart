import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../domain/entities/restaurant.dart';

part 'restaurant_detail_state.freezed.dart';

@freezed
class RestaurantDetailState with _$RestaurantDetailState {
  const factory RestaurantDetailState.initial() = _Initial;
  const factory RestaurantDetailState.loading() = _Loading;
  const factory RestaurantDetailState.loaded({
    required Restaurant restaurant,
  }) = DetailLoaded;
  const factory RestaurantDetailState.error({required String message}) = _Error;
}
