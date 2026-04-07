// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'available_slots_response_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

AvailableSlotsResponseModel _$AvailableSlotsResponseModelFromJson(
  Map<String, dynamic> json,
) {
  return _AvailableSlotsResponseModel.fromJson(json);
}

/// @nodoc
mixin _$AvailableSlotsResponseModel {
  String? get date => throw _privateConstructorUsedError;
  String? get tableId => throw _privateConstructorUsedError;
  int? get slotMinutes => throw _privateConstructorUsedError;
  int? get durationMinutes => throw _privateConstructorUsedError;
  List<String> get availableStartTimes => throw _privateConstructorUsedError;

  /// Serializes this AvailableSlotsResponseModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of AvailableSlotsResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AvailableSlotsResponseModelCopyWith<AvailableSlotsResponseModel>
  get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AvailableSlotsResponseModelCopyWith<$Res> {
  factory $AvailableSlotsResponseModelCopyWith(
    AvailableSlotsResponseModel value,
    $Res Function(AvailableSlotsResponseModel) then,
  ) =
      _$AvailableSlotsResponseModelCopyWithImpl<
        $Res,
        AvailableSlotsResponseModel
      >;
  @useResult
  $Res call({
    String? date,
    String? tableId,
    int? slotMinutes,
    int? durationMinutes,
    List<String> availableStartTimes,
  });
}

/// @nodoc
class _$AvailableSlotsResponseModelCopyWithImpl<
  $Res,
  $Val extends AvailableSlotsResponseModel
>
    implements $AvailableSlotsResponseModelCopyWith<$Res> {
  _$AvailableSlotsResponseModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AvailableSlotsResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? date = freezed,
    Object? tableId = freezed,
    Object? slotMinutes = freezed,
    Object? durationMinutes = freezed,
    Object? availableStartTimes = null,
  }) {
    return _then(
      _value.copyWith(
            date:
                freezed == date
                    ? _value.date
                    : date // ignore: cast_nullable_to_non_nullable
                        as String?,
            tableId:
                freezed == tableId
                    ? _value.tableId
                    : tableId // ignore: cast_nullable_to_non_nullable
                        as String?,
            slotMinutes:
                freezed == slotMinutes
                    ? _value.slotMinutes
                    : slotMinutes // ignore: cast_nullable_to_non_nullable
                        as int?,
            durationMinutes:
                freezed == durationMinutes
                    ? _value.durationMinutes
                    : durationMinutes // ignore: cast_nullable_to_non_nullable
                        as int?,
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
abstract class _$$AvailableSlotsResponseModelImplCopyWith<$Res>
    implements $AvailableSlotsResponseModelCopyWith<$Res> {
  factory _$$AvailableSlotsResponseModelImplCopyWith(
    _$AvailableSlotsResponseModelImpl value,
    $Res Function(_$AvailableSlotsResponseModelImpl) then,
  ) = __$$AvailableSlotsResponseModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String? date,
    String? tableId,
    int? slotMinutes,
    int? durationMinutes,
    List<String> availableStartTimes,
  });
}

/// @nodoc
class __$$AvailableSlotsResponseModelImplCopyWithImpl<$Res>
    extends
        _$AvailableSlotsResponseModelCopyWithImpl<
          $Res,
          _$AvailableSlotsResponseModelImpl
        >
    implements _$$AvailableSlotsResponseModelImplCopyWith<$Res> {
  __$$AvailableSlotsResponseModelImplCopyWithImpl(
    _$AvailableSlotsResponseModelImpl _value,
    $Res Function(_$AvailableSlotsResponseModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AvailableSlotsResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? date = freezed,
    Object? tableId = freezed,
    Object? slotMinutes = freezed,
    Object? durationMinutes = freezed,
    Object? availableStartTimes = null,
  }) {
    return _then(
      _$AvailableSlotsResponseModelImpl(
        date:
            freezed == date
                ? _value.date
                : date // ignore: cast_nullable_to_non_nullable
                    as String?,
        tableId:
            freezed == tableId
                ? _value.tableId
                : tableId // ignore: cast_nullable_to_non_nullable
                    as String?,
        slotMinutes:
            freezed == slotMinutes
                ? _value.slotMinutes
                : slotMinutes // ignore: cast_nullable_to_non_nullable
                    as int?,
        durationMinutes:
            freezed == durationMinutes
                ? _value.durationMinutes
                : durationMinutes // ignore: cast_nullable_to_non_nullable
                    as int?,
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
@JsonSerializable()
class _$AvailableSlotsResponseModelImpl extends _AvailableSlotsResponseModel {
  const _$AvailableSlotsResponseModelImpl({
    this.date,
    this.tableId,
    this.slotMinutes,
    this.durationMinutes,
    final List<String> availableStartTimes = const [],
  }) : _availableStartTimes = availableStartTimes,
       super._();

  factory _$AvailableSlotsResponseModelImpl.fromJson(
    Map<String, dynamic> json,
  ) => _$$AvailableSlotsResponseModelImplFromJson(json);

  @override
  final String? date;
  @override
  final String? tableId;
  @override
  final int? slotMinutes;
  @override
  final int? durationMinutes;
  final List<String> _availableStartTimes;
  @override
  @JsonKey()
  List<String> get availableStartTimes {
    if (_availableStartTimes is EqualUnmodifiableListView)
      return _availableStartTimes;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_availableStartTimes);
  }

  @override
  String toString() {
    return 'AvailableSlotsResponseModel(date: $date, tableId: $tableId, slotMinutes: $slotMinutes, durationMinutes: $durationMinutes, availableStartTimes: $availableStartTimes)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AvailableSlotsResponseModelImpl &&
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

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    date,
    tableId,
    slotMinutes,
    durationMinutes,
    const DeepCollectionEquality().hash(_availableStartTimes),
  );

  /// Create a copy of AvailableSlotsResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AvailableSlotsResponseModelImplCopyWith<_$AvailableSlotsResponseModelImpl>
  get copyWith => __$$AvailableSlotsResponseModelImplCopyWithImpl<
    _$AvailableSlotsResponseModelImpl
  >(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AvailableSlotsResponseModelImplToJson(this);
  }
}

abstract class _AvailableSlotsResponseModel
    extends AvailableSlotsResponseModel {
  const factory _AvailableSlotsResponseModel({
    final String? date,
    final String? tableId,
    final int? slotMinutes,
    final int? durationMinutes,
    final List<String> availableStartTimes,
  }) = _$AvailableSlotsResponseModelImpl;
  const _AvailableSlotsResponseModel._() : super._();

  factory _AvailableSlotsResponseModel.fromJson(Map<String, dynamic> json) =
      _$AvailableSlotsResponseModelImpl.fromJson;

  @override
  String? get date;
  @override
  String? get tableId;
  @override
  int? get slotMinutes;
  @override
  int? get durationMinutes;
  @override
  List<String> get availableStartTimes;

  /// Create a copy of AvailableSlotsResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AvailableSlotsResponseModelImplCopyWith<_$AvailableSlotsResponseModelImpl>
  get copyWith => throw _privateConstructorUsedError;
}
