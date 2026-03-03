// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'reservation_response_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

ReservationResponseModel _$ReservationResponseModelFromJson(
  Map<String, dynamic> json,
) {
  return _ReservationResponseModel.fromJson(json);
}

/// @nodoc
mixin _$ReservationResponseModel {
  String? get id => throw _privateConstructorUsedError;
  String? get restaurantId => throw _privateConstructorUsedError;
  String? get tableId => throw _privateConstructorUsedError;
  String? get restaurantName => throw _privateConstructorUsedError;
  String? get tableLabel => throw _privateConstructorUsedError;
  String? get date => throw _privateConstructorUsedError;
  String? get startTime => throw _privateConstructorUsedError;
  String? get endTime => throw _privateConstructorUsedError;
  String? get status => throw _privateConstructorUsedError;
  int? get partySize => throw _privateConstructorUsedError;
  bool get canEdit => throw _privateConstructorUsedError;
  bool get canCancel => throw _privateConstructorUsedError;

  /// Serializes this ReservationResponseModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ReservationResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ReservationResponseModelCopyWith<ReservationResponseModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ReservationResponseModelCopyWith<$Res> {
  factory $ReservationResponseModelCopyWith(
    ReservationResponseModel value,
    $Res Function(ReservationResponseModel) then,
  ) = _$ReservationResponseModelCopyWithImpl<$Res, ReservationResponseModel>;
  @useResult
  $Res call({
    String? id,
    String? restaurantId,
    String? tableId,
    String? restaurantName,
    String? tableLabel,
    String? date,
    String? startTime,
    String? endTime,
    String? status,
    int? partySize,
    bool canEdit,
    bool canCancel,
  });
}

/// @nodoc
class _$ReservationResponseModelCopyWithImpl<
  $Res,
  $Val extends ReservationResponseModel
