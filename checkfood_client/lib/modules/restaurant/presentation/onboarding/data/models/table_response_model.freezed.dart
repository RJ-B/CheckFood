// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'table_response_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

TableResponseModel _$TableResponseModelFromJson(Map<String, dynamic> json) {
  return _TableResponseModel.fromJson(json);
}

/// @nodoc
mixin _$TableResponseModel {
  String? get id => throw _privateConstructorUsedError;
  String? get label => throw _privateConstructorUsedError;
  int get capacity => throw _privateConstructorUsedError;
  bool get active => throw _privateConstructorUsedError;
  double? get yaw => throw _privateConstructorUsedError;
  double? get pitch => throw _privateConstructorUsedError;

  /// Serializes this TableResponseModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of TableResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TableResponseModelCopyWith<TableResponseModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TableResponseModelCopyWith<$Res> {
  factory $TableResponseModelCopyWith(
    TableResponseModel value,
    $Res Function(TableResponseModel) then,
  ) = _$TableResponseModelCopyWithImpl<$Res, TableResponseModel>;
  @useResult
  $Res call({
    String? id,
    String? label,
    int capacity,
    bool active,
    double? yaw,
    double? pitch,
  });
}

/// @nodoc
class _$TableResponseModelCopyWithImpl<$Res, $Val extends TableResponseModel>
    implements $TableResponseModelCopyWith<$Res> {
  _$TableResponseModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TableResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? label = freezed,
    Object? capacity = null,
    Object? active = null,
    Object? yaw = freezed,
    Object? pitch = freezed,
  }) {
    return _then(
      _value.copyWith(
            id:
                freezed == id
                    ? _value.id
                    : id // ignore: cast_nullable_to_non_nullable
                        as String?,
            label:
                freezed == label
                    ? _value.label
                    : label // ignore: cast_nullable_to_non_nullable
                        as String?,
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
abstract class _$$TableResponseModelImplCopyWith<$Res>
    implements $TableResponseModelCopyWith<$Res> {
  factory _$$TableResponseModelImplCopyWith(
    _$TableResponseModelImpl value,
    $Res Function(_$TableResponseModelImpl) then,
  ) = __$$TableResponseModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String? id,
    String? label,
    int capacity,
    bool active,
    double? yaw,
    double? pitch,
  });
}

/// @nodoc
class __$$TableResponseModelImplCopyWithImpl<$Res>
    extends _$TableResponseModelCopyWithImpl<$Res, _$TableResponseModelImpl>
    implements _$$TableResponseModelImplCopyWith<$Res> {
  __$$TableResponseModelImplCopyWithImpl(
    _$TableResponseModelImpl _value,
    $Res Function(_$TableResponseModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of TableResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? label = freezed,
    Object? capacity = null,
    Object? active = null,
    Object? yaw = freezed,
    Object? pitch = freezed,
  }) {
    return _then(
      _$TableResponseModelImpl(
        id:
            freezed == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                    as String?,
        label:
            freezed == label
                ? _value.label
                : label // ignore: cast_nullable_to_non_nullable
                    as String?,
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
class _$TableResponseModelImpl extends _TableResponseModel {
  const _$TableResponseModelImpl({
    this.id,
    this.label,
    this.capacity = 0,
    this.active = true,
    this.yaw,
    this.pitch,
  }) : super._();

  factory _$TableResponseModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$TableResponseModelImplFromJson(json);

  @override
  final String? id;
  @override
  final String? label;
  @override
  @JsonKey()
  final int capacity;
  @override
  @JsonKey()
  final bool active;
  @override
  final double? yaw;
  @override
  final double? pitch;

  @override
  String toString() {
    return 'TableResponseModel(id: $id, label: $label, capacity: $capacity, active: $active, yaw: $yaw, pitch: $pitch)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TableResponseModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.label, label) || other.label == label) &&
            (identical(other.capacity, capacity) ||
                other.capacity == capacity) &&
            (identical(other.active, active) || other.active == active) &&
            (identical(other.yaw, yaw) || other.yaw == yaw) &&
            (identical(other.pitch, pitch) || other.pitch == pitch));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, label, capacity, active, yaw, pitch);

  /// Create a copy of TableResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TableResponseModelImplCopyWith<_$TableResponseModelImpl> get copyWith =>
      __$$TableResponseModelImplCopyWithImpl<_$TableResponseModelImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$TableResponseModelImplToJson(this);
  }
}

abstract class _TableResponseModel extends TableResponseModel {
  const factory _TableResponseModel({
    final String? id,
    final String? label,
    final int capacity,
    final bool active,
    final double? yaw,
    final double? pitch,
  }) = _$TableResponseModelImpl;
  const _TableResponseModel._() : super._();

  factory _TableResponseModel.fromJson(Map<String, dynamic> json) =
      _$TableResponseModelImpl.fromJson;

  @override
  String? get id;
  @override
  String? get label;
  @override
  int get capacity;
  @override
  bool get active;
  @override
  double? get yaw;
  @override
  double? get pitch;

  /// Create a copy of TableResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TableResponseModelImplCopyWith<_$TableResponseModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
