// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'reservation_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$ReservationEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String restaurantId) loadScene,
    required TResult Function(String date) loadStatuses,
    required TResult Function(String tableId, String label, int capacity)
    selectTable,
    required TResult Function(String date) changeDate,
    required TResult Function(String startTime) selectTime,
    required TResult Function(int partySize) changePartySize,
    required TResult Function() submitReservation,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String restaurantId)? loadScene,
    TResult? Function(String date)? loadStatuses,
    TResult? Function(String tableId, String label, int capacity)? selectTable,
    TResult? Function(String date)? changeDate,
    TResult? Function(String startTime)? selectTime,
    TResult? Function(int partySize)? changePartySize,
    TResult? Function()? submitReservation,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String restaurantId)? loadScene,
    TResult Function(String date)? loadStatuses,
    TResult Function(String tableId, String label, int capacity)? selectTable,
    TResult Function(String date)? changeDate,
    TResult Function(String startTime)? selectTime,
    TResult Function(int partySize)? changePartySize,
    TResult Function()? submitReservation,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(LoadScene value) loadScene,
    required TResult Function(LoadStatuses value) loadStatuses,
    required TResult Function(SelectTable value) selectTable,
    required TResult Function(ChangeDate value) changeDate,
    required TResult Function(SelectTime value) selectTime,
    required TResult Function(ChangePartySize value) changePartySize,
    required TResult Function(SubmitReservation value) submitReservation,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(LoadScene value)? loadScene,
    TResult? Function(LoadStatuses value)? loadStatuses,
    TResult? Function(SelectTable value)? selectTable,
    TResult? Function(ChangeDate value)? changeDate,
    TResult? Function(SelectTime value)? selectTime,
    TResult? Function(ChangePartySize value)? changePartySize,
    TResult? Function(SubmitReservation value)? submitReservation,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LoadScene value)? loadScene,
    TResult Function(LoadStatuses value)? loadStatuses,
    TResult Function(SelectTable value)? selectTable,
    TResult Function(ChangeDate value)? changeDate,
    TResult Function(SelectTime value)? selectTime,
    TResult Function(ChangePartySize value)? changePartySize,
    TResult Function(SubmitReservation value)? submitReservation,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ReservationEventCopyWith<$Res> {
  factory $ReservationEventCopyWith(
    ReservationEvent value,
    $Res Function(ReservationEvent) then,
  ) = _$ReservationEventCopyWithImpl<$Res, ReservationEvent>;
}

/// @nodoc
class _$ReservationEventCopyWithImpl<$Res, $Val extends ReservationEvent>
    implements $ReservationEventCopyWith<$Res> {
  _$ReservationEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ReservationEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$LoadSceneImplCopyWith<$Res> {
  factory _$$LoadSceneImplCopyWith(
    _$LoadSceneImpl value,
    $Res Function(_$LoadSceneImpl) then,
  ) = __$$LoadSceneImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String restaurantId});
}

/// @nodoc
class __$$LoadSceneImplCopyWithImpl<$Res>
    extends _$ReservationEventCopyWithImpl<$Res, _$LoadSceneImpl>
    implements _$$LoadSceneImplCopyWith<$Res> {
  __$$LoadSceneImplCopyWithImpl(
    _$LoadSceneImpl _value,
    $Res Function(_$LoadSceneImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ReservationEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? restaurantId = null}) {
    return _then(
      _$LoadSceneImpl(
        restaurantId:
            null == restaurantId
                ? _value.restaurantId
                : restaurantId // ignore: cast_nullable_to_non_nullable
                    as String,
      ),
    );
  }
}

/// @nodoc

class _$LoadSceneImpl implements LoadScene {
  const _$LoadSceneImpl({required this.restaurantId});

  @override
  final String restaurantId;

