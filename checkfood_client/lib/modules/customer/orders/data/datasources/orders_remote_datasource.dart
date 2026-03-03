import 'package:dio/dio.dart';
import '../models/request/create_order_request_model.dart';
import '../models/response/dining_context_response_model.dart';
import '../models/response/menu_category_response_model.dart';
import '../models/response/order_summary_response_model.dart';

// ===== ABSTRACT INTERFACE =====

abstract class OrdersRemoteDataSource {
  Future<DiningContextResponseModel> getDiningContext();

  Future<List<MenuCategoryResponseModel>> getMenu(String restaurantId);

  Future<OrderSummaryResponseModel> createOrder(
      CreateOrderRequestModel request);

  Future<List<OrderSummaryResponseModel>> getCurrentOrders();
}

// ===== IMPLEMENTATION =====

class OrdersRemoteDataSourceImpl implements OrdersRemoteDataSource {
  final Dio _dio;

  static const String _diningContextBase = '/v1/dining-context';
  static const String _restaurantsBase = '/v1/restaurants';
  static const String _ordersBase = '/v1/orders';

  OrdersRemoteDataSourceImpl(this._dio);

  @override
  Future<DiningContextResponseModel> getDiningContext() async {
    final response = await _dio.get('$_diningContextBase/me');
    return DiningContextResponseModel.fromJson(
      response.data as Map<String, dynamic>,
    );
  }

  @override
  Future<List<MenuCategoryResponseModel>> getMenu(String restaurantId) async {
    final response = await _dio.get('$_restaurantsBase/$restaurantId/menu');
    return (response.data as List)
        .map((json) =>
            MenuCategoryResponseModel.fromJson(json as Map<String, dynamic>))
        .toList();
  }

  @override
  Future<OrderSummaryResponseModel> createOrder(
      CreateOrderRequestModel request) async {
    final response = await _dio.post(
      _ordersBase,
      data: request.toJson(),
    );
    return OrderSummaryResponseModel.fromJson(
      response.data as Map<String, dynamic>,
    );
  }

  @override
  Future<List<OrderSummaryResponseModel>> getCurrentOrders() async {
    final response = await _dio.get('$_ordersBase/me/current');
    return (response.data as List)
        .map((json) =>
            OrderSummaryResponseModel.fromJson(json as Map<String, dynamic>))
        .toList();
  }
}
