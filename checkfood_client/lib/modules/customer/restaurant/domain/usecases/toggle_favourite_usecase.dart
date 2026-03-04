import '../../data/datasources/favourite_remote_datasource.dart';

class ToggleFavouriteUseCase {
  final FavouriteRemoteDataSource _dataSource;

  ToggleFavouriteUseCase(this._dataSource);

  /// Pokud [currentlyFavourite] je true, odebere. Jinak přidá.
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
