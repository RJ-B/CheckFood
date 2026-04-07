// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'recurring_reservation.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$RecurringReservation {
  String get id => throw _privateConstructorUsedError;
  String get restaurantId => throw _privateConstructorUsedError;
  String get tableId => throw _privateConstructorUsedError;
  String? get restaurantName => throw _privateConstructorUsedError;
  String? get tableLabel => throw _privateConstructorUsedError;
  String get dayOfWeek => throw _privateConstructorUsedError;
  String get startTime => throw _privateConstructorUsedError;
  int get partySize => throw _privateConstructorUsedError;
  String get status => throw _privateConstructorUsedError;
  String? get repeatUntil => throw _privateConstructorUsedError;
  String get createdAt => throw _privateConstructorUsedError;
  int get instanceCount => throw _privateConstructorUsedError;

  /// Create a copy of RecurringReservation
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $RecurringReservationCopyWith<RecurringReservation> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RecurringReservationCopyWith<$Res> {
  factory $RecurringReservationCopyWith(
    RecurringReservation value,
    $Res Function(RecurringReservation) then,
  ) = _$RecurringReservationCopyWithImpl<$Res, RecurringReservation>;
  @useResult
  $Res call({
    String id,
    String restaurantId,
    String tableId,
    String? restaurantName,
    String? tableLabel,
    String dayOfWeek,
    String startTime,
    int partySize,
    String status,
    String? repeatUntil,
    String createdAt,
    int instanceCount,
  });
}

/// @nodoc
class _$RecurringReservationCopyWithImpl<
  $Res,
  $Val extends RecurringReservation
>
    implements $RecurringReservationCopyWith<$Res> {
  _$RecurringReservationCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of RecurringReservation
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? restaurantId = null,
    Object? tableId = null,
    Object? restaurantName = freezed,
    Object? tableLabel = freezed,
    Object? dayOfWeek = null,
    Object? startTime = null,
    Object? partySize = null,
    Object? status = null,
    Object? repeatUntil = freezed,
    Object? createdAt = null,
    Object? instanceCount = null,
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
            tableId:
                null == tableId
                    ? _value.tableId
                    : tableId // ignore: cast_nullable_to_non_nullable
                        as String,
            restaurantName:
                freezed == restaurantName
                    ? _value.restaurantName
                    : restaurantName // ignore: cast_nullable_to_non_nullable
                        as String?,
            tableLabel:
                freezed == tableLabel
                    ? _value.tableLabel
                    : tableLabel // ignore: cast_nullable_to_non_nullable
                        as String?,
            dayOfWeek:
                null == dayOfWeek
                    ? _value.dayOfWeek
                    : dayOfWeek // ignore: cast_nullable_to_non_nullable
                        as String,
            startTime:
                null == startTime
                    ? _value.startTime
                    : startTime // ignore: cast_nullable_to_non_nullable
                        as String,
            partySize:
                null == partySize
                    ? _value.partySize
                    : partySize // ignore: cast_nullable_to_non_nullable
                        as int,
            status:
                null == status
                    ? _value.status
                    : status // ignore: cast_nullable_to_non_nullable
                        as String,
            repeatUntil:
                freezed == repeatUntil
                    ? _value.repeatUntil
                    : repeatUntil // ignore: cast_nullable_to_non_nullable
                        as String?,
            createdAt:
                null == createdAt
                    ? _value.createdAt
                    : createdAt // ignore: cast_nullable_to_non_nullable
                        as String,
            instanceCount:
                null == instanceCount
                    ? _value.instanceCount
                    : instanceCount // ignore: cast_nullable_to_non_nullable
                        as int,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$RecurringReservationImplCopyWith<$Res>
    implements $RecurringReservationCopyWith<$Res> {
  factory _$$RecurringReservationImplCopyWith(
    _$RecurringReservationImpl value,
    $Res Function(_$RecurringReservationImpl) then,
  ) = __$$RecurringReservationImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String restaurantId,
    String tableId,
    String? restaurantName,
    String? tableLabel,
    String dayOfWeek,
    String startTime,
    int partySize,
    String status,
    String? repeatUntil,
    String createdAt,
    int instanceCount,
  });
}

