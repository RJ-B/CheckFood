// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'restaurant_table.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$RestaurantTable {
  String get id => throw _privateConstructorUsedError;
  String get restaurantId => throw _privateConstructorUsedError;
  String get label => throw _privateConstructorUsedError;
  int get capacity => throw _privateConstructorUsedError;
  bool get isActive => throw _privateConstructorUsedError;
  double? get yaw => throw _privateConstructorUsedError;
  double? get pitch => throw _privateConstructorUsedError;

  /// Create a copy of RestaurantTable
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $RestaurantTableCopyWith<RestaurantTable> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RestaurantTableCopyWith<$Res> {
  factory $RestaurantTableCopyWith(
    RestaurantTable value,
    $Res Function(RestaurantTable) then,
  ) = _$RestaurantTableCopyWithImpl<$Res, RestaurantTable>;
  @useResult
  $Res call({
    String id,
    String restaurantId,
    String label,
    int capacity,
    bool isActive,
    double? yaw,
    double? pitch,
  });
}

/// @nodoc
class _$RestaurantTableCopyWithImpl<$Res, $Val extends RestaurantTable>
    implements $RestaurantTableCopyWith<$Res> {
  _$RestaurantTableCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of RestaurantTable
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? restaurantId = null,
    Object? label = null,
    Object? capacity = null,
    Object? isActive = null,
    Object? yaw = freezed,
    Object? pitch = freezed,
  }) {
    return _then(
      _value.copyWith(
            id:
                null == id
                    ? _value.id
                    : id // ignore: cast_nullable_to_non_nullable
                        as String,
            restaurantId:
                null == restaurantId
                    ? _value.restaurantId
                    : restaurantId // ignore: cast_nullable_to_non_nullable
                        as String,
            label:
                null == label
                    ? _value.label
                    : label // ignore: cast_nullable_to_non_nullable
                        as String,
            capacity:
                null == capacity
                    ? _value.capacity
                    : capacity // ignore: cast_nullable_to_non_nullable
                        as int,
            isActive:
                null == isActive
                    ? _value.isActive
                    : isActive // ignore: cast_nullable_to_non_nullable
                        as bool,
            yaw:
                freezed == yaw
                    ? _value.yaw
                    : yaw // ignore: cast_nullable_to_non_nullable
                        as double?,
            pitch:
                freezed == pitch
                    ? _value.pitch
                    : pitch // ignore: cast_nullable_to_non_nullable
                        as double?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$RestaurantTableImplCopyWith<$Res>
    implements $RestaurantTableCopyWith<$Res> {
  factory _$$RestaurantTableImplCopyWith(
    _$RestaurantTableImpl value,
    $Res Function(_$RestaurantTableImpl) then,
  ) = __$$RestaurantTableImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String restaurantId,
    String label,
    int capacity,
    bool isActive,
    double? yaw,
    double? pitch,
  });
}

/// @nodoc
class __$$RestaurantTableImplCopyWithImpl<$Res>
    extends _$RestaurantTableCopyWithImpl<$Res, _$RestaurantTableImpl>
    implements _$$RestaurantTableImplCopyWith<$Res> {
  __$$RestaurantTableImplCopyWithImpl(
    _$RestaurantTableImpl _value,
    $Res Function(_$RestaurantTableImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of RestaurantTable
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? restaurantId = null,
    Object? label = null,
    Object? capacity = null,
    Object? isActive = null,
    Object? yaw = freezed,
    Object? pitch = freezed,
  }) {
    return _then(
      _$RestaurantTableImpl(
        id:
            null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                    as String,
        restaurantId:
            null == restaurantId
                ? _value.restaurantId
                : restaurantId // ignore: cast_nullable_to_non_nullable
                    as String,
        label:
            null == label
                ? _value.label
                : label // ignore: cast_nullable_to_non_nullable
                    as String,
        capacity:
            null == capacity
                ? _value.capacity
                : capacity // ignore: cast_nullable_to_non_nullable
                    as int,
        isActive:
            null == isActive
                ? _value.isActive
                : isActive // ignore: cast_nullable_to_non_nullable
                    as bool,
        yaw:
            freezed == yaw
                ? _value.yaw
                : yaw // ignore: cast_nullable_to_non_nullable
                    as double?,
        pitch:
            freezed == pitch
                ? _value.pitch
                : pitch // ignore: cast_nullable_to_non_nullable
                    as double?,
      ),
    );
  }
}

/// @nodoc

class _$RestaurantTableImpl extends _RestaurantTable {
  const _$RestaurantTableImpl({
    required this.id,
    required this.restaurantId,
    required this.label,
    required this.capacity,
    required this.isActive,
    this.yaw,
    this.pitch,
  }) : super._();

  @override
  final String id;
  @override
  final String restaurantId;
  @override
  final String label;
  @override
  final int capacity;
  @override
  final bool isActive;
  @override
  final double? yaw;
  @override
  final double? pitch;

  @override
  String toString() {
    return 'RestaurantTable(id: $id, restaurantId: $restaurantId, label: $label, capacity: $capacity, isActive: $isActive, yaw: $yaw, pitch: $pitch)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RestaurantTableImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.restaurantId, restaurantId) ||
                other.restaurantId == restaurantId) &&
            (identical(other.label, label) || other.label == label) &&
            (identical(other.capacity, capacity) ||
                other.capacity == capacity) &&
            (identical(other.isActive, isActive) ||
                other.isActive == isActive) &&
            (identical(other.yaw, yaw) || other.yaw == yaw) &&
            (identical(other.pitch, pitch) || other.pitch == pitch));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    restaurantId,
    label,
    capacity,
    isActive,
    yaw,
    pitch,
  );

  /// Create a copy of RestaurantTable
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$RestaurantTableImplCopyWith<_$RestaurantTableImpl> get copyWith =>
      __$$RestaurantTableImplCopyWithImpl<_$RestaurantTableImpl>(
        this,
        _$identity,
      );
}

abstract class _RestaurantTable extends RestaurantTable {
  const factory _RestaurantTable({
    required final String id,
    required final String restaurantId,
    required final String label,
    required final int capacity,
    required final bool isActive,
    final double? yaw,
    final double? pitch,
  }) = _$RestaurantTableImpl;
  const _RestaurantTable._() : super._();

  @override
  String get id;
  @override
  String get restaurantId;
  @override
  String get label;
  @override
  int get capacity;
  @override
  bool get isActive;
  @override
  double? get yaw;
  @override
  double? get pitch;

  /// Create a copy of RestaurantTable
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RestaurantTableImplCopyWith<_$RestaurantTableImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
