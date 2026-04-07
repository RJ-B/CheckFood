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
  @JsonKey(name: SecurityJsonKeys.id)
  int get id => throw _privateConstructorUsedError;
  @JsonKey(name: SecurityJsonKeys.deviceName)
  String? get deviceName => throw _privateConstructorUsedError;
  @JsonKey(name: SecurityJsonKeys.deviceType)
  String? get deviceType => throw _privateConstructorUsedError;
  @JsonKey(name: SecurityJsonKeys.deviceIdentifier)
  String get deviceIdentifier => throw _privateConstructorUsedError;
  @JsonKey(name: SecurityJsonKeys.lastLogin)
  DateTime? get lastLogin => throw _privateConstructorUsedError;
  @JsonKey(name: SecurityJsonKeys.isCurrentDevice)
  bool get isCurrentDevice => throw _privateConstructorUsedError;
  @JsonKey(name: SecurityJsonKeys.deviceActive)
  bool get active => throw _privateConstructorUsedError;

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
    @JsonKey(name: SecurityJsonKeys.id) int id,
    @JsonKey(name: SecurityJsonKeys.deviceName) String? deviceName,
    @JsonKey(name: SecurityJsonKeys.deviceType) String? deviceType,
    @JsonKey(name: SecurityJsonKeys.deviceIdentifier) String deviceIdentifier,
    @JsonKey(name: SecurityJsonKeys.lastLogin) DateTime? lastLogin,
    @JsonKey(name: SecurityJsonKeys.isCurrentDevice) bool isCurrentDevice,
    @JsonKey(name: SecurityJsonKeys.deviceActive) bool active,
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
    Object? deviceName = freezed,
    Object? deviceType = freezed,
    Object? deviceIdentifier = null,
    Object? lastLogin = freezed,
    Object? isCurrentDevice = null,
    Object? active = null,
  }) {
    return _then(
      _value.copyWith(
            id:
                null == id
                    ? _value.id
                    : id // ignore: cast_nullable_to_non_nullable
                        as int,
            deviceName:
                freezed == deviceName
                    ? _value.deviceName
                    : deviceName // ignore: cast_nullable_to_non_nullable
                        as String?,
            deviceType:
                freezed == deviceType
                    ? _value.deviceType
                    : deviceType // ignore: cast_nullable_to_non_nullable
                        as String?,
            deviceIdentifier:
                null == deviceIdentifier
                    ? _value.deviceIdentifier
                    : deviceIdentifier // ignore: cast_nullable_to_non_nullable
                        as String,
            lastLogin:
                freezed == lastLogin
                    ? _value.lastLogin
                    : lastLogin // ignore: cast_nullable_to_non_nullable
                        as DateTime?,
            isCurrentDevice:
                null == isCurrentDevice
                    ? _value.isCurrentDevice
                    : isCurrentDevice // ignore: cast_nullable_to_non_nullable
                        as bool,
            active:
                null == active
                    ? _value.active
                    : active // ignore: cast_nullable_to_non_nullable
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
    @JsonKey(name: SecurityJsonKeys.id) int id,
    @JsonKey(name: SecurityJsonKeys.deviceName) String? deviceName,
    @JsonKey(name: SecurityJsonKeys.deviceType) String? deviceType,
    @JsonKey(name: SecurityJsonKeys.deviceIdentifier) String deviceIdentifier,
    @JsonKey(name: SecurityJsonKeys.lastLogin) DateTime? lastLogin,
    @JsonKey(name: SecurityJsonKeys.isCurrentDevice) bool isCurrentDevice,
    @JsonKey(name: SecurityJsonKeys.deviceActive) bool active,
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
    Object? deviceName = freezed,
    Object? deviceType = freezed,
    Object? deviceIdentifier = null,
    Object? lastLogin = freezed,
    Object? isCurrentDevice = null,
    Object? active = null,
  }) {
    return _then(
      _$DeviceResponseModelImpl(
        id:
            null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                    as int,
        deviceName:
            freezed == deviceName
                ? _value.deviceName
                : deviceName // ignore: cast_nullable_to_non_nullable
                    as String?,
        deviceType:
            freezed == deviceType
                ? _value.deviceType
                : deviceType // ignore: cast_nullable_to_non_nullable
                    as String?,
        deviceIdentifier:
            null == deviceIdentifier
                ? _value.deviceIdentifier
                : deviceIdentifier // ignore: cast_nullable_to_non_nullable
                    as String,
        lastLogin:
            freezed == lastLogin
                ? _value.lastLogin
                : lastLogin // ignore: cast_nullable_to_non_nullable
                    as DateTime?,
        isCurrentDevice:
            null == isCurrentDevice
                ? _value.isCurrentDevice
                : isCurrentDevice // ignore: cast_nullable_to_non_nullable
                    as bool,
        active:
            null == active
                ? _value.active
                : active // ignore: cast_nullable_to_non_nullable
                    as bool,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$DeviceResponseModelImpl extends _DeviceResponseModel {
  const _$DeviceResponseModelImpl({
    @JsonKey(name: SecurityJsonKeys.id) required this.id,
    @JsonKey(name: SecurityJsonKeys.deviceName) required this.deviceName,
    @JsonKey(name: SecurityJsonKeys.deviceType) required this.deviceType,
    @JsonKey(name: SecurityJsonKeys.deviceIdentifier)
    required this.deviceIdentifier,
    @JsonKey(name: SecurityJsonKeys.lastLogin) required this.lastLogin,
    @JsonKey(name: SecurityJsonKeys.isCurrentDevice)
    this.isCurrentDevice = false,
    @JsonKey(name: SecurityJsonKeys.deviceActive) this.active = true,
  }) : super._();

  factory _$DeviceResponseModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$DeviceResponseModelImplFromJson(json);

  @override
  @JsonKey(name: SecurityJsonKeys.id)
  final int id;
  @override
  @JsonKey(name: SecurityJsonKeys.deviceName)
  final String? deviceName;
  @override
  @JsonKey(name: SecurityJsonKeys.deviceType)
  final String? deviceType;
  @override
  @JsonKey(name: SecurityJsonKeys.deviceIdentifier)
  final String deviceIdentifier;
  @override
  @JsonKey(name: SecurityJsonKeys.lastLogin)
  final DateTime? lastLogin;
  @override
  @JsonKey(name: SecurityJsonKeys.isCurrentDevice)
  final bool isCurrentDevice;
  @override
  @JsonKey(name: SecurityJsonKeys.deviceActive)
  final bool active;

  @override
  String toString() {
    return 'DeviceResponseModel(id: $id, deviceName: $deviceName, deviceType: $deviceType, deviceIdentifier: $deviceIdentifier, lastLogin: $lastLogin, isCurrentDevice: $isCurrentDevice, active: $active)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DeviceResponseModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.deviceName, deviceName) ||
                other.deviceName == deviceName) &&
            (identical(other.deviceType, deviceType) ||
                other.deviceType == deviceType) &&
            (identical(other.deviceIdentifier, deviceIdentifier) ||
                other.deviceIdentifier == deviceIdentifier) &&
            (identical(other.lastLogin, lastLogin) ||
                other.lastLogin == lastLogin) &&
            (identical(other.isCurrentDevice, isCurrentDevice) ||
                other.isCurrentDevice == isCurrentDevice) &&
            (identical(other.active, active) || other.active == active));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    deviceName,
    deviceType,
    deviceIdentifier,
    lastLogin,
    isCurrentDevice,
    active,
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
    @JsonKey(name: SecurityJsonKeys.id) required final int id,
    @JsonKey(name: SecurityJsonKeys.deviceName)
    required final String? deviceName,
    @JsonKey(name: SecurityJsonKeys.deviceType)
    required final String? deviceType,
    @JsonKey(name: SecurityJsonKeys.deviceIdentifier)
    required final String deviceIdentifier,
    @JsonKey(name: SecurityJsonKeys.lastLogin)
    required final DateTime? lastLogin,
    @JsonKey(name: SecurityJsonKeys.isCurrentDevice) final bool isCurrentDevice,
    @JsonKey(name: SecurityJsonKeys.deviceActive) final bool active,
  }) = _$DeviceResponseModelImpl;
  const _DeviceResponseModel._() : super._();

  factory _DeviceResponseModel.fromJson(Map<String, dynamic> json) =
      _$DeviceResponseModelImpl.fromJson;

  @override
  @JsonKey(name: SecurityJsonKeys.id)
  int get id;
  @override
  @JsonKey(name: SecurityJsonKeys.deviceName)
  String? get deviceName;
  @override
  @JsonKey(name: SecurityJsonKeys.deviceType)
  String? get deviceType;
  @override
  @JsonKey(name: SecurityJsonKeys.deviceIdentifier)
  String get deviceIdentifier;
  @override
  @JsonKey(name: SecurityJsonKeys.lastLogin)
  DateTime? get lastLogin;
  @override
  @JsonKey(name: SecurityJsonKeys.isCurrentDevice)
  bool get isCurrentDevice;
  @override
  @JsonKey(name: SecurityJsonKeys.deviceActive)
  bool get active;

  /// Create a copy of DeviceResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DeviceResponseModelImplCopyWith<_$DeviceResponseModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
