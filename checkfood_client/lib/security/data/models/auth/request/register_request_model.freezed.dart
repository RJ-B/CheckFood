// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'register_request_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

RegisterRequestModel _$RegisterRequestModelFromJson(Map<String, dynamic> json) {
  return _RegisterRequestModel.fromJson(json);
}

/// @nodoc
mixin _$RegisterRequestModel {
  @JsonKey(name: 'email')
  String get email => throw _privateConstructorUsedError;
  @JsonKey(name: 'password')
  String get password => throw _privateConstructorUsedError;
  @JsonKey(name: 'confirmPassword')
  String get confirmPassword => throw _privateConstructorUsedError;
  @JsonKey(name: 'firstName')
  String get firstName => throw _privateConstructorUsedError;
  @JsonKey(name: 'lastName')
  String get lastName => throw _privateConstructorUsedError;
  @JsonKey(name: 'deviceIdentifier')
  String get deviceIdentifier => throw _privateConstructorUsedError;
  @JsonKey(name: 'deviceName')
  String get deviceName => throw _privateConstructorUsedError;
  @JsonKey(name: 'deviceType')
  String get deviceType => throw _privateConstructorUsedError;

  /// Serializes this RegisterRequestModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of RegisterRequestModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $RegisterRequestModelCopyWith<RegisterRequestModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RegisterRequestModelCopyWith<$Res> {
  factory $RegisterRequestModelCopyWith(
    RegisterRequestModel value,
    $Res Function(RegisterRequestModel) then,
  ) = _$RegisterRequestModelCopyWithImpl<$Res, RegisterRequestModel>;
  @useResult
  $Res call({
    @JsonKey(name: 'email') String email,
    @JsonKey(name: 'password') String password,
    @JsonKey(name: 'confirmPassword') String confirmPassword,
    @JsonKey(name: 'firstName') String firstName,
    @JsonKey(name: 'lastName') String lastName,
    @JsonKey(name: 'deviceIdentifier') String deviceIdentifier,
    @JsonKey(name: 'deviceName') String deviceName,
    @JsonKey(name: 'deviceType') String deviceType,
  });
}

/// @nodoc
class _$RegisterRequestModelCopyWithImpl<
  $Res,
  $Val extends RegisterRequestModel
