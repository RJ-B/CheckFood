import 'package:dio/dio.dart';
import '../models/request/create_order_request_model.dart';
import '../models/response/dining_context_response_model.dart';
import '../models/response/menu_category_response_model.dart';
import '../models/response/order_summary_response_model.dart';

/// Kontrakt vzdáleného datového zdroje pro modul objednávek.
abstract class OrdersRemoteDataSource {
  Future<DiningContextResponseModel> getDiningContext();

  Future<List<MenuCategoryResponseModel>> getMenu(String restaurantId);

  Future<OrderSummaryResponseModel> createOrder(
      CreateOrderRequestModel request);

  Future<List<OrderSummaryResponseModel>> getCurrentOrders();

  Future<String> initiatePayment(String orderId);

  Future<String> getPaymentStatus(String orderId);

  Future<Map<String, dynamic>> joinSession(String inviteCode);
  Future<Map<String, dynamic>> getMySession();
  Future<List<Map<String, dynamic>>> getSessionOrders(String sessionId);
  Future<Map<String, dynamic>> getPaymentSummary(String sessionId);
  Future<Map<String, dynamic>> payItems(List<String> itemIds);
  Future<Map<String, dynamic>> getSessionQr(String sessionId);
}

/// Implementace [OrdersRemoteDataSource] využívající Dio.
class OrdersRemoteDataSourceImpl implements OrdersRemoteDataSource {
  final Dio _dio;

  static const String _diningContextBase = '/v1/dining-context';
  static const String _restaurantsBase = '/v1/restaurants';
  static const String _ordersBase = '/v1/orders';
  static const String _sessionsBase = '/v1/sessions';

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

  @override
  Future<String> initiatePayment(String orderId) async {
    final response = await _dio.post('$_ordersBase/$orderId/pay');
    final data = response.data as Map<String, dynamic>;
    return data['redirectUrl'] as String;
  }

  @override
  Future<String> getPaymentStatus(String orderId) async {
    final response = await _dio.get('$_ordersBase/$orderId/payment-status');
    final data = response.data as Map<String, dynamic>;
    return data['paymentStatus'] as String;
  }

  @override
  Future<Map<String, dynamic>> joinSession(String inviteCode) async {
    final response = await _dio.post(
      '$_sessionsBase/join',
      data: {'inviteCode': inviteCode},
    );
    return response.data as Map<String, dynamic>;
  }

  @override
  Future<Map<String, dynamic>> getMySession() async {
    final response = await _dio.get('$_sessionsBase/me');
    return response.data as Map<String, dynamic>;
  }

  @override
  Future<List<Map<String, dynamic>>> getSessionOrders(String sessionId) async {
    final response = await _dio.get('$_sessionsBase/$sessionId/orders');
    return (response.data as List)
        .map((e) => e as Map<String, dynamic>)
        .toList();
  }

  @override
  Future<Map<String, dynamic>> getPaymentSummary(String sessionId) async {
    final response =
        await _dio.get('$_sessionsBase/$sessionId/payment-summary');
    return response.data as Map<String, dynamic>;
  }

  @override
  Future<Map<String, dynamic>> payItems(List<String> itemIds) async {
    final response = await _dio.post(
      '$_ordersBase/pay-items',
      data: {'itemIds': itemIds},
    );
    return response.data as Map<String, dynamic>;
  }

  @override
  Future<Map<String, dynamic>> getSessionQr(String sessionId) async {
    final response = await _dio.get('$_sessionsBase/$sessionId/qr');
    return response.data as Map<String, dynamic>;
  }
}
