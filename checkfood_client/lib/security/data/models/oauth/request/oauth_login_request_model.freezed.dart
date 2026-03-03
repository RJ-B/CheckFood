// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'oauth_login_request_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

OAuthLoginRequestModel _$OAuthLoginRequestModelFromJson(
  Map<String, dynamic> json,
) {
  return _OAuthLoginRequestModel.fromJson(json);
}

/// @nodoc
mixin _$OAuthLoginRequestModel {
  @JsonKey(name: SecurityJsonKeys.idToken)
  String get idToken => throw _privateConstructorUsedError;
  @JsonKey(name: SecurityJsonKeys.provider)
  String get provider => throw _privateConstructorUsedError;
  @JsonKey(name: SecurityJsonKeys.email)
  String get email => throw _privateConstructorUsedError;
  @JsonKey(name: SecurityJsonKeys.firstName)
  String? get firstName => throw _privateConstructorUsedError;
  @JsonKey(name: SecurityJsonKeys.lastName)
  String? get lastName => throw _privateConstructorUsedError;
  @JsonKey(name: SecurityJsonKeys.deviceIdentifier)
  String get deviceIdentifier => throw _privateConstructorUsedError;
  @JsonKey(name: SecurityJsonKeys.deviceName)
  String get deviceName => throw _privateConstructorUsedError;
  @JsonKey(name: SecurityJsonKeys.deviceType)
  String get deviceType => throw _privateConstructorUsedError;

  /// Serializes this OAuthLoginRequestModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of OAuthLoginRequestModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $OAuthLoginRequestModelCopyWith<OAuthLoginRequestModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OAuthLoginRequestModelCopyWith<$Res> {
  factory $OAuthLoginRequestModelCopyWith(
    OAuthLoginRequestModel value,
    $Res Function(OAuthLoginRequestModel) then,
  ) = _$OAuthLoginRequestModelCopyWithImpl<$Res, OAuthLoginRequestModel>;
  @useResult
  $Res call({
    @JsonKey(name: SecurityJsonKeys.idToken) String idToken,
    @JsonKey(name: SecurityJsonKeys.provider) String provider,
    @JsonKey(name: SecurityJsonKeys.email) String email,
    @JsonKey(name: SecurityJsonKeys.firstName) String? firstName,
    @JsonKey(name: SecurityJsonKeys.lastName) String? lastName,
    @JsonKey(name: SecurityJsonKeys.deviceIdentifier) String deviceIdentifier,
    @JsonKey(name: SecurityJsonKeys.deviceName) String deviceName,
    @JsonKey(name: SecurityJsonKeys.deviceType) String deviceType,
  });
}

/// @nodoc
class _$OAuthLoginRequestModelCopyWithImpl<
  $Res,
  $Val extends OAuthLoginRequestModel
