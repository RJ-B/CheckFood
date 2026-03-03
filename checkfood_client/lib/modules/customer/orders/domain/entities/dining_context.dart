import 'package:freezed_annotation/freezed_annotation.dart';

part 'dining_context.freezed.dart';

@freezed
class DiningContext with _$DiningContext {
  const DiningContext._();

  const factory DiningContext({
    required String restaurantId,
    required String tableId,
    String? reservationId,
    String? sessionId,
    required String contextType,
    required String restaurantName,
    required String tableLabel,
    required String validFrom,
    required String validTo,
  }) = _DiningContext;
}
