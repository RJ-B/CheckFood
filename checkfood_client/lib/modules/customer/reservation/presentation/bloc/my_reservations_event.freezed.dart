// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'my_reservations_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$MyReservationsEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() load,
    required TResult Function() refresh,
    required TResult Function() showAllHistory,
    required TResult Function(String reservationId) cancel,
    required TResult Function(Reservation reservation) startEdit,
    required TResult Function(String date) editDateChanged,
    required TResult Function(String tableId) editTableChanged,
    required TResult Function(String startTime) editTimeSelected,
    required TResult Function(int partySize) editPartySizeChanged,
    required TResult Function() submitEdit,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? load,
    TResult? Function()? refresh,
    TResult? Function()? showAllHistory,
    TResult? Function(String reservationId)? cancel,
    TResult? Function(Reservation reservation)? startEdit,
    TResult? Function(String date)? editDateChanged,
    TResult? Function(String tableId)? editTableChanged,
    TResult? Function(String startTime)? editTimeSelected,
    TResult? Function(int partySize)? editPartySizeChanged,
    TResult? Function()? submitEdit,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? load,
    TResult Function()? refresh,
    TResult Function()? showAllHistory,
    TResult Function(String reservationId)? cancel,
    TResult Function(Reservation reservation)? startEdit,
    TResult Function(String date)? editDateChanged,
    TResult Function(String tableId)? editTableChanged,
    TResult Function(String startTime)? editTimeSelected,
    TResult Function(int partySize)? editPartySizeChanged,
    TResult Function()? submitEdit,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(LoadMyReservations value) load,
    required TResult Function(RefreshMyReservations value) refresh,
    required TResult Function(ShowAllHistory value) showAllHistory,
    required TResult Function(CancelReservation value) cancel,
    required TResult Function(StartEditReservation value) startEdit,
    required TResult Function(EditDateChanged value) editDateChanged,
    required TResult Function(EditTableChanged value) editTableChanged,
    required TResult Function(EditTimeSelected value) editTimeSelected,
    required TResult Function(EditPartySizeChanged value) editPartySizeChanged,
    required TResult Function(SubmitEditReservation value) submitEdit,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(LoadMyReservations value)? load,
    TResult? Function(RefreshMyReservations value)? refresh,
    TResult? Function(ShowAllHistory value)? showAllHistory,
    TResult? Function(CancelReservation value)? cancel,
    TResult? Function(StartEditReservation value)? startEdit,
    TResult? Function(EditDateChanged value)? editDateChanged,
    TResult? Function(EditTableChanged value)? editTableChanged,
    TResult? Function(EditTimeSelected value)? editTimeSelected,
    TResult? Function(EditPartySizeChanged value)? editPartySizeChanged,
    TResult? Function(SubmitEditReservation value)? submitEdit,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LoadMyReservations value)? load,
    TResult Function(RefreshMyReservations value)? refresh,
    TResult Function(ShowAllHistory value)? showAllHistory,
    TResult Function(CancelReservation value)? cancel,
    TResult Function(StartEditReservation value)? startEdit,
    TResult Function(EditDateChanged value)? editDateChanged,
    TResult Function(EditTableChanged value)? editTableChanged,
    TResult Function(EditTimeSelected value)? editTimeSelected,
    TResult Function(EditPartySizeChanged value)? editPartySizeChanged,
    TResult Function(SubmitEditReservation value)? submitEdit,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MyReservationsEventCopyWith<$Res> {
  factory $MyReservationsEventCopyWith(
    MyReservationsEvent value,
    $Res Function(MyReservationsEvent) then,
  ) = _$MyReservationsEventCopyWithImpl<$Res, MyReservationsEvent>;
}

/// @nodoc
class _$MyReservationsEventCopyWithImpl<$Res, $Val extends MyReservationsEvent>
    implements $MyReservationsEventCopyWith<$Res> {
  _$MyReservationsEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of MyReservationsEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$LoadMyReservationsImplCopyWith<$Res> {
  factory _$$LoadMyReservationsImplCopyWith(
    _$LoadMyReservationsImpl value,
    $Res Function(_$LoadMyReservationsImpl) then,
  ) = __$$LoadMyReservationsImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$LoadMyReservationsImplCopyWithImpl<$Res>
    extends _$MyReservationsEventCopyWithImpl<$Res, _$LoadMyReservationsImpl>
    implements _$$LoadMyReservationsImplCopyWith<$Res> {
  __$$LoadMyReservationsImplCopyWithImpl(
    _$LoadMyReservationsImpl _value,
    $Res Function(_$LoadMyReservationsImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of MyReservationsEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$LoadMyReservationsImpl implements LoadMyReservations {
  const _$LoadMyReservationsImpl();

  @override
  String toString() {
    return 'MyReservationsEvent.load()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$LoadMyReservationsImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() load,
    required TResult Function() refresh,
    required TResult Function() showAllHistory,
    required TResult Function(String reservationId) cancel,
    required TResult Function(Reservation reservation) startEdit,
    required TResult Function(String date) editDateChanged,
    required TResult Function(String tableId) editTableChanged,
    required TResult Function(String startTime) editTimeSelected,
    required TResult Function(int partySize) editPartySizeChanged,
    required TResult Function() submitEdit,
  }) {
    return load();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? load,
    TResult? Function()? refresh,
    TResult? Function()? showAllHistory,
    TResult? Function(String reservationId)? cancel,
    TResult? Function(Reservation reservation)? startEdit,
    TResult? Function(String date)? editDateChanged,
    TResult? Function(String tableId)? editTableChanged,
    TResult? Function(String startTime)? editTimeSelected,
    TResult? Function(int partySize)? editPartySizeChanged,
    TResult? Function()? submitEdit,
  }) {
    return load?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? load,
    TResult Function()? refresh,
    TResult Function()? showAllHistory,
    TResult Function(String reservationId)? cancel,
    TResult Function(Reservation reservation)? startEdit,
    TResult Function(String date)? editDateChanged,
    TResult Function(String tableId)? editTableChanged,
    TResult Function(String startTime)? editTimeSelected,
    TResult Function(int partySize)? editPartySizeChanged,
    TResult Function()? submitEdit,
    required TResult orElse(),
  }) {
    if (load != null) {
      return load();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(LoadMyReservations value) load,
    required TResult Function(RefreshMyReservations value) refresh,
    required TResult Function(ShowAllHistory value) showAllHistory,
    required TResult Function(CancelReservation value) cancel,
    required TResult Function(StartEditReservation value) startEdit,
    required TResult Function(EditDateChanged value) editDateChanged,
    required TResult Function(EditTableChanged value) editTableChanged,
    required TResult Function(EditTimeSelected value) editTimeSelected,
    required TResult Function(EditPartySizeChanged value) editPartySizeChanged,
    required TResult Function(SubmitEditReservation value) submitEdit,
  }) {
    return load(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(LoadMyReservations value)? load,
    TResult? Function(RefreshMyReservations value)? refresh,
    TResult? Function(ShowAllHistory value)? showAllHistory,
    TResult? Function(CancelReservation value)? cancel,
    TResult? Function(StartEditReservation value)? startEdit,
    TResult? Function(EditDateChanged value)? editDateChanged,
    TResult? Function(EditTableChanged value)? editTableChanged,
    TResult? Function(EditTimeSelected value)? editTimeSelected,
    TResult? Function(EditPartySizeChanged value)? editPartySizeChanged,
    TResult? Function(SubmitEditReservation value)? submitEdit,
  }) {
    return load?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LoadMyReservations value)? load,
    TResult Function(RefreshMyReservations value)? refresh,
    TResult Function(ShowAllHistory value)? showAllHistory,
    TResult Function(CancelReservation value)? cancel,
    TResult Function(StartEditReservation value)? startEdit,
    TResult Function(EditDateChanged value)? editDateChanged,
    TResult Function(EditTableChanged value)? editTableChanged,
    TResult Function(EditTimeSelected value)? editTimeSelected,
    TResult Function(EditPartySizeChanged value)? editPartySizeChanged,
    TResult Function(SubmitEditReservation value)? submitEdit,
    required TResult orElse(),
  }) {
    if (load != null) {
      return load(this);
    }
    return orElse();
  }
}