  @override
  String toString() {
    return 'ReservationEvent.loadScene(restaurantId: $restaurantId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoadSceneImpl &&
            (identical(other.restaurantId, restaurantId) ||
                other.restaurantId == restaurantId));
  }

  @override
  int get hashCode => Object.hash(runtimeType, restaurantId);

  /// Create a copy of ReservationEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LoadSceneImplCopyWith<_$LoadSceneImpl> get copyWith =>
      __$$LoadSceneImplCopyWithImpl<_$LoadSceneImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String restaurantId) loadScene,
    required TResult Function(String date) loadStatuses,
    required TResult Function(String tableId, String label, int capacity)
    selectTable,
    required TResult Function(String date) changeDate,
    required TResult Function(String startTime) selectTime,
    required TResult Function(int partySize) changePartySize,
    required TResult Function() submitReservation,
  }) {
    return loadScene(restaurantId);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String restaurantId)? loadScene,
    TResult? Function(String date)? loadStatuses,
    TResult? Function(String tableId, String label, int capacity)? selectTable,
    TResult? Function(String date)? changeDate,
    TResult? Function(String startTime)? selectTime,
    TResult? Function(int partySize)? changePartySize,
    TResult? Function()? submitReservation,
  }) {
    return loadScene?.call(restaurantId);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String restaurantId)? loadScene,
    TResult Function(String date)? loadStatuses,
    TResult Function(String tableId, String label, int capacity)? selectTable,
    TResult Function(String date)? changeDate,
    TResult Function(String startTime)? selectTime,
    TResult Function(int partySize)? changePartySize,
    TResult Function()? submitReservation,
    required TResult orElse(),
  }) {
    if (loadScene != null) {
      return loadScene(restaurantId);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(LoadScene value) loadScene,
    required TResult Function(LoadStatuses value) loadStatuses,
    required TResult Function(SelectTable value) selectTable,
    required TResult Function(ChangeDate value) changeDate,
    required TResult Function(SelectTime value) selectTime,
    required TResult Function(ChangePartySize value) changePartySize,
    required TResult Function(SubmitReservation value) submitReservation,
  }) {
    return loadScene(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(LoadScene value)? loadScene,
    TResult? Function(LoadStatuses value)? loadStatuses,
    TResult? Function(SelectTable value)? selectTable,
    TResult? Function(ChangeDate value)? changeDate,
    TResult? Function(SelectTime value)? selectTime,
    TResult? Function(ChangePartySize value)? changePartySize,
    TResult? Function(SubmitReservation value)? submitReservation,
  }) {
    return loadScene?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LoadScene value)? loadScene,
    TResult Function(LoadStatuses value)? loadStatuses,
    TResult Function(SelectTable value)? selectTable,
    TResult Function(ChangeDate value)? changeDate,
    TResult Function(SelectTime value)? selectTime,
    TResult Function(ChangePartySize value)? changePartySize,
    TResult Function(SubmitReservation value)? submitReservation,
    required TResult orElse(),
  }) {
    if (loadScene != null) {
      return loadScene(this);
    }
    return orElse();
  }
}

abstract class LoadScene implements ReservationEvent {
  const factory LoadScene({required final String restaurantId}) =
      _$LoadSceneImpl;

  String get restaurantId;

  /// Create a copy of ReservationEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LoadSceneImplCopyWith<_$LoadSceneImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$LoadStatusesImplCopyWith<$Res> {
  factory _$$LoadStatusesImplCopyWith(
    _$LoadStatusesImpl value,
    $Res Function(_$LoadStatusesImpl) then,
  ) = __$$LoadStatusesImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String date});
}

/// @nodoc
class __$$LoadStatusesImplCopyWithImpl<$Res>
    extends _$ReservationEventCopyWithImpl<$Res, _$LoadStatusesImpl>
    implements _$$LoadStatusesImplCopyWith<$Res> {
  __$$LoadStatusesImplCopyWithImpl(
    _$LoadStatusesImpl _value,
    $Res Function(_$LoadStatusesImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ReservationEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? date = null}) {
    return _then(
      _$LoadStatusesImpl(
        date:
            null == date
                ? _value.date
                : date // ignore: cast_nullable_to_non_nullable
                    as String,
      ),
    );
  }
}

/// @nodoc

class _$LoadStatusesImpl implements LoadStatuses {
  const _$LoadStatusesImpl({required this.date});

  @override
  final String date;