/// @nodoc
class __$$RecurringReservationImplCopyWithImpl<$Res>
    extends _$RecurringReservationCopyWithImpl<$Res, _$RecurringReservationImpl>
    implements _$$RecurringReservationImplCopyWith<$Res> {
  __$$RecurringReservationImplCopyWithImpl(
    _$RecurringReservationImpl _value,
    $Res Function(_$RecurringReservationImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of RecurringReservation
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? restaurantId = null,
    Object? tableId = null,
    Object? restaurantName = freezed,
    Object? tableLabel = freezed,
    Object? dayOfWeek = null,
    Object? startTime = null,
    Object? partySize = null,
    Object? status = null,
    Object? repeatUntil = freezed,
    Object? createdAt = null,
    Object? instanceCount = null,
  }) {
    return _then(
      _$RecurringReservationImpl(
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
        tableId:
            null == tableId
                ? _value.tableId
                : tableId // ignore: cast_nullable_to_non_nullable
                    as String,
        restaurantName:
            freezed == restaurantName
                ? _value.restaurantName
                : restaurantName // ignore: cast_nullable_to_non_nullable
                    as String?,
        tableLabel:
            freezed == tableLabel
                ? _value.tableLabel
                : tableLabel // ignore: cast_nullable_to_non_nullable
                    as String?,
        dayOfWeek:
            null == dayOfWeek
                ? _value.dayOfWeek
                : dayOfWeek // ignore: cast_nullable_to_non_nullable
                    as String,
        startTime:
            null == startTime
                ? _value.startTime
                : startTime // ignore: cast_nullable_to_non_nullable
                    as String,
        partySize:
            null == partySize
                ? _value.partySize
                : partySize // ignore: cast_nullable_to_non_nullable
                    as int,
        status:
            null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                    as String,
        repeatUntil:
            freezed == repeatUntil
                ? _value.repeatUntil
                : repeatUntil // ignore: cast_nullable_to_non_nullable
                    as String?,
        createdAt:
            null == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                    as String,
        instanceCount:
            null == instanceCount
                ? _value.instanceCount
                : instanceCount // ignore: cast_nullable_to_non_nullable
                    as int,
      ),
    );
  }
}

/// @nodoc

class _$RecurringReservationImpl implements _RecurringReservation {
  const _$RecurringReservationImpl({
    required this.id,
    required this.restaurantId,
    required this.tableId,
    this.restaurantName,
    this.tableLabel,
    required this.dayOfWeek,
    required this.startTime,
    required this.partySize,
    required this.status,
    this.repeatUntil,
    required this.createdAt,
    this.instanceCount = 0,
  });

  @override
  final String id;
  @override
  final String restaurantId;
  @override
  final String tableId;
  @override
  final String? restaurantName;
  @override
  final String? tableLabel;
  @override
  final String dayOfWeek;
  @override
  final String startTime;
  @override
  final int partySize;
  @override
  final String status;
  @override
  final String? repeatUntil;
  @override
  final String createdAt;
  @override
  @JsonKey()
  final int instanceCount;

  @override
  String toString() {
    return 'RecurringReservation(id: $id, restaurantId: $restaurantId, tableId: $tableId, restaurantName: $restaurantName, tableLabel: $tableLabel, dayOfWeek: $dayOfWeek, startTime: $startTime, partySize: $partySize, status: $status, repeatUntil: $repeatUntil, createdAt: $createdAt, instanceCount: $instanceCount)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RecurringReservationImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.restaurantId, restaurantId) ||
                other.restaurantId == restaurantId) &&
            (identical(other.tableId, tableId) || other.tableId == tableId) &&
            (identical(other.restaurantName, restaurantName) ||
                other.restaurantName == restaurantName) &&
            (identical(other.tableLabel, tableLabel) ||
                other.tableLabel == tableLabel) &&
            (identical(other.dayOfWeek, dayOfWeek) ||
                other.dayOfWeek == dayOfWeek) &&
            (identical(other.startTime, startTime) ||
                other.startTime == startTime) &&
            (identical(other.partySize, partySize) ||
                other.partySize == partySize) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.repeatUntil, repeatUntil) ||
                other.repeatUntil == repeatUntil) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.instanceCount, instanceCount) ||
                other.instanceCount == instanceCount));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    restaurantId,
    tableId,
    restaurantName,
    tableLabel,
    dayOfWeek,
    startTime,
    partySize,
    status,
    repeatUntil,
    createdAt,
    instanceCount,
  );

  /// Create a copy of RecurringReservation
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$RecurringReservationImplCopyWith<_$RecurringReservationImpl>
  get copyWith =>
      __$$RecurringReservationImplCopyWithImpl<_$RecurringReservationImpl>(
        this,
        _$identity,
      );
}

abstract class _RecurringReservation implements RecurringReservation {
  const factory _RecurringReservation({
    required final String id,
    required final String restaurantId,
    required final String tableId,
    final String? restaurantName,
    final String? tableLabel,
    required final String dayOfWeek,
    required final String startTime,
    required final int partySize,
    required final String status,
    final String? repeatUntil,
    required final String createdAt,
    final int instanceCount,
  }) = _$RecurringReservationImpl;

  @override
  String get id;
  @override
  String get restaurantId;
  @override
  String get tableId;
  @override
  String? get restaurantName;
  @override
  String? get tableLabel;
  @override
  String get dayOfWeek;
  @override
  String get startTime;
  @override
  int get partySize;
  @override
  String get status;
  @override
  String? get repeatUntil;
  @override
  String get createdAt;
  @override
  int get instanceCount;

  /// Create a copy of RecurringReservation
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RecurringReservationImplCopyWith<_$RecurringReservationImpl>
  get copyWith => throw _privateConstructorUsedError;
}