abstract class LoadMyReservations implements MyReservationsEvent {
  const factory LoadMyReservations() = _$LoadMyReservationsImpl;
}

/// @nodoc
abstract class _$$RefreshMyReservationsImplCopyWith<$Res> {
  factory _$$RefreshMyReservationsImplCopyWith(
    _$RefreshMyReservationsImpl value,
    $Res Function(_$RefreshMyReservationsImpl) then,
  ) = __$$RefreshMyReservationsImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$RefreshMyReservationsImplCopyWithImpl<$Res>
    extends _$MyReservationsEventCopyWithImpl<$Res, _$RefreshMyReservationsImpl>
    implements _$$RefreshMyReservationsImplCopyWith<$Res> {
  __$$RefreshMyReservationsImplCopyWithImpl(
    _$RefreshMyReservationsImpl _value,
    $Res Function(_$RefreshMyReservationsImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of MyReservationsEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$RefreshMyReservationsImpl implements RefreshMyReservations {
  const _$RefreshMyReservationsImpl();

  @override
  String toString() {
    return 'MyReservationsEvent.refresh()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RefreshMyReservationsImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() load,
    required TResult Function() refresh,
    required TResult Function() showAllHistory,
    required TResult Function(String reservationId) cancel,
    required TResult Function(Reservation reservation) startEdit,
    required TResult Function(String date) editDateChanged,
    required TResult Function(String tableId) editTableChanged,
    required TResult Function(String startTime) editTimeSelected,
    required TResult Function(int partySize) editPartySizeChanged,
    required TResult Function() submitEdit,
  }) {
    return refresh();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? load,
    TResult? Function()? refresh,
    TResult? Function()? showAllHistory,
    TResult? Function(String reservationId)? cancel,
    TResult? Function(Reservation reservation)? startEdit,
    TResult? Function(String date)? editDateChanged,
    TResult? Function(String tableId)? editTableChanged,
    TResult? Function(String startTime)? editTimeSelected,
    TResult? Function(int partySize)? editPartySizeChanged,
    TResult? Function()? submitEdit,
  }) {
    return refresh?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? load,
    TResult Function()? refresh,
    TResult Function()? showAllHistory,
    TResult Function(String reservationId)? cancel,
    TResult Function(Reservation reservation)? startEdit,
    TResult Function(String date)? editDateChanged,
    TResult Function(String tableId)? editTableChanged,
    TResult Function(String startTime)? editTimeSelected,
    TResult Function(int partySize)? editPartySizeChanged,
    TResult Function()? submitEdit,
    required TResult orElse(),
  }) {
    if (refresh != null) {
      return refresh();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(LoadMyReservations value) load,
    required TResult Function(RefreshMyReservations value) refresh,
    required TResult Function(ShowAllHistory value) showAllHistory,
    required TResult Function(CancelReservation value) cancel,
    required TResult Function(StartEditReservation value) startEdit,
    required TResult Function(EditDateChanged value) editDateChanged,
    required TResult Function(EditTableChanged value) editTableChanged,
    required TResult Function(EditTimeSelected value) editTimeSelected,
    required TResult Function(EditPartySizeChanged value) editPartySizeChanged,
    required TResult Function(SubmitEditReservation value) submitEdit,
  }) {
    return refresh(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(LoadMyReservations value)? load,
    TResult? Function(RefreshMyReservations value)? refresh,
    TResult? Function(ShowAllHistory value)? showAllHistory,
    TResult? Function(CancelReservation value)? cancel,
    TResult? Function(StartEditReservation value)? startEdit,
    TResult? Function(EditDateChanged value)? editDateChanged,
    TResult? Function(EditTableChanged value)? editTableChanged,
    TResult? Function(EditTimeSelected value)? editTimeSelected,
    TResult? Function(EditPartySizeChanged value)? editPartySizeChanged,
    TResult? Function(SubmitEditReservation value)? submitEdit,
  }) {
    return refresh?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LoadMyReservations value)? load,
    TResult Function(RefreshMyReservations value)? refresh,
    TResult Function(ShowAllHistory value)? showAllHistory,
    TResult Function(CancelReservation value)? cancel,
    TResult Function(StartEditReservation value)? startEdit,
    TResult Function(EditDateChanged value)? editDateChanged,
    TResult Function(EditTableChanged value)? editTableChanged,
    TResult Function(EditTimeSelected value)? editTimeSelected,
    TResult Function(EditPartySizeChanged value)? editPartySizeChanged,
    TResult Function(SubmitEditReservation value)? submitEdit,
    required TResult orElse(),
  }) {
    if (refresh != null) {
      return refresh(this);
    }
    return orElse();
  }
}

abstract class RefreshMyReservations implements MyReservationsEvent {
  const factory RefreshMyReservations() = _$RefreshMyReservationsImpl;
}