  @override
  String toString() {
    return 'ReservationEvent.loadStatuses(date: $date)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoadStatusesImpl &&
            (identical(other.date, date) || other.date == date));
  }

  @override
  int get hashCode => Object.hash(runtimeType, date);

  /// Create a copy of ReservationEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LoadStatusesImplCopyWith<_$LoadStatusesImpl> get copyWith =>
      __$$LoadStatusesImplCopyWithImpl<_$LoadStatusesImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String restaurantId) loadScene,
    required TResult Function(String date) loadStatuses,
    required TResult Function(String tableId, String label, int capacity)
    selectTable,
    required TResult Function(String date) changeDate,
    required TResult Function(String startTime) selectTime,
    required TResult Function(int partySize) changePartySize,
    required TResult Function() submitReservation,
  }) {
    return loadStatuses(date);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String restaurantId)? loadScene,
    TResult? Function(String date)? loadStatuses,
    TResult? Function(String tableId, String label, int capacity)? selectTable,
    TResult? Function(String date)? changeDate,
    TResult? Function(String startTime)? selectTime,
    TResult? Function(int partySize)? changePartySize,
    TResult? Function()? submitReservation,
  }) {
    return loadStatuses?.call(date);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String restaurantId)? loadScene,
    TResult Function(String date)? loadStatuses,
    TResult Function(String tableId, String label, int capacity)? selectTable,
    TResult Function(String date)? changeDate,
    TResult Function(String startTime)? selectTime,
    TResult Function(int partySize)? changePartySize,
    TResult Function()? submitReservation,
    required TResult orElse(),
  }) {
    if (loadStatuses != null) {
      return loadStatuses(date);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(LoadScene value) loadScene,
    required TResult Function(LoadStatuses value) loadStatuses,
    required TResult Function(SelectTable value) selectTable,
    required TResult Function(ChangeDate value) changeDate,
    required TResult Function(SelectTime value) selectTime,
    required TResult Function(ChangePartySize value) changePartySize,
    required TResult Function(SubmitReservation value) submitReservation,
  }) {
    return loadStatuses(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(LoadScene value)? loadScene,
    TResult? Function(LoadStatuses value)? loadStatuses,
    TResult? Function(SelectTable value)? selectTable,
    TResult? Function(ChangeDate value)? changeDate,
    TResult? Function(SelectTime value)? selectTime,
    TResult? Function(ChangePartySize value)? changePartySize,
    TResult? Function(SubmitReservation value)? submitReservation,
  }) {
    return loadStatuses?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LoadScene value)? loadScene,
    TResult Function(LoadStatuses value)? loadStatuses,
    TResult Function(SelectTable value)? selectTable,
    TResult Function(ChangeDate value)? changeDate,
    TResult Function(SelectTime value)? selectTime,
    TResult Function(ChangePartySize value)? changePartySize,
    TResult Function(SubmitReservation value)? submitReservation,
    required TResult orElse(),
  }) {
    if (loadStatuses != null) {
      return loadStatuses(this);
    }
    return orElse();
  }
}

abstract class LoadStatuses implements ReservationEvent {
  const factory LoadStatuses({required final String date}) = _$LoadStatusesImpl;

  String get date;

  /// Create a copy of ReservationEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LoadStatusesImplCopyWith<_$LoadStatusesImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$SelectTableImplCopyWith<$Res> {
  factory _$$SelectTableImplCopyWith(
    _$SelectTableImpl value,
    $Res Function(_$SelectTableImpl) then,
  ) = __$$SelectTableImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String tableId, String label, int capacity});
}

/// @nodoc
class __$$SelectTableImplCopyWithImpl<$Res>
    extends _$ReservationEventCopyWithImpl<$Res, _$SelectTableImpl>
    implements _$$SelectTableImplCopyWith<$Res> {
  __$$SelectTableImplCopyWithImpl(
    _$SelectTableImpl _value,
    $Res Function(_$SelectTableImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ReservationEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? tableId = null,
    Object? label = null,
    Object? capacity = null,
  }) {
    return _then(
      _$SelectTableImpl(
        tableId:
            null == tableId
                ? _value.tableId
                : tableId // ignore: cast_nullable_to_non_nullable
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
      ),
    );
  }
}