>
    implements $ReservationResponseModelCopyWith<$Res> {
  _$ReservationResponseModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ReservationResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? restaurantId = freezed,
    Object? tableId = freezed,
    Object? restaurantName = freezed,
    Object? tableLabel = freezed,
    Object? date = freezed,
    Object? startTime = freezed,
    Object? endTime = freezed,
    Object? status = freezed,
    Object? partySize = freezed,
    Object? canEdit = null,
    Object? canCancel = null,
  }) {
    return _then(
      _value.copyWith(
            id:
                freezed == id
                    ? _value.id
                    : id // ignore: cast_nullable_to_non_nullable
                        as String?,
            restaurantId:
                freezed == restaurantId
                    ? _value.restaurantId
                    : restaurantId // ignore: cast_nullable_to_non_nullable
                        as String?,
            tableId:
                freezed == tableId
                    ? _value.tableId
                    : tableId // ignore: cast_nullable_to_non_nullable
                        as String?,
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
                freezed == date
                    ? _value.date
                    : date // ignore: cast_nullable_to_non_nullable
                        as String?,
            startTime:
                freezed == startTime
                    ? _value.startTime
                    : startTime // ignore: cast_nullable_to_non_nullable
                        as String?,
            endTime:
                freezed == endTime
                    ? _value.endTime
                    : endTime // ignore: cast_nullable_to_non_nullable
                        as String?,
            status:
                freezed == status
                    ? _value.status
                    : status // ignore: cast_nullable_to_non_nullable
                        as String?,
            partySize:
                freezed == partySize
                    ? _value.partySize
                    : partySize // ignore: cast_nullable_to_non_nullable
                        as int?,
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
abstract class _$$ReservationResponseModelImplCopyWith<$Res>
    implements $ReservationResponseModelCopyWith<$Res> {
  factory _$$ReservationResponseModelImplCopyWith(
    _$ReservationResponseModelImpl value,
    $Res Function(_$ReservationResponseModelImpl) then,
  ) = __$$ReservationResponseModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String? id,
    String? restaurantId,
    String? tableId,
    String? restaurantName,
    String? tableLabel,
    String? date,
    String? startTime,
    String? endTime,
    String? status,
    int? partySize,
    bool canEdit,
    bool canCancel,
  });
}

/// @nodoc
class __$$ReservationResponseModelImplCopyWithImpl<$Res>
    extends
        _$ReservationResponseModelCopyWithImpl<
          $Res,
          _$ReservationResponseModelImpl
        >
    implements _$$ReservationResponseModelImplCopyWith<$Res> {
  __$$ReservationResponseModelImplCopyWithImpl(
    _$ReservationResponseModelImpl _value,
    $Res Function(_$ReservationResponseModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ReservationResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? restaurantId = freezed,
    Object? tableId = freezed,
    Object? restaurantName = freezed,
    Object? tableLabel = freezed,
    Object? date = freezed,
    Object? startTime = freezed,
    Object? endTime = freezed,
    Object? status = freezed,
    Object? partySize = freezed,
    Object? canEdit = null,
    Object? canCancel = null,
  }) {
    return _then(
      _$ReservationResponseModelImpl(
        id:
            freezed == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                    as String?,
        restaurantId:
            freezed == restaurantId
                ? _value.restaurantId
                : restaurantId // ignore: cast_nullable_to_non_nullable
                    as String?,
        tableId:
            freezed == tableId
                ? _value.tableId
                : tableId // ignore: cast_nullable_to_non_nullable
                    as String?,
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
            freezed == date
                ? _value.date
                : date // ignore: cast_nullable_to_non_nullable
                    as String?,
        startTime:
            freezed == startTime
                ? _value.startTime
                : startTime // ignore: cast_nullable_to_non_nullable
                    as String?,
        endTime:
            freezed == endTime
                ? _value.endTime
                : endTime // ignore: cast_nullable_to_non_nullable
                    as String?,
        status:
            freezed == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                    as String?,
        partySize:
            freezed == partySize
                ? _value.partySize
                : partySize // ignore: cast_nullable_to_non_nullable
                    as int?,
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
@JsonSerializable()
class _$ReservationResponseModelImpl extends _ReservationResponseModel {
  const _$ReservationResponseModelImpl({
    this.id,
    this.restaurantId,
    this.tableId,
    this.restaurantName,
    this.tableLabel,
    this.date,
    this.startTime,
    this.endTime,
    this.status,
    this.partySize,
    this.canEdit = false,
    this.canCancel = false,
  }) : super._();

  factory _$ReservationResponseModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$ReservationResponseModelImplFromJson(json);

  @override
  final String? id;
  @override
  final String? restaurantId;
  @override
  final String? tableId;
  @override
  final String? restaurantName;
  @override
  final String? tableLabel;
  @override
  final String? date;
  @override
  final String? startTime;
  @override
  final String? endTime;
  @override
  final String? status;
  @override
  final int? partySize;
  @override
  @JsonKey()
  final bool canEdit;
  @override
  @JsonKey()
  final bool canCancel;

  @override
  String toString() {
    return 'ReservationResponseModel(id: $id, restaurantId: $restaurantId, tableId: $tableId, restaurantName: $restaurantName, tableLabel: $tableLabel, date: $date, startTime: $startTime, endTime: $endTime, status: $status, partySize: $partySize, canEdit: $canEdit, canCancel: $canCancel)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ReservationResponseModelImpl &&
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

  @JsonKey(includeFromJson: false, includeToJson: false)
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

  /// Create a copy of ReservationResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ReservationResponseModelImplCopyWith<_$ReservationResponseModelImpl>
  get copyWith => __$$ReservationResponseModelImplCopyWithImpl<
    _$ReservationResponseModelImpl
  >(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ReservationResponseModelImplToJson(this);
  }
}

abstract class _ReservationResponseModel extends ReservationResponseModel {
  const factory _ReservationResponseModel({
    final String? id,
    final String? restaurantId,
    final String? tableId,
    final String? restaurantName,
    final String? tableLabel,
    final String? date,
    final String? startTime,
    final String? endTime,
    final String? status,
    final int? partySize,
    final bool canEdit,
    final bool canCancel,
  }) = _$ReservationResponseModelImpl;
  const _ReservationResponseModel._() : super._();

  factory _ReservationResponseModel.fromJson(Map<String, dynamic> json) =
      _$ReservationResponseModelImpl.fromJson;

  @override
  String? get id;
  @override
  String? get restaurantId;
  @override
  String? get tableId;
  @override
  String? get restaurantName;
  @override
  String? get tableLabel;
  @override
  String? get date;
  @override
  String? get startTime;
  @override
  String? get endTime;
  @override
  String? get status;
  @override
  int? get partySize;
  @override
  bool get canEdit;
  @override
  bool get canCancel;

  /// Create a copy of ReservationResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ReservationResponseModelImplCopyWith<_$ReservationResponseModelImpl>
  get copyWith => throw _privateConstructorUsedError;
}
