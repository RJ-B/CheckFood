import 'package:freezed_annotation/freezed_annotation.dart';

part 'restaurant_detail_event.freezed.dart';

@freezed
class RestaurantDetailEvent with _$RestaurantDetailEvent {
  const factory RestaurantDetailEvent.loadRequested({
    required String restaurantId,
  }) = LoadDetailRequested;

  const factory RestaurantDetailEvent.toggleFavourite() = ToggleFavourite;
}
