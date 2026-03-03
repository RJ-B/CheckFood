import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/usecases/get_restaurant_by_id_usecase.dart';
import 'restaurant_detail_event.dart';
import 'restaurant_detail_state.dart';

/// BLoC zodpovědný za načtení a správu detailu jedné restaurace.
class RestaurantDetailBloc
    extends Bloc<RestaurantDetailEvent, RestaurantDetailState> {
  final GetRestaurantByIdUseCase _getRestaurantByIdUseCase;

  RestaurantDetailBloc({
    required GetRestaurantByIdUseCase getRestaurantByIdUseCase,
  }) : _getRestaurantByIdUseCase = getRestaurantByIdUseCase,
       super(const RestaurantDetailState.initial()) {
    on<LoadDetailRequested>(_onLoadRequested);
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
}
