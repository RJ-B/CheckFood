// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'my_reservations_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$MyReservationsState {
  bool get isLoading => throw _privateConstructorUsedError;
  String? get loadError => throw _privateConstructorUsedError;
  List<Reservation> get upcoming => throw _privateConstructorUsedError;
  List<Reservation> get history => throw _privateConstructorUsedError;
  int get totalHistoryCount => throw _privateConstructorUsedError;
  bool get showingAllHistory => throw _privateConstructorUsedError;
  bool get isLoadingHistory => throw _privateConstructorUsedError;
  List<PendingChange> get pendingChanges => throw _privateConstructorUsedError;
  String? get pendingChangeActionId => throw _privateConstructorUsedError;
  String? get cancellingId => throw _privateConstructorUsedError;
  bool get cancelSuccess => throw _privateConstructorUsedError;
  Reservation? get editingReservation => throw _privateConstructorUsedError;
  List<SceneTable> get editTables => throw _privateConstructorUsedError;
  bool get isLoadingEditSlots => throw _privateConstructorUsedError;
  AvailableSlots? get editSlots => throw _privateConstructorUsedError;
  String? get editSelectedTableId => throw _privateConstructorUsedError;
  String? get editSelectedDate => throw _privateConstructorUsedError;
  String? get editSelectedTime => throw _privateConstructorUsedError;
  int? get editPartySize => throw _privateConstructorUsedError;
  bool get isSubmittingEdit => throw _privateConstructorUsedError;
  bool get editSuccess => throw _privateConstructorUsedError;
  bool get editConflict => throw _privateConstructorUsedError;
  String? get editError => throw _privateConstructorUsedError;
  List<RecurringReservation> get recurringReservations =>
      throw _privateConstructorUsedError;
  bool get isLoadingRecurring => throw _privateConstructorUsedError;
  bool get recurringSuccess => throw _privateConstructorUsedError;

  /// Create a copy of MyReservationsState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $MyReservationsStateCopyWith<MyReservationsState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MyReservationsStateCopyWith<$Res> {
  factory $MyReservationsStateCopyWith(
    MyReservationsState value,
    $Res Function(MyReservationsState) then,
  ) = _$MyReservationsStateCopyWithImpl<$Res, MyReservationsState>;
  @useResult
  $Res call({
    bool isLoading,
    String? loadError,
    List<Reservation> upcoming,
    List<Reservation> history,
    int totalHistoryCount,
    bool showingAllHistory,
    bool isLoadingHistory,
    List<PendingChange> pendingChanges,
    String? pendingChangeActionId,
    String? cancellingId,
    bool cancelSuccess,
    Reservation? editingReservation,
    List<SceneTable> editTables,
    bool isLoadingEditSlots,
    AvailableSlots? editSlots,
    String? editSelectedTableId,
    String? editSelectedDate,
    String? editSelectedTime,
    int? editPartySize,
    bool isSubmittingEdit,
    bool editSuccess,
    bool editConflict,
    String? editError,
    List<RecurringReservation> recurringReservations,
    bool isLoadingRecurring,
    bool recurringSuccess,
  });

  $ReservationCopyWith<$Res>? get editingReservation;
  $AvailableSlotsCopyWith<$Res>? get editSlots;
}

