// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'available_slots.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$AvailableSlots {
  String get date => throw _privateConstructorUsedError;
  String get tableId => throw _privateConstructorUsedError;
  int get slotMinutes => throw _privateConstructorUsedError;
  int get durationMinutes => throw _privateConstructorUsedError;
  List<String> get availableStartTimes => throw _privateConstructorUsedError;

  /// Create a copy of AvailableSlots
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AvailableSlotsCopyWith<AvailableSlots> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AvailableSlotsCopyWith<$Res> {
  factory $AvailableSlotsCopyWith(
    AvailableSlots value,
    $Res Function(AvailableSlots) then,
  ) = _$AvailableSlotsCopyWithImpl<$Res, AvailableSlots>;
  @useResult
  $Res call({
    String date,
    String tableId,
    int slotMinutes,
    int durationMinutes,
    List<String> availableStartTimes,
  });
}

/// @nodoc
class _$AvailableSlotsCopyWithImpl<$Res, $Val extends AvailableSlots>
    implements $AvailableSlotsCopyWith<$Res> {
  _$AvailableSlotsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AvailableSlots
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? date = null,
    Object? tableId = null,
    Object? slotMinutes = null,
    Object? durationMinutes = null,
    Object? availableStartTimes = null,
  }) {
    return _then(
      _value.copyWith(
            date:
                null == date
                    ? _value.date
                    : date // ignore: cast_nullable_to_non_nullable
                        as String,
            tableId:
                null == tableId
                    ? _value.tableId
                    : tableId // ignore: cast_nullable_to_non_nullable
                        as String,
            slotMinutes:
                null == slotMinutes
                    ? _value.slotMinutes
                    : slotMinutes // ignore: cast_nullable_to_non_nullable
                        as int,
            durationMinutes:
                null == durationMinutes
                    ? _value.durationMinutes
                    : durationMinutes // ignore: cast_nullable_to_non_nullable
                        as int,
            availableStartTimes:
                null == availableStartTimes
                    ? _value.availableStartTimes
                    : availableStartTimes // ignore: cast_nullable_to_non_nullable
                        as List<String>,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$AvailableSlotsImplCopyWith<$Res>
    implements $AvailableSlotsCopyWith<$Res> {
  factory _$$AvailableSlotsImplCopyWith(
    _$AvailableSlotsImpl value,
    $Res Function(_$AvailableSlotsImpl) then,
  ) = __$$AvailableSlotsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String date,
    String tableId,
    int slotMinutes,
    int durationMinutes,
    List<String> availableStartTimes,
  });
}

/// @nodoc
class __$$AvailableSlotsImplCopyWithImpl<$Res>
    extends _$AvailableSlotsCopyWithImpl<$Res, _$AvailableSlotsImpl>
    implements _$$AvailableSlotsImplCopyWith<$Res> {
  __$$AvailableSlotsImplCopyWithImpl(
    _$AvailableSlotsImpl _value,
    $Res Function(_$AvailableSlotsImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AvailableSlots
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? date = null,
    Object? tableId = null,
    Object? slotMinutes = null,
    Object? durationMinutes = null,
    Object? availableStartTimes = null,
  }) {
    return _then(
      _$AvailableSlotsImpl(
        date:
            null == date
                ? _value.date
                : date // ignore: cast_nullable_to_non_nullable
                    as String,
        tableId:
            null == tableId
                ? _value.tableId
                : tableId // ignore: cast_nullable_to_non_nullable
                    as String,
        slotMinutes:
            null == slotMinutes
                ? _value.slotMinutes
                : slotMinutes // ignore: cast_nullable_to_non_nullable
                    as int,
        durationMinutes:
            null == durationMinutes
                ? _value.durationMinutes
                : durationMinutes // ignore: cast_nullable_to_non_nullable
                    as int,
        availableStartTimes:
            null == availableStartTimes
                ? _value._availableStartTimes
                : availableStartTimes // ignore: cast_nullable_to_non_nullable
                    as List<String>,
      ),
    );
  }
}

/// @nodoc

class _$AvailableSlotsImpl implements _AvailableSlots {
  const _$AvailableSlotsImpl({
    required this.date,
    required this.tableId,
    required this.slotMinutes,
    required this.durationMinutes,
    required final List<String> availableStartTimes,
  }) : _availableStartTimes = availableStartTimes;

  @override
  final String date;
  @override
  final String tableId;
  @override
  final int slotMinutes;
  @override
  final int durationMinutes;
  final List<String> _availableStartTimes;
  @override
  List<String> get availableStartTimes {
    if (_availableStartTimes is EqualUnmodifiableListView)
      return _availableStartTimes;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_availableStartTimes);
  }

  @override
  String toString() {
    return 'AvailableSlots(date: $date, tableId: $tableId, slotMinutes: $slotMinutes, durationMinutes: $durationMinutes, availableStartTimes: $availableStartTimes)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AvailableSlotsImpl &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.tableId, tableId) || other.tableId == tableId) &&
            (identical(other.slotMinutes, slotMinutes) ||
                other.slotMinutes == slotMinutes) &&
            (identical(other.durationMinutes, durationMinutes) ||
                other.durationMinutes == durationMinutes) &&
            const DeepCollectionEquality().equals(
              other._availableStartTimes,
              _availableStartTimes,
            ));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    date,
    tableId,
    slotMinutes,
    durationMinutes,
    const DeepCollectionEquality().hash(_availableStartTimes),
  );

  /// Create a copy of AvailableSlots
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AvailableSlotsImplCopyWith<_$AvailableSlotsImpl> get copyWith =>
      __$$AvailableSlotsImplCopyWithImpl<_$AvailableSlotsImpl>(
        this,
        _$identity,
      );
}

abstract class _AvailableSlots implements AvailableSlots {
  const factory _AvailableSlots({
    required final String date,
    required final String tableId,
    required final int slotMinutes,
    required final int durationMinutes,
    required final List<String> availableStartTimes,
  }) = _$AvailableSlotsImpl;

  @override
  String get date;
  @override
  String get tableId;
  @override
  int get slotMinutes;
  @override
  int get durationMinutes;
  @override
  List<String> get availableStartTimes;

  /// Create a copy of AvailableSlots
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AvailableSlotsImplCopyWith<_$AvailableSlotsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
