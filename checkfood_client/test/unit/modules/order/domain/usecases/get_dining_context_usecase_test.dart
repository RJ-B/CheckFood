import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:checkfood_client/modules/order/domain/entities/dining_context.dart';
import 'package:checkfood_client/modules/order/domain/repositories/orders_repository.dart';
import 'package:checkfood_client/modules/order/domain/usecases/get_dining_context_usecase.dart';

class _MockOrdersRepository extends Mock implements OrdersRepository {}

const _kContext = DiningContext(
  restaurantId: 'rest-1',
  tableId: 'table-1',
  contextType: 'RESERVATION',
  restaurantName: 'Test',
  tableLabel: 'T1',
  validFrom: '2026-01-01T10:00:00Z',
  validTo: '2026-01-01T22:00:00Z',
);

void main() {
  late _MockOrdersRepository repo;
  late GetDiningContextUseCase useCase;

  setUp(() {
    repo = _MockOrdersRepository();
    useCase = GetDiningContextUseCase(repo);
  });

  group('GetDiningContextUseCase', () {
    test('should return context from repository when call succeeds', () async {
      when(() => repo.getDiningContext()).thenAnswer((_) async => _kContext);

      final result = await useCase();

      expect(result, equals(_kContext));
      verify(() => repo.getDiningContext()).called(1);
    });

    test('should propagate exception from repository', () async {
      when(() => repo.getDiningContext()).thenThrow(Exception('error'));

      expect(() => useCase(), throwsException);
    });
  });
}