/// @nodoc
class _$MyReservationsStateCopyWithImpl<$Res, $Val extends MyReservationsState>
    implements $MyReservationsStateCopyWith<$Res> {
  _$MyReservationsStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of MyReservationsState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoading = null,
    Object? loadError = freezed,
    Object? upcoming = null,
    Object? history = null,
    Object? totalHistoryCount = null,
    Object? showingAllHistory = null,
    Object? isLoadingHistory = null,
    Object? pendingChanges = null,
    Object? pendingChangeActionId = freezed,
    Object? cancellingId = freezed,
    Object? cancelSuccess = null,
    Object? editingReservation = freezed,
    Object? editTables = null,
    Object? isLoadingEditSlots = null,
    Object? editSlots = freezed,
    Object? editSelectedTableId = freezed,
    Object? editSelectedDate = freezed,
    Object? editSelectedTime = freezed,
    Object? editPartySize = freezed,
    Object? isSubmittingEdit = null,
    Object? editSuccess = null,
    Object? editConflict = null,
    Object? editError = freezed,
    Object? recurringReservations = null,
    Object? isLoadingRecurring = null,
    Object? recurringSuccess = null,
  }) {
    return _then(
      _value.copyWith(
            isLoading:
                null == isLoading
                    ? _value.isLoading
                    : isLoading // ignore: cast_nullable_to_non_nullable
                        as bool,
            loadError:
                freezed == loadError
                    ? _value.loadError
                    : loadError // ignore: cast_nullable_to_non_nullable
                        as String?,
            upcoming:
                null == upcoming
                    ? _value.upcoming
                    : upcoming // ignore: cast_nullable_to_non_nullable
                        as List<Reservation>,
            history:
                null == history
                    ? _value.history
                    : history // ignore: cast_nullable_to_non_nullable
                        as List<Reservation>,
            totalHistoryCount:
                null == totalHistoryCount
                    ? _value.totalHistoryCount
                    : totalHistoryCount // ignore: cast_nullable_to_non_nullable
                        as int,
            showingAllHistory:
                null == showingAllHistory
                    ? _value.showingAllHistory
                    : showingAllHistory // ignore: cast_nullable_to_non_nullable
                        as bool,
            isLoadingHistory:
                null == isLoadingHistory
                    ? _value.isLoadingHistory
                    : isLoadingHistory // ignore: cast_nullable_to_non_nullable
                        as bool,
            pendingChanges:
                null == pendingChanges
                    ? _value.pendingChanges
                    : pendingChanges // ignore: cast_nullable_to_non_nullable
                        as List<PendingChange>,
            pendingChangeActionId:
                freezed == pendingChangeActionId
                    ? _value.pendingChangeActionId
                    : pendingChangeActionId // ignore: cast_nullable_to_non_nullable
                        as String?,
            cancellingId:
                freezed == cancellingId
                    ? _value.cancellingId
                    : cancellingId // ignore: cast_nullable_to_non_nullable
                        as String?,
            cancelSuccess:
                null == cancelSuccess
                    ? _value.cancelSuccess
                    : cancelSuccess // ignore: cast_nullable_to_non_nullable
                        as bool,
            editingReservation:
                freezed == editingReservation
                    ? _value.editingReservation
                    : editingReservation // ignore: cast_nullable_to_non_nullable
                        as Reservation?,
            editTables:
                null == editTables
                    ? _value.editTables
                    : editTables // ignore: cast_nullable_to_non_nullable
                        as List<SceneTable>,
            isLoadingEditSlots:
                null == isLoadingEditSlots
                    ? _value.isLoadingEditSlots
                    : isLoadingEditSlots // ignore: cast_nullable_to_non_nullable
                        as bool,
            editSlots:
                freezed == editSlots
                    ? _value.editSlots
                    : editSlots // ignore: cast_nullable_to_non_nullable
                        as AvailableSlots?,
            editSelectedTableId:
                freezed == editSelectedTableId
                    ? _value.editSelectedTableId
                    : editSelectedTableId // ignore: cast_nullable_to_non_nullable
                        as String?,
            editSelectedDate:
                freezed == editSelectedDate
                    ? _value.editSelectedDate
                    : editSelectedDate // ignore: cast_nullable_to_non_nullable
                        as String?,
            editSelectedTime:
                freezed == editSelectedTime
                    ? _value.editSelectedTime
                    : editSelectedTime // ignore: cast_nullable_to_non_nullable
                        as String?,
            editPartySize:
                freezed == editPartySize
                    ? _value.editPartySize
                    : editPartySize // ignore: cast_nullable_to_non_nullable
                        as int?,
            isSubmittingEdit:
                null == isSubmittingEdit
                    ? _value.isSubmittingEdit
                    : isSubmittingEdit // ignore: cast_nullable_to_non_nullable
                        as bool,
            editSuccess:
                null == editSuccess
                    ? _value.editSuccess
                    : editSuccess // ignore: cast_nullable_to_non_nullable
                        as bool,
            editConflict:
                null == editConflict
                    ? _value.editConflict
                    : editConflict // ignore: cast_nullable_to_non_nullable
                        as bool,
            editError:
                freezed == editError
                    ? _value.editError
                    : editError // ignore: cast_nullable_to_non_nullable
                        as String?,
            recurringReservations:
                null == recurringReservations
                    ? _value.recurringReservations
                    : recurringReservations // ignore: cast_nullable_to_non_nullable
                        as List<RecurringReservation>,
            isLoadingRecurring:
                null == isLoadingRecurring
                    ? _value.isLoadingRecurring
                    : isLoadingRecurring // ignore: cast_nullable_to_non_nullable
                        as bool,
            recurringSuccess:
                null == recurringSuccess
                    ? _value.recurringSuccess
                    : recurringSuccess // ignore: cast_nullable_to_non_nullable
                        as bool,
          )
          as $Val,
    );
  }

  /// Create a copy of MyReservationsState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ReservationCopyWith<$Res>? get editingReservation {
    if (_value.editingReservation == null) {
      return null;
    }

    return $ReservationCopyWith<$Res>(_value.editingReservation!, (value) {
      return _then(_value.copyWith(editingReservation: value) as $Val);
    });
  }

  /// Create a copy of MyReservationsState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $AvailableSlotsCopyWith<$Res>? get editSlots {
    if (_value.editSlots == null) {
      return null;
    }

    return $AvailableSlotsCopyWith<$Res>(_value.editSlots!, (value) {
      return _then(_value.copyWith(editSlots: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$MyReservationsStateImplCopyWith<$Res>
    implements $MyReservationsStateCopyWith<$Res> {
  factory _$$MyReservationsStateImplCopyWith(
    _$MyReservationsStateImpl value,
    $Res Function(_$MyReservationsStateImpl) then,
  ) = __$$MyReservationsStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    bool isLoading,
    String? loadError,
    List<Reservation> upcoming,
    List<Reservation> history,
    int totalHistoryCount,
    bool showingAllHistory,
    bool isLoadingHistory,
    List<PendingChange> pendingChanges,
    String? pendingChangeActionId,
    String? cancellingId,
    bool cancelSuccess,
    Reservation? editingReservation,
    List<SceneTable> editTables,
    bool isLoadingEditSlots,
    AvailableSlots? editSlots,
    String? editSelectedTableId,
    String? editSelectedDate,
    String? editSelectedTime,
    int? editPartySize,
    bool isSubmittingEdit,
    bool editSuccess,
    bool editConflict,
    String? editError,
    List<RecurringReservation> recurringReservations,
    bool isLoadingRecurring,
    bool recurringSuccess,
  });

  @override
  $ReservationCopyWith<$Res>? get editingReservation;
  @override
  $AvailableSlotsCopyWith<$Res>? get editSlots;
}

/// @nodoc
class __$$MyReservationsStateImplCopyWithImpl<$Res>
    extends _$MyReservationsStateCopyWithImpl<$Res, _$MyReservationsStateImpl>
    implements _$$MyReservationsStateImplCopyWith<$Res> {
  __$$MyReservationsStateImplCopyWithImpl(
    _$MyReservationsStateImpl _value,
    $Res Function(_$MyReservationsStateImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of MyReservationsState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoading = null,
    Object? loadError = freezed,
    Object? upcoming = null,
    Object? history = null,
    Object? totalHistoryCount = null,
    Object? showingAllHistory = null,
    Object? isLoadingHistory = null,
    Object? pendingChanges = null,
    Object? pendingChangeActionId = freezed,
    Object? cancellingId = freezed,
    Object? cancelSuccess = null,
    Object? editingReservation = freezed,
    Object? editTables = null,
    Object? isLoadingEditSlots = null,
    Object? editSlots = freezed,
    Object? editSelectedTableId = freezed,
    Object? editSelectedDate = freezed,
    Object? editSelectedTime = freezed,
    Object? editPartySize = freezed,
    Object? isSubmittingEdit = null,
    Object? editSuccess = null,
    Object? editConflict = null,
    Object? editError = freezed,
    Object? recurringReservations = null,
    Object? isLoadingRecurring = null,
    Object? recurringSuccess = null,
  }) {
    return _then(
      _$MyReservationsStateImpl(
        isLoading:
            null == isLoading
                ? _value.isLoading
                : isLoading // ignore: cast_nullable_to_non_nullable
                    as bool,
        loadError:
            freezed == loadError
                ? _value.loadError
                : loadError // ignore: cast_nullable_to_non_nullable
                    as String?,
        upcoming:
            null == upcoming
                ? _value._upcoming
                : upcoming // ignore: cast_nullable_to_non_nullable
                    as List<Reservation>,
        history:
            null == history
                ? _value._history
                : history // ignore: cast_nullable_to_non_nullable
                    as List<Reservation>,
        totalHistoryCount:
            null == totalHistoryCount
                ? _value.totalHistoryCount
                : totalHistoryCount // ignore: cast_nullable_to_non_nullable
                    as int,
        showingAllHistory:
            null == showingAllHistory
                ? _value.showingAllHistory
                : showingAllHistory // ignore: cast_nullable_to_non_nullable
                    as bool,
        isLoadingHistory:
            null == isLoadingHistory
                ? _value.isLoadingHistory
                : isLoadingHistory // ignore: cast_nullable_to_non_nullable
                    as bool,
        pendingChanges:
            null == pendingChanges
                ? _value._pendingChanges
                : pendingChanges // ignore: cast_nullable_to_non_nullable
                    as List<PendingChange>,
        pendingChangeActionId:
            freezed == pendingChangeActionId
                ? _value.pendingChangeActionId
                : pendingChangeActionId // ignore: cast_nullable_to_non_nullable
                    as String?,
        cancellingId:
            freezed == cancellingId
                ? _value.cancellingId
                : cancellingId // ignore: cast_nullable_to_non_nullable
                    as String?,
        cancelSuccess:
            null == cancelSuccess
                ? _value.cancelSuccess
                : cancelSuccess // ignore: cast_nullable_to_non_nullable
                    as bool,
        editingReservation:
            freezed == editingReservation
                ? _value.editingReservation
                : editingReservation // ignore: cast_nullable_to_non_nullable
                    as Reservation?,
        editTables:
            null == editTables
                ? _value._editTables
                : editTables // ignore: cast_nullable_to_non_nullable
                    as List<SceneTable>,
        isLoadingEditSlots:
            null == isLoadingEditSlots
                ? _value.isLoadingEditSlots
                : isLoadingEditSlots // ignore: cast_nullable_to_non_nullable
                    as bool,
        editSlots:
            freezed == editSlots
                ? _value.editSlots
                : editSlots // ignore: cast_nullable_to_non_nullable
                    as AvailableSlots?,
        editSelectedTableId:
            freezed == editSelectedTableId
                ? _value.editSelectedTableId
                : editSelectedTableId // ignore: cast_nullable_to_non_nullable
                    as String?,
        editSelectedDate:
            freezed == editSelectedDate
                ? _value.editSelectedDate
                : editSelectedDate // ignore: cast_nullable_to_non_nullable
                    as String?,
        editSelectedTime:
            freezed == editSelectedTime
                ? _value.editSelectedTime
                : editSelectedTime // ignore: cast_nullable_to_non_nullable
                    as String?,
        editPartySize:
            freezed == editPartySize
                ? _value.editPartySize
                : editPartySize // ignore: cast_nullable_to_non_nullable
                    as int?,
        isSubmittingEdit:
            null == isSubmittingEdit
                ? _value.isSubmittingEdit
                : isSubmittingEdit // ignore: cast_nullable_to_non_nullable
                    as bool,
        editSuccess:
            null == editSuccess
                ? _value.editSuccess
                : editSuccess // ignore: cast_nullable_to_non_nullable
                    as bool,
        editConflict:
            null == editConflict
                ? _value.editConflict
                : editConflict // ignore: cast_nullable_to_non_nullable
                    as bool,
        editError:
            freezed == editError
                ? _value.editError
                : editError // ignore: cast_nullable_to_non_nullable
                    as String?,
        recurringReservations:
            null == recurringReservations
                ? _value._recurringReservations
                : recurringReservations // ignore: cast_nullable_to_non_nullable
                    as List<RecurringReservation>,
        isLoadingRecurring:
            null == isLoadingRecurring
                ? _value.isLoadingRecurring
                : isLoadingRecurring // ignore: cast_nullable_to_non_nullable
                    as bool,
        recurringSuccess:
            null == recurringSuccess
                ? _value.recurringSuccess
                : recurringSuccess // ignore: cast_nullable_to_non_nullable
                    as bool,
      ),
    );
  }
}

/// @nodoc

class _$MyReservationsStateImpl extends _MyReservationsState {
  const _$MyReservationsStateImpl({
    this.isLoading = true,
    this.loadError,
    final List<Reservation> upcoming = const [],
    final List<Reservation> history = const [],
    this.totalHistoryCount = 0,
    this.showingAllHistory = false,
    this.isLoadingHistory = false,
    final List<PendingChange> pendingChanges = const [],
    this.pendingChangeActionId,
    this.cancellingId,
    this.cancelSuccess = false,
    this.editingReservation,
    final List<SceneTable> editTables = const [],
    this.isLoadingEditSlots = false,
    this.editSlots,
    this.editSelectedTableId,
    this.editSelectedDate,
    this.editSelectedTime,
    this.editPartySize,
    this.isSubmittingEdit = false,
    this.editSuccess = false,
    this.editConflict = false,
    this.editError,
    final List<RecurringReservation> recurringReservations = const [],
    this.isLoadingRecurring = false,
    this.recurringSuccess = false,
  }) : _upcoming = upcoming,
       _history = history,
       _pendingChanges = pendingChanges,
       _editTables = editTables,
       _recurringReservations = recurringReservations,
       super._();

  @override
  @JsonKey()
  final bool isLoading;
  @override
  final String? loadError;
  final List<Reservation> _upcoming;
  @override
  @JsonKey()
  List<Reservation> get upcoming {
    if (_upcoming is EqualUnmodifiableListView) return _upcoming;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_upcoming);
  }

  final List<Reservation> _history;
  @override
  @JsonKey()
  List<Reservation> get history {
    if (_history is EqualUnmodifiableListView) return _history;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_history);
  }

  @override
  @JsonKey()
  final int totalHistoryCount;
  @override
  @JsonKey()
  final bool showingAllHistory;
  @override
  @JsonKey()
  final bool isLoadingHistory;
  final List<PendingChange> _pendingChanges;
  @override
  @JsonKey()
  List<PendingChange> get pendingChanges {
    if (_pendingChanges is EqualUnmodifiableListView) return _pendingChanges;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_pendingChanges);
  }

  @override
  final String? pendingChangeActionId;
  @override
  final String? cancellingId;
  @override
  @JsonKey()
  final bool cancelSuccess;
  @override
  final Reservation? editingReservation;
  final List<SceneTable> _editTables;
  @override
  @JsonKey()
  List<SceneTable> get editTables {
    if (_editTables is EqualUnmodifiableListView) return _editTables;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_editTables);
  }

  @override
  @JsonKey()
  final bool isLoadingEditSlots;
  @override
  final AvailableSlots? editSlots;
  @override
  final String? editSelectedTableId;
  @override
  final String? editSelectedDate;
  @override
  final String? editSelectedTime;
  @override
  final int? editPartySize;
  @override
  @JsonKey()
  final bool isSubmittingEdit;
  @override
  @JsonKey()
  final bool editSuccess;
  @override
  @JsonKey()
  final bool editConflict;
  @override
  final String? editError;
  final List<RecurringReservation> _recurringReservations;
  @override
  @JsonKey()
  List<RecurringReservation> get recurringReservations {
    if (_recurringReservations is EqualUnmodifiableListView)
      return _recurringReservations;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_recurringReservations);
  }

  @override
  @JsonKey()
  final bool isLoadingRecurring;
  @override
  @JsonKey()
  final bool recurringSuccess;

  @override
  String toString() {
    return 'MyReservationsState(isLoading: $isLoading, loadError: $loadError, upcoming: $upcoming, history: $history, totalHistoryCount: $totalHistoryCount, showingAllHistory: $showingAllHistory, isLoadingHistory: $isLoadingHistory, pendingChanges: $pendingChanges, pendingChangeActionId: $pendingChangeActionId, cancellingId: $cancellingId, cancelSuccess: $cancelSuccess, editingReservation: $editingReservation, editTables: $editTables, isLoadingEditSlots: $isLoadingEditSlots, editSlots: $editSlots, editSelectedTableId: $editSelectedTableId, editSelectedDate: $editSelectedDate, editSelectedTime: $editSelectedTime, editPartySize: $editPartySize, isSubmittingEdit: $isSubmittingEdit, editSuccess: $editSuccess, editConflict: $editConflict, editError: $editError, recurringReservations: $recurringReservations, isLoadingRecurring: $isLoadingRecurring, recurringSuccess: $recurringSuccess)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MyReservationsStateImpl &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            (identical(other.loadError, loadError) ||
                other.loadError == loadError) &&
            const DeepCollectionEquality().equals(other._upcoming, _upcoming) &&
            const DeepCollectionEquality().equals(other._history, _history) &&
            (identical(other.totalHistoryCount, totalHistoryCount) ||
                other.totalHistoryCount == totalHistoryCount) &&
            (identical(other.showingAllHistory, showingAllHistory) ||
                other.showingAllHistory == showingAllHistory) &&
            (identical(other.isLoadingHistory, isLoadingHistory) ||
                other.isLoadingHistory == isLoadingHistory) &&
            const DeepCollectionEquality().equals(
              other._pendingChanges,
              _pendingChanges,
            ) &&
            (identical(other.pendingChangeActionId, pendingChangeActionId) ||
                other.pendingChangeActionId == pendingChangeActionId) &&
            (identical(other.cancellingId, cancellingId) ||
                other.cancellingId == cancellingId) &&
            (identical(other.cancelSuccess, cancelSuccess) ||
                other.cancelSuccess == cancelSuccess) &&
            (identical(other.editingReservation, editingReservation) ||
                other.editingReservation == editingReservation) &&
            const DeepCollectionEquality().equals(
              other._editTables,
              _editTables,
            ) &&
            (identical(other.isLoadingEditSlots, isLoadingEditSlots) ||
                other.isLoadingEditSlots == isLoadingEditSlots) &&
            (identical(other.editSlots, editSlots) ||
                other.editSlots == editSlots) &&
            (identical(other.editSelectedTableId, editSelectedTableId) ||
                other.editSelectedTableId == editSelectedTableId) &&
            (identical(other.editSelectedDate, editSelectedDate) ||
                other.editSelectedDate == editSelectedDate) &&
            (identical(other.editSelectedTime, editSelectedTime) ||
                other.editSelectedTime == editSelectedTime) &&
            (identical(other.editPartySize, editPartySize) ||
                other.editPartySize == editPartySize) &&
            (identical(other.isSubmittingEdit, isSubmittingEdit) ||
                other.isSubmittingEdit == isSubmittingEdit) &&
            (identical(other.editSuccess, editSuccess) ||
                other.editSuccess == editSuccess) &&
            (identical(other.editConflict, editConflict) ||
                other.editConflict == editConflict) &&
            (identical(other.editError, editError) ||
                other.editError == editError) &&
            const DeepCollectionEquality().equals(
              other._recurringReservations,
              _recurringReservations,
            ) &&
            (identical(other.isLoadingRecurring, isLoadingRecurring) ||
                other.isLoadingRecurring == isLoadingRecurring) &&
            (identical(other.recurringSuccess, recurringSuccess) ||
                other.recurringSuccess == recurringSuccess));
  }

  @override
  int get hashCode => Object.hashAll([
    runtimeType,
    isLoading,
    loadError,
    const DeepCollectionEquality().hash(_upcoming),
    const DeepCollectionEquality().hash(_history),
    totalHistoryCount,
    showingAllHistory,
    isLoadingHistory,
    const DeepCollectionEquality().hash(_pendingChanges),
    pendingChangeActionId,
    cancellingId,
    cancelSuccess,
    editingReservation,
    const DeepCollectionEquality().hash(_editTables),
    isLoadingEditSlots,
    editSlots,
    editSelectedTableId,
    editSelectedDate,
    editSelectedTime,
    editPartySize,
    isSubmittingEdit,
    editSuccess,
    editConflict,
    editError,
    const DeepCollectionEquality().hash(_recurringReservations),
    isLoadingRecurring,
    recurringSuccess,
  ]);

  /// Create a copy of MyReservationsState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MyReservationsStateImplCopyWith<_$MyReservationsStateImpl> get copyWith =>
      __$$MyReservationsStateImplCopyWithImpl<_$MyReservationsStateImpl>(
        this,
        _$identity,
      );
}

