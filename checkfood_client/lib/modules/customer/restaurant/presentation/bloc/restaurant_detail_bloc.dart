import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/usecases/get_restaurant_by_id_usecase.dart';
import '../../domain/usecases/toggle_favourite_usecase.dart';
import 'restaurant_detail_event.dart';
import 'restaurant_detail_state.dart';

/// BLoC that loads a restaurant's full detail and handles favourite toggling
/// with an optimistic UI update.
class RestaurantDetailBloc
    extends Bloc<RestaurantDetailEvent, RestaurantDetailState> {
  final GetRestaurantByIdUseCase _getRestaurantByIdUseCase;
  final ToggleFavouriteUseCase _toggleFavouriteUseCase;

  RestaurantDetailBloc({
    required GetRestaurantByIdUseCase getRestaurantByIdUseCase,
    required ToggleFavouriteUseCase toggleFavouriteUseCase,
  })  : _getRestaurantByIdUseCase = getRestaurantByIdUseCase,
        _toggleFavouriteUseCase = toggleFavouriteUseCase,
        super(const RestaurantDetailState.initial()) {
    on<LoadDetailRequested>(_onLoadRequested);
    on<ToggleFavourite>(_onToggleFavourite);
  }

  Future<void> _onLoadRequested(
    LoadDetailRequested event,
    Emitter<RestaurantDetailState> emit,
  ) async {
    emit(const RestaurantDetailState.loading());
    try {
      final restaurant = await _getRestaurantByIdUseCase.call(
        event.restaurantId,
      );
      emit(RestaurantDetailState.loaded(restaurant: restaurant));
    } catch (e) {
      emit(RestaurantDetailState.error(message: e.toString()));
    }
  }

  Future<void> _onToggleFavourite(
    ToggleFavourite event,
    Emitter<RestaurantDetailState> emit,
  ) async {
    final current = state;
    if (current is! DetailLoaded) return;

    final restaurant = current.restaurant;
    final wasFavourite = restaurant.isFavourite;

    emit(
      RestaurantDetailState.loaded(
        restaurant: restaurant.copyWith(isFavourite: !wasFavourite),
      ),
    );

    try {
      await _toggleFavouriteUseCase.call(
        restaurantId: restaurant.id,
        currentlyFavourite: wasFavourite,
      );
    } catch (_) {
      // Rollback the optimistic update.
      emit(
        RestaurantDetailState.loaded(
          restaurant: restaurant.copyWith(isFavourite: wasFavourite),
        ),
      );
    }
  }
}
