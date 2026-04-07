// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'create_recurring_reservation_request_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

CreateRecurringReservationRequestModel
_$CreateRecurringReservationRequestModelFromJson(Map<String, dynamic> json) {
  return _CreateRecurringReservationRequestModel.fromJson(json);
}

/// @nodoc
mixin _$CreateRecurringReservationRequestModel {
  String get restaurantId => throw _privateConstructorUsedError;
  String get tableId => throw _privateConstructorUsedError;
  String get dayOfWeek => throw _privateConstructorUsedError;
  String get startTime => throw _privateConstructorUsedError;
  int get partySize => throw _privateConstructorUsedError;

  /// Serializes this CreateRecurringReservationRequestModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of CreateRecurringReservationRequestModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CreateRecurringReservationRequestModelCopyWith<
    CreateRecurringReservationRequestModel
  >
  get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CreateRecurringReservationRequestModelCopyWith<$Res> {
  factory $CreateRecurringReservationRequestModelCopyWith(
    CreateRecurringReservationRequestModel value,
    $Res Function(CreateRecurringReservationRequestModel) then,
  ) =
      _$CreateRecurringReservationRequestModelCopyWithImpl<
        $Res,
        CreateRecurringReservationRequestModel
      >;
  @useResult
  $Res call({
    String restaurantId,
    String tableId,
    String dayOfWeek,
    String startTime,
    int partySize,
  });
}

/// @nodoc
class _$CreateRecurringReservationRequestModelCopyWithImpl<
  $Res,
  $Val extends CreateRecurringReservationRequestModel
>
    implements $CreateRecurringReservationRequestModelCopyWith<$Res> {
  _$CreateRecurringReservationRequestModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CreateRecurringReservationRequestModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? restaurantId = null,
    Object? tableId = null,
    Object? dayOfWeek = null,
    Object? startTime = null,
    Object? partySize = null,
  }) {
    return _then(
      _value.copyWith(
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
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$CreateRecurringReservationRequestModelImplCopyWith<$Res>
    implements $CreateRecurringReservationRequestModelCopyWith<$Res> {
  factory _$$CreateRecurringReservationRequestModelImplCopyWith(
    _$CreateRecurringReservationRequestModelImpl value,
    $Res Function(_$CreateRecurringReservationRequestModelImpl) then,
  ) = __$$CreateRecurringReservationRequestModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String restaurantId,
    String tableId,
    String dayOfWeek,
    String startTime,
    int partySize,
  });
}

/// @nodoc
class __$$CreateRecurringReservationRequestModelImplCopyWithImpl<$Res>
    extends
        _$CreateRecurringReservationRequestModelCopyWithImpl<
          $Res,
          _$CreateRecurringReservationRequestModelImpl
        >
    implements _$$CreateRecurringReservationRequestModelImplCopyWith<$Res> {
  __$$CreateRecurringReservationRequestModelImplCopyWithImpl(
    _$CreateRecurringReservationRequestModelImpl _value,
    $Res Function(_$CreateRecurringReservationRequestModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CreateRecurringReservationRequestModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? restaurantId = null,
    Object? tableId = null,
    Object? dayOfWeek = null,
    Object? startTime = null,
    Object? partySize = null,
  }) {
    return _then(
      _$CreateRecurringReservationRequestModelImpl(
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
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$CreateRecurringReservationRequestModelImpl
    implements _CreateRecurringReservationRequestModel {
  const _$CreateRecurringReservationRequestModelImpl({
    required this.restaurantId,
    required this.tableId,
    required this.dayOfWeek,
    required this.startTime,
    this.partySize = 2,
  });

  factory _$CreateRecurringReservationRequestModelImpl.fromJson(
    Map<String, dynamic> json,
  ) => _$$CreateRecurringReservationRequestModelImplFromJson(json);

  @override
  final String restaurantId;
  @override
  final String tableId;
  @override
  final String dayOfWeek;
  @override
  final String startTime;
  @override
  @JsonKey()
  final int partySize;

  @override
  String toString() {
    return 'CreateRecurringReservationRequestModel(restaurantId: $restaurantId, tableId: $tableId, dayOfWeek: $dayOfWeek, startTime: $startTime, partySize: $partySize)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CreateRecurringReservationRequestModelImpl &&
            (identical(other.restaurantId, restaurantId) ||
                other.restaurantId == restaurantId) &&
            (identical(other.tableId, tableId) || other.tableId == tableId) &&
            (identical(other.dayOfWeek, dayOfWeek) ||
                other.dayOfWeek == dayOfWeek) &&
            (identical(other.startTime, startTime) ||
                other.startTime == startTime) &&
            (identical(other.partySize, partySize) ||
                other.partySize == partySize));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    restaurantId,
    tableId,
    dayOfWeek,
    startTime,
    partySize,
  );

  /// Create a copy of CreateRecurringReservationRequestModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CreateRecurringReservationRequestModelImplCopyWith<
    _$CreateRecurringReservationRequestModelImpl
  >
  get copyWith => __$$CreateRecurringReservationRequestModelImplCopyWithImpl<
    _$CreateRecurringReservationRequestModelImpl
  >(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CreateRecurringReservationRequestModelImplToJson(this);
  }
}

abstract class _CreateRecurringReservationRequestModel
    implements CreateRecurringReservationRequestModel {
  const factory _CreateRecurringReservationRequestModel({
    required final String restaurantId,
    required final String tableId,
    required final String dayOfWeek,
    required final String startTime,
    final int partySize,
  }) = _$CreateRecurringReservationRequestModelImpl;

  factory _CreateRecurringReservationRequestModel.fromJson(
    Map<String, dynamic> json,
  ) = _$CreateRecurringReservationRequestModelImpl.fromJson;

  @override
  String get restaurantId;
  @override
  String get tableId;
  @override
  String get dayOfWeek;
  @override
  String get startTime;
  @override
  int get partySize;

  /// Create a copy of CreateRecurringReservationRequestModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CreateRecurringReservationRequestModelImplCopyWith<
    _$CreateRecurringReservationRequestModelImpl
  >
  get copyWith => throw _privateConstructorUsedError;
}