/// @nodoc
abstract class _$$ShowAllHistoryImplCopyWith<$Res> {
  factory _$$ShowAllHistoryImplCopyWith(
    _$ShowAllHistoryImpl value,
    $Res Function(_$ShowAllHistoryImpl) then,
  ) = __$$ShowAllHistoryImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$ShowAllHistoryImplCopyWithImpl<$Res>
    extends _$MyReservationsEventCopyWithImpl<$Res, _$ShowAllHistoryImpl>
    implements _$$ShowAllHistoryImplCopyWith<$Res> {
  __$$ShowAllHistoryImplCopyWithImpl(
    _$ShowAllHistoryImpl _value,
    $Res Function(_$ShowAllHistoryImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of MyReservationsEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$ShowAllHistoryImpl implements ShowAllHistory {
  const _$ShowAllHistoryImpl();

  @override
  String toString() {
    return 'MyReservationsEvent.showAllHistory()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$ShowAllHistoryImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() load,
    required TResult Function() refresh,
    required TResult Function() showAllHistory,
    required TResult Function(String reservationId) cancel,
    required TResult Function(Reservation reservation) startEdit,
    required TResult Function(String date) editDateChanged,
    required TResult Function(String tableId) editTableChanged,
    required TResult Function(String startTime) editTimeSelected,
    required TResult Function(int partySize) editPartySizeChanged,
    required TResult Function() submitEdit,
  }) {
    return showAllHistory();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? load,
    TResult? Function()? refresh,
    TResult? Function()? showAllHistory,
    TResult? Function(String reservationId)? cancel,
    TResult? Function(Reservation reservation)? startEdit,
    TResult? Function(String date)? editDateChanged,
    TResult? Function(String tableId)? editTableChanged,
    TResult? Function(String startTime)? editTimeSelected,
    TResult? Function(int partySize)? editPartySizeChanged,
    TResult? Function()? submitEdit,
  }) {
    return showAllHistory?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? load,
    TResult Function()? refresh,
    TResult Function()? showAllHistory,
    TResult Function(String reservationId)? cancel,
    TResult Function(Reservation reservation)? startEdit,
    TResult Function(String date)? editDateChanged,
    TResult Function(String tableId)? editTableChanged,
    TResult Function(String startTime)? editTimeSelected,
    TResult Function(int partySize)? editPartySizeChanged,
    TResult Function()? submitEdit,
    required TResult orElse(),
  }) {
    if (showAllHistory != null) {
      return showAllHistory();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(LoadMyReservations value) load,
    required TResult Function(RefreshMyReservations value) refresh,
    required TResult Function(ShowAllHistory value) showAllHistory,
    required TResult Function(CancelReservation value) cancel,
    required TResult Function(StartEditReservation value) startEdit,
    required TResult Function(EditDateChanged value) editDateChanged,
    required TResult Function(EditTableChanged value) editTableChanged,
    required TResult Function(EditTimeSelected value) editTimeSelected,
    required TResult Function(EditPartySizeChanged value) editPartySizeChanged,
    required TResult Function(SubmitEditReservation value) submitEdit,
  }) {
    return showAllHistory(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(LoadMyReservations value)? load,
    TResult? Function(RefreshMyReservations value)? refresh,
    TResult? Function(ShowAllHistory value)? showAllHistory,
    TResult? Function(CancelReservation value)? cancel,
    TResult? Function(StartEditReservation value)? startEdit,
    TResult? Function(EditDateChanged value)? editDateChanged,
    TResult? Function(EditTableChanged value)? editTableChanged,
    TResult? Function(EditTimeSelected value)? editTimeSelected,
    TResult? Function(EditPartySizeChanged value)? editPartySizeChanged,
    TResult? Function(SubmitEditReservation value)? submitEdit,
  }) {
    return showAllHistory?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LoadMyReservations value)? load,
    TResult Function(RefreshMyReservations value)? refresh,
    TResult Function(ShowAllHistory value)? showAllHistory,
    TResult Function(CancelReservation value)? cancel,
    TResult Function(StartEditReservation value)? startEdit,
    TResult Function(EditDateChanged value)? editDateChanged,
    TResult Function(EditTableChanged value)? editTableChanged,
    TResult Function(EditTimeSelected value)? editTimeSelected,
    TResult Function(EditPartySizeChanged value)? editPartySizeChanged,
    TResult Function(SubmitEditReservation value)? submitEdit,
    required TResult orElse(),
  }) {
    if (showAllHistory != null) {
      return showAllHistory(this);
    }
    return orElse();
  }
}

abstract class ShowAllHistory implements MyReservationsEvent {
  const factory ShowAllHistory() = _$ShowAllHistoryImpl;
}

/// @nodoc
abstract class _$$CancelReservationImplCopyWith<$Res> {
  factory _$$CancelReservationImplCopyWith(
    _$CancelReservationImpl value,
    $Res Function(_$CancelReservationImpl) then,
  ) = __$$CancelReservationImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String reservationId});
}

/// @nodoc
class __$$CancelReservationImplCopyWithImpl<$Res>
    extends _$MyReservationsEventCopyWithImpl<$Res, _$CancelReservationImpl>
    implements _$$CancelReservationImplCopyWith<$Res> {
  __$$CancelReservationImplCopyWithImpl(
    _$CancelReservationImpl _value,
    $Res Function(_$CancelReservationImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of MyReservationsEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? reservationId = null}) {
    return _then(
      _$CancelReservationImpl(
        reservationId:
            null == reservationId
                ? _value.reservationId
                : reservationId // ignore: cast_nullable_to_non_nullable
                    as String,
      ),
    );
  }
}

/// @nodoc

class _$CancelReservationImpl implements CancelReservation {
  const _$CancelReservationImpl({required this.reservationId});

  @override
  final String reservationId;

