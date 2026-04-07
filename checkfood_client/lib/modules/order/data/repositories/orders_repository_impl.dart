import 'package:dio/dio.dart';

import '../../../../../../core/error/exceptions/server_exceptions.dart';
import '../../domain/entities/dining_context.dart';
import '../../domain/entities/menu_category.dart';
import '../../domain/entities/order_summary.dart';
import '../../domain/repositories/orders_repository.dart';
import '../datasources/orders_remote_datasource.dart';
import '../models/request/create_order_request_model.dart';
import '../models/request/order_item_request_model.dart';

/// Implementace repozitáře delegující na [OrdersRemoteDataSource]
/// a mapující modely odpovědí na doménové entity.
class OrdersRepositoryImpl implements OrdersRepository {
  final OrdersRemoteDataSource _remoteDataSource;

  OrdersRepositoryImpl(this._remoteDataSource);

  @override
  Future<DiningContext> getDiningContext() async {
    try {
      final model = await _remoteDataSource.getDiningContext();
      return model.toEntity();
    } on DioException catch (e) {
      throw _mapDioException(e);
    } catch (e) {
      throw ServerException('Neočekávaná chyba: $e');
    }
  }

  @override
  Future<List<MenuCategory>> getMenu(String restaurantId) async {
    try {
      final models = await _remoteDataSource.getMenu(restaurantId);
      return models.map((m) => m.toEntity()).toList();
    } on DioException catch (e) {
      throw _mapDioException(e);
    } catch (e) {
      throw ServerException('Neočekávaná chyba: $e');
    }
  }

  @override
  Future<OrderSummary> createOrder({
    required List<({String menuItemId, int quantity})> items,
    String? note,
  }) async {
    try {
      final request = CreateOrderRequestModel(
        items: items
            .map((i) => OrderItemRequestModel(
                  menuItemId: i.menuItemId,
                  quantity: i.quantity,
                ))
            .toList(),
        note: note,
      );
      final model = await _remoteDataSource.createOrder(request);
      return model.toEntity();
    } on DioException catch (e) {
      throw _mapDioException(e);
    } catch (e) {
      throw ServerException('Neočekávaná chyba: $e');
    }
  }

  @override
  Future<List<OrderSummary>> getCurrentOrders() async {
    try {
      final models = await _remoteDataSource.getCurrentOrders();
      return models.map((m) => m.toEntity()).toList();
    } on DioException catch (e) {
      throw _mapDioException(e);
    } catch (e) {
      throw ServerException('Neočekávaná chyba: $e');
    }
  }

  @override
  Future<String> initiatePayment(String orderId) async {
    try {
      return await _remoteDataSource.initiatePayment(orderId);
    } on DioException catch (e) {
      throw _mapDioException(e);
    } catch (e) {
      throw ServerException('Neočekávaná chyba: $e');
    }
  }

  @override
  Future<String> getPaymentStatus(String orderId) async {
    try {
      return await _remoteDataSource.getPaymentStatus(orderId);
    } on DioException catch (e) {
      throw _mapDioException(e);
    } catch (e) {
      throw ServerException('Neočekávaná chyba: $e');
    }
  }

  Exception _mapDioException(DioException e) {
    if (e.type == DioExceptionType.connectionTimeout ||
        e.type == DioExceptionType.connectionError) {
      return const ConnectionException();
    }
    final statusCode = e.response?.statusCode;
    final message = _extractErrorMessage(e);
    switch (statusCode) {
      case 400:
        return ValidationException(message);
      case 401:
        return UnauthorizedException(message);
      case 403:
        return ForbiddenException(message);
      case 404:
        return NotFoundException(message);
      case 409:
        return ConflictException(message);
      case 429:
        return RateLimitException(message);
      default:
        return ServerException(message);
    }
  }

  String _extractErrorMessage(DioException e) {
    try {
      final data = e.response?.data;
      if (data is Map<String, dynamic> && data.containsKey('message')) {
        return data['message'] as String;
      }
    } catch (_) {}
    return 'Došlo k chybě serveru.';
  }
}
