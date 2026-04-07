// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'order_summary_response_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

OrderSummaryResponseModel _$OrderSummaryResponseModelFromJson(
  Map<String, dynamic> json,
) {
  return _OrderSummaryResponseModel.fromJson(json);
}

/// @nodoc
mixin _$OrderSummaryResponseModel {
  String? get id => throw _privateConstructorUsedError;
  String? get status => throw _privateConstructorUsedError;
  int? get totalPriceMinor => throw _privateConstructorUsedError;
  String? get currency => throw _privateConstructorUsedError;
  int? get itemCount => throw _privateConstructorUsedError;
  String? get createdAt => throw _privateConstructorUsedError;
  String? get paymentStatus => throw _privateConstructorUsedError;

  /// Serializes this OrderSummaryResponseModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of OrderSummaryResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $OrderSummaryResponseModelCopyWith<OrderSummaryResponseModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OrderSummaryResponseModelCopyWith<$Res> {
  factory $OrderSummaryResponseModelCopyWith(
    OrderSummaryResponseModel value,
    $Res Function(OrderSummaryResponseModel) then,
  ) = _$OrderSummaryResponseModelCopyWithImpl<$Res, OrderSummaryResponseModel>;
  @useResult
  $Res call({
    String? id,
    String? status,
    int? totalPriceMinor,
    String? currency,
    int? itemCount,
    String? createdAt,
    String? paymentStatus,
  });
}

/// @nodoc
class _$OrderSummaryResponseModelCopyWithImpl<
  $Res,
  $Val extends OrderSummaryResponseModel
