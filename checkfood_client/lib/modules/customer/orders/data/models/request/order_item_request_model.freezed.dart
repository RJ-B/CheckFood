// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'order_item_request_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

OrderItemRequestModel _$OrderItemRequestModelFromJson(
  Map<String, dynamic> json,
) {
  return _OrderItemRequestModel.fromJson(json);
}

/// @nodoc
mixin _$OrderItemRequestModel {
  String get menuItemId => throw _privateConstructorUsedError;
  int get quantity => throw _privateConstructorUsedError;

  /// Serializes this OrderItemRequestModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of OrderItemRequestModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $OrderItemRequestModelCopyWith<OrderItemRequestModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OrderItemRequestModelCopyWith<$Res> {
  factory $OrderItemRequestModelCopyWith(
    OrderItemRequestModel value,
    $Res Function(OrderItemRequestModel) then,
  ) = _$OrderItemRequestModelCopyWithImpl<$Res, OrderItemRequestModel>;
  @useResult
  $Res call({String menuItemId, int quantity});
}

/// @nodoc
class _$OrderItemRequestModelCopyWithImpl<
  $Res,
  $Val extends OrderItemRequestModel
>
    implements $OrderItemRequestModelCopyWith<$Res> {
  _$OrderItemRequestModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of OrderItemRequestModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? menuItemId = null, Object? quantity = null}) {
    return _then(
      _value.copyWith(
            menuItemId:
                null == menuItemId
                    ? _value.menuItemId
                    : menuItemId // ignore: cast_nullable_to_non_nullable
                        as String,
            quantity:
                null == quantity
                    ? _value.quantity
                    : quantity // ignore: cast_nullable_to_non_nullable
                        as int,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$OrderItemRequestModelImplCopyWith<$Res>
    implements $OrderItemRequestModelCopyWith<$Res> {
  factory _$$OrderItemRequestModelImplCopyWith(
    _$OrderItemRequestModelImpl value,
    $Res Function(_$OrderItemRequestModelImpl) then,
  ) = __$$OrderItemRequestModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String menuItemId, int quantity});
}

/// @nodoc
class __$$OrderItemRequestModelImplCopyWithImpl<$Res>
    extends
        _$OrderItemRequestModelCopyWithImpl<$Res, _$OrderItemRequestModelImpl>
    implements _$$OrderItemRequestModelImplCopyWith<$Res> {
  __$$OrderItemRequestModelImplCopyWithImpl(
    _$OrderItemRequestModelImpl _value,
    $Res Function(_$OrderItemRequestModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of OrderItemRequestModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? menuItemId = null, Object? quantity = null}) {
    return _then(
      _$OrderItemRequestModelImpl(
        menuItemId:
            null == menuItemId
                ? _value.menuItemId
                : menuItemId // ignore: cast_nullable_to_non_nullable
                    as String,
        quantity:
            null == quantity
                ? _value.quantity
                : quantity // ignore: cast_nullable_to_non_nullable
                    as int,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$OrderItemRequestModelImpl implements _OrderItemRequestModel {
  const _$OrderItemRequestModelImpl({
    required this.menuItemId,
    required this.quantity,
  });

  factory _$OrderItemRequestModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$OrderItemRequestModelImplFromJson(json);

  @override
  final String menuItemId;
  @override
  final int quantity;

  @override
  String toString() {
    return 'OrderItemRequestModel(menuItemId: $menuItemId, quantity: $quantity)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OrderItemRequestModelImpl &&
            (identical(other.menuItemId, menuItemId) ||
                other.menuItemId == menuItemId) &&
            (identical(other.quantity, quantity) ||
                other.quantity == quantity));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, menuItemId, quantity);

  /// Create a copy of OrderItemRequestModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$OrderItemRequestModelImplCopyWith<_$OrderItemRequestModelImpl>
  get copyWith =>
      __$$OrderItemRequestModelImplCopyWithImpl<_$OrderItemRequestModelImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$OrderItemRequestModelImplToJson(this);
  }
}

abstract class _OrderItemRequestModel implements OrderItemRequestModel {
  const factory _OrderItemRequestModel({
    required final String menuItemId,
    required final int quantity,
  }) = _$OrderItemRequestModelImpl;

  factory _OrderItemRequestModel.fromJson(Map<String, dynamic> json) =
      _$OrderItemRequestModelImpl.fromJson;

  @override
  String get menuItemId;
  @override
  int get quantity;

  /// Create a copy of OrderItemRequestModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$OrderItemRequestModelImplCopyWith<_$OrderItemRequestModelImpl>
  get copyWith => throw _privateConstructorUsedError;
}
