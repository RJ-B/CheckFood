// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'reservation_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$ReservationState {
  bool get sceneLoading => throw _privateConstructorUsedError;
  ReservationScene? get scene => throw _privateConstructorUsedError;
  String? get sceneError => throw _privateConstructorUsedError;
  List<TableStatus> get tableStatuses => throw _privateConstructorUsedError;
  String? get selectedTableId => throw _privateConstructorUsedError;
  String? get selectedTableLabel => throw _privateConstructorUsedError;
  int? get selectedTableCapacity => throw _privateConstructorUsedError;
  String get selectedDate => throw _privateConstructorUsedError;
  int get selectedPartySize => throw _privateConstructorUsedError;
  bool get slotsLoading => throw _privateConstructorUsedError;
  AvailableSlots? get availableSlots => throw _privateConstructorUsedError;
  String? get selectedStartTime => throw _privateConstructorUsedError;
  bool get submitting => throw _privateConstructorUsedError;
  bool get submitSuccess => throw _privateConstructorUsedError;
  bool get submitConflict => throw _privateConstructorUsedError;
  String? get submitError => throw _privateConstructorUsedError;

  /// Create a copy of ReservationState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ReservationStateCopyWith<ReservationState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ReservationStateCopyWith<$Res> {
  factory $ReservationStateCopyWith(
    ReservationState value,
    $Res Function(ReservationState) then,
  ) = _$ReservationStateCopyWithImpl<$Res, ReservationState>;
  @useResult
  $Res call({
    bool sceneLoading,
    ReservationScene? scene,
    String? sceneError,
    List<TableStatus> tableStatuses,
    String? selectedTableId,
    String? selectedTableLabel,
    int? selectedTableCapacity,
    String selectedDate,
    int selectedPartySize,
    bool slotsLoading,
    AvailableSlots? availableSlots,
    String? selectedStartTime,
    bool submitting,
    bool submitSuccess,
    bool submitConflict,
    String? submitError,
  });

  $ReservationSceneCopyWith<$Res>? get scene;
  $AvailableSlotsCopyWith<$Res>? get availableSlots;
}

