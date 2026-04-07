import '../../data/datasources/favourite_remote_datasource.dart';

/// Přidá nebo odebere restauraci z oblíbených uživatele podle
/// aktuálního stavu.
class ToggleFavouriteUseCase {
  final FavouriteRemoteDataSource _dataSource;

  ToggleFavouriteUseCase(this._dataSource);

  /// Odebere restauraci z oblíbených, pokud je [currentlyFavourite] true; jinak ji přidá.
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
