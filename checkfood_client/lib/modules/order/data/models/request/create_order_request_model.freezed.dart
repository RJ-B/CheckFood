// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'create_order_request_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

CreateOrderRequestModel _$CreateOrderRequestModelFromJson(
  Map<String, dynamic> json,
) {
  return _CreateOrderRequestModel.fromJson(json);
}

/// @nodoc
mixin _$CreateOrderRequestModel {
  List<OrderItemRequestModel> get items => throw _privateConstructorUsedError;
  String? get note => throw _privateConstructorUsedError;

  /// Serializes this CreateOrderRequestModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of CreateOrderRequestModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CreateOrderRequestModelCopyWith<CreateOrderRequestModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CreateOrderRequestModelCopyWith<$Res> {
  factory $CreateOrderRequestModelCopyWith(
    CreateOrderRequestModel value,
    $Res Function(CreateOrderRequestModel) then,
  ) = _$CreateOrderRequestModelCopyWithImpl<$Res, CreateOrderRequestModel>;
  @useResult
  $Res call({List<OrderItemRequestModel> items, String? note});
}

/// @nodoc
class _$CreateOrderRequestModelCopyWithImpl<
  $Res,
  $Val extends CreateOrderRequestModel
>
    implements $CreateOrderRequestModelCopyWith<$Res> {
  _$CreateOrderRequestModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CreateOrderRequestModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? items = null, Object? note = freezed}) {
    return _then(
      _value.copyWith(
            items:
                null == items
                    ? _value.items
                    : items // ignore: cast_nullable_to_non_nullable
                        as List<OrderItemRequestModel>,
            note:
                freezed == note
                    ? _value.note
                    : note // ignore: cast_nullable_to_non_nullable
                        as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$CreateOrderRequestModelImplCopyWith<$Res>
    implements $CreateOrderRequestModelCopyWith<$Res> {
  factory _$$CreateOrderRequestModelImplCopyWith(
    _$CreateOrderRequestModelImpl value,
    $Res Function(_$CreateOrderRequestModelImpl) then,
  ) = __$$CreateOrderRequestModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<OrderItemRequestModel> items, String? note});
}

/// @nodoc
class __$$CreateOrderRequestModelImplCopyWithImpl<$Res>
    extends
        _$CreateOrderRequestModelCopyWithImpl<
          $Res,
          _$CreateOrderRequestModelImpl
        >
    implements _$$CreateOrderRequestModelImplCopyWith<$Res> {
  __$$CreateOrderRequestModelImplCopyWithImpl(
    _$CreateOrderRequestModelImpl _value,
    $Res Function(_$CreateOrderRequestModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CreateOrderRequestModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? items = null, Object? note = freezed}) {
    return _then(
      _$CreateOrderRequestModelImpl(
        items:
            null == items
                ? _value._items
                : items // ignore: cast_nullable_to_non_nullable
                    as List<OrderItemRequestModel>,
        note:
            freezed == note
                ? _value.note
                : note // ignore: cast_nullable_to_non_nullable
                    as String?,
      ),
    );
  }
}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class _$CreateOrderRequestModelImpl implements _CreateOrderRequestModel {
  const _$CreateOrderRequestModelImpl({
    required final List<OrderItemRequestModel> items,
    this.note,
  }) : _items = items;

  factory _$CreateOrderRequestModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$CreateOrderRequestModelImplFromJson(json);

  final List<OrderItemRequestModel> _items;
  @override
  List<OrderItemRequestModel> get items {
    if (_items is EqualUnmodifiableListView) return _items;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_items);
  }

  @override
  final String? note;

  @override
  String toString() {
    return 'CreateOrderRequestModel(items: $items, note: $note)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CreateOrderRequestModelImpl &&
            const DeepCollectionEquality().equals(other._items, _items) &&
            (identical(other.note, note) || other.note == note));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    const DeepCollectionEquality().hash(_items),
    note,
  );

  /// Create a copy of CreateOrderRequestModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CreateOrderRequestModelImplCopyWith<_$CreateOrderRequestModelImpl>
  get copyWith => __$$CreateOrderRequestModelImplCopyWithImpl<
    _$CreateOrderRequestModelImpl
  >(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CreateOrderRequestModelImplToJson(this);
  }
}

abstract class _CreateOrderRequestModel implements CreateOrderRequestModel {
  const factory _CreateOrderRequestModel({
    required final List<OrderItemRequestModel> items,
    final String? note,
  }) = _$CreateOrderRequestModelImpl;

  factory _CreateOrderRequestModel.fromJson(Map<String, dynamic> json) =
      _$CreateOrderRequestModelImpl.fromJson;

  @override
  List<OrderItemRequestModel> get items;
  @override
  String? get note;

  /// Create a copy of CreateOrderRequestModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CreateOrderRequestModelImplCopyWith<_$CreateOrderRequestModelImpl>
  get copyWith => throw _privateConstructorUsedError;
}
