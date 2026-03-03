// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'table_status_response_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

TableStatusResponseModel _$TableStatusResponseModelFromJson(
  Map<String, dynamic> json,
) {
  return _TableStatusResponseModel.fromJson(json);
}

/// @nodoc
mixin _$TableStatusResponseModel {
  String? get date => throw _privateConstructorUsedError;
  List<TableStatusItemModel> get tables => throw _privateConstructorUsedError;

  /// Serializes this TableStatusResponseModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of TableStatusResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TableStatusResponseModelCopyWith<TableStatusResponseModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TableStatusResponseModelCopyWith<$Res> {
  factory $TableStatusResponseModelCopyWith(
    TableStatusResponseModel value,
    $Res Function(TableStatusResponseModel) then,
  ) = _$TableStatusResponseModelCopyWithImpl<$Res, TableStatusResponseModel>;
  @useResult
  $Res call({String? date, List<TableStatusItemModel> tables});
}

/// @nodoc
class _$TableStatusResponseModelCopyWithImpl<
  $Res,
  $Val extends TableStatusResponseModel
>
    implements $TableStatusResponseModelCopyWith<$Res> {
  _$TableStatusResponseModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TableStatusResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? date = freezed, Object? tables = null}) {
    return _then(
      _value.copyWith(
            date:
                freezed == date
                    ? _value.date
                    : date // ignore: cast_nullable_to_non_nullable
                        as String?,
            tables:
                null == tables
                    ? _value.tables
                    : tables // ignore: cast_nullable_to_non_nullable
                        as List<TableStatusItemModel>,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$TableStatusResponseModelImplCopyWith<$Res>
    implements $TableStatusResponseModelCopyWith<$Res> {
  factory _$$TableStatusResponseModelImplCopyWith(
    _$TableStatusResponseModelImpl value,
    $Res Function(_$TableStatusResponseModelImpl) then,
  ) = __$$TableStatusResponseModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? date, List<TableStatusItemModel> tables});
}

/// @nodoc
class __$$TableStatusResponseModelImplCopyWithImpl<$Res>
    extends
        _$TableStatusResponseModelCopyWithImpl<
          $Res,
          _$TableStatusResponseModelImpl
        >
    implements _$$TableStatusResponseModelImplCopyWith<$Res> {
  __$$TableStatusResponseModelImplCopyWithImpl(
    _$TableStatusResponseModelImpl _value,
    $Res Function(_$TableStatusResponseModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of TableStatusResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? date = freezed, Object? tables = null}) {
    return _then(
      _$TableStatusResponseModelImpl(
        date:
            freezed == date
                ? _value.date
                : date // ignore: cast_nullable_to_non_nullable
                    as String?,
        tables:
            null == tables
                ? _value._tables
                : tables // ignore: cast_nullable_to_non_nullable
                    as List<TableStatusItemModel>,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$TableStatusResponseModelImpl extends _TableStatusResponseModel {
  const _$TableStatusResponseModelImpl({
    this.date,
    final List<TableStatusItemModel> tables = const [],
  }) : _tables = tables,
       super._();

  factory _$TableStatusResponseModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$TableStatusResponseModelImplFromJson(json);

  @override
  final String? date;
  final List<TableStatusItemModel> _tables;
  @override
  @JsonKey()
  List<TableStatusItemModel> get tables {
    if (_tables is EqualUnmodifiableListView) return _tables;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_tables);
  }

  @override
  String toString() {
    return 'TableStatusResponseModel(date: $date, tables: $tables)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TableStatusResponseModelImpl &&
            (identical(other.date, date) || other.date == date) &&
            const DeepCollectionEquality().equals(other._tables, _tables));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    date,
    const DeepCollectionEquality().hash(_tables),
  );

  /// Create a copy of TableStatusResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TableStatusResponseModelImplCopyWith<_$TableStatusResponseModelImpl>
  get copyWith => __$$TableStatusResponseModelImplCopyWithImpl<
    _$TableStatusResponseModelImpl
  >(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TableStatusResponseModelImplToJson(this);
  }
}

abstract class _TableStatusResponseModel extends TableStatusResponseModel {
  const factory _TableStatusResponseModel({
    final String? date,
    final List<TableStatusItemModel> tables,
  }) = _$TableStatusResponseModelImpl;
  const _TableStatusResponseModel._() : super._();

  factory _TableStatusResponseModel.fromJson(Map<String, dynamic> json) =
      _$TableStatusResponseModelImpl.fromJson;

  @override
  String? get date;
  @override
  List<TableStatusItemModel> get tables;

  /// Create a copy of TableStatusResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TableStatusResponseModelImplCopyWith<_$TableStatusResponseModelImpl>
  get copyWith => throw _privateConstructorUsedError;
}

TableStatusItemModel _$TableStatusItemModelFromJson(Map<String, dynamic> json) {
  return _TableStatusItemModel.fromJson(json);
}

/// @nodoc
mixin _$TableStatusItemModel {
  String? get tableId => throw _privateConstructorUsedError;
  String? get status => throw _privateConstructorUsedError;

  /// Serializes this TableStatusItemModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of TableStatusItemModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TableStatusItemModelCopyWith<TableStatusItemModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TableStatusItemModelCopyWith<$Res> {
  factory $TableStatusItemModelCopyWith(
    TableStatusItemModel value,
    $Res Function(TableStatusItemModel) then,
  ) = _$TableStatusItemModelCopyWithImpl<$Res, TableStatusItemModel>;
  @useResult
  $Res call({String? tableId, String? status});
}

/// @nodoc
class _$TableStatusItemModelCopyWithImpl<
  $Res,
  $Val extends TableStatusItemModel
>
    implements $TableStatusItemModelCopyWith<$Res> {
  _$TableStatusItemModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TableStatusItemModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? tableId = freezed, Object? status = freezed}) {
    return _then(
      _value.copyWith(
            tableId:
                freezed == tableId
                    ? _value.tableId
                    : tableId // ignore: cast_nullable_to_non_nullable
                        as String?,
            status:
                freezed == status
                    ? _value.status
                    : status // ignore: cast_nullable_to_non_nullable
                        as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$TableStatusItemModelImplCopyWith<$Res>
    implements $TableStatusItemModelCopyWith<$Res> {
  factory _$$TableStatusItemModelImplCopyWith(
    _$TableStatusItemModelImpl value,
    $Res Function(_$TableStatusItemModelImpl) then,
  ) = __$$TableStatusItemModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? tableId, String? status});
}

/// @nodoc
class __$$TableStatusItemModelImplCopyWithImpl<$Res>
    extends _$TableStatusItemModelCopyWithImpl<$Res, _$TableStatusItemModelImpl>
    implements _$$TableStatusItemModelImplCopyWith<$Res> {
  __$$TableStatusItemModelImplCopyWithImpl(
    _$TableStatusItemModelImpl _value,
    $Res Function(_$TableStatusItemModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of TableStatusItemModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? tableId = freezed, Object? status = freezed}) {
    return _then(
      _$TableStatusItemModelImpl(
        tableId:
            freezed == tableId
                ? _value.tableId
                : tableId // ignore: cast_nullable_to_non_nullable
                    as String?,
        status:
            freezed == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                    as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$TableStatusItemModelImpl extends _TableStatusItemModel {
  const _$TableStatusItemModelImpl({this.tableId, this.status}) : super._();

  factory _$TableStatusItemModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$TableStatusItemModelImplFromJson(json);

  @override
  final String? tableId;
  @override
  final String? status;

  @override
  String toString() {
    return 'TableStatusItemModel(tableId: $tableId, status: $status)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TableStatusItemModelImpl &&
            (identical(other.tableId, tableId) || other.tableId == tableId) &&
            (identical(other.status, status) || other.status == status));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, tableId, status);

  /// Create a copy of TableStatusItemModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TableStatusItemModelImplCopyWith<_$TableStatusItemModelImpl>
  get copyWith =>
      __$$TableStatusItemModelImplCopyWithImpl<_$TableStatusItemModelImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$TableStatusItemModelImplToJson(this);
  }
}

abstract class _TableStatusItemModel extends TableStatusItemModel {
  const factory _TableStatusItemModel({
    final String? tableId,
    final String? status,
  }) = _$TableStatusItemModelImpl;
  const _TableStatusItemModel._() : super._();

  factory _TableStatusItemModel.fromJson(Map<String, dynamic> json) =
      _$TableStatusItemModelImpl.fromJson;

  @override
  String? get tableId;
  @override
  String? get status;

  /// Create a copy of TableStatusItemModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TableStatusItemModelImplCopyWith<_$TableStatusItemModelImpl>
  get copyWith => throw _privateConstructorUsedError;
}
