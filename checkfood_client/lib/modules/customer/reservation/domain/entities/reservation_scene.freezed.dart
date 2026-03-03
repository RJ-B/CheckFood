// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'reservation_scene.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$ReservationScene {
  String get restaurantId => throw _privateConstructorUsedError;
  String? get panoramaUrl => throw _privateConstructorUsedError;
  List<SceneTable> get tables => throw _privateConstructorUsedError;

  /// Create a copy of ReservationScene
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ReservationSceneCopyWith<ReservationScene> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ReservationSceneCopyWith<$Res> {
  factory $ReservationSceneCopyWith(
    ReservationScene value,
    $Res Function(ReservationScene) then,
  ) = _$ReservationSceneCopyWithImpl<$Res, ReservationScene>;
  @useResult
  $Res call({
    String restaurantId,
    String? panoramaUrl,
    List<SceneTable> tables,
  });
}

/// @nodoc
class _$ReservationSceneCopyWithImpl<$Res, $Val extends ReservationScene>
    implements $ReservationSceneCopyWith<$Res> {
  _$ReservationSceneCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ReservationScene
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? restaurantId = null,
    Object? panoramaUrl = freezed,
    Object? tables = null,
  }) {
    return _then(
      _value.copyWith(
            restaurantId:
                null == restaurantId
                    ? _value.restaurantId
                    : restaurantId // ignore: cast_nullable_to_non_nullable
                        as String,
            panoramaUrl:
                freezed == panoramaUrl
                    ? _value.panoramaUrl
                    : panoramaUrl // ignore: cast_nullable_to_non_nullable
                        as String?,
            tables:
                null == tables
                    ? _value.tables
                    : tables // ignore: cast_nullable_to_non_nullable
                        as List<SceneTable>,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ReservationSceneImplCopyWith<$Res>
    implements $ReservationSceneCopyWith<$Res> {
  factory _$$ReservationSceneImplCopyWith(
    _$ReservationSceneImpl value,
    $Res Function(_$ReservationSceneImpl) then,
  ) = __$$ReservationSceneImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String restaurantId,
    String? panoramaUrl,
    List<SceneTable> tables,
  });
}

/// @nodoc
class __$$ReservationSceneImplCopyWithImpl<$Res>
    extends _$ReservationSceneCopyWithImpl<$Res, _$ReservationSceneImpl>
    implements _$$ReservationSceneImplCopyWith<$Res> {
  __$$ReservationSceneImplCopyWithImpl(
    _$ReservationSceneImpl _value,
    $Res Function(_$ReservationSceneImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ReservationScene
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? restaurantId = null,
    Object? panoramaUrl = freezed,
    Object? tables = null,
  }) {
    return _then(
      _$ReservationSceneImpl(
        restaurantId:
            null == restaurantId
                ? _value.restaurantId
                : restaurantId // ignore: cast_nullable_to_non_nullable
                    as String,
        panoramaUrl:
            freezed == panoramaUrl
                ? _value.panoramaUrl
                : panoramaUrl // ignore: cast_nullable_to_non_nullable
                    as String?,
        tables:
            null == tables
                ? _value._tables
                : tables // ignore: cast_nullable_to_non_nullable
                    as List<SceneTable>,
      ),
    );
  }
}

/// @nodoc

class _$ReservationSceneImpl extends _ReservationScene {
  const _$ReservationSceneImpl({
    required this.restaurantId,
    this.panoramaUrl,
    required final List<SceneTable> tables,
  }) : _tables = tables,
       super._();

  @override
  final String restaurantId;
  @override
  final String? panoramaUrl;
  final List<SceneTable> _tables;
  @override
  List<SceneTable> get tables {
    if (_tables is EqualUnmodifiableListView) return _tables;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_tables);
  }

  @override
  String toString() {
    return 'ReservationScene(restaurantId: $restaurantId, panoramaUrl: $panoramaUrl, tables: $tables)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ReservationSceneImpl &&
            (identical(other.restaurantId, restaurantId) ||
                other.restaurantId == restaurantId) &&
            (identical(other.panoramaUrl, panoramaUrl) ||
                other.panoramaUrl == panoramaUrl) &&
            const DeepCollectionEquality().equals(other._tables, _tables));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    restaurantId,
    panoramaUrl,
    const DeepCollectionEquality().hash(_tables),
  );

  /// Create a copy of ReservationScene
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ReservationSceneImplCopyWith<_$ReservationSceneImpl> get copyWith =>
      __$$ReservationSceneImplCopyWithImpl<_$ReservationSceneImpl>(
        this,
        _$identity,
      );
}

abstract class _ReservationScene extends ReservationScene {
  const factory _ReservationScene({
    required final String restaurantId,
    final String? panoramaUrl,
    required final List<SceneTable> tables,
  }) = _$ReservationSceneImpl;
  const _ReservationScene._() : super._();

