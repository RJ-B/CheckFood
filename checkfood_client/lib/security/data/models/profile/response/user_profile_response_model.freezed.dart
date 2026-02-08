// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_profile_response_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

UserProfileResponseModel _$UserProfileResponseModelFromJson(
  Map<String, dynamic> json,
) {
  return _UserProfileResponseModel.fromJson(json);
}

/// @nodoc
mixin _$UserProfileResponseModel {
  @JsonKey(name: 'id')
  int get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'email')
  String get email => throw _privateConstructorUsedError;
  @JsonKey(name: 'firstName')
  String? get firstName => throw _privateConstructorUsedError;
  @JsonKey(name: 'lastName')
  String? get lastName => throw _privateConstructorUsedError;
  @JsonKey(name: 'isActive')
  bool get isActive => throw _privateConstructorUsedError;
  @JsonKey(name: 'createdAt')
  DateTime get createdAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'roles')
  List<String> get roles => throw _privateConstructorUsedError; // Používáme náš sjednocený DeviceResponseModel
  @JsonKey(name: 'devices')
  List<DeviceResponseModel> get devices => throw _privateConstructorUsedError;

  /// Serializes this UserProfileResponseModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of UserProfileResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $UserProfileResponseModelCopyWith<UserProfileResponseModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserProfileResponseModelCopyWith<$Res> {
  factory $UserProfileResponseModelCopyWith(
    UserProfileResponseModel value,
    $Res Function(UserProfileResponseModel) then,
  ) = _$UserProfileResponseModelCopyWithImpl<$Res, UserProfileResponseModel>;
  @useResult
  $Res call({
    @JsonKey(name: 'id') int id,
    @JsonKey(name: 'email') String email,
    @JsonKey(name: 'firstName') String? firstName,
    @JsonKey(name: 'lastName') String? lastName,
    @JsonKey(name: 'isActive') bool isActive,
    @JsonKey(name: 'createdAt') DateTime createdAt,
    @JsonKey(name: 'roles') List<String> roles,
    @JsonKey(name: 'devices') List<DeviceResponseModel> devices,
  });
}

/// @nodoc
class _$UserProfileResponseModelCopyWithImpl<
  $Res,
  $Val extends UserProfileResponseModel
