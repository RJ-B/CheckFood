// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$User {
  int get id => throw _privateConstructorUsedError;
  String get email => throw _privateConstructorUsedError;
  UserRole get role => throw _privateConstructorUsedError;
  bool get isActive => throw _privateConstructorUsedError;
  String get firstName => throw _privateConstructorUsedError;
  String get lastName => throw _privateConstructorUsedError;
  String get phone => throw _privateConstructorUsedError;
  List<String> get permissions => throw _privateConstructorUsedError;
  bool get needsRestaurantClaim => throw _privateConstructorUsedError;
  bool get needsOnboarding => throw _privateConstructorUsedError;

  /// Create a copy of User
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $UserCopyWith<User> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserCopyWith<$Res> {
  factory $UserCopyWith(User value, $Res Function(User) then) =
      _$UserCopyWithImpl<$Res, User>;
  @useResult
  $Res call({
    int id,
    String email,
    UserRole role,
    bool isActive,
    String firstName,
    String lastName,
    String phone,
    List<String> permissions,
    bool needsRestaurantClaim,
    bool needsOnboarding,
  });
}

/// @nodoc
class _$UserCopyWithImpl<$Res, $Val extends User>
    implements $UserCopyWith<$Res> {
  _$UserCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of User
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? email = null,
    Object? role = null,
    Object? isActive = null,
    Object? firstName = null,
    Object? lastName = null,
    Object? phone = null,
    Object? permissions = null,
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
                        as UserRole,
            isActive:
                null == isActive
                    ? _value.isActive
                    : isActive // ignore: cast_nullable_to_non_nullable
                        as bool,
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
            phone:
                null == phone
                    ? _value.phone
                    : phone // ignore: cast_nullable_to_non_nullable
                        as String,
            permissions:
                null == permissions
                    ? _value.permissions
                    : permissions // ignore: cast_nullable_to_non_nullable
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
abstract class _$$UserImplCopyWith<$Res> implements $UserCopyWith<$Res> {
  factory _$$UserImplCopyWith(
    _$UserImpl value,
    $Res Function(_$UserImpl) then,
  ) = __$$UserImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int id,
    String email,
    UserRole role,
    bool isActive,
    String firstName,
    String lastName,
    String phone,
    List<String> permissions,
    bool needsRestaurantClaim,
    bool needsOnboarding,
  });
}

/// @nodoc
class __$$UserImplCopyWithImpl<$Res>
    extends _$UserCopyWithImpl<$Res, _$UserImpl>
    implements _$$UserImplCopyWith<$Res> {
  __$$UserImplCopyWithImpl(_$UserImpl _value, $Res Function(_$UserImpl) _then)
    : super(_value, _then);

  /// Create a copy of User
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? email = null,
    Object? role = null,
    Object? isActive = null,
    Object? firstName = null,
    Object? lastName = null,
    Object? phone = null,
    Object? permissions = null,
    Object? needsRestaurantClaim = null,
    Object? needsOnboarding = null,
  }) {
    return _then(
      _$UserImpl(
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
                    as UserRole,
        isActive:
            null == isActive
                ? _value.isActive
                : isActive // ignore: cast_nullable_to_non_nullable
                    as bool,
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
        phone:
            null == phone
                ? _value.phone
                : phone // ignore: cast_nullable_to_non_nullable
                    as String,
        permissions:
            null == permissions
                ? _value._permissions
                : permissions // ignore: cast_nullable_to_non_nullable
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

class _$UserImpl extends _User {
  const _$UserImpl({
    required this.id,
    required this.email,
    required this.role,
    required this.isActive,
    this.firstName = '',
    this.lastName = '',
    this.phone = '',
    final List<String> permissions = const [],
    this.needsRestaurantClaim = false,
    this.needsOnboarding = false,
  }) : _permissions = permissions,
       super._();

  @override
  final int id;
  @override
  final String email;
  @override
  final UserRole role;
  @override
  final bool isActive;
  @override
  @JsonKey()
  final String firstName;
  @override
  @JsonKey()
  final String lastName;
  @override
  @JsonKey()
  final String phone;
  final List<String> _permissions;
  @override
  @JsonKey()
  List<String> get permissions {
    if (_permissions is EqualUnmodifiableListView) return _permissions;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_permissions);
  }

  @override
  @JsonKey()
  final bool needsRestaurantClaim;
  @override
  @JsonKey()
  final bool needsOnboarding;

  @override
  String toString() {
    return 'User(id: $id, email: $email, role: $role, isActive: $isActive, firstName: $firstName, lastName: $lastName, phone: $phone, permissions: $permissions, needsRestaurantClaim: $needsRestaurantClaim, needsOnboarding: $needsOnboarding)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.role, role) || other.role == role) &&
            (identical(other.isActive, isActive) ||
                other.isActive == isActive) &&
            (identical(other.firstName, firstName) ||
                other.firstName == firstName) &&
            (identical(other.lastName, lastName) ||
                other.lastName == lastName) &&
            (identical(other.phone, phone) || other.phone == phone) &&
            const DeepCollectionEquality().equals(
              other._permissions,
              _permissions,
            ) &&
            (identical(other.needsRestaurantClaim, needsRestaurantClaim) ||
                other.needsRestaurantClaim == needsRestaurantClaim) &&
            (identical(other.needsOnboarding, needsOnboarding) ||
                other.needsOnboarding == needsOnboarding));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    email,
    role,
    isActive,
    firstName,
    lastName,
    phone,
    const DeepCollectionEquality().hash(_permissions),
    needsRestaurantClaim,
    needsOnboarding,
  );

  /// Create a copy of User
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UserImplCopyWith<_$UserImpl> get copyWith =>
      __$$UserImplCopyWithImpl<_$UserImpl>(this, _$identity);
}

abstract class _User extends User {
  const factory _User({
    required final int id,
    required final String email,
    required final UserRole role,
    required final bool isActive,
    final String firstName,
    final String lastName,
    final String phone,
    final List<String> permissions,
    final bool needsRestaurantClaim,
    final bool needsOnboarding,
  }) = _$UserImpl;
  const _User._() : super._();

  @override
  int get id;
  @override
  String get email;
  @override
  UserRole get role;
  @override
  bool get isActive;
  @override
  String get firstName;
  @override
  String get lastName;
  @override
  String get phone;
  @override
  List<String> get permissions;
  @override
  bool get needsRestaurantClaim;
  @override
  bool get needsOnboarding;

  /// Create a copy of User
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UserImplCopyWith<_$UserImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