/// @nodoc
class _$ReservationStateCopyWithImpl<$Res, $Val extends ReservationState>
    implements $ReservationStateCopyWith<$Res> {
  _$ReservationStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ReservationState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? sceneLoading = null,
    Object? scene = freezed,
    Object? sceneError = freezed,
    Object? tableStatuses = null,
    Object? selectedTableId = freezed,
    Object? selectedTableLabel = freezed,
    Object? selectedTableCapacity = freezed,
    Object? selectedDate = null,
    Object? selectedPartySize = null,
    Object? slotsLoading = null,
    Object? availableSlots = freezed,
    Object? selectedStartTime = freezed,
    Object? submitting = null,
    Object? submitSuccess = null,
    Object? submitConflict = null,
    Object? submitError = freezed,
  }) {
    return _then(
      _value.copyWith(
            sceneLoading:
                null == sceneLoading
                    ? _value.sceneLoading
                    : sceneLoading // ignore: cast_nullable_to_non_nullable
                        as bool,
            scene:
                freezed == scene
                    ? _value.scene
                    : scene // ignore: cast_nullable_to_non_nullable
                        as ReservationScene?,
            sceneError:
                freezed == sceneError
                    ? _value.sceneError
                    : sceneError // ignore: cast_nullable_to_non_nullable
                        as String?,
            tableStatuses:
                null == tableStatuses
                    ? _value.tableStatuses
                    : tableStatuses // ignore: cast_nullable_to_non_nullable
                        as List<TableStatus>,
            selectedTableId:
                freezed == selectedTableId
                    ? _value.selectedTableId
                    : selectedTableId // ignore: cast_nullable_to_non_nullable
                        as String?,
            selectedTableLabel:
                freezed == selectedTableLabel
                    ? _value.selectedTableLabel
                    : selectedTableLabel // ignore: cast_nullable_to_non_nullable
                        as String?,
            selectedTableCapacity:
                freezed == selectedTableCapacity
                    ? _value.selectedTableCapacity
                    : selectedTableCapacity // ignore: cast_nullable_to_non_nullable
                        as int?,
            selectedDate:
                null == selectedDate
                    ? _value.selectedDate
                    : selectedDate // ignore: cast_nullable_to_non_nullable
                        as String,
            selectedPartySize:
                null == selectedPartySize
                    ? _value.selectedPartySize
                    : selectedPartySize // ignore: cast_nullable_to_non_nullable
                        as int,
            slotsLoading:
                null == slotsLoading
                    ? _value.slotsLoading
                    : slotsLoading // ignore: cast_nullable_to_non_nullable
                        as bool,
            availableSlots:
                freezed == availableSlots
                    ? _value.availableSlots
                    : availableSlots // ignore: cast_nullable_to_non_nullable
                        as AvailableSlots?,
            selectedStartTime:
                freezed == selectedStartTime
                    ? _value.selectedStartTime
                    : selectedStartTime // ignore: cast_nullable_to_non_nullable
                        as String?,
            submitting:
                null == submitting
                    ? _value.submitting
                    : submitting // ignore: cast_nullable_to_non_nullable
                        as bool,
            submitSuccess:
                null == submitSuccess
                    ? _value.submitSuccess
                    : submitSuccess // ignore: cast_nullable_to_non_nullable
                        as bool,
            submitConflict:
                null == submitConflict
                    ? _value.submitConflict
                    : submitConflict // ignore: cast_nullable_to_non_nullable
                        as bool,
            submitError:
                freezed == submitError
                    ? _value.submitError
                    : submitError // ignore: cast_nullable_to_non_nullable
                        as String?,
          )
          as $Val,
    );
  }

  /// Create a copy of ReservationState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ReservationSceneCopyWith<$Res>? get scene {
    if (_value.scene == null) {
      return null;
    }

    return $ReservationSceneCopyWith<$Res>(_value.scene!, (value) {
      return _then(_value.copyWith(scene: value) as $Val);
    });
  }

  /// Create a copy of ReservationState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $AvailableSlotsCopyWith<$Res>? get availableSlots {
    if (_value.availableSlots == null) {
      return null;
    }

    return $AvailableSlotsCopyWith<$Res>(_value.availableSlots!, (value) {
      return _then(_value.copyWith(availableSlots: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$ReservationStateImplCopyWith<$Res>
    implements $ReservationStateCopyWith<$Res> {
  factory _$$ReservationStateImplCopyWith(
    _$ReservationStateImpl value,
    $Res Function(_$ReservationStateImpl) then,
  ) = __$$ReservationStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    bool sceneLoading,
    ReservationScene? scene,
    String? sceneError,
    List<TableStatus> tableStatuses,
    String? selectedTableId,
    String? selectedTableLabel,
    int? selectedTableCapacity,
    String selectedDate,
    int selectedPartySize,
    bool slotsLoading,
    AvailableSlots? availableSlots,
    String? selectedStartTime,
    bool submitting,
    bool submitSuccess,
    bool submitConflict,
    String? submitError,
  });

  @override
  $ReservationSceneCopyWith<$Res>? get scene;
  @override
  $AvailableSlotsCopyWith<$Res>? get availableSlots;
}

/// @nodoc
class __$$ReservationStateImplCopyWithImpl<$Res>
    extends _$ReservationStateCopyWithImpl<$Res, _$ReservationStateImpl>
    implements _$$ReservationStateImplCopyWith<$Res> {
  __$$ReservationStateImplCopyWithImpl(
    _$ReservationStateImpl _value,
    $Res Function(_$ReservationStateImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ReservationState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? sceneLoading = null,
    Object? scene = freezed,
    Object? sceneError = freezed,
    Object? tableStatuses = null,
    Object? selectedTableId = freezed,
    Object? selectedTableLabel = freezed,
    Object? selectedTableCapacity = freezed,
    Object? selectedDate = null,
    Object? selectedPartySize = null,
    Object? slotsLoading = null,
    Object? availableSlots = freezed,
    Object? selectedStartTime = freezed,
    Object? submitting = null,
    Object? submitSuccess = null,
    Object? submitConflict = null,
    Object? submitError = freezed,
  }) {
    return _then(
      _$ReservationStateImpl(
        sceneLoading:
            null == sceneLoading
                ? _value.sceneLoading
                : sceneLoading // ignore: cast_nullable_to_non_nullable
                    as bool,
        scene:
            freezed == scene
                ? _value.scene
                : scene // ignore: cast_nullable_to_non_nullable
                    as ReservationScene?,
        sceneError:
            freezed == sceneError
                ? _value.sceneError
                : sceneError // ignore: cast_nullable_to_non_nullable
                    as String?,
        tableStatuses:
            null == tableStatuses
                ? _value._tableStatuses
                : tableStatuses // ignore: cast_nullable_to_non_nullable
                    as List<TableStatus>,
        selectedTableId:
            freezed == selectedTableId
                ? _value.selectedTableId
                : selectedTableId // ignore: cast_nullable_to_non_nullable
                    as String?,
        selectedTableLabel:
            freezed == selectedTableLabel
                ? _value.selectedTableLabel
                : selectedTableLabel // ignore: cast_nullable_to_non_nullable
                    as String?,
        selectedTableCapacity:
            freezed == selectedTableCapacity
                ? _value.selectedTableCapacity
                : selectedTableCapacity // ignore: cast_nullable_to_non_nullable
                    as int?,
        selectedDate:
            null == selectedDate
                ? _value.selectedDate
                : selectedDate // ignore: cast_nullable_to_non_nullable
                    as String,
        selectedPartySize:
            null == selectedPartySize
                ? _value.selectedPartySize
                : selectedPartySize // ignore: cast_nullable_to_non_nullable
                    as int,
        slotsLoading:
            null == slotsLoading
                ? _value.slotsLoading
                : slotsLoading // ignore: cast_nullable_to_non_nullable
                    as bool,
        availableSlots:
            freezed == availableSlots
                ? _value.availableSlots
                : availableSlots // ignore: cast_nullable_to_non_nullable
                    as AvailableSlots?,
        selectedStartTime:
            freezed == selectedStartTime
                ? _value.selectedStartTime
                : selectedStartTime // ignore: cast_nullable_to_non_nullable
                    as String?,
        submitting:
            null == submitting
                ? _value.submitting
                : submitting // ignore: cast_nullable_to_non_nullable
                    as bool,
        submitSuccess:
            null == submitSuccess
                ? _value.submitSuccess
                : submitSuccess // ignore: cast_nullable_to_non_nullable
                    as bool,
        submitConflict:
            null == submitConflict
                ? _value.submitConflict
                : submitConflict // ignore: cast_nullable_to_non_nullable
                    as bool,
        submitError:
            freezed == submitError
                ? _value.submitError
                : submitError // ignore: cast_nullable_to_non_nullable
                    as String?,
      ),
    );
  }
}

/// @nodoc

class _$ReservationStateImpl extends _ReservationState {
  const _$ReservationStateImpl({
    this.sceneLoading = false,
    this.scene,
    this.sceneError,
    final List<TableStatus> tableStatuses = const [],
    this.selectedTableId,
    this.selectedTableLabel,
    this.selectedTableCapacity,
    required this.selectedDate,
    this.selectedPartySize = 2,
    this.slotsLoading = false,
    this.availableSlots,
    this.selectedStartTime,
    this.submitting = false,
    this.submitSuccess = false,
    this.submitConflict = false,
    this.submitError,
  }) : _tableStatuses = tableStatuses,
       super._();

  @override
  @JsonKey()
  final bool sceneLoading;
  @override
  final ReservationScene? scene;
  @override
  final String? sceneError;
  final List<TableStatus> _tableStatuses;
  @override
  @JsonKey()
  List<TableStatus> get tableStatuses {
    if (_tableStatuses is EqualUnmodifiableListView) return _tableStatuses;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_tableStatuses);
  }

  @override
  final String? selectedTableId;
  @override
  final String? selectedTableLabel;
  @override
  final int? selectedTableCapacity;
  @override
  final String selectedDate;
  @override
  @JsonKey()
  final int selectedPartySize;
  @override
  @JsonKey()
  final bool slotsLoading;
  @override
  final AvailableSlots? availableSlots;
  @override
  final String? selectedStartTime;
  @override
  @JsonKey()
  final bool submitting;
  @override
  @JsonKey()
  final bool submitSuccess;
  @override
  @JsonKey()
  final bool submitConflict;
  @override
  final String? submitError;

  @override
  String toString() {
    return 'ReservationState(sceneLoading: $sceneLoading, scene: $scene, sceneError: $sceneError, tableStatuses: $tableStatuses, selectedTableId: $selectedTableId, selectedTableLabel: $selectedTableLabel, selectedTableCapacity: $selectedTableCapacity, selectedDate: $selectedDate, selectedPartySize: $selectedPartySize, slotsLoading: $slotsLoading, availableSlots: $availableSlots, selectedStartTime: $selectedStartTime, submitting: $submitting, submitSuccess: $submitSuccess, submitConflict: $submitConflict, submitError: $submitError)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ReservationStateImpl &&
            (identical(other.sceneLoading, sceneLoading) ||
                other.sceneLoading == sceneLoading) &&
            (identical(other.scene, scene) || other.scene == scene) &&
            (identical(other.sceneError, sceneError) ||
                other.sceneError == sceneError) &&
            const DeepCollectionEquality().equals(
              other._tableStatuses,
              _tableStatuses,
            ) &&
            (identical(other.selectedTableId, selectedTableId) ||
                other.selectedTableId == selectedTableId) &&
            (identical(other.selectedTableLabel, selectedTableLabel) ||
                other.selectedTableLabel == selectedTableLabel) &&
            (identical(other.selectedTableCapacity, selectedTableCapacity) ||
                other.selectedTableCapacity == selectedTableCapacity) &&
            (identical(other.selectedDate, selectedDate) ||
                other.selectedDate == selectedDate) &&
            (identical(other.selectedPartySize, selectedPartySize) ||
                other.selectedPartySize == selectedPartySize) &&
            (identical(other.slotsLoading, slotsLoading) ||
                other.slotsLoading == slotsLoading) &&
            (identical(other.availableSlots, availableSlots) ||
                other.availableSlots == availableSlots) &&
            (identical(other.selectedStartTime, selectedStartTime) ||
                other.selectedStartTime == selectedStartTime) &&
            (identical(other.submitting, submitting) ||
                other.submitting == submitting) &&
            (identical(other.submitSuccess, submitSuccess) ||
                other.submitSuccess == submitSuccess) &&
            (identical(other.submitConflict, submitConflict) ||
                other.submitConflict == submitConflict) &&
            (identical(other.submitError, submitError) ||
                other.submitError == submitError));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    sceneLoading,
    scene,
    sceneError,
    const DeepCollectionEquality().hash(_tableStatuses),
    selectedTableId,
    selectedTableLabel,
    selectedTableCapacity,
    selectedDate,
    selectedPartySize,
    slotsLoading,
    availableSlots,
    selectedStartTime,
    submitting,
    submitSuccess,
    submitConflict,
    submitError,
  );

  /// Create a copy of ReservationState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ReservationStateImplCopyWith<_$ReservationStateImpl> get copyWith =>
      __$$ReservationStateImplCopyWithImpl<_$ReservationStateImpl>(
        this,
        _$identity,
      );
}

