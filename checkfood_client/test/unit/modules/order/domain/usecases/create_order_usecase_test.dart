import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:checkfood_client/modules/order/domain/entities/order_summary.dart';
import 'package:checkfood_client/modules/order/domain/repositories/orders_repository.dart';
import 'package:checkfood_client/modules/order/domain/usecases/create_order_usecase.dart';

class _MockOrdersRepository extends Mock implements OrdersRepository {}

void main() {
  late _MockOrdersRepository repo;
  late CreateOrderUseCase useCase;

  setUp(() {
    repo = _MockOrdersRepository();
    useCase = CreateOrderUseCase(repo);
  });

  setUpAll(() {
    registerFallbackValue(<({String menuItemId, int quantity})>[]);
  });

  group('CreateOrderUseCase', () {
    const tOrder = OrderSummary(
      id: 'ord-1',
      status: 'PENDING',
      totalPriceMinor: 25000,
      currency: 'CZK',
      itemCount: 1,
      createdAt: '2026-01-01T12:00:00Z',
    );

    test('should return created order from repository', () async {
      when(() => repo.createOrder(items: any(named: 'items'), note: any(named: 'note')))
          .thenAnswer((_) async => tOrder);

      final result = await useCase(
        items: [(menuItemId: 'item-1', quantity: 2)],
        note: 'bez cibule',
      );

      expect(result, equals(tOrder));
      verify(
        () => repo.createOrder(
          items: any(named: 'items'),
          note: 'bez cibule',
        ),
      ).called(1);
    });

    test('should forward null note to repository', () async {
      when(() => repo.createOrder(items: any(named: 'items'), note: any(named: 'note')))
          .thenAnswer((_) async => tOrder);

      await useCase(items: [(menuItemId: 'item-1', quantity: 1)]);

      verify(
        () => repo.createOrder(items: any(named: 'items'), note: null),
      ).called(1);
    });

    test('should propagate exception from repository', () async {
      when(() => repo.createOrder(items: any(named: 'items'), note: any(named: 'note')))
          .thenThrow(Exception('error'));

      expect(
        () => useCase(items: [(menuItemId: 'item-1', quantity: 1)]),
        throwsException,
      );
    });
  });
}
