import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:checkfood_client/modules/order/domain/repositories/orders_repository.dart';
import 'package:checkfood_client/modules/order/domain/usecases/initiate_payment_usecase.dart';

class _MockOrdersRepository extends Mock implements OrdersRepository {}

void main() {
  late _MockOrdersRepository repo;
  late InitiatePaymentUseCase useCase;

  setUp(() {
    repo = _MockOrdersRepository();
    useCase = InitiatePaymentUseCase(repo);
  });

  group('InitiatePaymentUseCase', () {
    test('should return redirect URL from repository', () async {
      when(() => repo.initiatePayment('ord-1'))
          .thenAnswer((_) async => 'https://pay.example.com/ord-1');

      final result = await useCase('ord-1');

      expect(result, equals('https://pay.example.com/ord-1'));
      verify(() => repo.initiatePayment('ord-1')).called(1);
    });

    test('should propagate exception from repository', () async {
      when(() => repo.initiatePayment(any())).thenThrow(Exception('payment error'));

      expect(() => useCase('ord-1'), throwsException);
    });
  });
}