  @override
  String toString() {
    return 'MyReservationsEvent.cancel(reservationId: $reservationId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CancelReservationImpl &&
            (identical(other.reservationId, reservationId) ||
                other.reservationId == reservationId));
  }

  @override
  int get hashCode => Object.hash(runtimeType, reservationId);

  /// Create a copy of MyReservationsEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CancelReservationImplCopyWith<_$CancelReservationImpl> get copyWith =>
      __$$CancelReservationImplCopyWithImpl<_$CancelReservationImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() load,
    required TResult Function() refresh,
    required TResult Function() showAllHistory,
    required TResult Function(String reservationId) cancel,
    required TResult Function(Reservation reservation) startEdit,
    required TResult Function(String date) editDateChanged,
    required TResult Function(String tableId) editTableChanged,
    required TResult Function(String startTime) editTimeSelected,
    required TResult Function(int partySize) editPartySizeChanged,
    required TResult Function() submitEdit,
  }) {
    return cancel(reservationId);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? load,
    TResult? Function()? refresh,
    TResult? Function()? showAllHistory,
    TResult? Function(String reservationId)? cancel,
    TResult? Function(Reservation reservation)? startEdit,
    TResult? Function(String date)? editDateChanged,
    TResult? Function(String tableId)? editTableChanged,
    TResult? Function(String startTime)? editTimeSelected,
    TResult? Function(int partySize)? editPartySizeChanged,
    TResult? Function()? submitEdit,
  }) {
    return cancel?.call(reservationId);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? load,
    TResult Function()? refresh,
    TResult Function()? showAllHistory,
    TResult Function(String reservationId)? cancel,
    TResult Function(Reservation reservation)? startEdit,
    TResult Function(String date)? editDateChanged,
    TResult Function(String tableId)? editTableChanged,
    TResult Function(String startTime)? editTimeSelected,
    TResult Function(int partySize)? editPartySizeChanged,
    TResult Function()? submitEdit,
    required TResult orElse(),
  }) {
    if (cancel != null) {
      return cancel(reservationId);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(LoadMyReservations value) load,
    required TResult Function(RefreshMyReservations value) refresh,
    required TResult Function(ShowAllHistory value) showAllHistory,
    required TResult Function(CancelReservation value) cancel,
    required TResult Function(StartEditReservation value) startEdit,
    required TResult Function(EditDateChanged value) editDateChanged,
    required TResult Function(EditTableChanged value) editTableChanged,
    required TResult Function(EditTimeSelected value) editTimeSelected,
    required TResult Function(EditPartySizeChanged value) editPartySizeChanged,
    required TResult Function(SubmitEditReservation value) submitEdit,
  }) {
    return cancel(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(LoadMyReservations value)? load,
    TResult? Function(RefreshMyReservations value)? refresh,
    TResult? Function(ShowAllHistory value)? showAllHistory,
    TResult? Function(CancelReservation value)? cancel,
    TResult? Function(StartEditReservation value)? startEdit,
    TResult? Function(EditDateChanged value)? editDateChanged,
    TResult? Function(EditTableChanged value)? editTableChanged,
    TResult? Function(EditTimeSelected value)? editTimeSelected,
    TResult? Function(EditPartySizeChanged value)? editPartySizeChanged,
    TResult? Function(SubmitEditReservation value)? submitEdit,
  }) {
    return cancel?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LoadMyReservations value)? load,
    TResult Function(RefreshMyReservations value)? refresh,
    TResult Function(ShowAllHistory value)? showAllHistory,
    TResult Function(CancelReservation value)? cancel,
    TResult Function(StartEditReservation value)? startEdit,
    TResult Function(EditDateChanged value)? editDateChanged,
    TResult Function(EditTableChanged value)? editTableChanged,
    TResult Function(EditTimeSelected value)? editTimeSelected,
    TResult Function(EditPartySizeChanged value)? editPartySizeChanged,
    TResult Function(SubmitEditReservation value)? submitEdit,
    required TResult orElse(),
  }) {
    if (cancel != null) {
      return cancel(this);
    }
    return orElse();
  }
}

abstract class CancelReservation implements MyReservationsEvent {
  const factory CancelReservation({required final String reservationId}) =
      _$CancelReservationImpl;

  String get reservationId;

  /// Create a copy of MyReservationsEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CancelReservationImplCopyWith<_$CancelReservationImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$StartEditReservationImplCopyWith<$Res> {
  factory _$$StartEditReservationImplCopyWith(
    _$StartEditReservationImpl value,
    $Res Function(_$StartEditReservationImpl) then,
  ) = __$$StartEditReservationImplCopyWithImpl<$Res>;
  @useResult
  $Res call({Reservation reservation});

  $ReservationCopyWith<$Res> get reservation;
}

/// @nodoc
class __$$StartEditReservationImplCopyWithImpl<$Res>
    extends _$MyReservationsEventCopyWithImpl<$Res, _$StartEditReservationImpl>
    implements _$$StartEditReservationImplCopyWith<$Res> {
  __$$StartEditReservationImplCopyWithImpl(
    _$StartEditReservationImpl _value,
    $Res Function(_$StartEditReservationImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of MyReservationsEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? reservation = null}) {
    return _then(
      _$StartEditReservationImpl(
        reservation:
            null == reservation
                ? _value.reservation
                : reservation // ignore: cast_nullable_to_non_nullable
                    as Reservation,
      ),
    );
  }

  /// Create a copy of MyReservationsEvent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ReservationCopyWith<$Res> get reservation {
    return $ReservationCopyWith<$Res>(_value.reservation, (value) {
      return _then(_value.copyWith(reservation: value));
    });
  }
}

/// @nodoc

class _$StartEditReservationImpl implements StartEditReservation {
  const _$StartEditReservationImpl({required this.reservation});

  @override
  final Reservation reservation;

  @override
  String toString() {
    return 'MyReservationsEvent.startEdit(reservation: $reservation)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$StartEditReservationImpl &&
            (identical(other.reservation, reservation) ||
                other.reservation == reservation));
  }

  @override
  int get hashCode => Object.hash(runtimeType, reservation);

  /// Create a copy of MyReservationsEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$StartEditReservationImplCopyWith<_$StartEditReservationImpl>
  get copyWith =>
      __$$StartEditReservationImplCopyWithImpl<_$StartEditReservationImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() load,
    required TResult Function() refresh,
    required TResult Function() showAllHistory,
    required TResult Function(String reservationId) cancel,
    required TResult Function(Reservation reservation) startEdit,
    required TResult Function(String date) editDateChanged,
    required TResult Function(String tableId) editTableChanged,
    required TResult Function(String startTime) editTimeSelected,
    required TResult Function(int partySize) editPartySizeChanged,
    required TResult Function() submitEdit,
  }) {
    return startEdit(reservation);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? load,
    TResult? Function()? refresh,
    TResult? Function()? showAllHistory,
    TResult? Function(String reservationId)? cancel,
    TResult? Function(Reservation reservation)? startEdit,
    TResult? Function(String date)? editDateChanged,
    TResult? Function(String tableId)? editTableChanged,
    TResult? Function(String startTime)? editTimeSelected,
    TResult? Function(int partySize)? editPartySizeChanged,
    TResult? Function()? submitEdit,
  }) {
    return startEdit?.call(reservation);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? load,
    TResult Function()? refresh,
    TResult Function()? showAllHistory,
    TResult Function(String reservationId)? cancel,
    TResult Function(Reservation reservation)? startEdit,
    TResult Function(String date)? editDateChanged,
    TResult Function(String tableId)? editTableChanged,
    TResult Function(String startTime)? editTimeSelected,
    TResult Function(int partySize)? editPartySizeChanged,
    TResult Function()? submitEdit,
    required TResult orElse(),
  }) {
    if (startEdit != null) {
      return startEdit(reservation);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(LoadMyReservations value) load,
    required TResult Function(RefreshMyReservations value) refresh,
    required TResult Function(ShowAllHistory value) showAllHistory,
    required TResult Function(CancelReservation value) cancel,
    required TResult Function(StartEditReservation value) startEdit,
    required TResult Function(EditDateChanged value) editDateChanged,
    required TResult Function(EditTableChanged value) editTableChanged,
    required TResult Function(EditTimeSelected value) editTimeSelected,
    required TResult Function(EditPartySizeChanged value) editPartySizeChanged,
    required TResult Function(SubmitEditReservation value) submitEdit,
  }) {
    return startEdit(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(LoadMyReservations value)? load,
    TResult? Function(RefreshMyReservations value)? refresh,
    TResult? Function(ShowAllHistory value)? showAllHistory,
    TResult? Function(CancelReservation value)? cancel,
    TResult? Function(StartEditReservation value)? startEdit,
    TResult? Function(EditDateChanged value)? editDateChanged,
    TResult? Function(EditTableChanged value)? editTableChanged,
    TResult? Function(EditTimeSelected value)? editTimeSelected,
    TResult? Function(EditPartySizeChanged value)? editPartySizeChanged,
    TResult? Function(SubmitEditReservation value)? submitEdit,
  }) {
    return startEdit?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LoadMyReservations value)? load,
    TResult Function(RefreshMyReservations value)? refresh,
    TResult Function(ShowAllHistory value)? showAllHistory,
    TResult Function(CancelReservation value)? cancel,
    TResult Function(StartEditReservation value)? startEdit,
    TResult Function(EditDateChanged value)? editDateChanged,
    TResult Function(EditTableChanged value)? editTableChanged,
    TResult Function(EditTimeSelected value)? editTimeSelected,
    TResult Function(EditPartySizeChanged value)? editPartySizeChanged,
    TResult Function(SubmitEditReservation value)? submitEdit,
    required TResult orElse(),
  }) {
    if (startEdit != null) {
      return startEdit(this);
    }
    return orElse();
  }
}