>
    implements $UserProfileResponseModelCopyWith<$Res> {
  _$UserProfileResponseModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of UserProfileResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? email = null,
    Object? firstName = freezed,
    Object? lastName = freezed,
    Object? isActive = null,
    Object? createdAt = null,
    Object? roles = null,
    Object? devices = null,
  }) {
    return _then(
      _value.copyWith(
            id:
                null == id
                    ? _value.id
                    : id // ignore: cast_nullable_to_non_nullable
                        as int,
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
            isActive:
                null == isActive
                    ? _value.isActive
                    : isActive // ignore: cast_nullable_to_non_nullable
                        as bool,
            createdAt:
                null == createdAt
                    ? _value.createdAt
                    : createdAt // ignore: cast_nullable_to_non_nullable
                        as DateTime,
            roles:
                null == roles
                    ? _value.roles
                    : roles // ignore: cast_nullable_to_non_nullable
                        as List<String>,
            devices:
                null == devices
                    ? _value.devices
                    : devices // ignore: cast_nullable_to_non_nullable
                        as List<DeviceResponseModel>,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$UserProfileResponseModelImplCopyWith<$Res>
    implements $UserProfileResponseModelCopyWith<$Res> {
  factory _$$UserProfileResponseModelImplCopyWith(
    _$UserProfileResponseModelImpl value,
    $Res Function(_$UserProfileResponseModelImpl) then,
  ) = __$$UserProfileResponseModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @JsonKey(name: 'id') int id,
    @JsonKey(name: 'email') String email,
    @JsonKey(name: 'firstName') String? firstName,
    @JsonKey(name: 'lastName') String? lastName,
    @JsonKey(name: 'isActive') bool isActive,
    @JsonKey(name: 'createdAt') DateTime createdAt,
    @JsonKey(name: 'roles') List<String> roles,
    @JsonKey(name: 'devices') List<DeviceResponseModel> devices,
  });
}

/// @nodoc
class __$$UserProfileResponseModelImplCopyWithImpl<$Res>
    extends
        _$UserProfileResponseModelCopyWithImpl<
          $Res,
          _$UserProfileResponseModelImpl
        >
    implements _$$UserProfileResponseModelImplCopyWith<$Res> {
  __$$UserProfileResponseModelImplCopyWithImpl(
    _$UserProfileResponseModelImpl _value,
    $Res Function(_$UserProfileResponseModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of UserProfileResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? email = null,
    Object? firstName = freezed,
    Object? lastName = freezed,
    Object? isActive = null,
    Object? createdAt = null,
    Object? roles = null,
    Object? devices = null,
  }) {
    return _then(
      _$UserProfileResponseModelImpl(
        id:
            null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                    as int,
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
        isActive:
            null == isActive
                ? _value.isActive
                : isActive // ignore: cast_nullable_to_non_nullable
                    as bool,
        createdAt:
            null == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                    as DateTime,
        roles:
            null == roles
                ? _value._roles
                : roles // ignore: cast_nullable_to_non_nullable
                    as List<String>,
        devices:
            null == devices
                ? _value._devices
                : devices // ignore: cast_nullable_to_non_nullable
                    as List<DeviceResponseModel>,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$UserProfileResponseModelImpl extends _UserProfileResponseModel {
  const _$UserProfileResponseModelImpl({
    @JsonKey(name: 'id') required this.id,
    @JsonKey(name: 'email') required this.email,
    @JsonKey(name: 'firstName') this.firstName,
    @JsonKey(name: 'lastName') this.lastName,
    @JsonKey(name: 'isActive') required this.isActive,
    @JsonKey(name: 'createdAt') required this.createdAt,
    @JsonKey(name: 'roles') required final List<String> roles,
    @JsonKey(name: 'devices') required final List<DeviceResponseModel> devices,
  }) : _roles = roles,
       _devices = devices,
       super._();

  factory _$UserProfileResponseModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$UserProfileResponseModelImplFromJson(json);

  @override
  @JsonKey(name: 'id')
  final int id;
  @override
  @JsonKey(name: 'email')
  final String email;
  @override
  @JsonKey(name: 'firstName')
  final String? firstName;
  @override
  @JsonKey(name: 'lastName')
  final String? lastName;
  @override
  @JsonKey(name: 'isActive')
  final bool isActive;
  @override
  @JsonKey(name: 'createdAt')
  final DateTime createdAt;
  final List<String> _roles;
  @override
  @JsonKey(name: 'roles')
  List<String> get roles {
    if (_roles is EqualUnmodifiableListView) return _roles;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_roles);
  }

  // Používáme náš sjednocený DeviceResponseModel
  final List<DeviceResponseModel> _devices;
  // Používáme náš sjednocený DeviceResponseModel
  @override
  @JsonKey(name: 'devices')
  List<DeviceResponseModel> get devices {
    if (_devices is EqualUnmodifiableListView) return _devices;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_devices);
  }

  @override
  String toString() {
    return 'UserProfileResponseModel(id: $id, email: $email, firstName: $firstName, lastName: $lastName, isActive: $isActive, createdAt: $createdAt, roles: $roles, devices: $devices)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserProfileResponseModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.firstName, firstName) ||
                other.firstName == firstName) &&
            (identical(other.lastName, lastName) ||
                other.lastName == lastName) &&
            (identical(other.isActive, isActive) ||
                other.isActive == isActive) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            const DeepCollectionEquality().equals(other._roles, _roles) &&
            const DeepCollectionEquality().equals(other._devices, _devices));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    email,
    firstName,
    lastName,
    isActive,
    createdAt,
    const DeepCollectionEquality().hash(_roles),
    const DeepCollectionEquality().hash(_devices),
  );

  /// Create a copy of UserProfileResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UserProfileResponseModelImplCopyWith<_$UserProfileResponseModelImpl>
  get copyWith => __$$UserProfileResponseModelImplCopyWithImpl<
    _$UserProfileResponseModelImpl
  >(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$UserProfileResponseModelImplToJson(this);
  }
}

abstract class _UserProfileResponseModel extends UserProfileResponseModel {
  const factory _UserProfileResponseModel({
    @JsonKey(name: 'id') required final int id,
    @JsonKey(name: 'email') required final String email,
    @JsonKey(name: 'firstName') final String? firstName,
    @JsonKey(name: 'lastName') final String? lastName,
    @JsonKey(name: 'isActive') required final bool isActive,
    @JsonKey(name: 'createdAt') required final DateTime createdAt,
    @JsonKey(name: 'roles') required final List<String> roles,
    @JsonKey(name: 'devices') required final List<DeviceResponseModel> devices,
  }) = _$UserProfileResponseModelImpl;
  const _UserProfileResponseModel._() : super._();

  factory _UserProfileResponseModel.fromJson(Map<String, dynamic> json) =
      _$UserProfileResponseModelImpl.fromJson;

  @override
  @JsonKey(name: 'id')
  int get id;
  @override
  @JsonKey(name: 'email')
  String get email;
  @override
  @JsonKey(name: 'firstName')
  String? get firstName;
  @override
  @JsonKey(name: 'lastName')
  String? get lastName;
  @override
  @JsonKey(name: 'isActive')
  bool get isActive;
  @override
  @JsonKey(name: 'createdAt')
  DateTime get createdAt;
  @override
  @JsonKey(name: 'roles')
  List<String> get roles; // Používáme náš sjednocený DeviceResponseModel
  @override
  @JsonKey(name: 'devices')
  List<DeviceResponseModel> get devices;

  /// Create a copy of UserProfileResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UserProfileResponseModelImplCopyWith<_$UserProfileResponseModelImpl>
  get copyWith => throw _privateConstructorUsedError;
}