/// @nodoc

class _$SelectTableImpl implements SelectTable {
  const _$SelectTableImpl({
    required this.tableId,
    required this.label,
    required this.capacity,
  });

  @override
  final String tableId;
  @override
  final String label;
  @override
  final int capacity;

  @override
  String toString() {
    return 'ReservationEvent.selectTable(tableId: $tableId, label: $label, capacity: $capacity)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SelectTableImpl &&
            (identical(other.tableId, tableId) || other.tableId == tableId) &&
            (identical(other.label, label) || other.label == label) &&
            (identical(other.capacity, capacity) ||
                other.capacity == capacity));
  }

  @override
  int get hashCode => Object.hash(runtimeType, tableId, label, capacity);

  /// Create a copy of ReservationEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SelectTableImplCopyWith<_$SelectTableImpl> get copyWith =>
      __$$SelectTableImplCopyWithImpl<_$SelectTableImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String restaurantId) loadScene,
    required TResult Function(String date) loadStatuses,
    required TResult Function(String tableId, String label, int capacity)
    selectTable,
    required TResult Function(String date) changeDate,
    required TResult Function(String startTime) selectTime,
    required TResult Function(int partySize) changePartySize,
    required TResult Function() submitReservation,
  }) {
    return selectTable(tableId, label, capacity);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String restaurantId)? loadScene,
    TResult? Function(String date)? loadStatuses,
    TResult? Function(String tableId, String label, int capacity)? selectTable,
    TResult? Function(String date)? changeDate,
    TResult? Function(String startTime)? selectTime,
    TResult? Function(int partySize)? changePartySize,
    TResult? Function()? submitReservation,
  }) {
    return selectTable?.call(tableId, label, capacity);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String restaurantId)? loadScene,
    TResult Function(String date)? loadStatuses,
    TResult Function(String tableId, String label, int capacity)? selectTable,
    TResult Function(String date)? changeDate,
    TResult Function(String startTime)? selectTime,
    TResult Function(int partySize)? changePartySize,
    TResult Function()? submitReservation,
    required TResult orElse(),
  }) {
    if (selectTable != null) {
      return selectTable(tableId, label, capacity);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(LoadScene value) loadScene,
    required TResult Function(LoadStatuses value) loadStatuses,
    required TResult Function(SelectTable value) selectTable,
    required TResult Function(ChangeDate value) changeDate,
    required TResult Function(SelectTime value) selectTime,
    required TResult Function(ChangePartySize value) changePartySize,
    required TResult Function(SubmitReservation value) submitReservation,
  }) {
    return selectTable(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(LoadScene value)? loadScene,
    TResult? Function(LoadStatuses value)? loadStatuses,
    TResult? Function(SelectTable value)? selectTable,
    TResult? Function(ChangeDate value)? changeDate,
    TResult? Function(SelectTime value)? selectTime,
    TResult? Function(ChangePartySize value)? changePartySize,
    TResult? Function(SubmitReservation value)? submitReservation,
  }) {
    return selectTable?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LoadScene value)? loadScene,
    TResult Function(LoadStatuses value)? loadStatuses,
    TResult Function(SelectTable value)? selectTable,
    TResult Function(ChangeDate value)? changeDate,
    TResult Function(SelectTime value)? selectTime,
    TResult Function(ChangePartySize value)? changePartySize,
    TResult Function(SubmitReservation value)? submitReservation,
    required TResult orElse(),
  }) {
    if (selectTable != null) {
      return selectTable(this);
    }
    return orElse();
  }
}

abstract class SelectTable implements ReservationEvent {
  const factory SelectTable({
    required final String tableId,
    required final String label,
    required final int capacity,
  }) = _$SelectTableImpl;

  String get tableId;
  String get label;
  int get capacity;

  /// Create a copy of ReservationEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SelectTableImplCopyWith<_$SelectTableImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ChangeDateImplCopyWith<$Res> {
  factory _$$ChangeDateImplCopyWith(
    _$ChangeDateImpl value,
    $Res Function(_$ChangeDateImpl) then,
  ) = __$$ChangeDateImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String date});
}

