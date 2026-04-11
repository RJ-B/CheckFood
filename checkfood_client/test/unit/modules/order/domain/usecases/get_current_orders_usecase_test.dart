import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:checkfood_client/modules/order/domain/entities/order_summary.dart';
import 'package:checkfood_client/modules/order/domain/repositories/orders_repository.dart';
import 'package:checkfood_client/modules/order/domain/usecases/get_current_orders_usecase.dart';

class _MockOrdersRepository extends Mock implements OrdersRepository {}

void main() {
  late _MockOrdersRepository repo;
  late GetCurrentOrdersUseCase useCase;

  setUp(() {
    repo = _MockOrdersRepository();
    useCase = GetCurrentOrdersUseCase(repo);
  });

  group('GetCurrentOrdersUseCase', () {
    final tOrders = [
      const OrderSummary(
        id: 'ord-1',
        status: 'PENDING',
        totalPriceMinor: 25000,
        currency: 'CZK',
        itemCount: 1,
        createdAt: '2026-01-01T12:00:00Z',
      ),
    ];

    test('should return order list when repository succeeds', () async {
      when(() => repo.getCurrentOrders()).thenAnswer((_) async => tOrders);

      final result = await useCase();

      expect(result, equals(tOrders));
      verify(() => repo.getCurrentOrders()).called(1);
    });

    test('should return empty list when no active orders', () async {
      when(() => repo.getCurrentOrders()).thenAnswer((_) async => []);

      final result = await useCase();

      expect(result, isEmpty);
    });

    test('should propagate exception from repository', () async {
      when(() => repo.getCurrentOrders()).thenThrow(Exception('error'));

      expect(() => useCase(), throwsException);
    });
  });
}
