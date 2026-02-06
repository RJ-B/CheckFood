// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'device_response_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

DeviceResponseModel _$DeviceResponseModelFromJson(Map<String, dynamic> json) {
  return _DeviceResponseModel.fromJson(json);
}

/// @nodoc
mixin _$DeviceResponseModel {
  @JsonKey(name: 'id')
  int get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'name')
  String get name => throw _privateConstructorUsedError;
  @JsonKey(name: 'deviceIdentifier')
  String get deviceIdentifier => throw _privateConstructorUsedError;
  @JsonKey(name: 'type')
  String get type => throw _privateConstructorUsedError;
  @JsonKey(name: 'ipAddress')
  String get ipAddress => throw _privateConstructorUsedError;
  @JsonKey(name: 'lastActive')
  DateTime get lastActive => throw _privateConstructorUsedError;
  @JsonKey(name: 'isCurrent')
  bool get isCurrent => throw _privateConstructorUsedError;

  /// Serializes this DeviceResponseModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of DeviceResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $DeviceResponseModelCopyWith<DeviceResponseModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DeviceResponseModelCopyWith<$Res> {
  factory $DeviceResponseModelCopyWith(
    DeviceResponseModel value,
    $Res Function(DeviceResponseModel) then,
  ) = _$DeviceResponseModelCopyWithImpl<$Res, DeviceResponseModel>;
  @useResult
  $Res call({
    @JsonKey(name: 'id') int id,
    @JsonKey(name: 'name') String name,
    @JsonKey(name: 'deviceIdentifier') String deviceIdentifier,
    @JsonKey(name: 'type') String type,
    @JsonKey(name: 'ipAddress') String ipAddress,
    @JsonKey(name: 'lastActive') DateTime lastActive,
    @JsonKey(name: 'isCurrent') bool isCurrent,
  });
}

