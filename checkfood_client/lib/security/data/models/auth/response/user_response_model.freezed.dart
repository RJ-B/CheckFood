// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_response_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

UserResponseModel _$UserResponseModelFromJson(Map<String, dynamic> json) {
  return _UserResponseModel.fromJson(json);
}

/// @nodoc
mixin _$UserResponseModel {
  @JsonKey(name: SecurityJsonKeys.id)
  int get id => throw _privateConstructorUsedError;
  @JsonKey(name: SecurityJsonKeys.email)
  String get email => throw _privateConstructorUsedError;
  @JsonKey(name: SecurityJsonKeys.role)
  String get role => throw _privateConstructorUsedError;
  @JsonKey(name: SecurityJsonKeys.isActive)
  bool get isActive => throw _privateConstructorUsedError;
  @JsonKey(name: SecurityJsonKeys.authorities)
  List<String> get authorities => throw _privateConstructorUsedError;
  @JsonKey(name: 'needsRestaurantClaim')
  bool get needsRestaurantClaim => throw _privateConstructorUsedError;
  @JsonKey(name: 'needsOnboarding')
  bool get needsOnboarding => throw _privateConstructorUsedError;

  /// Serializes this UserResponseModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of UserResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $UserResponseModelCopyWith<UserResponseModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserResponseModelCopyWith<$Res> {
  factory $UserResponseModelCopyWith(
    UserResponseModel value,
    $Res Function(UserResponseModel) then,
  ) = _$UserResponseModelCopyWithImpl<$Res, UserResponseModel>;
  @useResult
  $Res call({
    @JsonKey(name: SecurityJsonKeys.id) int id,
    @JsonKey(name: SecurityJsonKeys.email) String email,
    @JsonKey(name: SecurityJsonKeys.role) String role,
    @JsonKey(name: SecurityJsonKeys.isActive) bool isActive,
    @JsonKey(name: SecurityJsonKeys.authorities) List<String> authorities,
    @JsonKey(name: 'needsRestaurantClaim') bool needsRestaurantClaim,
    @JsonKey(name: 'needsOnboarding') bool needsOnboarding,
  });
}

/// @nodoc
class _$UserResponseModelCopyWithImpl<$Res, $Val extends UserResponseModel>
    implements $UserResponseModelCopyWith<$Res> {
  _$UserResponseModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of UserResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? email = null,
    Object? role = null,
    Object? isActive = null,
    Object? authorities = null,
    Object? needsRestaurantClaim = null,
    Object? needsOnboarding = null,
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
            role:
                null == role
                    ? _value.role
                    : role // ignore: cast_nullable_to_non_nullable
                        as String,
            isActive:
                null == isActive
                    ? _value.isActive
                    : isActive // ignore: cast_nullable_to_non_nullable
                        as bool,
            authorities:
                null == authorities
                    ? _value.authorities
                    : authorities // ignore: cast_nullable_to_non_nullable
                        as List<String>,
            needsRestaurantClaim:
                null == needsRestaurantClaim
                    ? _value.needsRestaurantClaim
                    : needsRestaurantClaim // ignore: cast_nullable_to_non_nullable
                        as bool,
            needsOnboarding:
                null == needsOnboarding
                    ? _value.needsOnboarding
                    : needsOnboarding // ignore: cast_nullable_to_non_nullable
                        as bool,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$UserResponseModelImplCopyWith<$Res>
    implements $UserResponseModelCopyWith<$Res> {
  factory _$$UserResponseModelImplCopyWith(
    _$UserResponseModelImpl value,
    $Res Function(_$UserResponseModelImpl) then,
  ) = __$$UserResponseModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @JsonKey(name: SecurityJsonKeys.id) int id,
    @JsonKey(name: SecurityJsonKeys.email) String email,
    @JsonKey(name: SecurityJsonKeys.role) String role,
    @JsonKey(name: SecurityJsonKeys.isActive) bool isActive,
    @JsonKey(name: SecurityJsonKeys.authorities) List<String> authorities,
    @JsonKey(name: 'needsRestaurantClaim') bool needsRestaurantClaim,
    @JsonKey(name: 'needsOnboarding') bool needsOnboarding,
  });
}