  @override
  String get restaurantId;
  @override
  String? get panoramaUrl;
  @override
  List<SceneTable> get tables;

  /// Create a copy of ReservationScene
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ReservationSceneImplCopyWith<_$ReservationSceneImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$SceneTable {
  String get tableId => throw _privateConstructorUsedError;
  String get label => throw _privateConstructorUsedError;
  double get yaw => throw _privateConstructorUsedError;
  double get pitch => throw _privateConstructorUsedError;
  int get capacity => throw _privateConstructorUsedError;

  /// Create a copy of SceneTable
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SceneTableCopyWith<SceneTable> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SceneTableCopyWith<$Res> {
  factory $SceneTableCopyWith(
    SceneTable value,
    $Res Function(SceneTable) then,
  ) = _$SceneTableCopyWithImpl<$Res, SceneTable>;
  @useResult
  $Res call({
    String tableId,
    String label,
    double yaw,
    double pitch,
    int capacity,
  });
}

/// @nodoc
class _$SceneTableCopyWithImpl<$Res, $Val extends SceneTable>
    implements $SceneTableCopyWith<$Res> {
  _$SceneTableCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SceneTable
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? tableId = null,
    Object? label = null,
    Object? yaw = null,
    Object? pitch = null,
    Object? capacity = null,
  }) {
    return _then(
      _value.copyWith(
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
            yaw:
                null == yaw
                    ? _value.yaw
                    : yaw // ignore: cast_nullable_to_non_nullable
                        as double,
            pitch:
                null == pitch
                    ? _value.pitch
                    : pitch // ignore: cast_nullable_to_non_nullable
                        as double,
            capacity:
                null == capacity
                    ? _value.capacity
                    : capacity // ignore: cast_nullable_to_non_nullable
                        as int,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$SceneTableImplCopyWith<$Res>
    implements $SceneTableCopyWith<$Res> {
  factory _$$SceneTableImplCopyWith(
    _$SceneTableImpl value,
    $Res Function(_$SceneTableImpl) then,
  ) = __$$SceneTableImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String tableId,
    String label,
    double yaw,
    double pitch,
    int capacity,
  });
}

/// @nodoc
class __$$SceneTableImplCopyWithImpl<$Res>
    extends _$SceneTableCopyWithImpl<$Res, _$SceneTableImpl>
    implements _$$SceneTableImplCopyWith<$Res> {
  __$$SceneTableImplCopyWithImpl(
    _$SceneTableImpl _value,
    $Res Function(_$SceneTableImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of SceneTable
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? tableId = null,
    Object? label = null,
    Object? yaw = null,
    Object? pitch = null,
    Object? capacity = null,
  }) {
    return _then(
      _$SceneTableImpl(
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
        yaw:
            null == yaw
                ? _value.yaw
                : yaw // ignore: cast_nullable_to_non_nullable
                    as double,
        pitch:
            null == pitch
                ? _value.pitch
                : pitch // ignore: cast_nullable_to_non_nullable
                    as double,
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

class _$SceneTableImpl extends _SceneTable {
  const _$SceneTableImpl({
    required this.tableId,
    required this.label,
    required this.yaw,
    required this.pitch,
    required this.capacity,
  }) : super._();

  @override
  final String tableId;
  @override
  final String label;
  @override
  final double yaw;
  @override
  final double pitch;
  @override
  final int capacity;

  @override
  String toString() {
    return 'SceneTable(tableId: $tableId, label: $label, yaw: $yaw, pitch: $pitch, capacity: $capacity)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SceneTableImpl &&
            (identical(other.tableId, tableId) || other.tableId == tableId) &&
            (identical(other.label, label) || other.label == label) &&
            (identical(other.yaw, yaw) || other.yaw == yaw) &&
            (identical(other.pitch, pitch) || other.pitch == pitch) &&
            (identical(other.capacity, capacity) ||
                other.capacity == capacity));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, tableId, label, yaw, pitch, capacity);

  /// Create a copy of SceneTable
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SceneTableImplCopyWith<_$SceneTableImpl> get copyWith =>
      __$$SceneTableImplCopyWithImpl<_$SceneTableImpl>(this, _$identity);
}

abstract class _SceneTable extends SceneTable {
  const factory _SceneTable({
    required final String tableId,
    required final String label,
    required final double yaw,
    required final double pitch,
    required final int capacity,
  }) = _$SceneTableImpl;
  const _SceneTable._() : super._();

  @override
  String get tableId;
  @override
  String get label;
  @override
  double get yaw;
  @override
  double get pitch;
  @override
  int get capacity;

  /// Create a copy of SceneTable
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SceneTableImplCopyWith<_$SceneTableImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
