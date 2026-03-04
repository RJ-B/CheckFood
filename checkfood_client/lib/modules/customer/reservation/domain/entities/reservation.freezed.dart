// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'reservation.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$Reservation {
  String get id => throw _privateConstructorUsedError;
  String get restaurantId => throw _privateConstructorUsedError;
  String get tableId => throw _privateConstructorUsedError;
  String? get restaurantName => throw _privateConstructorUsedError;
  String? get tableLabel => throw _privateConstructorUsedError;
  String get date => throw _privateConstructorUsedError;
  String get startTime => throw _privateConstructorUsedError;
  String? get endTime => throw _privateConstructorUsedError;
  String get status => throw _privateConstructorUsedError;
  int get partySize => throw _privateConstructorUsedError;
  bool get canEdit => throw _privateConstructorUsedError;
  bool get canCancel => throw _privateConstructorUsedError;

  /// Create a copy of Reservation
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ReservationCopyWith<Reservation> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ReservationCopyWith<$Res> {
  factory $ReservationCopyWith(
    Reservation value,
    $Res Function(Reservation) then,
  ) = _$ReservationCopyWithImpl<$Res, Reservation>;
  @useResult
  $Res call({
    String id,
    String restaurantId,
    String tableId,
    String? restaurantName,
    String? tableLabel,
    String date,
    String startTime,
    String? endTime,
    String status,
    int partySize,
    bool canEdit,
    bool canCancel,
  });
}

/// @nodoc
class _$ReservationCopyWithImpl<$Res, $Val extends Reservation>
    implements $ReservationCopyWith<$Res> {
  _$ReservationCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Reservation
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? restaurantId = null,
    Object? tableId = null,
    Object? restaurantName = freezed,
    Object? tableLabel = freezed,
    Object? date = null,
    Object? startTime = null,
    Object? endTime = freezed,
    Object? status = null,
    Object? partySize = null,
    Object? canEdit = null,
    Object? canCancel = null,
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
            date:
                null == date
                    ? _value.date
                    : date // ignore: cast_nullable_to_non_nullable
                        as String,
            startTime:
                null == startTime
                    ? _value.startTime
                    : startTime // ignore: cast_nullable_to_non_nullable
                        as String,
            endTime:
                freezed == endTime
                    ? _value.endTime
                    : endTime // ignore: cast_nullable_to_non_nullable
                        as String?,
            status:
                null == status
                    ? _value.status
                    : status // ignore: cast_nullable_to_non_nullable
                        as String,
            partySize:
                null == partySize
                    ? _value.partySize
                    : partySize // ignore: cast_nullable_to_non_nullable
                        as int,
            canEdit:
                null == canEdit
                    ? _value.canEdit
                    : canEdit // ignore: cast_nullable_to_non_nullable
                        as bool,
            canCancel:
                null == canCancel
                    ? _value.canCancel
                    : canCancel // ignore: cast_nullable_to_non_nullable
                        as bool,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ReservationImplCopyWith<$Res>
    implements $ReservationCopyWith<$Res> {
  factory _$$ReservationImplCopyWith(
    _$ReservationImpl value,
    $Res Function(_$ReservationImpl) then,
  ) = __$$ReservationImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String restaurantId,
    String tableId,
    String? restaurantName,
    String? tableLabel,
    String date,
    String startTime,
    String? endTime,
    String status,
    int partySize,
    bool canEdit,
    bool canCancel,
  });
}

