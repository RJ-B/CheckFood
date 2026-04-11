import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:checkfood_client/modules/order/domain/repositories/orders_repository.dart';
import 'package:checkfood_client/modules/order/domain/usecases/get_payment_status_usecase.dart';

class _MockOrdersRepository extends Mock implements OrdersRepository {}

void main() {
  late _MockOrdersRepository repo;
  late GetPaymentStatusUseCase useCase;

  setUp(() {
    repo = _MockOrdersRepository();
    useCase = GetPaymentStatusUseCase(repo);
  });

  group('GetPaymentStatusUseCase', () {
    test('should return payment status string from repository', () async {
      when(() => repo.getPaymentStatus('ord-1')).thenAnswer((_) async => 'PAID');

      final result = await useCase('ord-1');

      expect(result, equals('PAID'));
      verify(() => repo.getPaymentStatus('ord-1')).called(1);
    });

    test('should return FAILED status correctly', () async {
      when(() => repo.getPaymentStatus(any())).thenAnswer((_) async => 'FAILED');

      final result = await useCase('ord-2');

      expect(result, equals('FAILED'));
    });

    test('should propagate exception from repository', () async {
      when(() => repo.getPaymentStatus(any())).thenThrow(Exception('error'));

      expect(() => useCase('ord-1'), throwsException);
    });
  });
}