abstract class _MyReservationsState extends MyReservationsState {
  const factory _MyReservationsState({
    final bool isLoading,
    final String? loadError,
    final List<Reservation> upcoming,
    final List<Reservation> history,
    final int totalHistoryCount,
    final bool showingAllHistory,
    final bool isLoadingHistory,
    final List<PendingChange> pendingChanges,
    final String? pendingChangeActionId,
    final String? cancellingId,
    final bool cancelSuccess,
    final Reservation? editingReservation,
    final List<SceneTable> editTables,
    final bool isLoadingEditSlots,
    final AvailableSlots? editSlots,
    final String? editSelectedTableId,
    final String? editSelectedDate,
    final String? editSelectedTime,
    final int? editPartySize,
    final bool isSubmittingEdit,
    final bool editSuccess,
    final bool editConflict,
    final String? editError,
    final List<RecurringReservation> recurringReservations,
    final bool isLoadingRecurring,
    final bool recurringSuccess,
  }) = _$MyReservationsStateImpl;
  const _MyReservationsState._() : super._();

  @override
  bool get isLoading;
  @override
  String? get loadError;
  @override
  List<Reservation> get upcoming;
  @override
  List<Reservation> get history;
  @override
  int get totalHistoryCount;
  @override
  bool get showingAllHistory;
  @override
  bool get isLoadingHistory;
  @override
  List<PendingChange> get pendingChanges;
  @override
  String? get pendingChangeActionId;
  @override
  String? get cancellingId;
  @override
  bool get cancelSuccess;
  @override
  Reservation? get editingReservation;
  @override
  List<SceneTable> get editTables;
  @override
  bool get isLoadingEditSlots;
  @override
  AvailableSlots? get editSlots;
  @override
  String? get editSelectedTableId;
  @override
  String? get editSelectedDate;
  @override
  String? get editSelectedTime;
  @override
  int? get editPartySize;
  @override
  bool get isSubmittingEdit;
  @override
  bool get editSuccess;
  @override
  bool get editConflict;
  @override
  String? get editError;
  @override
  List<RecurringReservation> get recurringReservations;
  @override
  bool get isLoadingRecurring;
  @override
  bool get recurringSuccess;

  /// Create a copy of MyReservationsState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MyReservationsStateImplCopyWith<_$MyReservationsStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
