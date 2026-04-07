// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'update_reservation_request_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

UpdateReservationRequestModel _$UpdateReservationRequestModelFromJson(
  Map<String, dynamic> json,
) {
  return _UpdateReservationRequestModel.fromJson(json);
}

/// @nodoc
mixin _$UpdateReservationRequestModel {
  String get tableId => throw _privateConstructorUsedError;
  String get date => throw _privateConstructorUsedError;
  String get startTime => throw _privateConstructorUsedError;
  int get partySize => throw _privateConstructorUsedError;

  /// Serializes this UpdateReservationRequestModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of UpdateReservationRequestModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $UpdateReservationRequestModelCopyWith<UpdateReservationRequestModel>
  get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UpdateReservationRequestModelCopyWith<$Res> {
  factory $UpdateReservationRequestModelCopyWith(
    UpdateReservationRequestModel value,
    $Res Function(UpdateReservationRequestModel) then,
  ) =
      _$UpdateReservationRequestModelCopyWithImpl<
        $Res,
        UpdateReservationRequestModel
      >;
  @useResult
  $Res call({String tableId, String date, String startTime, int partySize});
}

/// @nodoc
class _$UpdateReservationRequestModelCopyWithImpl<
  $Res,
  $Val extends UpdateReservationRequestModel
>
    implements $UpdateReservationRequestModelCopyWith<$Res> {
  _$UpdateReservationRequestModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of UpdateReservationRequestModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? tableId = null,
    Object? date = null,
    Object? startTime = null,
    Object? partySize = null,
  }) {
    return _then(
      _value.copyWith(
            tableId:
                null == tableId
                    ? _value.tableId
                    : tableId // ignore: cast_nullable_to_non_nullable
                        as String,
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
            partySize:
                null == partySize
                    ? _value.partySize
                    : partySize // ignore: cast_nullable_to_non_nullable
                        as int,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$UpdateReservationRequestModelImplCopyWith<$Res>
    implements $UpdateReservationRequestModelCopyWith<$Res> {
  factory _$$UpdateReservationRequestModelImplCopyWith(
    _$UpdateReservationRequestModelImpl value,
    $Res Function(_$UpdateReservationRequestModelImpl) then,
  ) = __$$UpdateReservationRequestModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String tableId, String date, String startTime, int partySize});
}

/// @nodoc
class __$$UpdateReservationRequestModelImplCopyWithImpl<$Res>
    extends
        _$UpdateReservationRequestModelCopyWithImpl<
          $Res,
          _$UpdateReservationRequestModelImpl
        >
    implements _$$UpdateReservationRequestModelImplCopyWith<$Res> {
  __$$UpdateReservationRequestModelImplCopyWithImpl(
    _$UpdateReservationRequestModelImpl _value,
    $Res Function(_$UpdateReservationRequestModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of UpdateReservationRequestModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? tableId = null,
    Object? date = null,
    Object? startTime = null,
    Object? partySize = null,
  }) {
    return _then(
      _$UpdateReservationRequestModelImpl(
        tableId:
            null == tableId
                ? _value.tableId
                : tableId // ignore: cast_nullable_to_non_nullable
                    as String,
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
@JsonSerializable()
class _$UpdateReservationRequestModelImpl
    implements _UpdateReservationRequestModel {
  const _$UpdateReservationRequestModelImpl({
    required this.tableId,
    required this.date,
    required this.startTime,
    required this.partySize,
  });

  factory _$UpdateReservationRequestModelImpl.fromJson(
    Map<String, dynamic> json,
  ) => _$$UpdateReservationRequestModelImplFromJson(json);

  @override
  final String tableId;
  @override
  final String date;
  @override
  final String startTime;
  @override
  final int partySize;

  @override
  String toString() {
    return 'UpdateReservationRequestModel(tableId: $tableId, date: $date, startTime: $startTime, partySize: $partySize)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UpdateReservationRequestModelImpl &&
            (identical(other.tableId, tableId) || other.tableId == tableId) &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.startTime, startTime) ||
                other.startTime == startTime) &&
            (identical(other.partySize, partySize) ||
                other.partySize == partySize));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, tableId, date, startTime, partySize);

  /// Create a copy of UpdateReservationRequestModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UpdateReservationRequestModelImplCopyWith<
    _$UpdateReservationRequestModelImpl
  >
  get copyWith => __$$UpdateReservationRequestModelImplCopyWithImpl<
    _$UpdateReservationRequestModelImpl
  >(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$UpdateReservationRequestModelImplToJson(this);
  }
}

abstract class _UpdateReservationRequestModel
    implements UpdateReservationRequestModel {
  const factory _UpdateReservationRequestModel({
    required final String tableId,
    required final String date,
    required final String startTime,
    required final int partySize,
  }) = _$UpdateReservationRequestModelImpl;

  factory _UpdateReservationRequestModel.fromJson(Map<String, dynamic> json) =
      _$UpdateReservationRequestModelImpl.fromJson;

  @override
  String get tableId;
  @override
  String get date;
  @override
  String get startTime;
  @override
  int get partySize;

  /// Create a copy of UpdateReservationRequestModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UpdateReservationRequestModelImplCopyWith<
    _$UpdateReservationRequestModelImpl
  >
  get copyWith => throw _privateConstructorUsedError;
}
