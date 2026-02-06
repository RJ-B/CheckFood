// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'revoke_device_request_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

RevokeDeviceRequestModel _$RevokeDeviceRequestModelFromJson(
  Map<String, dynamic> json,
) {
  return _RevokeDeviceRequestModel.fromJson(json);
}

/// @nodoc
mixin _$RevokeDeviceRequestModel {
  // Backend potřebuje vědět, KTERÉ zařízení má odstřihnout.
  // Může to být 'id' (z databáze) nebo 'deviceIdentifier', záleží na backendu.
  // Většinou je bezpečnější používat ID záznamu.
  @JsonKey(name: 'deviceId')
  String get deviceId => throw _privateConstructorUsedError;

  /// Serializes this RevokeDeviceRequestModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of RevokeDeviceRequestModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $RevokeDeviceRequestModelCopyWith<RevokeDeviceRequestModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RevokeDeviceRequestModelCopyWith<$Res> {
  factory $RevokeDeviceRequestModelCopyWith(
    RevokeDeviceRequestModel value,
    $Res Function(RevokeDeviceRequestModel) then,
  ) = _$RevokeDeviceRequestModelCopyWithImpl<$Res, RevokeDeviceRequestModel>;
  @useResult
  $Res call({@JsonKey(name: 'deviceId') String deviceId});
}

/// @nodoc
class _$RevokeDeviceRequestModelCopyWithImpl<
  $Res,
  $Val extends RevokeDeviceRequestModel
>
    implements $RevokeDeviceRequestModelCopyWith<$Res> {
  _$RevokeDeviceRequestModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of RevokeDeviceRequestModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? deviceId = null}) {
    return _then(
      _value.copyWith(
            deviceId:
                null == deviceId
                    ? _value.deviceId
                    : deviceId // ignore: cast_nullable_to_non_nullable
                        as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$RevokeDeviceRequestModelImplCopyWith<$Res>
    implements $RevokeDeviceRequestModelCopyWith<$Res> {
  factory _$$RevokeDeviceRequestModelImplCopyWith(
    _$RevokeDeviceRequestModelImpl value,
    $Res Function(_$RevokeDeviceRequestModelImpl) then,
  ) = __$$RevokeDeviceRequestModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({@JsonKey(name: 'deviceId') String deviceId});
}

/// @nodoc
class __$$RevokeDeviceRequestModelImplCopyWithImpl<$Res>
    extends
        _$RevokeDeviceRequestModelCopyWithImpl<
          $Res,
          _$RevokeDeviceRequestModelImpl
        >
    implements _$$RevokeDeviceRequestModelImplCopyWith<$Res> {
  __$$RevokeDeviceRequestModelImplCopyWithImpl(
    _$RevokeDeviceRequestModelImpl _value,
    $Res Function(_$RevokeDeviceRequestModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of RevokeDeviceRequestModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? deviceId = null}) {
    return _then(
      _$RevokeDeviceRequestModelImpl(
        deviceId:
            null == deviceId
                ? _value.deviceId
                : deviceId // ignore: cast_nullable_to_non_nullable
                    as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$RevokeDeviceRequestModelImpl implements _RevokeDeviceRequestModel {
  const _$RevokeDeviceRequestModelImpl({
    @JsonKey(name: 'deviceId') required this.deviceId,
  });

  factory _$RevokeDeviceRequestModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$RevokeDeviceRequestModelImplFromJson(json);

  // Backend potřebuje vědět, KTERÉ zařízení má odstřihnout.
  // Může to být 'id' (z databáze) nebo 'deviceIdentifier', záleží na backendu.
  // Většinou je bezpečnější používat ID záznamu.
  @override
  @JsonKey(name: 'deviceId')
  final String deviceId;

  @override
  String toString() {
    return 'RevokeDeviceRequestModel(deviceId: $deviceId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RevokeDeviceRequestModelImpl &&
            (identical(other.deviceId, deviceId) ||
                other.deviceId == deviceId));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, deviceId);

  /// Create a copy of RevokeDeviceRequestModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$RevokeDeviceRequestModelImplCopyWith<_$RevokeDeviceRequestModelImpl>
  get copyWith => __$$RevokeDeviceRequestModelImplCopyWithImpl<
    _$RevokeDeviceRequestModelImpl
  >(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$RevokeDeviceRequestModelImplToJson(this);
  }
}

abstract class _RevokeDeviceRequestModel implements RevokeDeviceRequestModel {
  const factory _RevokeDeviceRequestModel({
    @JsonKey(name: 'deviceId') required final String deviceId,
  }) = _$RevokeDeviceRequestModelImpl;

  factory _RevokeDeviceRequestModel.fromJson(Map<String, dynamic> json) =
      _$RevokeDeviceRequestModelImpl.fromJson;

  // Backend potřebuje vědět, KTERÉ zařízení má odstřihnout.
  // Může to být 'id' (z databáze) nebo 'deviceIdentifier', záleží na backendu.
  // Většinou je bezpečnější používat ID záznamu.
  @override
  @JsonKey(name: 'deviceId')
  String get deviceId;

  /// Create a copy of RevokeDeviceRequestModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RevokeDeviceRequestModelImplCopyWith<_$RevokeDeviceRequestModelImpl>
  get copyWith => throw _privateConstructorUsedError;
}