/// @nodoc
class __$$ChangeDateImplCopyWithImpl<$Res>
    extends _$ReservationEventCopyWithImpl<$Res, _$ChangeDateImpl>
    implements _$$ChangeDateImplCopyWith<$Res> {
  __$$ChangeDateImplCopyWithImpl(
    _$ChangeDateImpl _value,
    $Res Function(_$ChangeDateImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ReservationEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? date = null}) {
    return _then(
      _$ChangeDateImpl(
        date:
            null == date
                ? _value.date
                : date // ignore: cast_nullable_to_non_nullable
                    as String,
      ),
    );
  }
}

/// @nodoc

class _$ChangeDateImpl implements ChangeDate {
  const _$ChangeDateImpl({required this.date});

  @override
  final String date;

  @override
  String toString() {
    return 'ReservationEvent.changeDate(date: $date)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ChangeDateImpl &&
            (identical(other.date, date) || other.date == date));
  }

  @override
  int get hashCode => Object.hash(runtimeType, date);

  /// Create a copy of ReservationEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ChangeDateImplCopyWith<_$ChangeDateImpl> get copyWith =>
      __$$ChangeDateImplCopyWithImpl<_$ChangeDateImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String restaurantId) loadScene,
    required TResult Function(String date) loadStatuses,
    required TResult Function(String tableId, String label, int capacity)
    selectTable,
    required TResult Function(String date) changeDate,
    required TResult Function(String startTime) selectTime,
    required TResult Function(int partySize) changePartySize,
    required TResult Function() submitReservation,
  }) {
    return changeDate(date);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String restaurantId)? loadScene,
    TResult? Function(String date)? loadStatuses,
    TResult? Function(String tableId, String label, int capacity)? selectTable,
    TResult? Function(String date)? changeDate,
    TResult? Function(String startTime)? selectTime,
    TResult? Function(int partySize)? changePartySize,
    TResult? Function()? submitReservation,
  }) {
    return changeDate?.call(date);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String restaurantId)? loadScene,
    TResult Function(String date)? loadStatuses,
    TResult Function(String tableId, String label, int capacity)? selectTable,
    TResult Function(String date)? changeDate,
    TResult Function(String startTime)? selectTime,
    TResult Function(int partySize)? changePartySize,
    TResult Function()? submitReservation,
    required TResult orElse(),
  }) {
    if (changeDate != null) {
      return changeDate(date);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(LoadScene value) loadScene,
    required TResult Function(LoadStatuses value) loadStatuses,
    required TResult Function(SelectTable value) selectTable,
    required TResult Function(ChangeDate value) changeDate,
    required TResult Function(SelectTime value) selectTime,
    required TResult Function(ChangePartySize value) changePartySize,
    required TResult Function(SubmitReservation value) submitReservation,
  }) {
    return changeDate(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(LoadScene value)? loadScene,
    TResult? Function(LoadStatuses value)? loadStatuses,
    TResult? Function(SelectTable value)? selectTable,
    TResult? Function(ChangeDate value)? changeDate,
    TResult? Function(SelectTime value)? selectTime,
    TResult? Function(ChangePartySize value)? changePartySize,
    TResult? Function(SubmitReservation value)? submitReservation,
  }) {
    return changeDate?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LoadScene value)? loadScene,
    TResult Function(LoadStatuses value)? loadStatuses,
    TResult Function(SelectTable value)? selectTable,
    TResult Function(ChangeDate value)? changeDate,
    TResult Function(SelectTime value)? selectTime,
    TResult Function(ChangePartySize value)? changePartySize,
    TResult Function(SubmitReservation value)? submitReservation,
    required TResult orElse(),
  }) {
    if (changeDate != null) {
      return changeDate(this);
    }
    return orElse();
  }
}

abstract class ChangeDate implements ReservationEvent {
  const factory ChangeDate({required final String date}) = _$ChangeDateImpl;

  String get date;

  /// Create a copy of ReservationEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ChangeDateImplCopyWith<_$ChangeDateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$SelectTimeImplCopyWith<$Res> {
  factory _$$SelectTimeImplCopyWith(
    _$SelectTimeImpl value,
    $Res Function(_$SelectTimeImpl) then,
  ) = __$$SelectTimeImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String startTime});
}

