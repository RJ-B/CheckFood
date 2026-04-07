// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'session_order_item.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$SessionOrderItem {
  String get id => throw _privateConstructorUsedError;
  String get orderId => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  int get unitPriceMinor => throw _privateConstructorUsedError;
  int get quantity => throw _privateConstructorUsedError;
  int? get orderedByUserId => throw _privateConstructorUsedError;
  String? get orderedByName => throw _privateConstructorUsedError;
  int? get paidByUserId => throw _privateConstructorUsedError;
  String? get paidByName => throw _privateConstructorUsedError;
  String get paymentStatus => throw _privateConstructorUsedError;

  /// Create a copy of SessionOrderItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SessionOrderItemCopyWith<SessionOrderItem> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SessionOrderItemCopyWith<$Res> {
  factory $SessionOrderItemCopyWith(
    SessionOrderItem value,
    $Res Function(SessionOrderItem) then,
  ) = _$SessionOrderItemCopyWithImpl<$Res, SessionOrderItem>;
  @useResult
  $Res call({
    String id,
    String orderId,
    String name,
    int unitPriceMinor,
    int quantity,
    int? orderedByUserId,
    String? orderedByName,
    int? paidByUserId,
    String? paidByName,
    String paymentStatus,
  });
}

/// @nodoc
class _$SessionOrderItemCopyWithImpl<$Res, $Val extends SessionOrderItem>
    implements $SessionOrderItemCopyWith<$Res> {
  _$SessionOrderItemCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SessionOrderItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? orderId = null,
    Object? name = null,
    Object? unitPriceMinor = null,
    Object? quantity = null,
    Object? orderedByUserId = freezed,
    Object? orderedByName = freezed,
    Object? paidByUserId = freezed,
    Object? paidByName = freezed,
    Object? paymentStatus = null,
  }) {
    return _then(
      _value.copyWith(
            id:
                null == id
                    ? _value.id
                    : id // ignore: cast_nullable_to_non_nullable
                        as String,
            orderId:
                null == orderId
                    ? _value.orderId
                    : orderId // ignore: cast_nullable_to_non_nullable
                        as String,
            name:
                null == name
                    ? _value.name
                    : name // ignore: cast_nullable_to_non_nullable
                        as String,
            unitPriceMinor:
                null == unitPriceMinor
                    ? _value.unitPriceMinor
                    : unitPriceMinor // ignore: cast_nullable_to_non_nullable
                        as int,
            quantity:
                null == quantity
                    ? _value.quantity
                    : quantity // ignore: cast_nullable_to_non_nullable
                        as int,
            orderedByUserId:
                freezed == orderedByUserId
                    ? _value.orderedByUserId
                    : orderedByUserId // ignore: cast_nullable_to_non_nullable
                        as int?,
            orderedByName:
                freezed == orderedByName
                    ? _value.orderedByName
                    : orderedByName // ignore: cast_nullable_to_non_nullable
                        as String?,
            paidByUserId:
                freezed == paidByUserId
                    ? _value.paidByUserId
                    : paidByUserId // ignore: cast_nullable_to_non_nullable
                        as int?,
            paidByName:
                freezed == paidByName
                    ? _value.paidByName
                    : paidByName // ignore: cast_nullable_to_non_nullable
                        as String?,
            paymentStatus:
                null == paymentStatus
                    ? _value.paymentStatus
                    : paymentStatus // ignore: cast_nullable_to_non_nullable
                        as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$SessionOrderItemImplCopyWith<$Res>
    implements $SessionOrderItemCopyWith<$Res> {
  factory _$$SessionOrderItemImplCopyWith(
    _$SessionOrderItemImpl value,
    $Res Function(_$SessionOrderItemImpl) then,
  ) = __$$SessionOrderItemImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String orderId,
    String name,
    int unitPriceMinor,
    int quantity,
    int? orderedByUserId,
    String? orderedByName,
    int? paidByUserId,
    String? paidByName,
    String paymentStatus,
  });
}

/// @nodoc
class __$$SessionOrderItemImplCopyWithImpl<$Res>
    extends _$SessionOrderItemCopyWithImpl<$Res, _$SessionOrderItemImpl>
    implements _$$SessionOrderItemImplCopyWith<$Res> {
  __$$SessionOrderItemImplCopyWithImpl(
    _$SessionOrderItemImpl _value,
    $Res Function(_$SessionOrderItemImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of SessionOrderItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? orderId = null,
    Object? name = null,
    Object? unitPriceMinor = null,
    Object? quantity = null,
    Object? orderedByUserId = freezed,
    Object? orderedByName = freezed,
    Object? paidByUserId = freezed,
    Object? paidByName = freezed,
    Object? paymentStatus = null,
  }) {
    return _then(
      _$SessionOrderItemImpl(
        id:
            null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                    as String,
        orderId:
            null == orderId
                ? _value.orderId
                : orderId // ignore: cast_nullable_to_non_nullable
                    as String,
        name:
            null == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                    as String,
        unitPriceMinor:
            null == unitPriceMinor
                ? _value.unitPriceMinor
                : unitPriceMinor // ignore: cast_nullable_to_non_nullable
                    as int,
        quantity:
            null == quantity
                ? _value.quantity
                : quantity // ignore: cast_nullable_to_non_nullable
                    as int,
        orderedByUserId:
            freezed == orderedByUserId
                ? _value.orderedByUserId
                : orderedByUserId // ignore: cast_nullable_to_non_nullable
                    as int?,
        orderedByName:
            freezed == orderedByName
                ? _value.orderedByName
                : orderedByName // ignore: cast_nullable_to_non_nullable
                    as String?,
        paidByUserId:
            freezed == paidByUserId
                ? _value.paidByUserId
                : paidByUserId // ignore: cast_nullable_to_non_nullable
                    as int?,
        paidByName:
            freezed == paidByName
                ? _value.paidByName
                : paidByName // ignore: cast_nullable_to_non_nullable
                    as String?,
        paymentStatus:
            null == paymentStatus
                ? _value.paymentStatus
                : paymentStatus // ignore: cast_nullable_to_non_nullable
                    as String,
      ),
    );
  }
}

/// @nodoc

class _$SessionOrderItemImpl extends _SessionOrderItem {
  const _$SessionOrderItemImpl({
    required this.id,
    required this.orderId,
    required this.name,
    required this.unitPriceMinor,
    required this.quantity,
    this.orderedByUserId,
    this.orderedByName,
    this.paidByUserId,
    this.paidByName,
    this.paymentStatus = 'UNPAID',
  }) : super._();

  @override
  final String id;
  @override
  final String orderId;
  @override
  final String name;
  @override
  final int unitPriceMinor;
  @override
  final int quantity;
  @override
  final int? orderedByUserId;
  @override
  final String? orderedByName;
  @override
  final int? paidByUserId;
  @override
  final String? paidByName;
  @override
  @JsonKey()
  final String paymentStatus;

  @override
  String toString() {
    return 'SessionOrderItem(id: $id, orderId: $orderId, name: $name, unitPriceMinor: $unitPriceMinor, quantity: $quantity, orderedByUserId: $orderedByUserId, orderedByName: $orderedByName, paidByUserId: $paidByUserId, paidByName: $paidByName, paymentStatus: $paymentStatus)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SessionOrderItemImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.orderId, orderId) || other.orderId == orderId) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.unitPriceMinor, unitPriceMinor) ||
                other.unitPriceMinor == unitPriceMinor) &&
            (identical(other.quantity, quantity) ||
                other.quantity == quantity) &&
            (identical(other.orderedByUserId, orderedByUserId) ||
                other.orderedByUserId == orderedByUserId) &&
            (identical(other.orderedByName, orderedByName) ||
                other.orderedByName == orderedByName) &&
            (identical(other.paidByUserId, paidByUserId) ||
                other.paidByUserId == paidByUserId) &&
            (identical(other.paidByName, paidByName) ||
                other.paidByName == paidByName) &&
            (identical(other.paymentStatus, paymentStatus) ||
                other.paymentStatus == paymentStatus));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    orderId,
    name,
    unitPriceMinor,
    quantity,
    orderedByUserId,
    orderedByName,
    paidByUserId,
    paidByName,
    paymentStatus,
  );

  /// Create a copy of SessionOrderItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SessionOrderItemImplCopyWith<_$SessionOrderItemImpl> get copyWith =>
      __$$SessionOrderItemImplCopyWithImpl<_$SessionOrderItemImpl>(
        this,
        _$identity,
      );
}

abstract class _SessionOrderItem extends SessionOrderItem {
  const factory _SessionOrderItem({
    required final String id,
    required final String orderId,
    required final String name,
    required final int unitPriceMinor,
    required final int quantity,
    final int? orderedByUserId,
    final String? orderedByName,
    final int? paidByUserId,
    final String? paidByName,
    final String paymentStatus,
  }) = _$SessionOrderItemImpl;
  const _SessionOrderItem._() : super._();

  @override
  String get id;
  @override
  String get orderId;
  @override
  String get name;
  @override
  int get unitPriceMinor;
  @override
  int get quantity;
  @override
  int? get orderedByUserId;
  @override
  String? get orderedByName;
  @override
  int? get paidByUserId;
  @override
  String? get paidByName;
  @override
  String get paymentStatus;

  /// Create a copy of SessionOrderItem
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SessionOrderItemImplCopyWith<_$SessionOrderItemImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
