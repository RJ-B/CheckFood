import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:checkfood_client/modules/order/domain/entities/menu_category.dart';
import 'package:checkfood_client/modules/order/domain/entities/menu_item.dart';
import 'package:checkfood_client/modules/order/domain/repositories/orders_repository.dart';
import 'package:checkfood_client/modules/order/domain/usecases/get_menu_usecase.dart';

class _MockOrdersRepository extends Mock implements OrdersRepository {}

void main() {
  late _MockOrdersRepository repo;
  late GetMenuUseCase useCase;

  setUp(() {
    repo = _MockOrdersRepository();
    useCase = GetMenuUseCase(repo);
  });

  group('GetMenuUseCase', () {
    final tCategories = [
      MenuCategory(
        id: 'c1',
        name: 'Polévky',
        items: [
          const MenuItem(
              id: 'i1',
              name: 'Gulášová',
              priceMinor: 8000,
              currency: 'CZK',
              available: true),
        ],
      ),
    ];

    test('should return categories from repository when call succeeds', () async {
      when(() => repo.getMenu('rest-1')).thenAnswer((_) async => tCategories);

      final result = await useCase('rest-1');

      expect(result, equals(tCategories));
      verify(() => repo.getMenu('rest-1')).called(1);
    });

    test('should propagate exception from repository', () async {
      when(() => repo.getMenu(any())).thenThrow(Exception('network error'));

      expect(() => useCase('rest-1'), throwsException);
    });
  });
}
