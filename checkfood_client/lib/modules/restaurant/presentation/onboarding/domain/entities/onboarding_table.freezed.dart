// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'onboarding_table.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$OnboardingTable {
  String get id => throw _privateConstructorUsedError;
  String get label => throw _privateConstructorUsedError;
  int get capacity => throw _privateConstructorUsedError;
  bool get active => throw _privateConstructorUsedError;
  double? get yaw => throw _privateConstructorUsedError;
  double? get pitch => throw _privateConstructorUsedError;

  /// Create a copy of OnboardingTable
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $OnboardingTableCopyWith<OnboardingTable> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OnboardingTableCopyWith<$Res> {
  factory $OnboardingTableCopyWith(
    OnboardingTable value,
    $Res Function(OnboardingTable) then,
  ) = _$OnboardingTableCopyWithImpl<$Res, OnboardingTable>;
  @useResult
  $Res call({
    String id,
    String label,
    int capacity,
    bool active,
    double? yaw,
    double? pitch,
  });
}

/// @nodoc
class _$OnboardingTableCopyWithImpl<$Res, $Val extends OnboardingTable>
    implements $OnboardingTableCopyWith<$Res> {
  _$OnboardingTableCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of OnboardingTable
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? label = null,
    Object? capacity = null,
    Object? active = null,
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
abstract class _$$OnboardingTableImplCopyWith<$Res>
    implements $OnboardingTableCopyWith<$Res> {
  factory _$$OnboardingTableImplCopyWith(
    _$OnboardingTableImpl value,
    $Res Function(_$OnboardingTableImpl) then,
  ) = __$$OnboardingTableImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String label,
    int capacity,
    bool active,
    double? yaw,
    double? pitch,
  });
}

/// @nodoc
class __$$OnboardingTableImplCopyWithImpl<$Res>
    extends _$OnboardingTableCopyWithImpl<$Res, _$OnboardingTableImpl>
    implements _$$OnboardingTableImplCopyWith<$Res> {
  __$$OnboardingTableImplCopyWithImpl(
    _$OnboardingTableImpl _value,
    $Res Function(_$OnboardingTableImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of OnboardingTable
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? label = null,
    Object? capacity = null,
    Object? active = null,
    Object? yaw = freezed,
    Object? pitch = freezed,
  }) {
    return _then(
      _$OnboardingTableImpl(
        id:
            null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
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

class _$OnboardingTableImpl implements _OnboardingTable {
  const _$OnboardingTableImpl({
    required this.id,
    required this.label,
    this.capacity = 0,
    this.active = true,
    this.yaw,
    this.pitch,
  });

  @override
  final String id;
  @override
  final String label;
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
    return 'OnboardingTable(id: $id, label: $label, capacity: $capacity, active: $active, yaw: $yaw, pitch: $pitch)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OnboardingTableImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.label, label) || other.label == label) &&
            (identical(other.capacity, capacity) ||
                other.capacity == capacity) &&
            (identical(other.active, active) || other.active == active) &&
            (identical(other.yaw, yaw) || other.yaw == yaw) &&
            (identical(other.pitch, pitch) || other.pitch == pitch));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, id, label, capacity, active, yaw, pitch);

  /// Create a copy of OnboardingTable
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$OnboardingTableImplCopyWith<_$OnboardingTableImpl> get copyWith =>
      __$$OnboardingTableImplCopyWithImpl<_$OnboardingTableImpl>(
        this,
        _$identity,
      );
}

abstract class _OnboardingTable implements OnboardingTable {
  const factory _OnboardingTable({
    required final String id,
    required final String label,
    final int capacity,
    final bool active,
    final double? yaw,
    final double? pitch,
  }) = _$OnboardingTableImpl;

  @override
  String get id;
  @override
  String get label;
  @override
  int get capacity;
  @override
  bool get active;
  @override
  double? get yaw;
  @override
  double? get pitch;

  /// Create a copy of OnboardingTable
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$OnboardingTableImplCopyWith<_$OnboardingTableImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