abstract class StartEditReservation implements MyReservationsEvent {
  const factory StartEditReservation({required final Reservation reservation}) =
      _$StartEditReservationImpl;

  Reservation get reservation;

  /// Create a copy of MyReservationsEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$StartEditReservationImplCopyWith<_$StartEditReservationImpl>
  get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$EditDateChangedImplCopyWith<$Res> {
  factory _$$EditDateChangedImplCopyWith(
    _$EditDateChangedImpl value,
    $Res Function(_$EditDateChangedImpl) then,
  ) = __$$EditDateChangedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String date});
}

/// @nodoc
class __$$EditDateChangedImplCopyWithImpl<$Res>
    extends _$MyReservationsEventCopyWithImpl<$Res, _$EditDateChangedImpl>
    implements _$$EditDateChangedImplCopyWith<$Res> {
  __$$EditDateChangedImplCopyWithImpl(
    _$EditDateChangedImpl _value,
    $Res Function(_$EditDateChangedImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of MyReservationsEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? date = null}) {
    return _then(
      _$EditDateChangedImpl(
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

class _$EditDateChangedImpl implements EditDateChanged {
  const _$EditDateChangedImpl({required this.date});

  @override
  final String date;

  @override
  String toString() {
    return 'MyReservationsEvent.editDateChanged(date: $date)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EditDateChangedImpl &&
            (identical(other.date, date) || other.date == date));
  }

  @override
  int get hashCode => Object.hash(runtimeType, date);

  /// Create a copy of MyReservationsEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$EditDateChangedImplCopyWith<_$EditDateChangedImpl> get copyWith =>
      __$$EditDateChangedImplCopyWithImpl<_$EditDateChangedImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() load,
    required TResult Function() refresh,
    required TResult Function() showAllHistory,
    required TResult Function(String reservationId) cancel,
    required TResult Function(Reservation reservation) startEdit,
    required TResult Function(String date) editDateChanged,
    required TResult Function(String tableId) editTableChanged,
    required TResult Function(String startTime) editTimeSelected,
    required TResult Function(int partySize) editPartySizeChanged,
    required TResult Function() submitEdit,
  }) {
    return editDateChanged(date);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? load,
    TResult? Function()? refresh,
    TResult? Function()? showAllHistory,
    TResult? Function(String reservationId)? cancel,
    TResult? Function(Reservation reservation)? startEdit,
    TResult? Function(String date)? editDateChanged,
    TResult? Function(String tableId)? editTableChanged,
    TResult? Function(String startTime)? editTimeSelected,
    TResult? Function(int partySize)? editPartySizeChanged,
    TResult? Function()? submitEdit,
  }) {
    return editDateChanged?.call(date);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? load,
    TResult Function()? refresh,
    TResult Function()? showAllHistory,
    TResult Function(String reservationId)? cancel,
    TResult Function(Reservation reservation)? startEdit,
    TResult Function(String date)? editDateChanged,
    TResult Function(String tableId)? editTableChanged,
    TResult Function(String startTime)? editTimeSelected,
    TResult Function(int partySize)? editPartySizeChanged,
    TResult Function()? submitEdit,
    required TResult orElse(),
  }) {
    if (editDateChanged != null) {
      return editDateChanged(date);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(LoadMyReservations value) load,
    required TResult Function(RefreshMyReservations value) refresh,
    required TResult Function(ShowAllHistory value) showAllHistory,
    required TResult Function(CancelReservation value) cancel,
    required TResult Function(StartEditReservation value) startEdit,
    required TResult Function(EditDateChanged value) editDateChanged,
    required TResult Function(EditTableChanged value) editTableChanged,
    required TResult Function(EditTimeSelected value) editTimeSelected,
    required TResult Function(EditPartySizeChanged value) editPartySizeChanged,
    required TResult Function(SubmitEditReservation value) submitEdit,
  }) {
    return editDateChanged(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(LoadMyReservations value)? load,
    TResult? Function(RefreshMyReservations value)? refresh,
    TResult? Function(ShowAllHistory value)? showAllHistory,
    TResult? Function(CancelReservation value)? cancel,
    TResult? Function(StartEditReservation value)? startEdit,
    TResult? Function(EditDateChanged value)? editDateChanged,
    TResult? Function(EditTableChanged value)? editTableChanged,
    TResult? Function(EditTimeSelected value)? editTimeSelected,
    TResult? Function(EditPartySizeChanged value)? editPartySizeChanged,
    TResult? Function(SubmitEditReservation value)? submitEdit,
  }) {
    return editDateChanged?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LoadMyReservations value)? load,
    TResult Function(RefreshMyReservations value)? refresh,
    TResult Function(ShowAllHistory value)? showAllHistory,
    TResult Function(CancelReservation value)? cancel,
    TResult Function(StartEditReservation value)? startEdit,
    TResult Function(EditDateChanged value)? editDateChanged,
    TResult Function(EditTableChanged value)? editTableChanged,
    TResult Function(EditTimeSelected value)? editTimeSelected,
    TResult Function(EditPartySizeChanged value)? editPartySizeChanged,
    TResult Function(SubmitEditReservation value)? submitEdit,
    required TResult orElse(),
  }) {
    if (editDateChanged != null) {
      return editDateChanged(this);
    }
    return orElse();
  }
}

abstract class EditDateChanged implements MyReservationsEvent {
  const factory EditDateChanged({required final String date}) =
      _$EditDateChangedImpl;

  String get date;

  /// Create a copy of MyReservationsEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$EditDateChangedImplCopyWith<_$EditDateChangedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$EditTableChangedImplCopyWith<$Res> {
  factory _$$EditTableChangedImplCopyWith(
    _$EditTableChangedImpl value,
    $Res Function(_$EditTableChangedImpl) then,
  ) = __$$EditTableChangedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String tableId});
}

