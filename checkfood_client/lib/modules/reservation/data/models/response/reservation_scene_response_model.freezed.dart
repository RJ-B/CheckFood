// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'reservation_scene_response_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

ReservationSceneResponseModel _$ReservationSceneResponseModelFromJson(
  Map<String, dynamic> json,
) {
  return _ReservationSceneResponseModel.fromJson(json);
}

/// @nodoc
mixin _$ReservationSceneResponseModel {
  String? get restaurantId => throw _privateConstructorUsedError;
  String? get panoramaUrl => throw _privateConstructorUsedError;
  List<SceneTableModel> get tables => throw _privateConstructorUsedError;

  /// Serializes this ReservationSceneResponseModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ReservationSceneResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ReservationSceneResponseModelCopyWith<ReservationSceneResponseModel>
  get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ReservationSceneResponseModelCopyWith<$Res> {
  factory $ReservationSceneResponseModelCopyWith(
    ReservationSceneResponseModel value,
    $Res Function(ReservationSceneResponseModel) then,
  ) =
      _$ReservationSceneResponseModelCopyWithImpl<
        $Res,
        ReservationSceneResponseModel
      >;
  @useResult
  $Res call({
    String? restaurantId,
    String? panoramaUrl,
    List<SceneTableModel> tables,
  });
}

/// @nodoc
class _$ReservationSceneResponseModelCopyWithImpl<
  $Res,
  $Val extends ReservationSceneResponseModel
>
    implements $ReservationSceneResponseModelCopyWith<$Res> {
  _$ReservationSceneResponseModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ReservationSceneResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? restaurantId = freezed,
    Object? panoramaUrl = freezed,
    Object? tables = null,
  }) {
    return _then(
      _value.copyWith(
            restaurantId:
                freezed == restaurantId
                    ? _value.restaurantId
                    : restaurantId // ignore: cast_nullable_to_non_nullable
                        as String?,
            panoramaUrl:
                freezed == panoramaUrl
                    ? _value.panoramaUrl
                    : panoramaUrl // ignore: cast_nullable_to_non_nullable
                        as String?,
            tables:
                null == tables
                    ? _value.tables
                    : tables // ignore: cast_nullable_to_non_nullable
                        as List<SceneTableModel>,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ReservationSceneResponseModelImplCopyWith<$Res>
    implements $ReservationSceneResponseModelCopyWith<$Res> {
  factory _$$ReservationSceneResponseModelImplCopyWith(
    _$ReservationSceneResponseModelImpl value,
    $Res Function(_$ReservationSceneResponseModelImpl) then,
  ) = __$$ReservationSceneResponseModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String? restaurantId,
    String? panoramaUrl,
    List<SceneTableModel> tables,
  });
}

/// @nodoc
class __$$ReservationSceneResponseModelImplCopyWithImpl<$Res>
    extends
        _$ReservationSceneResponseModelCopyWithImpl<
          $Res,
          _$ReservationSceneResponseModelImpl
        >
    implements _$$ReservationSceneResponseModelImplCopyWith<$Res> {
  __$$ReservationSceneResponseModelImplCopyWithImpl(
    _$ReservationSceneResponseModelImpl _value,
    $Res Function(_$ReservationSceneResponseModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ReservationSceneResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? restaurantId = freezed,
    Object? panoramaUrl = freezed,
    Object? tables = null,
  }) {
    return _then(
      _$ReservationSceneResponseModelImpl(
        restaurantId:
            freezed == restaurantId
                ? _value.restaurantId
                : restaurantId // ignore: cast_nullable_to_non_nullable
                    as String?,
        panoramaUrl:
            freezed == panoramaUrl
                ? _value.panoramaUrl
                : panoramaUrl // ignore: cast_nullable_to_non_nullable
                    as String?,
        tables:
            null == tables
                ? _value._tables
                : tables // ignore: cast_nullable_to_non_nullable
                    as List<SceneTableModel>,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ReservationSceneResponseModelImpl
    extends _ReservationSceneResponseModel {
  const _$ReservationSceneResponseModelImpl({
    this.restaurantId,
    this.panoramaUrl,
    final List<SceneTableModel> tables = const [],
  }) : _tables = tables,
       super._();

  factory _$ReservationSceneResponseModelImpl.fromJson(
    Map<String, dynamic> json,
  ) => _$$ReservationSceneResponseModelImplFromJson(json);

  @override
  final String? restaurantId;
  @override
  final String? panoramaUrl;
  final List<SceneTableModel> _tables;
  @override
  @JsonKey()
  List<SceneTableModel> get tables {
    if (_tables is EqualUnmodifiableListView) return _tables;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_tables);
  }

  @override
  String toString() {
    return 'ReservationSceneResponseModel(restaurantId: $restaurantId, panoramaUrl: $panoramaUrl, tables: $tables)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ReservationSceneResponseModelImpl &&
            (identical(other.restaurantId, restaurantId) ||
                other.restaurantId == restaurantId) &&
            (identical(other.panoramaUrl, panoramaUrl) ||
                other.panoramaUrl == panoramaUrl) &&
            const DeepCollectionEquality().equals(other._tables, _tables));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    restaurantId,
    panoramaUrl,
    const DeepCollectionEquality().hash(_tables),
  );

  /// Create a copy of ReservationSceneResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ReservationSceneResponseModelImplCopyWith<
    _$ReservationSceneResponseModelImpl
  >
  get copyWith => __$$ReservationSceneResponseModelImplCopyWithImpl<
    _$ReservationSceneResponseModelImpl
  >(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ReservationSceneResponseModelImplToJson(this);
  }
}

abstract class _ReservationSceneResponseModel
    extends ReservationSceneResponseModel {
  const factory _ReservationSceneResponseModel({
    final String? restaurantId,
    final String? panoramaUrl,
    final List<SceneTableModel> tables,
  }) = _$ReservationSceneResponseModelImpl;
  const _ReservationSceneResponseModel._() : super._();

  factory _ReservationSceneResponseModel.fromJson(Map<String, dynamic> json) =
      _$ReservationSceneResponseModelImpl.fromJson;

  @override
  String? get restaurantId;
  @override
  String? get panoramaUrl;
  @override
  List<SceneTableModel> get tables;

  /// Create a copy of ReservationSceneResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ReservationSceneResponseModelImplCopyWith<
    _$ReservationSceneResponseModelImpl
  >
  get copyWith => throw _privateConstructorUsedError;
}

SceneTableModel _$SceneTableModelFromJson(Map<String, dynamic> json) {
  return _SceneTableModel.fromJson(json);
}

/// @nodoc
mixin _$SceneTableModel {
  String? get tableId => throw _privateConstructorUsedError;
  String? get label => throw _privateConstructorUsedError;
  double? get yaw => throw _privateConstructorUsedError;
  double? get pitch => throw _privateConstructorUsedError;
  int? get capacity => throw _privateConstructorUsedError;

  /// Serializes this SceneTableModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of SceneTableModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SceneTableModelCopyWith<SceneTableModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SceneTableModelCopyWith<$Res> {
  factory $SceneTableModelCopyWith(
    SceneTableModel value,
    $Res Function(SceneTableModel) then,
  ) = _$SceneTableModelCopyWithImpl<$Res, SceneTableModel>;
  @useResult
  $Res call({
    String? tableId,
    String? label,
    double? yaw,
    double? pitch,
    int? capacity,
  });
}

/// @nodoc
class _$SceneTableModelCopyWithImpl<$Res, $Val extends SceneTableModel>
    implements $SceneTableModelCopyWith<$Res> {
  _$SceneTableModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SceneTableModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? tableId = freezed,
    Object? label = freezed,
    Object? yaw = freezed,
    Object? pitch = freezed,
    Object? capacity = freezed,
  }) {
    return _then(
      _value.copyWith(
            tableId:
                freezed == tableId
                    ? _value.tableId
                    : tableId // ignore: cast_nullable_to_non_nullable
                        as String?,
            label:
                freezed == label
                    ? _value.label
                    : label // ignore: cast_nullable_to_non_nullable
                        as String?,
            yaw:
                freezed == yaw
                    ? _value.yaw
                    : yaw // ignore: cast_nullable_to_non_nullable
                        as double?,
            pitch:
                freezed == pitch
                    ? _value.pitch
                    : pitch // ignore: cast_nullable_to_non_nullable
                        as double?,
            capacity:
                freezed == capacity
                    ? _value.capacity
                    : capacity // ignore: cast_nullable_to_non_nullable
                        as int?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$SceneTableModelImplCopyWith<$Res>
    implements $SceneTableModelCopyWith<$Res> {
  factory _$$SceneTableModelImplCopyWith(
    _$SceneTableModelImpl value,
    $Res Function(_$SceneTableModelImpl) then,
  ) = __$$SceneTableModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String? tableId,
    String? label,
    double? yaw,
    double? pitch,
    int? capacity,
  });
}

/// @nodoc
class __$$SceneTableModelImplCopyWithImpl<$Res>
    extends _$SceneTableModelCopyWithImpl<$Res, _$SceneTableModelImpl>
    implements _$$SceneTableModelImplCopyWith<$Res> {
  __$$SceneTableModelImplCopyWithImpl(
    _$SceneTableModelImpl _value,
    $Res Function(_$SceneTableModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of SceneTableModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? tableId = freezed,
    Object? label = freezed,
    Object? yaw = freezed,
    Object? pitch = freezed,
    Object? capacity = freezed,
  }) {
    return _then(
      _$SceneTableModelImpl(
        tableId:
            freezed == tableId
                ? _value.tableId
                : tableId // ignore: cast_nullable_to_non_nullable
                    as String?,
        label:
            freezed == label
                ? _value.label
                : label // ignore: cast_nullable_to_non_nullable
                    as String?,
        yaw:
            freezed == yaw
                ? _value.yaw
                : yaw // ignore: cast_nullable_to_non_nullable
                    as double?,
        pitch:
            freezed == pitch
                ? _value.pitch
                : pitch // ignore: cast_nullable_to_non_nullable
                    as double?,
        capacity:
            freezed == capacity
                ? _value.capacity
                : capacity // ignore: cast_nullable_to_non_nullable
                    as int?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$SceneTableModelImpl extends _SceneTableModel {
  const _$SceneTableModelImpl({
    this.tableId,
    this.label,
    this.yaw,
    this.pitch,
    this.capacity,
  }) : super._();

  factory _$SceneTableModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$SceneTableModelImplFromJson(json);

  @override
  final String? tableId;
  @override
  final String? label;
  @override
  final double? yaw;
  @override
  final double? pitch;
  @override
  final int? capacity;

  @override
  String toString() {
    return 'SceneTableModel(tableId: $tableId, label: $label, yaw: $yaw, pitch: $pitch, capacity: $capacity)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SceneTableModelImpl &&
            (identical(other.tableId, tableId) || other.tableId == tableId) &&
            (identical(other.label, label) || other.label == label) &&
            (identical(other.yaw, yaw) || other.yaw == yaw) &&
            (identical(other.pitch, pitch) || other.pitch == pitch) &&
            (identical(other.capacity, capacity) ||
                other.capacity == capacity));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, tableId, label, yaw, pitch, capacity);

  /// Create a copy of SceneTableModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SceneTableModelImplCopyWith<_$SceneTableModelImpl> get copyWith =>
      __$$SceneTableModelImplCopyWithImpl<_$SceneTableModelImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$SceneTableModelImplToJson(this);
  }
}

abstract class _SceneTableModel extends SceneTableModel {
  const factory _SceneTableModel({
    final String? tableId,
    final String? label,
    final double? yaw,
    final double? pitch,
    final int? capacity,
  }) = _$SceneTableModelImpl;
  const _SceneTableModel._() : super._();

  factory _SceneTableModel.fromJson(Map<String, dynamic> json) =
      _$SceneTableModelImpl.fromJson;

  @override
  String? get tableId;
  @override
  String? get label;
  @override
  double? get yaw;
  @override
  double? get pitch;
  @override
  int? get capacity;

  /// Create a copy of SceneTableModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SceneTableModelImplCopyWith<_$SceneTableModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
