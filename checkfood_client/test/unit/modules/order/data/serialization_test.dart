import 'package:flutter_test/flutter_test.dart';
import 'package:checkfood_client/modules/order/data/models/response/dining_context_response_model.dart';
import 'package:checkfood_client/modules/order/data/models/response/menu_category_response_model.dart';
import 'package:checkfood_client/modules/order/data/models/response/menu_item_response_model.dart';
import 'package:checkfood_client/modules/order/data/models/response/order_summary_response_model.dart';
import 'package:checkfood_client/modules/order/data/models/request/create_order_request_model.dart';
import 'package:checkfood_client/modules/order/data/models/request/order_item_request_model.dart';

void main() {
  group('DiningContextResponseModel', () {
    final json = {
      'restaurantId': 'rest-1',
      'tableId': 'table-1',
      'reservationId': 'res-1',
      'sessionId': null,
      'contextType': 'RESERVATION',
      'restaurantName': 'Test Restaurant',
      'tableLabel': 'Stůl 1',
      'validFrom': '2026-01-01T10:00:00Z',
      'validTo': '2026-01-01T23:00:00Z',
    };

    test('fromJson round-trip', () {
      final model = DiningContextResponseModel.fromJson(json);
      expect(model.restaurantId, 'rest-1');
      expect(model.tableId, 'table-1');
      expect(model.reservationId, 'res-1');
      expect(model.sessionId, isNull);
      expect(model.contextType, 'RESERVATION');
    });

    test('toJson produces correct keys', () {
      final model = DiningContextResponseModel.fromJson(json);
      final out = model.toJson();
      expect(out['restaurantId'], 'rest-1');
      expect(out['tableLabel'], 'Stůl 1');
    });

    test('toEntity maps to domain DiningContext correctly', () {
      final model = DiningContextResponseModel.fromJson(json);
      final entity = model.toEntity();
      expect(entity.restaurantId, 'rest-1');
      expect(entity.restaurantName, 'Test Restaurant');
      expect(entity.tableLabel, 'Stůl 1');
    });

    test('toEntity uses empty strings for null fields', () {
      final model = const DiningContextResponseModel();
      final entity = model.toEntity();
      expect(entity.restaurantId, '');
      expect(entity.contextType, 'RESERVATION');
    });
  });

  group('MenuItemResponseModel', () {
    final json = {
      'id': 'item-1',
      'name': 'Svíčková',
      'description': 'Klasická česká',
      'priceMinor': 25000,
      'currency': 'CZK',
      'imageUrl': null,
      'available': true,
    };

    test('fromJson round-trip', () {
      final model = MenuItemResponseModel.fromJson(json);
      expect(model.id, 'item-1');
      expect(model.priceMinor, 25000);
      expect(model.available, isTrue);
    });

    test('toJson preserves values', () {
      final model = MenuItemResponseModel.fromJson(json);
      final out = model.toJson();
      expect(out['priceMinor'], 25000);
      expect(out['currency'], 'CZK');
    });

    test('toEntity maps price and availability', () {
      final model = MenuItemResponseModel.fromJson(json);
      final entity = model.toEntity();
      expect(entity.priceMinor, 25000);
      expect(entity.available, isTrue);
      expect(entity.formattedPrice, '250 Kč');
    });

    test('toEntity defaults currency to CZK when null', () {
      final model = const MenuItemResponseModel(id: 'x', name: 'X', priceMinor: 100);
      expect(model.toEntity().currency, 'CZK');
    });
  });

  group('MenuCategoryResponseModel', () {
    final json = {
      'id': 'cat-1',
      'name': 'Hlavní jídla',
      'items': [
        {
          'id': 'item-1',
          'name': 'Svíčková',
          'priceMinor': 25000,
          'currency': 'CZK',
          'available': true,
        }
      ],
    };

    test('fromJson round-trip', () {
      final model = MenuCategoryResponseModel.fromJson(json);
      expect(model.id, 'cat-1');
      expect(model.items.length, 1);
      expect(model.items.first.name, 'Svíčková');
    });

    test('toEntity maps nested items', () {
      final model = MenuCategoryResponseModel.fromJson(json);
      final entity = model.toEntity();
      expect(entity.items.length, 1);
      expect(entity.items.first.id, 'item-1');
    });

    test('toEntity with empty items list', () {
      final model = const MenuCategoryResponseModel(id: 'c', name: 'C');
      expect(model.toEntity().items, isEmpty);
    });
  });

  group('OrderSummaryResponseModel', () {
    final json = {
      'id': 'ord-1',
      'status': 'PENDING',
      'totalPriceMinor': 25000,
      'currency': 'CZK',
      'itemCount': 1,
      'createdAt': '2026-01-01T12:00:00Z',
      'paymentStatus': null,
    };

    test('fromJson round-trip', () {
      final model = OrderSummaryResponseModel.fromJson(json);
      expect(model.id, 'ord-1');
      expect(model.status, 'PENDING');
      expect(model.totalPriceMinor, 25000);
    });

    test('toEntity maps status label', () {
      final model = OrderSummaryResponseModel.fromJson(json);
      final entity = model.toEntity();
      expect(entity.statusLabel, 'Čeká na potvrzení');
      expect(entity.formattedTotal, '250 Kč');
    });

    test('toEntity defaults status to PENDING when null', () {
      final model = const OrderSummaryResponseModel();
      expect(model.toEntity().status, 'PENDING');
    });
  });

  group('CreateOrderRequestModel', () {
    test('toJson serialises items correctly', () {
      const model = CreateOrderRequestModel(
        items: [
          OrderItemRequestModel(menuItemId: 'item-1', quantity: 2),
        ],
        note: 'bez cibule',
      );

      final json = model.toJson();
      expect(json['note'], 'bez cibule');
      final items = json['items'] as List;
      expect(items.length, 1);
      // json_serializable without explicitToJson:true stores nested freezed
      // objects as their Dart instances in the items list.
      // Use the nested model's own toJson to verify field values.
      final firstItemJson =
          (items.first as OrderItemRequestModel).toJson();
      expect(firstItemJson['menuItemId'], 'item-1');
      expect(firstItemJson['quantity'], 2);
    });

    test('toJson with null note omits or nulls note', () {
      const model = CreateOrderRequestModel(
        items: [OrderItemRequestModel(menuItemId: 'x', quantity: 1)],
      );
      final json = model.toJson();
      // null note should either be absent or null
      expect(json['note'], isNull);
    });
  });
}