/// @nodoc
class __$$EditTableChangedImplCopyWithImpl<$Res>
    extends _$MyReservationsEventCopyWithImpl<$Res, _$EditTableChangedImpl>
    implements _$$EditTableChangedImplCopyWith<$Res> {
  __$$EditTableChangedImplCopyWithImpl(
    _$EditTableChangedImpl _value,
    $Res Function(_$EditTableChangedImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of MyReservationsEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? tableId = null}) {
    return _then(
      _$EditTableChangedImpl(
        tableId:
            null == tableId
                ? _value.tableId
                : tableId // ignore: cast_nullable_to_non_nullable
                    as String,
      ),
    );
  }
}

/// @nodoc

class _$EditTableChangedImpl implements EditTableChanged {
  const _$EditTableChangedImpl({required this.tableId});

  @override
  final String tableId;

  @override
  String toString() {
    return 'MyReservationsEvent.editTableChanged(tableId: $tableId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EditTableChangedImpl &&
            (identical(other.tableId, tableId) || other.tableId == tableId));
  }

  @override
  int get hashCode => Object.hash(runtimeType, tableId);

  /// Create a copy of MyReservationsEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$EditTableChangedImplCopyWith<_$EditTableChangedImpl> get copyWith =>
      __$$EditTableChangedImplCopyWithImpl<_$EditTableChangedImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() load,
    required TResult Function() refresh,
    required TResult Function() showAllHistory,
    required TResult Function(String reservationId) cancel,
    required TResult Function(Reservation reservation) startEdit,
    required TResult Function(String date) editDateChanged,
    required TResult Function(String tableId) editTableChanged,
    required TResult Function(String startTime) editTimeSelected,
    required TResult Function(int partySize) editPartySizeChanged,
    required TResult Function() submitEdit,
  }) {
    return editTableChanged(tableId);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? load,
    TResult? Function()? refresh,
    TResult? Function()? showAllHistory,
    TResult? Function(String reservationId)? cancel,
    TResult? Function(Reservation reservation)? startEdit,
    TResult? Function(String date)? editDateChanged,
    TResult? Function(String tableId)? editTableChanged,
    TResult? Function(String startTime)? editTimeSelected,
    TResult? Function(int partySize)? editPartySizeChanged,
    TResult? Function()? submitEdit,
  }) {
    return editTableChanged?.call(tableId);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? load,
    TResult Function()? refresh,
    TResult Function()? showAllHistory,
    TResult Function(String reservationId)? cancel,
    TResult Function(Reservation reservation)? startEdit,
    TResult Function(String date)? editDateChanged,
    TResult Function(String tableId)? editTableChanged,
    TResult Function(String startTime)? editTimeSelected,
    TResult Function(int partySize)? editPartySizeChanged,
    TResult Function()? submitEdit,
    required TResult orElse(),
  }) {
    if (editTableChanged != null) {
      return editTableChanged(tableId);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(LoadMyReservations value) load,
    required TResult Function(RefreshMyReservations value) refresh,
    required TResult Function(ShowAllHistory value) showAllHistory,
    required TResult Function(CancelReservation value) cancel,
    required TResult Function(StartEditReservation value) startEdit,
    required TResult Function(EditDateChanged value) editDateChanged,
    required TResult Function(EditTableChanged value) editTableChanged,
    required TResult Function(EditTimeSelected value) editTimeSelected,
    required TResult Function(EditPartySizeChanged value) editPartySizeChanged,
    required TResult Function(SubmitEditReservation value) submitEdit,
  }) {
    return editTableChanged(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(LoadMyReservations value)? load,
    TResult? Function(RefreshMyReservations value)? refresh,
    TResult? Function(ShowAllHistory value)? showAllHistory,
    TResult? Function(CancelReservation value)? cancel,
    TResult? Function(StartEditReservation value)? startEdit,
    TResult? Function(EditDateChanged value)? editDateChanged,
    TResult? Function(EditTableChanged value)? editTableChanged,
    TResult? Function(EditTimeSelected value)? editTimeSelected,
    TResult? Function(EditPartySizeChanged value)? editPartySizeChanged,
    TResult? Function(SubmitEditReservation value)? submitEdit,
  }) {
    return editTableChanged?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LoadMyReservations value)? load,
    TResult Function(RefreshMyReservations value)? refresh,
    TResult Function(ShowAllHistory value)? showAllHistory,
    TResult Function(CancelReservation value)? cancel,
    TResult Function(StartEditReservation value)? startEdit,
    TResult Function(EditDateChanged value)? editDateChanged,
    TResult Function(EditTableChanged value)? editTableChanged,
    TResult Function(EditTimeSelected value)? editTimeSelected,
    TResult Function(EditPartySizeChanged value)? editPartySizeChanged,
    TResult Function(SubmitEditReservation value)? submitEdit,
    required TResult orElse(),
  }) {
    if (editTableChanged != null) {
      return editTableChanged(this);
    }
    return orElse();
  }
}

abstract class EditTableChanged implements MyReservationsEvent {
  const factory EditTableChanged({required final String tableId}) =
      _$EditTableChangedImpl;

  String get tableId;

  /// Create a copy of MyReservationsEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$EditTableChangedImplCopyWith<_$EditTableChangedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$EditTimeSelectedImplCopyWith<$Res> {
  factory _$$EditTimeSelectedImplCopyWith(
    _$EditTimeSelectedImpl value,
    $Res Function(_$EditTimeSelectedImpl) then,
  ) = __$$EditTimeSelectedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String startTime});
}