/// @nodoc
class _$DeviceResponseModelCopyWithImpl<$Res, $Val extends DeviceResponseModel>
    implements $DeviceResponseModelCopyWith<$Res> {
  _$DeviceResponseModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of DeviceResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? deviceIdentifier = null,
    Object? type = null,
    Object? ipAddress = null,
    Object? lastActive = null,
    Object? isCurrent = null,
  }) {
    return _then(
      _value.copyWith(
            id:
                null == id
                    ? _value.id
                    : id // ignore: cast_nullable_to_non_nullable
                        as int,
            name:
                null == name
                    ? _value.name
                    : name // ignore: cast_nullable_to_non_nullable
                        as String,
            deviceIdentifier:
                null == deviceIdentifier
                    ? _value.deviceIdentifier
                    : deviceIdentifier // ignore: cast_nullable_to_non_nullable
                        as String,
            type:
                null == type
                    ? _value.type
                    : type // ignore: cast_nullable_to_non_nullable
                        as String,
            ipAddress:
                null == ipAddress
                    ? _value.ipAddress
                    : ipAddress // ignore: cast_nullable_to_non_nullable
                        as String,
            lastActive:
                null == lastActive
                    ? _value.lastActive
                    : lastActive // ignore: cast_nullable_to_non_nullable
                        as DateTime,
            isCurrent:
                null == isCurrent
                    ? _value.isCurrent
                    : isCurrent // ignore: cast_nullable_to_non_nullable
                        as bool,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$DeviceResponseModelImplCopyWith<$Res>
    implements $DeviceResponseModelCopyWith<$Res> {
  factory _$$DeviceResponseModelImplCopyWith(
    _$DeviceResponseModelImpl value,
    $Res Function(_$DeviceResponseModelImpl) then,
  ) = __$$DeviceResponseModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @JsonKey(name: 'id') int id,
    @JsonKey(name: 'name') String name,
    @JsonKey(name: 'deviceIdentifier') String deviceIdentifier,
    @JsonKey(name: 'type') String type,
    @JsonKey(name: 'ipAddress') String ipAddress,
    @JsonKey(name: 'lastActive') DateTime lastActive,
    @JsonKey(name: 'isCurrent') bool isCurrent,
  });
}

/// @nodoc
class __$$DeviceResponseModelImplCopyWithImpl<$Res>
    extends _$DeviceResponseModelCopyWithImpl<$Res, _$DeviceResponseModelImpl>
    implements _$$DeviceResponseModelImplCopyWith<$Res> {
  __$$DeviceResponseModelImplCopyWithImpl(
    _$DeviceResponseModelImpl _value,
    $Res Function(_$DeviceResponseModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of DeviceResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? deviceIdentifier = null,
    Object? type = null,
    Object? ipAddress = null,
    Object? lastActive = null,
    Object? isCurrent = null,
  }) {
    return _then(
      _$DeviceResponseModelImpl(
        id:
            null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                    as int,
        name:
            null == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                    as String,
        deviceIdentifier:
            null == deviceIdentifier
                ? _value.deviceIdentifier
                : deviceIdentifier // ignore: cast_nullable_to_non_nullable
                    as String,
        type:
            null == type
                ? _value.type
                : type // ignore: cast_nullable_to_non_nullable
                    as String,
        ipAddress:
            null == ipAddress
                ? _value.ipAddress
                : ipAddress // ignore: cast_nullable_to_non_nullable
                    as String,
        lastActive:
            null == lastActive
                ? _value.lastActive
                : lastActive // ignore: cast_nullable_to_non_nullable
                    as DateTime,
        isCurrent:
            null == isCurrent
                ? _value.isCurrent
                : isCurrent // ignore: cast_nullable_to_non_nullable
                    as bool,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$DeviceResponseModelImpl extends _DeviceResponseModel {
  const _$DeviceResponseModelImpl({
    @JsonKey(name: 'id') required this.id,
    @JsonKey(name: 'name') required this.name,
    @JsonKey(name: 'deviceIdentifier') required this.deviceIdentifier,
    @JsonKey(name: 'type') required this.type,
    @JsonKey(name: 'ipAddress') required this.ipAddress,
    @JsonKey(name: 'lastActive') required this.lastActive,
    @JsonKey(name: 'isCurrent') required this.isCurrent,
  }) : super._();

  factory _$DeviceResponseModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$DeviceResponseModelImplFromJson(json);

  @override
  @JsonKey(name: 'id')
  final int id;
  @override
  @JsonKey(name: 'name')
  final String name;
  @override
  @JsonKey(name: 'deviceIdentifier')
  final String deviceIdentifier;
  @override
  @JsonKey(name: 'type')
  final String type;
  @override
  @JsonKey(name: 'ipAddress')
  final String ipAddress;
  @override
  @JsonKey(name: 'lastActive')
  final DateTime lastActive;
  @override
  @JsonKey(name: 'isCurrent')
  final bool isCurrent;

  @override
  String toString() {
    return 'DeviceResponseModel(id: $id, name: $name, deviceIdentifier: $deviceIdentifier, type: $type, ipAddress: $ipAddress, lastActive: $lastActive, isCurrent: $isCurrent)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DeviceResponseModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.deviceIdentifier, deviceIdentifier) ||
                other.deviceIdentifier == deviceIdentifier) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.ipAddress, ipAddress) ||
                other.ipAddress == ipAddress) &&
            (identical(other.lastActive, lastActive) ||
                other.lastActive == lastActive) &&
            (identical(other.isCurrent, isCurrent) ||
                other.isCurrent == isCurrent));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    name,
    deviceIdentifier,
    type,
    ipAddress,
    lastActive,
    isCurrent,
  );

  /// Create a copy of DeviceResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DeviceResponseModelImplCopyWith<_$DeviceResponseModelImpl> get copyWith =>
      __$$DeviceResponseModelImplCopyWithImpl<_$DeviceResponseModelImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$DeviceResponseModelImplToJson(this);
  }
}

abstract class _DeviceResponseModel extends DeviceResponseModel {
  const factory _DeviceResponseModel({
    @JsonKey(name: 'id') required final int id,
    @JsonKey(name: 'name') required final String name,
    @JsonKey(name: 'deviceIdentifier') required final String deviceIdentifier,
    @JsonKey(name: 'type') required final String type,
    @JsonKey(name: 'ipAddress') required final String ipAddress,
    @JsonKey(name: 'lastActive') required final DateTime lastActive,
    @JsonKey(name: 'isCurrent') required final bool isCurrent,
  }) = _$DeviceResponseModelImpl;
  const _DeviceResponseModel._() : super._();

  factory _DeviceResponseModel.fromJson(Map<String, dynamic> json) =
      _$DeviceResponseModelImpl.fromJson;

  @override
  @JsonKey(name: 'id')
  int get id;
  @override
  @JsonKey(name: 'name')
  String get name;
  @override
  @JsonKey(name: 'deviceIdentifier')
  String get deviceIdentifier;
  @override
  @JsonKey(name: 'type')
  String get type;
  @override
  @JsonKey(name: 'ipAddress')
  String get ipAddress;
  @override
  @JsonKey(name: 'lastActive')
  DateTime get lastActive;
  @override
  @JsonKey(name: 'isCurrent')
  bool get isCurrent;

  /// Create a copy of DeviceResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DeviceResponseModelImplCopyWith<_$DeviceResponseModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
