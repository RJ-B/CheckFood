import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../domain/entities/dining_context.dart';

part 'dining_context_response_model.freezed.dart';
part 'dining_context_response_model.g.dart';

@freezed
class DiningContextResponseModel with _$DiningContextResponseModel {
  const DiningContextResponseModel._();

  const factory DiningContextResponseModel({
    String? restaurantId,
    String? tableId,
    String? reservationId,
    String? sessionId,
    String? contextType,
    String? restaurantName,
    String? tableLabel,
    String? validFrom,
    String? validTo,
  }) = _DiningContextResponseModel;

  factory DiningContextResponseModel.fromJson(Map<String, dynamic> json) =>
      _$DiningContextResponseModelFromJson(json);

  DiningContext toEntity() => DiningContext(
        restaurantId: restaurantId ?? '',
        tableId: tableId ?? '',
        reservationId: reservationId,
        sessionId: sessionId,
        contextType: contextType ?? 'RESERVATION',
        restaurantName: restaurantName ?? '',
        tableLabel: tableLabel ?? '',
        validFrom: validFrom ?? '',
        validTo: validTo ?? '',
      );
}