/// @nodoc
class __$$EditTimeSelectedImplCopyWithImpl<$Res>
    extends _$MyReservationsEventCopyWithImpl<$Res, _$EditTimeSelectedImpl>
    implements _$$EditTimeSelectedImplCopyWith<$Res> {
  __$$EditTimeSelectedImplCopyWithImpl(
    _$EditTimeSelectedImpl _value,
    $Res Function(_$EditTimeSelectedImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of MyReservationsEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? startTime = null}) {
    return _then(
      _$EditTimeSelectedImpl(
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

class _$EditTimeSelectedImpl implements EditTimeSelected {
  const _$EditTimeSelectedImpl({required this.startTime});

  @override
  final String startTime;

  @override
  String toString() {
    return 'MyReservationsEvent.editTimeSelected(startTime: $startTime)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EditTimeSelectedImpl &&
            (identical(other.startTime, startTime) ||
                other.startTime == startTime));
  }

  @override
  int get hashCode => Object.hash(runtimeType, startTime);

  /// Create a copy of MyReservationsEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$EditTimeSelectedImplCopyWith<_$EditTimeSelectedImpl> get copyWith =>
      __$$EditTimeSelectedImplCopyWithImpl<_$EditTimeSelectedImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() load,
    required TResult Function() refresh,
    required TResult Function() showAllHistory,
    required TResult Function(String reservationId) cancel,
    required TResult Function(Reservation reservation) startEdit,
    required TResult Function(String date) editDateChanged,
    required TResult Function(String tableId) editTableChanged,
    required TResult Function(String startTime) editTimeSelected,
    required TResult Function(int partySize) editPartySizeChanged,
    required TResult Function() submitEdit,
  }) {
    return editTimeSelected(startTime);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? load,
    TResult? Function()? refresh,
    TResult? Function()? showAllHistory,
    TResult? Function(String reservationId)? cancel,
    TResult? Function(Reservation reservation)? startEdit,
    TResult? Function(String date)? editDateChanged,
    TResult? Function(String tableId)? editTableChanged,
    TResult? Function(String startTime)? editTimeSelected,
    TResult? Function(int partySize)? editPartySizeChanged,
    TResult? Function()? submitEdit,
  }) {
    return editTimeSelected?.call(startTime);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? load,
    TResult Function()? refresh,
    TResult Function()? showAllHistory,
    TResult Function(String reservationId)? cancel,
    TResult Function(Reservation reservation)? startEdit,
    TResult Function(String date)? editDateChanged,
    TResult Function(String tableId)? editTableChanged,
    TResult Function(String startTime)? editTimeSelected,
    TResult Function(int partySize)? editPartySizeChanged,
    TResult Function()? submitEdit,
    required TResult orElse(),
  }) {
    if (editTimeSelected != null) {
      return editTimeSelected(startTime);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(LoadMyReservations value) load,
    required TResult Function(RefreshMyReservations value) refresh,
    required TResult Function(ShowAllHistory value) showAllHistory,
    required TResult Function(CancelReservation value) cancel,
    required TResult Function(StartEditReservation value) startEdit,
    required TResult Function(EditDateChanged value) editDateChanged,
    required TResult Function(EditTableChanged value) editTableChanged,
    required TResult Function(EditTimeSelected value) editTimeSelected,
    required TResult Function(EditPartySizeChanged value) editPartySizeChanged,
    required TResult Function(SubmitEditReservation value) submitEdit,
  }) {
    return editTimeSelected(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(LoadMyReservations value)? load,
    TResult? Function(RefreshMyReservations value)? refresh,
    TResult? Function(ShowAllHistory value)? showAllHistory,
    TResult? Function(CancelReservation value)? cancel,
    TResult? Function(StartEditReservation value)? startEdit,
    TResult? Function(EditDateChanged value)? editDateChanged,
    TResult? Function(EditTableChanged value)? editTableChanged,
    TResult? Function(EditTimeSelected value)? editTimeSelected,
    TResult? Function(EditPartySizeChanged value)? editPartySizeChanged,
    TResult? Function(SubmitEditReservation value)? submitEdit,
  }) {
    return editTimeSelected?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LoadMyReservations value)? load,
    TResult Function(RefreshMyReservations value)? refresh,
    TResult Function(ShowAllHistory value)? showAllHistory,
    TResult Function(CancelReservation value)? cancel,
    TResult Function(StartEditReservation value)? startEdit,
    TResult Function(EditDateChanged value)? editDateChanged,
    TResult Function(EditTableChanged value)? editTableChanged,
    TResult Function(EditTimeSelected value)? editTimeSelected,
    TResult Function(EditPartySizeChanged value)? editPartySizeChanged,
    TResult Function(SubmitEditReservation value)? submitEdit,
    required TResult orElse(),
  }) {
    if (editTimeSelected != null) {
      return editTimeSelected(this);
    }
    return orElse();
  }
}

abstract class EditTimeSelected implements MyReservationsEvent {
  const factory EditTimeSelected({required final String startTime}) =
      _$EditTimeSelectedImpl;

  String get startTime;

  /// Create a copy of MyReservationsEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$EditTimeSelectedImplCopyWith<_$EditTimeSelectedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$EditPartySizeChangedImplCopyWith<$Res> {
  factory _$$EditPartySizeChangedImplCopyWith(
    _$EditPartySizeChangedImpl value,
    $Res Function(_$EditPartySizeChangedImpl) then,
  ) = __$$EditPartySizeChangedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({int partySize});
}

/// @nodoc
class __$$EditPartySizeChangedImplCopyWithImpl<$Res>
    extends _$MyReservationsEventCopyWithImpl<$Res, _$EditPartySizeChangedImpl>
    implements _$$EditPartySizeChangedImplCopyWith<$Res> {
  __$$EditPartySizeChangedImplCopyWithImpl(
    _$EditPartySizeChangedImpl _value,
    $Res Function(_$EditPartySizeChangedImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of MyReservationsEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? partySize = null}) {
    return _then(
      _$EditPartySizeChangedImpl(
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

class _$EditPartySizeChangedImpl implements EditPartySizeChanged {
  const _$EditPartySizeChangedImpl({required this.partySize});

  @override
  final int partySize;

  @override
  String toString() {
    return 'MyReservationsEvent.editPartySizeChanged(partySize: $partySize)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EditPartySizeChangedImpl &&
            (identical(other.partySize, partySize) ||
                other.partySize == partySize));
  }

  @override
  int get hashCode => Object.hash(runtimeType, partySize);

  /// Create a copy of MyReservationsEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$EditPartySizeChangedImplCopyWith<_$EditPartySizeChangedImpl>
  get copyWith =>
      __$$EditPartySizeChangedImplCopyWithImpl<_$EditPartySizeChangedImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() load,
    required TResult Function() refresh,
    required TResult Function() showAllHistory,
    required TResult Function(String reservationId) cancel,
    required TResult Function(Reservation reservation) startEdit,
    required TResult Function(String date) editDateChanged,
    required TResult Function(String tableId) editTableChanged,
    required TResult Function(String startTime) editTimeSelected,
    required TResult Function(int partySize) editPartySizeChanged,
    required TResult Function() submitEdit,
  }) {
    return editPartySizeChanged(partySize);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? load,
    TResult? Function()? refresh,
    TResult? Function()? showAllHistory,
    TResult? Function(String reservationId)? cancel,
    TResult? Function(Reservation reservation)? startEdit,
    TResult? Function(String date)? editDateChanged,
    TResult? Function(String tableId)? editTableChanged,
    TResult? Function(String startTime)? editTimeSelected,
    TResult? Function(int partySize)? editPartySizeChanged,
    TResult? Function()? submitEdit,
  }) {
    return editPartySizeChanged?.call(partySize);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? load,
    TResult Function()? refresh,
    TResult Function()? showAllHistory,
    TResult Function(String reservationId)? cancel,
    TResult Function(Reservation reservation)? startEdit,
    TResult Function(String date)? editDateChanged,
    TResult Function(String tableId)? editTableChanged,
    TResult Function(String startTime)? editTimeSelected,
    TResult Function(int partySize)? editPartySizeChanged,
    TResult Function()? submitEdit,
    required TResult orElse(),
  }) {
    if (editPartySizeChanged != null) {
      return editPartySizeChanged(partySize);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(LoadMyReservations value) load,
    required TResult Function(RefreshMyReservations value) refresh,
    required TResult Function(ShowAllHistory value) showAllHistory,
    required TResult Function(CancelReservation value) cancel,
    required TResult Function(StartEditReservation value) startEdit,
    required TResult Function(EditDateChanged value) editDateChanged,
    required TResult Function(EditTableChanged value) editTableChanged,
    required TResult Function(EditTimeSelected value) editTimeSelected,
    required TResult Function(EditPartySizeChanged value) editPartySizeChanged,
    required TResult Function(SubmitEditReservation value) submitEdit,
  }) {
    return editPartySizeChanged(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(LoadMyReservations value)? load,
    TResult? Function(RefreshMyReservations value)? refresh,
    TResult? Function(ShowAllHistory value)? showAllHistory,
    TResult? Function(CancelReservation value)? cancel,
    TResult? Function(StartEditReservation value)? startEdit,
    TResult? Function(EditDateChanged value)? editDateChanged,
    TResult? Function(EditTableChanged value)? editTableChanged,
    TResult? Function(EditTimeSelected value)? editTimeSelected,
    TResult? Function(EditPartySizeChanged value)? editPartySizeChanged,
    TResult? Function(SubmitEditReservation value)? submitEdit,
  }) {
    return editPartySizeChanged?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LoadMyReservations value)? load,
    TResult Function(RefreshMyReservations value)? refresh,
    TResult Function(ShowAllHistory value)? showAllHistory,
    TResult Function(CancelReservation value)? cancel,
    TResult Function(StartEditReservation value)? startEdit,
    TResult Function(EditDateChanged value)? editDateChanged,
    TResult Function(EditTableChanged value)? editTableChanged,
    TResult Function(EditTimeSelected value)? editTimeSelected,
    TResult Function(EditPartySizeChanged value)? editPartySizeChanged,
    TResult Function(SubmitEditReservation value)? submitEdit,
    required TResult orElse(),
  }) {
    if (editPartySizeChanged != null) {
      return editPartySizeChanged(this);
    }
    return orElse();
  }
}