>
    implements $OAuthLoginRequestModelCopyWith<$Res> {
  _$OAuthLoginRequestModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of OAuthLoginRequestModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? idToken = null,
    Object? provider = null,
    Object? email = null,
    Object? firstName = freezed,
    Object? lastName = freezed,
    Object? deviceIdentifier = null,
    Object? deviceName = null,
    Object? deviceType = null,
  }) {
    return _then(
      _value.copyWith(
            idToken:
                null == idToken
                    ? _value.idToken
                    : idToken // ignore: cast_nullable_to_non_nullable
                        as String,
            provider:
                null == provider
                    ? _value.provider
                    : provider // ignore: cast_nullable_to_non_nullable
                        as String,
            email:
                null == email
                    ? _value.email
                    : email // ignore: cast_nullable_to_non_nullable
                        as String,
            firstName:
                freezed == firstName
                    ? _value.firstName
                    : firstName // ignore: cast_nullable_to_non_nullable
                        as String?,
            lastName:
                freezed == lastName
                    ? _value.lastName
                    : lastName // ignore: cast_nullable_to_non_nullable
                        as String?,
            deviceIdentifier:
                null == deviceIdentifier
                    ? _value.deviceIdentifier
                    : deviceIdentifier // ignore: cast_nullable_to_non_nullable
                        as String,
            deviceName:
                null == deviceName
                    ? _value.deviceName
                    : deviceName // ignore: cast_nullable_to_non_nullable
                        as String,
            deviceType:
                null == deviceType
                    ? _value.deviceType
                    : deviceType // ignore: cast_nullable_to_non_nullable
                        as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$OAuthLoginRequestModelImplCopyWith<$Res>
    implements $OAuthLoginRequestModelCopyWith<$Res> {
  factory _$$OAuthLoginRequestModelImplCopyWith(
    _$OAuthLoginRequestModelImpl value,
    $Res Function(_$OAuthLoginRequestModelImpl) then,
  ) = __$$OAuthLoginRequestModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @JsonKey(name: SecurityJsonKeys.idToken) String idToken,
    @JsonKey(name: SecurityJsonKeys.provider) String provider,
    @JsonKey(name: SecurityJsonKeys.email) String email,
    @JsonKey(name: SecurityJsonKeys.firstName) String? firstName,
    @JsonKey(name: SecurityJsonKeys.lastName) String? lastName,
    @JsonKey(name: SecurityJsonKeys.deviceIdentifier) String deviceIdentifier,
    @JsonKey(name: SecurityJsonKeys.deviceName) String deviceName,
    @JsonKey(name: SecurityJsonKeys.deviceType) String deviceType,
  });
}

/// @nodoc
class __$$OAuthLoginRequestModelImplCopyWithImpl<$Res>
    extends
        _$OAuthLoginRequestModelCopyWithImpl<$Res, _$OAuthLoginRequestModelImpl>
    implements _$$OAuthLoginRequestModelImplCopyWith<$Res> {
  __$$OAuthLoginRequestModelImplCopyWithImpl(
    _$OAuthLoginRequestModelImpl _value,
    $Res Function(_$OAuthLoginRequestModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of OAuthLoginRequestModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? idToken = null,
    Object? provider = null,
    Object? email = null,
    Object? firstName = freezed,
    Object? lastName = freezed,
    Object? deviceIdentifier = null,
    Object? deviceName = null,
    Object? deviceType = null,
  }) {
    return _then(
      _$OAuthLoginRequestModelImpl(
        idToken:
            null == idToken
                ? _value.idToken
                : idToken // ignore: cast_nullable_to_non_nullable
                    as String,
        provider:
            null == provider
                ? _value.provider
                : provider // ignore: cast_nullable_to_non_nullable
                    as String,
        email:
            null == email
                ? _value.email
                : email // ignore: cast_nullable_to_non_nullable
                    as String,
        firstName:
            freezed == firstName
                ? _value.firstName
                : firstName // ignore: cast_nullable_to_non_nullable
                    as String?,
        lastName:
            freezed == lastName
                ? _value.lastName
                : lastName // ignore: cast_nullable_to_non_nullable
                    as String?,
        deviceIdentifier:
            null == deviceIdentifier
                ? _value.deviceIdentifier
                : deviceIdentifier // ignore: cast_nullable_to_non_nullable
                    as String,
        deviceName:
            null == deviceName
                ? _value.deviceName
                : deviceName // ignore: cast_nullable_to_non_nullable
                    as String,
        deviceType:
            null == deviceType
                ? _value.deviceType
                : deviceType // ignore: cast_nullable_to_non_nullable
                    as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$OAuthLoginRequestModelImpl implements _OAuthLoginRequestModel {
  const _$OAuthLoginRequestModelImpl({
    @JsonKey(name: SecurityJsonKeys.idToken) required this.idToken,
    @JsonKey(name: SecurityJsonKeys.provider) required this.provider,
    @JsonKey(name: SecurityJsonKeys.email) required this.email,
    @JsonKey(name: SecurityJsonKeys.firstName) this.firstName,
    @JsonKey(name: SecurityJsonKeys.lastName) this.lastName,
    @JsonKey(name: SecurityJsonKeys.deviceIdentifier)
    required this.deviceIdentifier,
    @JsonKey(name: SecurityJsonKeys.deviceName) required this.deviceName,
    @JsonKey(name: SecurityJsonKeys.deviceType) required this.deviceType,
  });

  factory _$OAuthLoginRequestModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$OAuthLoginRequestModelImplFromJson(json);

  @override
  @JsonKey(name: SecurityJsonKeys.idToken)
  final String idToken;
  @override
  @JsonKey(name: SecurityJsonKeys.provider)
  final String provider;
  @override
  @JsonKey(name: SecurityJsonKeys.email)
  final String email;
  @override
  @JsonKey(name: SecurityJsonKeys.firstName)
  final String? firstName;
  @override
  @JsonKey(name: SecurityJsonKeys.lastName)
  final String? lastName;
  @override
  @JsonKey(name: SecurityJsonKeys.deviceIdentifier)
  final String deviceIdentifier;
  @override
  @JsonKey(name: SecurityJsonKeys.deviceName)
  final String deviceName;
  @override
  @JsonKey(name: SecurityJsonKeys.deviceType)
  final String deviceType;

  @override
  String toString() {
    return 'OAuthLoginRequestModel(idToken: $idToken, provider: $provider, email: $email, firstName: $firstName, lastName: $lastName, deviceIdentifier: $deviceIdentifier, deviceName: $deviceName, deviceType: $deviceType)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OAuthLoginRequestModelImpl &&
            (identical(other.idToken, idToken) || other.idToken == idToken) &&
            (identical(other.provider, provider) ||
                other.provider == provider) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.firstName, firstName) ||
                other.firstName == firstName) &&
            (identical(other.lastName, lastName) ||
                other.lastName == lastName) &&
            (identical(other.deviceIdentifier, deviceIdentifier) ||
                other.deviceIdentifier == deviceIdentifier) &&
            (identical(other.deviceName, deviceName) ||
                other.deviceName == deviceName) &&
            (identical(other.deviceType, deviceType) ||
                other.deviceType == deviceType));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    idToken,
    provider,
    email,
    firstName,
    lastName,
    deviceIdentifier,
    deviceName,
    deviceType,
  );

  /// Create a copy of OAuthLoginRequestModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$OAuthLoginRequestModelImplCopyWith<_$OAuthLoginRequestModelImpl>
  get copyWith =>
      __$$OAuthLoginRequestModelImplCopyWithImpl<_$OAuthLoginRequestModelImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$OAuthLoginRequestModelImplToJson(this);
  }
}

abstract class _OAuthLoginRequestModel implements OAuthLoginRequestModel {
  const factory _OAuthLoginRequestModel({
    @JsonKey(name: SecurityJsonKeys.idToken) required final String idToken,
    @JsonKey(name: SecurityJsonKeys.provider) required final String provider,
    @JsonKey(name: SecurityJsonKeys.email) required final String email,
    @JsonKey(name: SecurityJsonKeys.firstName) final String? firstName,
    @JsonKey(name: SecurityJsonKeys.lastName) final String? lastName,
    @JsonKey(name: SecurityJsonKeys.deviceIdentifier)
    required final String deviceIdentifier,
    @JsonKey(name: SecurityJsonKeys.deviceName)
    required final String deviceName,
    @JsonKey(name: SecurityJsonKeys.deviceType)
    required final String deviceType,
  }) = _$OAuthLoginRequestModelImpl;

  factory _OAuthLoginRequestModel.fromJson(Map<String, dynamic> json) =
      _$OAuthLoginRequestModelImpl.fromJson;

  @override
  @JsonKey(name: SecurityJsonKeys.idToken)
  String get idToken;
  @override
  @JsonKey(name: SecurityJsonKeys.provider)
  String get provider;
  @override
  @JsonKey(name: SecurityJsonKeys.email)
  String get email;
  @override
  @JsonKey(name: SecurityJsonKeys.firstName)
  String? get firstName;
  @override
  @JsonKey(name: SecurityJsonKeys.lastName)
  String? get lastName;
  @override
  @JsonKey(name: SecurityJsonKeys.deviceIdentifier)
  String get deviceIdentifier;
  @override
  @JsonKey(name: SecurityJsonKeys.deviceName)
  String get deviceName;
  @override
  @JsonKey(name: SecurityJsonKeys.deviceType)
  String get deviceType;

  /// Create a copy of OAuthLoginRequestModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$OAuthLoginRequestModelImplCopyWith<_$OAuthLoginRequestModelImpl>
  get copyWith => throw _privateConstructorUsedError;
}
