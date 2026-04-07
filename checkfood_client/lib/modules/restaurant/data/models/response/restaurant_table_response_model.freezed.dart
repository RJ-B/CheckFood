// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'restaurant_table_response_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

RestaurantTableResponseModel _$RestaurantTableResponseModelFromJson(
  Map<String, dynamic> json,
) {
  return _RestaurantTableResponseModel.fromJson(json);
}

/// @nodoc
mixin _$RestaurantTableResponseModel {
  String get id => throw _privateConstructorUsedError;
  String get restaurantId => throw _privateConstructorUsedError;
  String get label => throw _privateConstructorUsedError;
  int get capacity => throw _privateConstructorUsedError;
  @JsonKey(name: 'active')
  bool get isActive => throw _privateConstructorUsedError;
  double? get yaw => throw _privateConstructorUsedError;
  double? get pitch => throw _privateConstructorUsedError;

  /// Serializes this RestaurantTableResponseModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of RestaurantTableResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $RestaurantTableResponseModelCopyWith<RestaurantTableResponseModel>
  get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RestaurantTableResponseModelCopyWith<$Res> {
  factory $RestaurantTableResponseModelCopyWith(
    RestaurantTableResponseModel value,
    $Res Function(RestaurantTableResponseModel) then,
  ) =
      _$RestaurantTableResponseModelCopyWithImpl<
        $Res,
        RestaurantTableResponseModel
      >;
  @useResult
  $Res call({
    String id,
    String restaurantId,
    String label,
    int capacity,
    @JsonKey(name: 'active') bool isActive,
    double? yaw,
    double? pitch,
  });
}

/// @nodoc
class _$RestaurantTableResponseModelCopyWithImpl<
  $Res,
  $Val extends RestaurantTableResponseModel
>
    implements $RestaurantTableResponseModelCopyWith<$Res> {
  _$RestaurantTableResponseModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of RestaurantTableResponseModel
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
abstract class _$$RestaurantTableResponseModelImplCopyWith<$Res>
    implements $RestaurantTableResponseModelCopyWith<$Res> {
  factory _$$RestaurantTableResponseModelImplCopyWith(
    _$RestaurantTableResponseModelImpl value,
    $Res Function(_$RestaurantTableResponseModelImpl) then,
  ) = __$$RestaurantTableResponseModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String restaurantId,
    String label,
    int capacity,
    @JsonKey(name: 'active') bool isActive,
    double? yaw,
    double? pitch,
  });
}

/// @nodoc
class __$$RestaurantTableResponseModelImplCopyWithImpl<$Res>
    extends
        _$RestaurantTableResponseModelCopyWithImpl<
          $Res,
          _$RestaurantTableResponseModelImpl
        >
    implements _$$RestaurantTableResponseModelImplCopyWith<$Res> {
  __$$RestaurantTableResponseModelImplCopyWithImpl(
    _$RestaurantTableResponseModelImpl _value,
    $Res Function(_$RestaurantTableResponseModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of RestaurantTableResponseModel
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
      _$RestaurantTableResponseModelImpl(
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
@JsonSerializable()
class _$RestaurantTableResponseModelImpl extends _RestaurantTableResponseModel {
  const _$RestaurantTableResponseModelImpl({
    required this.id,
    required this.restaurantId,
    required this.label,
    required this.capacity,
    @JsonKey(name: 'active') required this.isActive,
    this.yaw,
    this.pitch,
  }) : super._();

  factory _$RestaurantTableResponseModelImpl.fromJson(
    Map<String, dynamic> json,
  ) => _$$RestaurantTableResponseModelImplFromJson(json);

  @override
  final String id;
  @override
  final String restaurantId;
  @override
  final String label;
  @override
  final int capacity;
  @override
  @JsonKey(name: 'active')
  final bool isActive;
  @override
  final double? yaw;
  @override
  final double? pitch;

  @override
  String toString() {
    return 'RestaurantTableResponseModel(id: $id, restaurantId: $restaurantId, label: $label, capacity: $capacity, isActive: $isActive, yaw: $yaw, pitch: $pitch)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RestaurantTableResponseModelImpl &&
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

  @JsonKey(includeFromJson: false, includeToJson: false)
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

  /// Create a copy of RestaurantTableResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$RestaurantTableResponseModelImplCopyWith<
    _$RestaurantTableResponseModelImpl
  >
  get copyWith => __$$RestaurantTableResponseModelImplCopyWithImpl<
    _$RestaurantTableResponseModelImpl
  >(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$RestaurantTableResponseModelImplToJson(this);
  }
}

abstract class _RestaurantTableResponseModel
    extends RestaurantTableResponseModel {
  const factory _RestaurantTableResponseModel({
    required final String id,
    required final String restaurantId,
    required final String label,
    required final int capacity,
    @JsonKey(name: 'active') required final bool isActive,
    final double? yaw,
    final double? pitch,
  }) = _$RestaurantTableResponseModelImpl;
  const _RestaurantTableResponseModel._() : super._();

  factory _RestaurantTableResponseModel.fromJson(Map<String, dynamic> json) =
      _$RestaurantTableResponseModelImpl.fromJson;

  @override
  String get id;
  @override
  String get restaurantId;
  @override
  String get label;
  @override
  int get capacity;
  @override
  @JsonKey(name: 'active')
  bool get isActive;
  @override
  double? get yaw;
  @override
  double? get pitch;

  /// Create a copy of RestaurantTableResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RestaurantTableResponseModelImplCopyWith<
    _$RestaurantTableResponseModelImpl
  >
  get copyWith => throw _privateConstructorUsedError;
}
