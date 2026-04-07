import '../../data/datasources/favourite_remote_datasource.dart';

/// Adds or removes a restaurant from the user's favourites depending on its
/// current state.
class ToggleFavouriteUseCase {
  final FavouriteRemoteDataSource _dataSource;

  ToggleFavouriteUseCase(this._dataSource);

  /// Removes the restaurant from favourites if [currentlyFavourite] is true; otherwise adds it.
  Future<void> call({
    required String restaurantId,
    required bool currentlyFavourite,
  }) {
    if (currentlyFavourite) {
      return _dataSource.removeFavourite(restaurantId);
    } else {
      return _dataSource.addFavourite(restaurantId);
    }
  }
}