/// @nodoc
class __$$ReservationImplCopyWithImpl<$Res>
    extends _$ReservationCopyWithImpl<$Res, _$ReservationImpl>
    implements _$$ReservationImplCopyWith<$Res> {
  __$$ReservationImplCopyWithImpl(
    _$ReservationImpl _value,
    $Res Function(_$ReservationImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Reservation
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? restaurantId = null,
    Object? tableId = null,
    Object? restaurantName = freezed,
    Object? tableLabel = freezed,
    Object? date = null,
    Object? startTime = null,
    Object? endTime = freezed,
    Object? status = null,
    Object? partySize = null,
    Object? canEdit = null,
    Object? canCancel = null,
  }) {
    return _then(
      _$ReservationImpl(
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
        date:
            null == date
                ? _value.date
                : date // ignore: cast_nullable_to_non_nullable
                    as String,
        startTime:
            null == startTime
                ? _value.startTime
                : startTime // ignore: cast_nullable_to_non_nullable
                    as String,
        endTime:
            freezed == endTime
                ? _value.endTime
                : endTime // ignore: cast_nullable_to_non_nullable
                    as String?,
        status:
            null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                    as String,
        partySize:
            null == partySize
                ? _value.partySize
                : partySize // ignore: cast_nullable_to_non_nullable
                    as int,
        canEdit:
            null == canEdit
                ? _value.canEdit
                : canEdit // ignore: cast_nullable_to_non_nullable
                    as bool,
        canCancel:
            null == canCancel
                ? _value.canCancel
                : canCancel // ignore: cast_nullable_to_non_nullable
                    as bool,
      ),
    );
  }
}

/// @nodoc

class _$ReservationImpl extends _Reservation {
  const _$ReservationImpl({
    required this.id,
    required this.restaurantId,
    required this.tableId,
    this.restaurantName,
    this.tableLabel,
    required this.date,
    required this.startTime,
    this.endTime,
    required this.status,
    required this.partySize,
    this.canEdit = false,
    this.canCancel = false,
  }) : super._();

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
  final String date;
  @override
  final String startTime;
  @override
  final String? endTime;
  @override
  final String status;
  @override
  final int partySize;
  @override
  @JsonKey()
  final bool canEdit;
  @override
  @JsonKey()
  final bool canCancel;

  @override
  String toString() {
    return 'Reservation(id: $id, restaurantId: $restaurantId, tableId: $tableId, restaurantName: $restaurantName, tableLabel: $tableLabel, date: $date, startTime: $startTime, endTime: $endTime, status: $status, partySize: $partySize, canEdit: $canEdit, canCancel: $canCancel)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ReservationImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.restaurantId, restaurantId) ||
                other.restaurantId == restaurantId) &&
            (identical(other.tableId, tableId) || other.tableId == tableId) &&
            (identical(other.restaurantName, restaurantName) ||
                other.restaurantName == restaurantName) &&
            (identical(other.tableLabel, tableLabel) ||
                other.tableLabel == tableLabel) &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.startTime, startTime) ||
                other.startTime == startTime) &&
            (identical(other.endTime, endTime) || other.endTime == endTime) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.partySize, partySize) ||
                other.partySize == partySize) &&
            (identical(other.canEdit, canEdit) || other.canEdit == canEdit) &&
            (identical(other.canCancel, canCancel) ||
                other.canCancel == canCancel));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    restaurantId,
    tableId,
    restaurantName,
    tableLabel,
    date,
    startTime,
    endTime,
    status,
    partySize,
    canEdit,
    canCancel,
  );

  /// Create a copy of Reservation
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ReservationImplCopyWith<_$ReservationImpl> get copyWith =>
      __$$ReservationImplCopyWithImpl<_$ReservationImpl>(this, _$identity);
}

abstract class _Reservation extends Reservation {
  const factory _Reservation({
    required final String id,
    required final String restaurantId,
    required final String tableId,
    final String? restaurantName,
    final String? tableLabel,
    required final String date,
    required final String startTime,
    final String? endTime,
    required final String status,
    required final int partySize,
    final bool canEdit,
    final bool canCancel,
  }) = _$ReservationImpl;
  const _Reservation._() : super._();

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
  String get date;
  @override
  String get startTime;
  @override
  String? get endTime;
  @override
  String get status;
  @override
  int get partySize;
  @override
  bool get canEdit;
  @override
  bool get canCancel;

  /// Create a copy of Reservation
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ReservationImplCopyWith<_$ReservationImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