/// @nodoc
class __$$UserResponseModelImplCopyWithImpl<$Res>
    extends _$UserResponseModelCopyWithImpl<$Res, _$UserResponseModelImpl>
    implements _$$UserResponseModelImplCopyWith<$Res> {
  __$$UserResponseModelImplCopyWithImpl(
    _$UserResponseModelImpl _value,
    $Res Function(_$UserResponseModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of UserResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? email = null,
    Object? role = null,
    Object? isActive = null,
    Object? authorities = null,
    Object? needsRestaurantClaim = null,
    Object? needsOnboarding = null,
  }) {
    return _then(
      _$UserResponseModelImpl(
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
        role:
            null == role
                ? _value.role
                : role // ignore: cast_nullable_to_non_nullable
                    as String,
        isActive:
            null == isActive
                ? _value.isActive
                : isActive // ignore: cast_nullable_to_non_nullable
                    as bool,
        authorities:
            null == authorities
                ? _value._authorities
                : authorities // ignore: cast_nullable_to_non_nullable
                    as List<String>,
        needsRestaurantClaim:
            null == needsRestaurantClaim
                ? _value.needsRestaurantClaim
                : needsRestaurantClaim // ignore: cast_nullable_to_non_nullable
                    as bool,
        needsOnboarding:
            null == needsOnboarding
                ? _value.needsOnboarding
                : needsOnboarding // ignore: cast_nullable_to_non_nullable
                    as bool,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$UserResponseModelImpl extends _UserResponseModel {
  const _$UserResponseModelImpl({
    @JsonKey(name: SecurityJsonKeys.id) required this.id,
    @JsonKey(name: SecurityJsonKeys.email) required this.email,
    @JsonKey(name: SecurityJsonKeys.role) required this.role,
    @JsonKey(name: SecurityJsonKeys.isActive) required this.isActive,
    @JsonKey(name: SecurityJsonKeys.authorities)
    final List<String> authorities = const [],
    @JsonKey(name: 'needsRestaurantClaim') this.needsRestaurantClaim = false,
    @JsonKey(name: 'needsOnboarding') this.needsOnboarding = false,
  }) : _authorities = authorities,
       super._();

  factory _$UserResponseModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$UserResponseModelImplFromJson(json);

  @override
  @JsonKey(name: SecurityJsonKeys.id)
  final int id;
  @override
  @JsonKey(name: SecurityJsonKeys.email)
  final String email;
  @override
  @JsonKey(name: SecurityJsonKeys.role)
  final String role;
  @override
  @JsonKey(name: SecurityJsonKeys.isActive)
  final bool isActive;
  final List<String> _authorities;
  @override
  @JsonKey(name: SecurityJsonKeys.authorities)
  List<String> get authorities {
    if (_authorities is EqualUnmodifiableListView) return _authorities;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_authorities);
  }

  @override
  @JsonKey(name: 'needsRestaurantClaim')
  final bool needsRestaurantClaim;
  @override
  @JsonKey(name: 'needsOnboarding')
  final bool needsOnboarding;

  @override
  String toString() {
    return 'UserResponseModel(id: $id, email: $email, role: $role, isActive: $isActive, authorities: $authorities, needsRestaurantClaim: $needsRestaurantClaim, needsOnboarding: $needsOnboarding)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserResponseModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.role, role) || other.role == role) &&
            (identical(other.isActive, isActive) ||
                other.isActive == isActive) &&
            const DeepCollectionEquality().equals(
              other._authorities,
              _authorities,
            ) &&
            (identical(other.needsRestaurantClaim, needsRestaurantClaim) ||
                other.needsRestaurantClaim == needsRestaurantClaim) &&
            (identical(other.needsOnboarding, needsOnboarding) ||
                other.needsOnboarding == needsOnboarding));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    email,
    role,
    isActive,
    const DeepCollectionEquality().hash(_authorities),
    needsRestaurantClaim,
    needsOnboarding,
  );

  /// Create a copy of UserResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UserResponseModelImplCopyWith<_$UserResponseModelImpl> get copyWith =>
      __$$UserResponseModelImplCopyWithImpl<_$UserResponseModelImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$UserResponseModelImplToJson(this);
  }
}

abstract class _UserResponseModel extends UserResponseModel {
  const factory _UserResponseModel({
    @JsonKey(name: SecurityJsonKeys.id) required final int id,
    @JsonKey(name: SecurityJsonKeys.email) required final String email,
    @JsonKey(name: SecurityJsonKeys.role) required final String role,
    @JsonKey(name: SecurityJsonKeys.isActive) required final bool isActive,
    @JsonKey(name: SecurityJsonKeys.authorities) final List<String> authorities,
    @JsonKey(name: 'needsRestaurantClaim') final bool needsRestaurantClaim,
    @JsonKey(name: 'needsOnboarding') final bool needsOnboarding,
  }) = _$UserResponseModelImpl;
  const _UserResponseModel._() : super._();

  factory _UserResponseModel.fromJson(Map<String, dynamic> json) =
      _$UserResponseModelImpl.fromJson;

  @override
  @JsonKey(name: SecurityJsonKeys.id)
  int get id;
  @override
  @JsonKey(name: SecurityJsonKeys.email)
  String get email;
  @override
  @JsonKey(name: SecurityJsonKeys.role)
  String get role;
  @override
  @JsonKey(name: SecurityJsonKeys.isActive)
  bool get isActive;
  @override
  @JsonKey(name: SecurityJsonKeys.authorities)
  List<String> get authorities;
  @override
  @JsonKey(name: 'needsRestaurantClaim')
  bool get needsRestaurantClaim;
  @override
  @JsonKey(name: 'needsOnboarding')
  bool get needsOnboarding;

  /// Create a copy of UserResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UserResponseModelImplCopyWith<_$UserResponseModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
