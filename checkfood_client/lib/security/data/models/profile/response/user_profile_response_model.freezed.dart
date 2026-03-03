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
  @JsonKey(name: SecurityJsonKeys.id)
  int get id => throw _privateConstructorUsedError;
  @JsonKey(name: SecurityJsonKeys.email)
  String get email => throw _privateConstructorUsedError;
  @JsonKey(name: SecurityJsonKeys.firstName)
  String? get firstName => throw _privateConstructorUsedError;
  @JsonKey(name: SecurityJsonKeys.lastName)
  String? get lastName => throw _privateConstructorUsedError;
  @JsonKey(name: SecurityJsonKeys.profileImageUrl)
  String? get profileImageUrl => throw _privateConstructorUsedError;
  @JsonKey(name: SecurityJsonKeys.isActive)
  bool get isActive => throw _privateConstructorUsedError;
  @JsonKey(name: SecurityJsonKeys.lastLogin)
  DateTime? get lastLogin => throw _privateConstructorUsedError;
  @JsonKey(name: SecurityJsonKeys.createdAt)
  DateTime get createdAt => throw _privateConstructorUsedError;
  @JsonKey(name: SecurityJsonKeys.role)
  String get role => throw _privateConstructorUsedError;

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
    @JsonKey(name: SecurityJsonKeys.id) int id,
    @JsonKey(name: SecurityJsonKeys.email) String email,
    @JsonKey(name: SecurityJsonKeys.firstName) String? firstName,
    @JsonKey(name: SecurityJsonKeys.lastName) String? lastName,
    @JsonKey(name: SecurityJsonKeys.profileImageUrl) String? profileImageUrl,
    @JsonKey(name: SecurityJsonKeys.isActive) bool isActive,
    @JsonKey(name: SecurityJsonKeys.lastLogin) DateTime? lastLogin,
    @JsonKey(name: SecurityJsonKeys.createdAt) DateTime createdAt,
    @JsonKey(name: SecurityJsonKeys.role) String role,
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
    Object? profileImageUrl = freezed,
    Object? isActive = null,
    Object? lastLogin = freezed,
    Object? createdAt = null,
    Object? role = null,
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
            profileImageUrl:
                freezed == profileImageUrl
                    ? _value.profileImageUrl
                    : profileImageUrl // ignore: cast_nullable_to_non_nullable
                        as String?,
            isActive:
                null == isActive
                    ? _value.isActive
                    : isActive // ignore: cast_nullable_to_non_nullable
                        as bool,
            lastLogin:
                freezed == lastLogin
                    ? _value.lastLogin
                    : lastLogin // ignore: cast_nullable_to_non_nullable
                        as DateTime?,
            createdAt:
                null == createdAt
                    ? _value.createdAt
                    : createdAt // ignore: cast_nullable_to_non_nullable
                        as DateTime,
            role:
                null == role
                    ? _value.role
                    : role // ignore: cast_nullable_to_non_nullable
                        as String,
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
    @JsonKey(name: SecurityJsonKeys.id) int id,
    @JsonKey(name: SecurityJsonKeys.email) String email,
    @JsonKey(name: SecurityJsonKeys.firstName) String? firstName,
    @JsonKey(name: SecurityJsonKeys.lastName) String? lastName,
    @JsonKey(name: SecurityJsonKeys.profileImageUrl) String? profileImageUrl,
    @JsonKey(name: SecurityJsonKeys.isActive) bool isActive,
    @JsonKey(name: SecurityJsonKeys.lastLogin) DateTime? lastLogin,
    @JsonKey(name: SecurityJsonKeys.createdAt) DateTime createdAt,
    @JsonKey(name: SecurityJsonKeys.role) String role,
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
    Object? profileImageUrl = freezed,
    Object? isActive = null,
    Object? lastLogin = freezed,
    Object? createdAt = null,
    Object? role = null,
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
        profileImageUrl:
            freezed == profileImageUrl
                ? _value.profileImageUrl
                : profileImageUrl // ignore: cast_nullable_to_non_nullable
                    as String?,
        isActive:
            null == isActive
                ? _value.isActive
                : isActive // ignore: cast_nullable_to_non_nullable
                    as bool,
        lastLogin:
            freezed == lastLogin
                ? _value.lastLogin
                : lastLogin // ignore: cast_nullable_to_non_nullable
                    as DateTime?,
        createdAt:
            null == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                    as DateTime,
        role:
            null == role
                ? _value.role
                : role // ignore: cast_nullable_to_non_nullable
                    as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$UserProfileResponseModelImpl extends _UserProfileResponseModel {
  const _$UserProfileResponseModelImpl({
    @JsonKey(name: SecurityJsonKeys.id) required this.id,
    @JsonKey(name: SecurityJsonKeys.email) required this.email,
    @JsonKey(name: SecurityJsonKeys.firstName) this.firstName,
    @JsonKey(name: SecurityJsonKeys.lastName) this.lastName,
    @JsonKey(name: SecurityJsonKeys.profileImageUrl) this.profileImageUrl,
    @JsonKey(name: SecurityJsonKeys.isActive) this.isActive = false,
    @JsonKey(name: SecurityJsonKeys.lastLogin) this.lastLogin,
    @JsonKey(name: SecurityJsonKeys.createdAt) required this.createdAt,
    @JsonKey(name: SecurityJsonKeys.role) required this.role,
  }) : super._();

  factory _$UserProfileResponseModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$UserProfileResponseModelImplFromJson(json);

  @override
  @JsonKey(name: SecurityJsonKeys.id)
  final int id;
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
  @JsonKey(name: SecurityJsonKeys.profileImageUrl)
  final String? profileImageUrl;
  @override
  @JsonKey(name: SecurityJsonKeys.isActive)
  final bool isActive;
  @override
  @JsonKey(name: SecurityJsonKeys.lastLogin)
  final DateTime? lastLogin;
  @override
  @JsonKey(name: SecurityJsonKeys.createdAt)
  final DateTime createdAt;
  @override
  @JsonKey(name: SecurityJsonKeys.role)
  final String role;

  @override
  String toString() {
    return 'UserProfileResponseModel(id: $id, email: $email, firstName: $firstName, lastName: $lastName, profileImageUrl: $profileImageUrl, isActive: $isActive, lastLogin: $lastLogin, createdAt: $createdAt, role: $role)';
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
            (identical(other.profileImageUrl, profileImageUrl) ||
                other.profileImageUrl == profileImageUrl) &&
            (identical(other.isActive, isActive) ||
                other.isActive == isActive) &&
            (identical(other.lastLogin, lastLogin) ||
                other.lastLogin == lastLogin) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.role, role) || other.role == role));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    email,
    firstName,
    lastName,
    profileImageUrl,
    isActive,
    lastLogin,
    createdAt,
    role,
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
    @JsonKey(name: SecurityJsonKeys.id) required final int id,
    @JsonKey(name: SecurityJsonKeys.email) required final String email,
    @JsonKey(name: SecurityJsonKeys.firstName) final String? firstName,
    @JsonKey(name: SecurityJsonKeys.lastName) final String? lastName,
    @JsonKey(name: SecurityJsonKeys.profileImageUrl)
    final String? profileImageUrl,
    @JsonKey(name: SecurityJsonKeys.isActive) final bool isActive,
    @JsonKey(name: SecurityJsonKeys.lastLogin) final DateTime? lastLogin,
    @JsonKey(name: SecurityJsonKeys.createdAt)
    required final DateTime createdAt,
    @JsonKey(name: SecurityJsonKeys.role) required final String role,
  }) = _$UserProfileResponseModelImpl;
  const _UserProfileResponseModel._() : super._();

  factory _UserProfileResponseModel.fromJson(Map<String, dynamic> json) =
      _$UserProfileResponseModelImpl.fromJson;

  @override
  @JsonKey(name: SecurityJsonKeys.id)
  int get id;
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
  @JsonKey(name: SecurityJsonKeys.profileImageUrl)
  String? get profileImageUrl;
  @override
  @JsonKey(name: SecurityJsonKeys.isActive)
  bool get isActive;
  @override
  @JsonKey(name: SecurityJsonKeys.lastLogin)
  DateTime? get lastLogin;
  @override
  @JsonKey(name: SecurityJsonKeys.createdAt)
  DateTime get createdAt;
  @override
  @JsonKey(name: SecurityJsonKeys.role)
  String get role;

  /// Create a copy of UserProfileResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UserProfileResponseModelImplCopyWith<_$UserProfileResponseModelImpl>
  get copyWith => throw _privateConstructorUsedError;
}
