import 'package:dio/dio.dart';

abstract class FavouriteRemoteDataSource {
  Future<void> addFavourite(String restaurantId);
  Future<void> removeFavourite(String restaurantId);
}

class FavouriteRemoteDataSourceImpl implements FavouriteRemoteDataSource {
  final Dio _dio;
  static const String _baseUrl = '/v1/users/me/favourites';

  FavouriteRemoteDataSourceImpl(this._dio);

  @override
  Future<void> addFavourite(String restaurantId) async {
    await _dio.put('$_baseUrl/$restaurantId');
  }

  @override
  Future<void> removeFavourite(String restaurantId) async {
    await _dio.delete('$_baseUrl/$restaurantId');
  }
}
