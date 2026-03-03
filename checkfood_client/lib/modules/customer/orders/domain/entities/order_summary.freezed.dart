// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'order_summary.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$OrderSummary {
  String get id => throw _privateConstructorUsedError;
  String get status => throw _privateConstructorUsedError;
  int get totalPriceMinor => throw _privateConstructorUsedError;
  String get currency => throw _privateConstructorUsedError;
  int get itemCount => throw _privateConstructorUsedError;
  String get createdAt => throw _privateConstructorUsedError;

  /// Create a copy of OrderSummary
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $OrderSummaryCopyWith<OrderSummary> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OrderSummaryCopyWith<$Res> {
  factory $OrderSummaryCopyWith(
    OrderSummary value,
    $Res Function(OrderSummary) then,
  ) = _$OrderSummaryCopyWithImpl<$Res, OrderSummary>;
  @useResult
  $Res call({
    String id,
    String status,
    int totalPriceMinor,
    String currency,
    int itemCount,
    String createdAt,
  });
}

/// @nodoc
class _$OrderSummaryCopyWithImpl<$Res, $Val extends OrderSummary>
    implements $OrderSummaryCopyWith<$Res> {
  _$OrderSummaryCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of OrderSummary
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? status = null,
    Object? totalPriceMinor = null,
    Object? currency = null,
    Object? itemCount = null,
    Object? createdAt = null,
  }) {
    return _then(
      _value.copyWith(
            id:
                null == id
                    ? _value.id
                    : id // ignore: cast_nullable_to_non_nullable
                        as String,
            status:
                null == status
                    ? _value.status
                    : status // ignore: cast_nullable_to_non_nullable
                        as String,
            totalPriceMinor:
                null == totalPriceMinor
                    ? _value.totalPriceMinor
                    : totalPriceMinor // ignore: cast_nullable_to_non_nullable
                        as int,
            currency:
                null == currency
                    ? _value.currency
                    : currency // ignore: cast_nullable_to_non_nullable
                        as String,
            itemCount:
                null == itemCount
                    ? _value.itemCount
                    : itemCount // ignore: cast_nullable_to_non_nullable
                        as int,
            createdAt:
                null == createdAt
                    ? _value.createdAt
                    : createdAt // ignore: cast_nullable_to_non_nullable
                        as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$OrderSummaryImplCopyWith<$Res>
    implements $OrderSummaryCopyWith<$Res> {
  factory _$$OrderSummaryImplCopyWith(
    _$OrderSummaryImpl value,
    $Res Function(_$OrderSummaryImpl) then,
  ) = __$$OrderSummaryImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String status,
    int totalPriceMinor,
    String currency,
    int itemCount,
    String createdAt,
  });
}

/// @nodoc
class __$$OrderSummaryImplCopyWithImpl<$Res>
    extends _$OrderSummaryCopyWithImpl<$Res, _$OrderSummaryImpl>
    implements _$$OrderSummaryImplCopyWith<$Res> {
  __$$OrderSummaryImplCopyWithImpl(
    _$OrderSummaryImpl _value,
    $Res Function(_$OrderSummaryImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of OrderSummary
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? status = null,
    Object? totalPriceMinor = null,
    Object? currency = null,
    Object? itemCount = null,
    Object? createdAt = null,
  }) {
    return _then(
      _$OrderSummaryImpl(
        id:
            null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                    as String,
        status:
            null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                    as String,
        totalPriceMinor:
            null == totalPriceMinor
                ? _value.totalPriceMinor
                : totalPriceMinor // ignore: cast_nullable_to_non_nullable
                    as int,
        currency:
            null == currency
                ? _value.currency
                : currency // ignore: cast_nullable_to_non_nullable
                    as String,
        itemCount:
            null == itemCount
                ? _value.itemCount
                : itemCount // ignore: cast_nullable_to_non_nullable
                    as int,
        createdAt:
            null == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                    as String,
      ),
    );
  }
}

/// @nodoc

class _$OrderSummaryImpl extends _OrderSummary {
  const _$OrderSummaryImpl({
    required this.id,
    required this.status,
    required this.totalPriceMinor,
    required this.currency,
    required this.itemCount,
    required this.createdAt,
  }) : super._();

  @override
  final String id;
  @override
  final String status;
  @override
  final int totalPriceMinor;
  @override
  final String currency;
  @override
  final int itemCount;
  @override
  final String createdAt;

  @override
  String toString() {
    return 'OrderSummary(id: $id, status: $status, totalPriceMinor: $totalPriceMinor, currency: $currency, itemCount: $itemCount, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OrderSummaryImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.totalPriceMinor, totalPriceMinor) ||
                other.totalPriceMinor == totalPriceMinor) &&
            (identical(other.currency, currency) ||
                other.currency == currency) &&
            (identical(other.itemCount, itemCount) ||
                other.itemCount == itemCount) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    status,
    totalPriceMinor,
    currency,
    itemCount,
    createdAt,
  );

  /// Create a copy of OrderSummary
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$OrderSummaryImplCopyWith<_$OrderSummaryImpl> get copyWith =>
      __$$OrderSummaryImplCopyWithImpl<_$OrderSummaryImpl>(this, _$identity);
}

abstract class _OrderSummary extends OrderSummary {
  const factory _OrderSummary({
    required final String id,
    required final String status,
    required final int totalPriceMinor,
    required final String currency,
    required final int itemCount,
    required final String createdAt,
  }) = _$OrderSummaryImpl;
  const _OrderSummary._() : super._();

  @override
  String get id;
  @override
  String get status;
  @override
  int get totalPriceMinor;
  @override
  String get currency;
  @override
  int get itemCount;
  @override
  String get createdAt;

  /// Create a copy of OrderSummary
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$OrderSummaryImplCopyWith<_$OrderSummaryImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