/// @nodoc
class __$$SelectTimeImplCopyWithImpl<$Res>
    extends _$ReservationEventCopyWithImpl<$Res, _$SelectTimeImpl>
    implements _$$SelectTimeImplCopyWith<$Res> {
  __$$SelectTimeImplCopyWithImpl(
    _$SelectTimeImpl _value,
    $Res Function(_$SelectTimeImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ReservationEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? startTime = null}) {
    return _then(
      _$SelectTimeImpl(
        startTime:
            null == startTime
                ? _value.startTime
                : startTime // ignore: cast_nullable_to_non_nullable
                    as String,
      ),
    );
  }
}

/// @nodoc

class _$SelectTimeImpl implements SelectTime {
  const _$SelectTimeImpl({required this.startTime});

  @override
  final String startTime;

  @override
  String toString() {
    return 'ReservationEvent.selectTime(startTime: $startTime)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SelectTimeImpl &&
            (identical(other.startTime, startTime) ||
                other.startTime == startTime));
  }

  @override
  int get hashCode => Object.hash(runtimeType, startTime);

  /// Create a copy of ReservationEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SelectTimeImplCopyWith<_$SelectTimeImpl> get copyWith =>
      __$$SelectTimeImplCopyWithImpl<_$SelectTimeImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String restaurantId) loadScene,
    required TResult Function(String date) loadStatuses,
    required TResult Function(String tableId, String label, int capacity)
    selectTable,
    required TResult Function(String date) changeDate,
    required TResult Function(String startTime) selectTime,
    required TResult Function(int partySize) changePartySize,
    required TResult Function() submitReservation,
  }) {
    return selectTime(startTime);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String restaurantId)? loadScene,
    TResult? Function(String date)? loadStatuses,
    TResult? Function(String tableId, String label, int capacity)? selectTable,
    TResult? Function(String date)? changeDate,
    TResult? Function(String startTime)? selectTime,
    TResult? Function(int partySize)? changePartySize,
    TResult? Function()? submitReservation,
  }) {
    return selectTime?.call(startTime);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String restaurantId)? loadScene,
    TResult Function(String date)? loadStatuses,
    TResult Function(String tableId, String label, int capacity)? selectTable,
    TResult Function(String date)? changeDate,
    TResult Function(String startTime)? selectTime,
    TResult Function(int partySize)? changePartySize,
    TResult Function()? submitReservation,
    required TResult orElse(),
  }) {
    if (selectTime != null) {
      return selectTime(startTime);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(LoadScene value) loadScene,
    required TResult Function(LoadStatuses value) loadStatuses,
    required TResult Function(SelectTable value) selectTable,
    required TResult Function(ChangeDate value) changeDate,
    required TResult Function(SelectTime value) selectTime,
    required TResult Function(ChangePartySize value) changePartySize,
    required TResult Function(SubmitReservation value) submitReservation,
  }) {
    return selectTime(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(LoadScene value)? loadScene,
    TResult? Function(LoadStatuses value)? loadStatuses,
    TResult? Function(SelectTable value)? selectTable,
    TResult? Function(ChangeDate value)? changeDate,
    TResult? Function(SelectTime value)? selectTime,
    TResult? Function(ChangePartySize value)? changePartySize,
    TResult? Function(SubmitReservation value)? submitReservation,
  }) {
    return selectTime?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LoadScene value)? loadScene,
    TResult Function(LoadStatuses value)? loadStatuses,
    TResult Function(SelectTable value)? selectTable,
    TResult Function(ChangeDate value)? changeDate,
    TResult Function(SelectTime value)? selectTime,
    TResult Function(ChangePartySize value)? changePartySize,
    TResult Function(SubmitReservation value)? submitReservation,
    required TResult orElse(),
  }) {
    if (selectTime != null) {
      return selectTime(this);
    }
    return orElse();
  }
}

abstract class SelectTime implements ReservationEvent {
  const factory SelectTime({required final String startTime}) =
      _$SelectTimeImpl;

