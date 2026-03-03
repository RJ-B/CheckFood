import 'package:freezed_annotation/freezed_annotation.dart';

part 'restaurant_detail_event.freezed.dart';

@freezed
class RestaurantDetailEvent with _$RestaurantDetailEvent {
  /// Požadavek na načtení detailu restaurace podle ID.
  const factory RestaurantDetailEvent.loadRequested({
    required String restaurantId,
  }) = LoadDetailRequested;
}