>
    implements $OrderSummaryResponseModelCopyWith<$Res> {
  _$OrderSummaryResponseModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of OrderSummaryResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? status = freezed,
    Object? totalPriceMinor = freezed,
    Object? currency = freezed,
    Object? itemCount = freezed,
    Object? createdAt = freezed,
    Object? paymentStatus = freezed,
  }) {
    return _then(
      _value.copyWith(
            id:
                freezed == id
                    ? _value.id
                    : id // ignore: cast_nullable_to_non_nullable
                        as String?,
            status:
                freezed == status
                    ? _value.status
                    : status // ignore: cast_nullable_to_non_nullable
                        as String?,
            totalPriceMinor:
                freezed == totalPriceMinor
                    ? _value.totalPriceMinor
                    : totalPriceMinor // ignore: cast_nullable_to_non_nullable
                        as int?,
            currency:
                freezed == currency
                    ? _value.currency
                    : currency // ignore: cast_nullable_to_non_nullable
                        as String?,
            itemCount:
                freezed == itemCount
                    ? _value.itemCount
                    : itemCount // ignore: cast_nullable_to_non_nullable
                        as int?,
            createdAt:
                freezed == createdAt
                    ? _value.createdAt
                    : createdAt // ignore: cast_nullable_to_non_nullable
                        as String?,
            paymentStatus:
                freezed == paymentStatus
                    ? _value.paymentStatus
                    : paymentStatus // ignore: cast_nullable_to_non_nullable
                        as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$OrderSummaryResponseModelImplCopyWith<$Res>
    implements $OrderSummaryResponseModelCopyWith<$Res> {
  factory _$$OrderSummaryResponseModelImplCopyWith(
    _$OrderSummaryResponseModelImpl value,
    $Res Function(_$OrderSummaryResponseModelImpl) then,
  ) = __$$OrderSummaryResponseModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String? id,
    String? status,
    int? totalPriceMinor,
    String? currency,
    int? itemCount,
    String? createdAt,
    String? paymentStatus,
  });
}

/// @nodoc
class __$$OrderSummaryResponseModelImplCopyWithImpl<$Res>
    extends
        _$OrderSummaryResponseModelCopyWithImpl<
          $Res,
          _$OrderSummaryResponseModelImpl
        >
    implements _$$OrderSummaryResponseModelImplCopyWith<$Res> {
  __$$OrderSummaryResponseModelImplCopyWithImpl(
    _$OrderSummaryResponseModelImpl _value,
    $Res Function(_$OrderSummaryResponseModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of OrderSummaryResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? status = freezed,
    Object? totalPriceMinor = freezed,
    Object? currency = freezed,
    Object? itemCount = freezed,
    Object? createdAt = freezed,
    Object? paymentStatus = freezed,
  }) {
    return _then(
      _$OrderSummaryResponseModelImpl(
        id:
            freezed == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                    as String?,
        status:
            freezed == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                    as String?,
        totalPriceMinor:
            freezed == totalPriceMinor
                ? _value.totalPriceMinor
                : totalPriceMinor // ignore: cast_nullable_to_non_nullable
                    as int?,
        currency:
            freezed == currency
                ? _value.currency
                : currency // ignore: cast_nullable_to_non_nullable
                    as String?,
        itemCount:
            freezed == itemCount
                ? _value.itemCount
                : itemCount // ignore: cast_nullable_to_non_nullable
                    as int?,
        createdAt:
            freezed == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                    as String?,
        paymentStatus:
            freezed == paymentStatus
                ? _value.paymentStatus
                : paymentStatus // ignore: cast_nullable_to_non_nullable
                    as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$OrderSummaryResponseModelImpl extends _OrderSummaryResponseModel {
  const _$OrderSummaryResponseModelImpl({
    this.id,
    this.status,
    this.totalPriceMinor,
    this.currency,
    this.itemCount,
    this.createdAt,
    this.paymentStatus,
  }) : super._();

  factory _$OrderSummaryResponseModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$OrderSummaryResponseModelImplFromJson(json);

  @override
  final String? id;
  @override
  final String? status;
  @override
  final int? totalPriceMinor;
  @override
  final String? currency;
  @override
  final int? itemCount;
  @override
  final String? createdAt;
  @override
  final String? paymentStatus;

  @override
  String toString() {
    return 'OrderSummaryResponseModel(id: $id, status: $status, totalPriceMinor: $totalPriceMinor, currency: $currency, itemCount: $itemCount, createdAt: $createdAt, paymentStatus: $paymentStatus)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OrderSummaryResponseModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.totalPriceMinor, totalPriceMinor) ||
                other.totalPriceMinor == totalPriceMinor) &&
            (identical(other.currency, currency) ||
                other.currency == currency) &&
            (identical(other.itemCount, itemCount) ||
                other.itemCount == itemCount) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.paymentStatus, paymentStatus) ||
                other.paymentStatus == paymentStatus));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    status,
    totalPriceMinor,
    currency,
    itemCount,
    createdAt,
    paymentStatus,
  );

  /// Create a copy of OrderSummaryResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$OrderSummaryResponseModelImplCopyWith<_$OrderSummaryResponseModelImpl>
  get copyWith => __$$OrderSummaryResponseModelImplCopyWithImpl<
    _$OrderSummaryResponseModelImpl
  >(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$OrderSummaryResponseModelImplToJson(this);
  }
}

abstract class _OrderSummaryResponseModel extends OrderSummaryResponseModel {
  const factory _OrderSummaryResponseModel({
    final String? id,
    final String? status,
    final int? totalPriceMinor,
    final String? currency,
    final int? itemCount,
    final String? createdAt,
    final String? paymentStatus,
  }) = _$OrderSummaryResponseModelImpl;
  const _OrderSummaryResponseModel._() : super._();

  factory _OrderSummaryResponseModel.fromJson(Map<String, dynamic> json) =
      _$OrderSummaryResponseModelImpl.fromJson;

  @override
  String? get id;
  @override
  String? get status;
  @override
  int? get totalPriceMinor;
  @override
  String? get currency;
  @override
  int? get itemCount;
  @override
  String? get createdAt;
  @override
  String? get paymentStatus;

  /// Create a copy of OrderSummaryResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$OrderSummaryResponseModelImplCopyWith<_$OrderSummaryResponseModelImpl>
  get copyWith => throw _privateConstructorUsedError;
}