  String get startTime;

  /// Create a copy of ReservationEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SelectTimeImplCopyWith<_$SelectTimeImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ChangePartySizeImplCopyWith<$Res> {
  factory _$$ChangePartySizeImplCopyWith(
    _$ChangePartySizeImpl value,
    $Res Function(_$ChangePartySizeImpl) then,
  ) = __$$ChangePartySizeImplCopyWithImpl<$Res>;
  @useResult
  $Res call({int partySize});
}

/// @nodoc
class __$$ChangePartySizeImplCopyWithImpl<$Res>
    extends _$ReservationEventCopyWithImpl<$Res, _$ChangePartySizeImpl>
    implements _$$ChangePartySizeImplCopyWith<$Res> {
  __$$ChangePartySizeImplCopyWithImpl(
    _$ChangePartySizeImpl _value,
    $Res Function(_$ChangePartySizeImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ReservationEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? partySize = null}) {
    return _then(
      _$ChangePartySizeImpl(
        partySize:
            null == partySize
                ? _value.partySize
                : partySize // ignore: cast_nullable_to_non_nullable
                    as int,
      ),
    );
  }
}

/// @nodoc

class _$ChangePartySizeImpl implements ChangePartySize {
  const _$ChangePartySizeImpl({required this.partySize});

  @override
  final int partySize;

  @override
  String toString() {
    return 'ReservationEvent.changePartySize(partySize: $partySize)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ChangePartySizeImpl &&
            (identical(other.partySize, partySize) ||
                other.partySize == partySize));
  }

  @override
  int get hashCode => Object.hash(runtimeType, partySize);

  /// Create a copy of ReservationEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ChangePartySizeImplCopyWith<_$ChangePartySizeImpl> get copyWith =>
      __$$ChangePartySizeImplCopyWithImpl<_$ChangePartySizeImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String restaurantId) loadScene,
    required TResult Function(String date) loadStatuses,
    required TResult Function(String tableId, String label, int capacity)
    selectTable,
    required TResult Function(String date) changeDate,
    required TResult Function(String startTime) selectTime,
    required TResult Function(int partySize) changePartySize,
    required TResult Function() submitReservation,
  }) {
    return changePartySize(partySize);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String restaurantId)? loadScene,
    TResult? Function(String date)? loadStatuses,
    TResult? Function(String tableId, String label, int capacity)? selectTable,
    TResult? Function(String date)? changeDate,
    TResult? Function(String startTime)? selectTime,
    TResult? Function(int partySize)? changePartySize,
    TResult? Function()? submitReservation,
  }) {
    return changePartySize?.call(partySize);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String restaurantId)? loadScene,
    TResult Function(String date)? loadStatuses,
    TResult Function(String tableId, String label, int capacity)? selectTable,
    TResult Function(String date)? changeDate,
    TResult Function(String startTime)? selectTime,
    TResult Function(int partySize)? changePartySize,
    TResult Function()? submitReservation,
    required TResult orElse(),
  }) {
    if (changePartySize != null) {
      return changePartySize(partySize);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(LoadScene value) loadScene,
    required TResult Function(LoadStatuses value) loadStatuses,
    required TResult Function(SelectTable value) selectTable,
    required TResult Function(ChangeDate value) changeDate,
    required TResult Function(SelectTime value) selectTime,
    required TResult Function(ChangePartySize value) changePartySize,
    required TResult Function(SubmitReservation value) submitReservation,
  }) {
    return changePartySize(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(LoadScene value)? loadScene,
    TResult? Function(LoadStatuses value)? loadStatuses,
    TResult? Function(SelectTable value)? selectTable,
    TResult? Function(ChangeDate value)? changeDate,
    TResult? Function(SelectTime value)? selectTime,
    TResult? Function(ChangePartySize value)? changePartySize,
    TResult? Function(SubmitReservation value)? submitReservation,
  }) {
    return changePartySize?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LoadScene value)? loadScene,
    TResult Function(LoadStatuses value)? loadStatuses,
    TResult Function(SelectTable value)? selectTable,
    TResult Function(ChangeDate value)? changeDate,
    TResult Function(SelectTime value)? selectTime,
    TResult Function(ChangePartySize value)? changePartySize,
    TResult Function(SubmitReservation value)? submitReservation,
    required TResult orElse(),
  }) {
    if (changePartySize != null) {
      return changePartySize(this);
    }
    return orElse();
  }
}