abstract class _ReservationState extends ReservationState {
  const factory _ReservationState({
    final bool sceneLoading,
    final ReservationScene? scene,
    final String? sceneError,
    final List<TableStatus> tableStatuses,
    final String? selectedTableId,
    final String? selectedTableLabel,
    final int? selectedTableCapacity,
    required final String selectedDate,
    final int selectedPartySize,
    final bool slotsLoading,
    final AvailableSlots? availableSlots,
    final String? selectedStartTime,
    final bool submitting,
    final bool submitSuccess,
    final bool submitConflict,
    final String? submitError,
  }) = _$ReservationStateImpl;
  const _ReservationState._() : super._();

  @override
  bool get sceneLoading;
  @override
  ReservationScene? get scene;
  @override
  String? get sceneError;
  @override
  List<TableStatus> get tableStatuses;
  @override
  String? get selectedTableId;
  @override
  String? get selectedTableLabel;
  @override
  int? get selectedTableCapacity;
  @override
  String get selectedDate;
  @override
  int get selectedPartySize;
  @override
  bool get slotsLoading;
  @override
  AvailableSlots? get availableSlots;
  @override
  String? get selectedStartTime;
  @override
  bool get submitting;
  @override
  bool get submitSuccess;
  @override
  bool get submitConflict;
  @override
  String? get submitError;

  /// Create a copy of ReservationState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ReservationStateImplCopyWith<_$ReservationStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