>
    implements $RegisterRequestModelCopyWith<$Res> {
  _$RegisterRequestModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of RegisterRequestModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? email = null,
    Object? password = null,
    Object? confirmPassword = null,
    Object? firstName = null,
    Object? lastName = null,
    Object? deviceIdentifier = null,
    Object? deviceName = null,
    Object? deviceType = null,
  }) {
    return _then(
      _value.copyWith(
            email:
                null == email
                    ? _value.email
                    : email // ignore: cast_nullable_to_non_nullable
                        as String,
            password:
                null == password
                    ? _value.password
                    : password // ignore: cast_nullable_to_non_nullable
                        as String,
            confirmPassword:
                null == confirmPassword
                    ? _value.confirmPassword
                    : confirmPassword // ignore: cast_nullable_to_non_nullable
                        as String,
            firstName:
                null == firstName
                    ? _value.firstName
                    : firstName // ignore: cast_nullable_to_non_nullable
                        as String,
            lastName:
                null == lastName
                    ? _value.lastName
                    : lastName // ignore: cast_nullable_to_non_nullable
                        as String,
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
abstract class _$$RegisterRequestModelImplCopyWith<$Res>
    implements $RegisterRequestModelCopyWith<$Res> {
  factory _$$RegisterRequestModelImplCopyWith(
    _$RegisterRequestModelImpl value,
    $Res Function(_$RegisterRequestModelImpl) then,
  ) = __$$RegisterRequestModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @JsonKey(name: 'email') String email,
    @JsonKey(name: 'password') String password,
    @JsonKey(name: 'confirmPassword') String confirmPassword,
    @JsonKey(name: 'firstName') String firstName,
    @JsonKey(name: 'lastName') String lastName,
    @JsonKey(name: 'deviceIdentifier') String deviceIdentifier,
    @JsonKey(name: 'deviceName') String deviceName,
    @JsonKey(name: 'deviceType') String deviceType,
  });
}

/// @nodoc
class __$$RegisterRequestModelImplCopyWithImpl<$Res>
    extends _$RegisterRequestModelCopyWithImpl<$Res, _$RegisterRequestModelImpl>
    implements _$$RegisterRequestModelImplCopyWith<$Res> {
  __$$RegisterRequestModelImplCopyWithImpl(
    _$RegisterRequestModelImpl _value,
    $Res Function(_$RegisterRequestModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of RegisterRequestModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? email = null,
    Object? password = null,
    Object? confirmPassword = null,
    Object? firstName = null,
    Object? lastName = null,
    Object? deviceIdentifier = null,
    Object? deviceName = null,
    Object? deviceType = null,
  }) {
    return _then(
      _$RegisterRequestModelImpl(
        email:
            null == email
                ? _value.email
                : email // ignore: cast_nullable_to_non_nullable
                    as String,
        password:
            null == password
                ? _value.password
                : password // ignore: cast_nullable_to_non_nullable
                    as String,
        confirmPassword:
            null == confirmPassword
                ? _value.confirmPassword
                : confirmPassword // ignore: cast_nullable_to_non_nullable
                    as String,
        firstName:
            null == firstName
                ? _value.firstName
                : firstName // ignore: cast_nullable_to_non_nullable
                    as String,
        lastName:
            null == lastName
                ? _value.lastName
                : lastName // ignore: cast_nullable_to_non_nullable
                    as String,
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
class _$RegisterRequestModelImpl implements _RegisterRequestModel {
  const _$RegisterRequestModelImpl({
    @JsonKey(name: 'email') required this.email,
    @JsonKey(name: 'password') required this.password,
    @JsonKey(name: 'confirmPassword') required this.confirmPassword,
    @JsonKey(name: 'firstName') required this.firstName,
    @JsonKey(name: 'lastName') required this.lastName,
    @JsonKey(name: 'deviceIdentifier') required this.deviceIdentifier,
    @JsonKey(name: 'deviceName') required this.deviceName,
    @JsonKey(name: 'deviceType') required this.deviceType,
  });

  factory _$RegisterRequestModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$RegisterRequestModelImplFromJson(json);

  @override
  @JsonKey(name: 'email')
  final String email;
  @override
  @JsonKey(name: 'password')
  final String password;
  @override
  @JsonKey(name: 'confirmPassword')
  final String confirmPassword;
  @override
  @JsonKey(name: 'firstName')
  final String firstName;
  @override
  @JsonKey(name: 'lastName')
  final String lastName;
  @override
  @JsonKey(name: 'deviceIdentifier')
  final String deviceIdentifier;
  @override
  @JsonKey(name: 'deviceName')
  final String deviceName;
  @override
  @JsonKey(name: 'deviceType')
  final String deviceType;

  @override
  String toString() {
    return 'RegisterRequestModel(email: $email, password: $password, confirmPassword: $confirmPassword, firstName: $firstName, lastName: $lastName, deviceIdentifier: $deviceIdentifier, deviceName: $deviceName, deviceType: $deviceType)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RegisterRequestModelImpl &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.password, password) ||
                other.password == password) &&
            (identical(other.confirmPassword, confirmPassword) ||
                other.confirmPassword == confirmPassword) &&
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
    email,
    password,
    confirmPassword,
    firstName,
    lastName,
    deviceIdentifier,
    deviceName,
    deviceType,
  );

  /// Create a copy of RegisterRequestModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$RegisterRequestModelImplCopyWith<_$RegisterRequestModelImpl>
  get copyWith =>
      __$$RegisterRequestModelImplCopyWithImpl<_$RegisterRequestModelImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$RegisterRequestModelImplToJson(this);
  }
}

abstract class _RegisterRequestModel implements RegisterRequestModel {
  const factory _RegisterRequestModel({
    @JsonKey(name: 'email') required final String email,
    @JsonKey(name: 'password') required final String password,
    @JsonKey(name: 'confirmPassword') required final String confirmPassword,
    @JsonKey(name: 'firstName') required final String firstName,
    @JsonKey(name: 'lastName') required final String lastName,
    @JsonKey(name: 'deviceIdentifier') required final String deviceIdentifier,
    @JsonKey(name: 'deviceName') required final String deviceName,
    @JsonKey(name: 'deviceType') required final String deviceType,
  }) = _$RegisterRequestModelImpl;

  factory _RegisterRequestModel.fromJson(Map<String, dynamic> json) =
      _$RegisterRequestModelImpl.fromJson;

  @override
  @JsonKey(name: 'email')
  String get email;
  @override
  @JsonKey(name: 'password')
  String get password;
  @override
  @JsonKey(name: 'confirmPassword')
  String get confirmPassword;
  @override
  @JsonKey(name: 'firstName')
  String get firstName;
  @override
  @JsonKey(name: 'lastName')
  String get lastName;
  @override
  @JsonKey(name: 'deviceIdentifier')
  String get deviceIdentifier;
  @override
  @JsonKey(name: 'deviceName')
  String get deviceName;
  @override
  @JsonKey(name: 'deviceType')
  String get deviceType;

  /// Create a copy of RegisterRequestModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RegisterRequestModelImplCopyWith<_$RegisterRequestModelImpl>
  get copyWith => throw _privateConstructorUsedError;
}
