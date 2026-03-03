// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'table_status.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$TableStatusList {
  String get date => throw _privateConstructorUsedError;
  List<TableStatus> get tables => throw _privateConstructorUsedError;

  /// Create a copy of TableStatusList
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TableStatusListCopyWith<TableStatusList> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TableStatusListCopyWith<$Res> {
  factory $TableStatusListCopyWith(
    TableStatusList value,
    $Res Function(TableStatusList) then,
  ) = _$TableStatusListCopyWithImpl<$Res, TableStatusList>;
  @useResult
  $Res call({String date, List<TableStatus> tables});
}

/// @nodoc
class _$TableStatusListCopyWithImpl<$Res, $Val extends TableStatusList>
    implements $TableStatusListCopyWith<$Res> {
  _$TableStatusListCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TableStatusList
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? date = null, Object? tables = null}) {
    return _then(
      _value.copyWith(
            date:
                null == date
                    ? _value.date
                    : date // ignore: cast_nullable_to_non_nullable
                        as String,
            tables:
                null == tables
                    ? _value.tables
                    : tables // ignore: cast_nullable_to_non_nullable
                        as List<TableStatus>,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$TableStatusListImplCopyWith<$Res>
    implements $TableStatusListCopyWith<$Res> {
  factory _$$TableStatusListImplCopyWith(
    _$TableStatusListImpl value,
    $Res Function(_$TableStatusListImpl) then,
  ) = __$$TableStatusListImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String date, List<TableStatus> tables});
}

/// @nodoc
class __$$TableStatusListImplCopyWithImpl<$Res>
    extends _$TableStatusListCopyWithImpl<$Res, _$TableStatusListImpl>
    implements _$$TableStatusListImplCopyWith<$Res> {
  __$$TableStatusListImplCopyWithImpl(
    _$TableStatusListImpl _value,
    $Res Function(_$TableStatusListImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of TableStatusList
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? date = null, Object? tables = null}) {
    return _then(
      _$TableStatusListImpl(
        date:
            null == date
                ? _value.date
                : date // ignore: cast_nullable_to_non_nullable
                    as String,
        tables:
            null == tables
                ? _value._tables
                : tables // ignore: cast_nullable_to_non_nullable
                    as List<TableStatus>,
      ),
    );
  }
}

/// @nodoc

class _$TableStatusListImpl implements _TableStatusList {
  const _$TableStatusListImpl({
    required this.date,
    required final List<TableStatus> tables,
  }) : _tables = tables;

  @override
  final String date;
  final List<TableStatus> _tables;
  @override
  List<TableStatus> get tables {
    if (_tables is EqualUnmodifiableListView) return _tables;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_tables);
  }

  @override
  String toString() {
    return 'TableStatusList(date: $date, tables: $tables)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TableStatusListImpl &&
            (identical(other.date, date) || other.date == date) &&
            const DeepCollectionEquality().equals(other._tables, _tables));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    date,
    const DeepCollectionEquality().hash(_tables),
  );

  /// Create a copy of TableStatusList
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TableStatusListImplCopyWith<_$TableStatusListImpl> get copyWith =>
      __$$TableStatusListImplCopyWithImpl<_$TableStatusListImpl>(
        this,
        _$identity,
      );
}

abstract class _TableStatusList implements TableStatusList {
  const factory _TableStatusList({
    required final String date,
    required final List<TableStatus> tables,
  }) = _$TableStatusListImpl;

  @override
  String get date;
  @override
  List<TableStatus> get tables;

  /// Create a copy of TableStatusList
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TableStatusListImplCopyWith<_$TableStatusListImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$TableStatus {
  String get tableId => throw _privateConstructorUsedError;
  String get status => throw _privateConstructorUsedError;

  /// Create a copy of TableStatus
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TableStatusCopyWith<TableStatus> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TableStatusCopyWith<$Res> {
  factory $TableStatusCopyWith(
    TableStatus value,
    $Res Function(TableStatus) then,
  ) = _$TableStatusCopyWithImpl<$Res, TableStatus>;
  @useResult
  $Res call({String tableId, String status});
}

/// @nodoc
class _$TableStatusCopyWithImpl<$Res, $Val extends TableStatus>
    implements $TableStatusCopyWith<$Res> {
  _$TableStatusCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TableStatus
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? tableId = null, Object? status = null}) {
    return _then(
      _value.copyWith(
            tableId:
                null == tableId
                    ? _value.tableId
                    : tableId // ignore: cast_nullable_to_non_nullable
                        as String,
            status:
                null == status
                    ? _value.status
                    : status // ignore: cast_nullable_to_non_nullable
                        as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$TableStatusImplCopyWith<$Res>
    implements $TableStatusCopyWith<$Res> {
  factory _$$TableStatusImplCopyWith(
    _$TableStatusImpl value,
    $Res Function(_$TableStatusImpl) then,
  ) = __$$TableStatusImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String tableId, String status});
}

/// @nodoc
class __$$TableStatusImplCopyWithImpl<$Res>
    extends _$TableStatusCopyWithImpl<$Res, _$TableStatusImpl>
    implements _$$TableStatusImplCopyWith<$Res> {
  __$$TableStatusImplCopyWithImpl(
    _$TableStatusImpl _value,
    $Res Function(_$TableStatusImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of TableStatus
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? tableId = null, Object? status = null}) {
    return _then(
      _$TableStatusImpl(
        tableId:
            null == tableId
                ? _value.tableId
                : tableId // ignore: cast_nullable_to_non_nullable
                    as String,
        status:
            null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                    as String,
      ),
    );
  }
}

/// @nodoc

class _$TableStatusImpl implements _TableStatus {
  const _$TableStatusImpl({required this.tableId, required this.status});

  @override
  final String tableId;
  @override
  final String status;

  @override
  String toString() {
    return 'TableStatus(tableId: $tableId, status: $status)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TableStatusImpl &&
            (identical(other.tableId, tableId) || other.tableId == tableId) &&
            (identical(other.status, status) || other.status == status));
  }

  @override
  int get hashCode => Object.hash(runtimeType, tableId, status);

  /// Create a copy of TableStatus
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TableStatusImplCopyWith<_$TableStatusImpl> get copyWith =>
      __$$TableStatusImplCopyWithImpl<_$TableStatusImpl>(this, _$identity);
}

abstract class _TableStatus implements TableStatus {
  const factory _TableStatus({
    required final String tableId,
    required final String status,
  }) = _$TableStatusImpl;

  @override
  String get tableId;
  @override
  String get status;

  /// Create a copy of TableStatus
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TableStatusImplCopyWith<_$TableStatusImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
