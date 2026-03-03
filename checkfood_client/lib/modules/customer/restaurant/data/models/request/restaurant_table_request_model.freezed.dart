// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'restaurant_table_request_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

RestaurantTableRequestModel _$RestaurantTableRequestModelFromJson(
  Map<String, dynamic> json,
) {
  return _RestaurantTableRequestModel.fromJson(json);
}

/// @nodoc
mixin _$RestaurantTableRequestModel {
  String get label => throw _privateConstructorUsedError;
  int get capacity => throw _privateConstructorUsedError;
  bool get active => throw _privateConstructorUsedError;

  /// Serializes this RestaurantTableRequestModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of RestaurantTableRequestModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $RestaurantTableRequestModelCopyWith<RestaurantTableRequestModel>
  get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RestaurantTableRequestModelCopyWith<$Res> {
  factory $RestaurantTableRequestModelCopyWith(
    RestaurantTableRequestModel value,
    $Res Function(RestaurantTableRequestModel) then,
  ) =
      _$RestaurantTableRequestModelCopyWithImpl<
        $Res,
        RestaurantTableRequestModel
      >;
  @useResult
  $Res call({String label, int capacity, bool active});
}

/// @nodoc
class _$RestaurantTableRequestModelCopyWithImpl<
  $Res,
  $Val extends RestaurantTableRequestModel
>
    implements $RestaurantTableRequestModelCopyWith<$Res> {
  _$RestaurantTableRequestModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of RestaurantTableRequestModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? label = null,
    Object? capacity = null,
    Object? active = null,
  }) {
    return _then(
      _value.copyWith(
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
            active:
                null == active
                    ? _value.active
                    : active // ignore: cast_nullable_to_non_nullable
                        as bool,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$RestaurantTableRequestModelImplCopyWith<$Res>
    implements $RestaurantTableRequestModelCopyWith<$Res> {
  factory _$$RestaurantTableRequestModelImplCopyWith(
    _$RestaurantTableRequestModelImpl value,
    $Res Function(_$RestaurantTableRequestModelImpl) then,
  ) = __$$RestaurantTableRequestModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String label, int capacity, bool active});
}

/// @nodoc
class __$$RestaurantTableRequestModelImplCopyWithImpl<$Res>
    extends
        _$RestaurantTableRequestModelCopyWithImpl<
          $Res,
          _$RestaurantTableRequestModelImpl
        >
    implements _$$RestaurantTableRequestModelImplCopyWith<$Res> {
  __$$RestaurantTableRequestModelImplCopyWithImpl(
    _$RestaurantTableRequestModelImpl _value,
    $Res Function(_$RestaurantTableRequestModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of RestaurantTableRequestModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? label = null,
    Object? capacity = null,
    Object? active = null,
  }) {
    return _then(
      _$RestaurantTableRequestModelImpl(
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
        active:
            null == active
                ? _value.active
                : active // ignore: cast_nullable_to_non_nullable
                    as bool,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$RestaurantTableRequestModelImpl
    implements _RestaurantTableRequestModel {
  const _$RestaurantTableRequestModelImpl({
    required this.label,
    required this.capacity,
    this.active = true,
  });

  factory _$RestaurantTableRequestModelImpl.fromJson(
    Map<String, dynamic> json,
  ) => _$$RestaurantTableRequestModelImplFromJson(json);

  @override
  final String label;
  @override
  final int capacity;
  @override
  @JsonKey()
  final bool active;

  @override
  String toString() {
    return 'RestaurantTableRequestModel(label: $label, capacity: $capacity, active: $active)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RestaurantTableRequestModelImpl &&
            (identical(other.label, label) || other.label == label) &&
            (identical(other.capacity, capacity) ||
                other.capacity == capacity) &&
            (identical(other.active, active) || other.active == active));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, label, capacity, active);

  /// Create a copy of RestaurantTableRequestModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$RestaurantTableRequestModelImplCopyWith<_$RestaurantTableRequestModelImpl>
  get copyWith => __$$RestaurantTableRequestModelImplCopyWithImpl<
    _$RestaurantTableRequestModelImpl
  >(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$RestaurantTableRequestModelImplToJson(this);
  }
}

abstract class _RestaurantTableRequestModel
    implements RestaurantTableRequestModel {
  const factory _RestaurantTableRequestModel({
    required final String label,
    required final int capacity,
    final bool active,
  }) = _$RestaurantTableRequestModelImpl;

  factory _RestaurantTableRequestModel.fromJson(Map<String, dynamic> json) =
      _$RestaurantTableRequestModelImpl.fromJson;

  @override
  String get label;
  @override
  int get capacity;
  @override
  bool get active;

  /// Create a copy of RestaurantTableRequestModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RestaurantTableRequestModelImplCopyWith<_$RestaurantTableRequestModelImpl>
  get copyWith => throw _privateConstructorUsedError;
}