abstract class EditPartySizeChanged implements MyReservationsEvent {
  const factory EditPartySizeChanged({required final int partySize}) =
      _$EditPartySizeChangedImpl;

  int get partySize;

  /// Create a copy of MyReservationsEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$EditPartySizeChangedImplCopyWith<_$EditPartySizeChangedImpl>
  get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$SubmitEditReservationImplCopyWith<$Res> {
  factory _$$SubmitEditReservationImplCopyWith(
    _$SubmitEditReservationImpl value,
    $Res Function(_$SubmitEditReservationImpl) then,
  ) = __$$SubmitEditReservationImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$SubmitEditReservationImplCopyWithImpl<$Res>
    extends _$MyReservationsEventCopyWithImpl<$Res, _$SubmitEditReservationImpl>
    implements _$$SubmitEditReservationImplCopyWith<$Res> {
  __$$SubmitEditReservationImplCopyWithImpl(
    _$SubmitEditReservationImpl _value,
    $Res Function(_$SubmitEditReservationImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of MyReservationsEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$SubmitEditReservationImpl implements SubmitEditReservation {
  const _$SubmitEditReservationImpl();

  @override
  String toString() {
    return 'MyReservationsEvent.submitEdit()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SubmitEditReservationImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() load,
    required TResult Function() refresh,
    required TResult Function() showAllHistory,
    required TResult Function(String reservationId) cancel,
    required TResult Function(Reservation reservation) startEdit,
    required TResult Function(String date) editDateChanged,
    required TResult Function(String tableId) editTableChanged,
    required TResult Function(String startTime) editTimeSelected,
    required TResult Function(int partySize) editPartySizeChanged,
    required TResult Function() submitEdit,
  }) {
    return submitEdit();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? load,
    TResult? Function()? refresh,
    TResult? Function()? showAllHistory,
    TResult? Function(String reservationId)? cancel,
    TResult? Function(Reservation reservation)? startEdit,
    TResult? Function(String date)? editDateChanged,
    TResult? Function(String tableId)? editTableChanged,
    TResult? Function(String startTime)? editTimeSelected,
    TResult? Function(int partySize)? editPartySizeChanged,
    TResult? Function()? submitEdit,
  }) {
    return submitEdit?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? load,
    TResult Function()? refresh,
    TResult Function()? showAllHistory,
    TResult Function(String reservationId)? cancel,
    TResult Function(Reservation reservation)? startEdit,
    TResult Function(String date)? editDateChanged,
    TResult Function(String tableId)? editTableChanged,
    TResult Function(String startTime)? editTimeSelected,
    TResult Function(int partySize)? editPartySizeChanged,
    TResult Function()? submitEdit,
    required TResult orElse(),
  }) {
    if (submitEdit != null) {
      return submitEdit();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(LoadMyReservations value) load,
    required TResult Function(RefreshMyReservations value) refresh,
    required TResult Function(ShowAllHistory value) showAllHistory,
    required TResult Function(CancelReservation value) cancel,
    required TResult Function(StartEditReservation value) startEdit,
    required TResult Function(EditDateChanged value) editDateChanged,
    required TResult Function(EditTableChanged value) editTableChanged,
    required TResult Function(EditTimeSelected value) editTimeSelected,
    required TResult Function(EditPartySizeChanged value) editPartySizeChanged,
    required TResult Function(SubmitEditReservation value) submitEdit,
  }) {
    return submitEdit(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(LoadMyReservations value)? load,
    TResult? Function(RefreshMyReservations value)? refresh,
    TResult? Function(ShowAllHistory value)? showAllHistory,
    TResult? Function(CancelReservation value)? cancel,
    TResult? Function(StartEditReservation value)? startEdit,
    TResult? Function(EditDateChanged value)? editDateChanged,
    TResult? Function(EditTableChanged value)? editTableChanged,
    TResult? Function(EditTimeSelected value)? editTimeSelected,
    TResult? Function(EditPartySizeChanged value)? editPartySizeChanged,
    TResult? Function(SubmitEditReservation value)? submitEdit,
  }) {
    return submitEdit?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LoadMyReservations value)? load,
    TResult Function(RefreshMyReservations value)? refresh,
    TResult Function(ShowAllHistory value)? showAllHistory,
    TResult Function(CancelReservation value)? cancel,
    TResult Function(StartEditReservation value)? startEdit,
    TResult Function(EditDateChanged value)? editDateChanged,
    TResult Function(EditTableChanged value)? editTableChanged,
    TResult Function(EditTimeSelected value)? editTimeSelected,
    TResult Function(EditPartySizeChanged value)? editPartySizeChanged,
    TResult Function(SubmitEditReservation value)? submitEdit,
    required TResult orElse(),
  }) {
    if (submitEdit != null) {
      return submitEdit(this);
    }
    return orElse();
  }
}

abstract class SubmitEditReservation implements MyReservationsEvent {
  const factory SubmitEditReservation() = _$SubmitEditReservationImpl;
}
