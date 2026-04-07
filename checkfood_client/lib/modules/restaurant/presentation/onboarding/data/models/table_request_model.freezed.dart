// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'table_request_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

TableRequestModel _$TableRequestModelFromJson(Map<String, dynamic> json) {
  return _TableRequestModel.fromJson(json);
}

/// @nodoc
mixin _$TableRequestModel {
  String get label => throw _privateConstructorUsedError;
  int get capacity => throw _privateConstructorUsedError;
  bool get active => throw _privateConstructorUsedError;

  /// Serializes this TableRequestModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of TableRequestModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TableRequestModelCopyWith<TableRequestModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TableRequestModelCopyWith<$Res> {
  factory $TableRequestModelCopyWith(
    TableRequestModel value,
    $Res Function(TableRequestModel) then,
  ) = _$TableRequestModelCopyWithImpl<$Res, TableRequestModel>;
  @useResult
  $Res call({String label, int capacity, bool active});
}

/// @nodoc
class _$TableRequestModelCopyWithImpl<$Res, $Val extends TableRequestModel>
    implements $TableRequestModelCopyWith<$Res> {
  _$TableRequestModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TableRequestModel
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
abstract class _$$TableRequestModelImplCopyWith<$Res>
    implements $TableRequestModelCopyWith<$Res> {
  factory _$$TableRequestModelImplCopyWith(
    _$TableRequestModelImpl value,
    $Res Function(_$TableRequestModelImpl) then,
  ) = __$$TableRequestModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String label, int capacity, bool active});
}

/// @nodoc
class __$$TableRequestModelImplCopyWithImpl<$Res>
    extends _$TableRequestModelCopyWithImpl<$Res, _$TableRequestModelImpl>
    implements _$$TableRequestModelImplCopyWith<$Res> {
  __$$TableRequestModelImplCopyWithImpl(
    _$TableRequestModelImpl _value,
    $Res Function(_$TableRequestModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of TableRequestModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? label = null,
    Object? capacity = null,
    Object? active = null,
  }) {
    return _then(
      _$TableRequestModelImpl(
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
class _$TableRequestModelImpl implements _TableRequestModel {
  const _$TableRequestModelImpl({
    required this.label,
    required this.capacity,
    this.active = true,
  });

  factory _$TableRequestModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$TableRequestModelImplFromJson(json);

  @override
  final String label;
  @override
  final int capacity;
  @override
  @JsonKey()
  final bool active;

  @override
  String toString() {
    return 'TableRequestModel(label: $label, capacity: $capacity, active: $active)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TableRequestModelImpl &&
            (identical(other.label, label) || other.label == label) &&
            (identical(other.capacity, capacity) ||
                other.capacity == capacity) &&
            (identical(other.active, active) || other.active == active));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, label, capacity, active);

  /// Create a copy of TableRequestModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TableRequestModelImplCopyWith<_$TableRequestModelImpl> get copyWith =>
      __$$TableRequestModelImplCopyWithImpl<_$TableRequestModelImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$TableRequestModelImplToJson(this);
  }
}

abstract class _TableRequestModel implements TableRequestModel {
  const factory _TableRequestModel({
    required final String label,
    required final int capacity,
    final bool active,
  }) = _$TableRequestModelImpl;

  factory _TableRequestModel.fromJson(Map<String, dynamic> json) =
      _$TableRequestModelImpl.fromJson;

  @override
  String get label;
  @override
  int get capacity;
  @override
  bool get active;

  /// Create a copy of TableRequestModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TableRequestModelImplCopyWith<_$TableRequestModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