abstract class ChangePartySize implements ReservationEvent {
  const factory ChangePartySize({required final int partySize}) =
      _$ChangePartySizeImpl;

  int get partySize;

  /// Create a copy of ReservationEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ChangePartySizeImplCopyWith<_$ChangePartySizeImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$SubmitReservationImplCopyWith<$Res> {
  factory _$$SubmitReservationImplCopyWith(
    _$SubmitReservationImpl value,
    $Res Function(_$SubmitReservationImpl) then,
  ) = __$$SubmitReservationImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$SubmitReservationImplCopyWithImpl<$Res>
    extends _$ReservationEventCopyWithImpl<$Res, _$SubmitReservationImpl>
    implements _$$SubmitReservationImplCopyWith<$Res> {
  __$$SubmitReservationImplCopyWithImpl(
    _$SubmitReservationImpl _value,
    $Res Function(_$SubmitReservationImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ReservationEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$SubmitReservationImpl implements SubmitReservation {
  const _$SubmitReservationImpl();

  @override
  String toString() {
    return 'ReservationEvent.submitReservation()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$SubmitReservationImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String restaurantId) loadScene,
    required TResult Function(String date) loadStatuses,
    required TResult Function(String tableId, String label, int capacity)
    selectTable,
    required TResult Function(String date) changeDate,
    required TResult Function(String startTime) selectTime,
    required TResult Function(int partySize) changePartySize,
    required TResult Function() submitReservation,
  }) {
    return submitReservation();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String restaurantId)? loadScene,
    TResult? Function(String date)? loadStatuses,
    TResult? Function(String tableId, String label, int capacity)? selectTable,
    TResult? Function(String date)? changeDate,
    TResult? Function(String startTime)? selectTime,
    TResult? Function(int partySize)? changePartySize,
    TResult? Function()? submitReservation,
  }) {
    return submitReservation?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String restaurantId)? loadScene,
    TResult Function(String date)? loadStatuses,
    TResult Function(String tableId, String label, int capacity)? selectTable,
    TResult Function(String date)? changeDate,
    TResult Function(String startTime)? selectTime,
    TResult Function(int partySize)? changePartySize,
    TResult Function()? submitReservation,
    required TResult orElse(),
  }) {
    if (submitReservation != null) {
      return submitReservation();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(LoadScene value) loadScene,
    required TResult Function(LoadStatuses value) loadStatuses,
    required TResult Function(SelectTable value) selectTable,
    required TResult Function(ChangeDate value) changeDate,
    required TResult Function(SelectTime value) selectTime,
    required TResult Function(ChangePartySize value) changePartySize,
    required TResult Function(SubmitReservation value) submitReservation,
  }) {
    return submitReservation(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(LoadScene value)? loadScene,
    TResult? Function(LoadStatuses value)? loadStatuses,
    TResult? Function(SelectTable value)? selectTable,
    TResult? Function(ChangeDate value)? changeDate,
    TResult? Function(SelectTime value)? selectTime,
    TResult? Function(ChangePartySize value)? changePartySize,
    TResult? Function(SubmitReservation value)? submitReservation,
  }) {
    return submitReservation?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LoadScene value)? loadScene,
    TResult Function(LoadStatuses value)? loadStatuses,
    TResult Function(SelectTable value)? selectTable,
    TResult Function(ChangeDate value)? changeDate,
    TResult Function(SelectTime value)? selectTime,
    TResult Function(ChangePartySize value)? changePartySize,
    TResult Function(SubmitReservation value)? submitReservation,
    required TResult orElse(),
  }) {
    if (submitReservation != null) {
      return submitReservation(this);
    }
    return orElse();
  }
}

abstract class SubmitReservation implements ReservationEvent {
  const factory SubmitReservation() = _$SubmitReservationImpl;
}
