// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'dining_session.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$DiningSession {
  String get id => throw _privateConstructorUsedError;
  String get restaurantId => throw _privateConstructorUsedError;
  String get tableId => throw _privateConstructorUsedError;
  String get inviteCode => throw _privateConstructorUsedError;
  String get status => throw _privateConstructorUsedError;
  List<SessionMember> get members => throw _privateConstructorUsedError;

  /// Create a copy of DiningSession
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $DiningSessionCopyWith<DiningSession> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DiningSessionCopyWith<$Res> {
  factory $DiningSessionCopyWith(
    DiningSession value,
    $Res Function(DiningSession) then,
  ) = _$DiningSessionCopyWithImpl<$Res, DiningSession>;
  @useResult
  $Res call({
    String id,
    String restaurantId,
    String tableId,
    String inviteCode,
    String status,
    List<SessionMember> members,
  });
}

/// @nodoc
class _$DiningSessionCopyWithImpl<$Res, $Val extends DiningSession>
    implements $DiningSessionCopyWith<$Res> {
  _$DiningSessionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of DiningSession
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? restaurantId = null,
    Object? tableId = null,
    Object? inviteCode = null,
    Object? status = null,
    Object? members = null,
  }) {
    return _then(
      _value.copyWith(
            id:
                null == id
                    ? _value.id
                    : id // ignore: cast_nullable_to_non_nullable
                        as String,
            restaurantId:
                null == restaurantId
                    ? _value.restaurantId
                    : restaurantId // ignore: cast_nullable_to_non_nullable
                        as String,
            tableId:
                null == tableId
                    ? _value.tableId
                    : tableId // ignore: cast_nullable_to_non_nullable
                        as String,
            inviteCode:
                null == inviteCode
                    ? _value.inviteCode
                    : inviteCode // ignore: cast_nullable_to_non_nullable
                        as String,
            status:
                null == status
                    ? _value.status
                    : status // ignore: cast_nullable_to_non_nullable
                        as String,
            members:
                null == members
                    ? _value.members
                    : members // ignore: cast_nullable_to_non_nullable
                        as List<SessionMember>,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$DiningSessionImplCopyWith<$Res>
    implements $DiningSessionCopyWith<$Res> {
  factory _$$DiningSessionImplCopyWith(
    _$DiningSessionImpl value,
    $Res Function(_$DiningSessionImpl) then,
  ) = __$$DiningSessionImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String restaurantId,
    String tableId,
    String inviteCode,
    String status,
    List<SessionMember> members,
  });
}

/// @nodoc
class __$$DiningSessionImplCopyWithImpl<$Res>
    extends _$DiningSessionCopyWithImpl<$Res, _$DiningSessionImpl>
    implements _$$DiningSessionImplCopyWith<$Res> {
  __$$DiningSessionImplCopyWithImpl(
    _$DiningSessionImpl _value,
    $Res Function(_$DiningSessionImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of DiningSession
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? restaurantId = null,
    Object? tableId = null,
    Object? inviteCode = null,
    Object? status = null,
    Object? members = null,
  }) {
    return _then(
      _$DiningSessionImpl(
        id:
            null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                    as String,
        restaurantId:
            null == restaurantId
                ? _value.restaurantId
                : restaurantId // ignore: cast_nullable_to_non_nullable
                    as String,
        tableId:
            null == tableId
                ? _value.tableId
                : tableId // ignore: cast_nullable_to_non_nullable
                    as String,
        inviteCode:
            null == inviteCode
                ? _value.inviteCode
                : inviteCode // ignore: cast_nullable_to_non_nullable
                    as String,
        status:
            null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                    as String,
        members:
            null == members
                ? _value._members
                : members // ignore: cast_nullable_to_non_nullable
                    as List<SessionMember>,
      ),
    );
  }
}

/// @nodoc

class _$DiningSessionImpl implements _DiningSession {
  const _$DiningSessionImpl({
    required this.id,
    required this.restaurantId,
    required this.tableId,
    required this.inviteCode,
    required this.status,
    final List<SessionMember> members = const [],
  }) : _members = members;

  @override
  final String id;
  @override
  final String restaurantId;
  @override
  final String tableId;
  @override
  final String inviteCode;
  @override
  final String status;
  final List<SessionMember> _members;
  @override
  @JsonKey()
  List<SessionMember> get members {
    if (_members is EqualUnmodifiableListView) return _members;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_members);
  }

  @override
  String toString() {
    return 'DiningSession(id: $id, restaurantId: $restaurantId, tableId: $tableId, inviteCode: $inviteCode, status: $status, members: $members)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DiningSessionImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.restaurantId, restaurantId) ||
                other.restaurantId == restaurantId) &&
            (identical(other.tableId, tableId) || other.tableId == tableId) &&
            (identical(other.inviteCode, inviteCode) ||
                other.inviteCode == inviteCode) &&
            (identical(other.status, status) || other.status == status) &&
            const DeepCollectionEquality().equals(other._members, _members));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    restaurantId,
    tableId,
    inviteCode,
    status,
    const DeepCollectionEquality().hash(_members),
  );

  /// Create a copy of DiningSession
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DiningSessionImplCopyWith<_$DiningSessionImpl> get copyWith =>
      __$$DiningSessionImplCopyWithImpl<_$DiningSessionImpl>(this, _$identity);
}

abstract class _DiningSession implements DiningSession {
  const factory _DiningSession({
    required final String id,
    required final String restaurantId,
    required final String tableId,
    required final String inviteCode,
    required final String status,
    final List<SessionMember> members,
  }) = _$DiningSessionImpl;

  @override
  String get id;
  @override
  String get restaurantId;
  @override
  String get tableId;
  @override
  String get inviteCode;
  @override
  String get status;
  @override
  List<SessionMember> get members;

  /// Create a copy of DiningSession
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DiningSessionImplCopyWith<_$DiningSessionImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$SessionMember {
  int get userId => throw _privateConstructorUsedError;
  String? get firstName => throw _privateConstructorUsedError;
  String? get lastName => throw _privateConstructorUsedError;
  DateTime get joinedAt => throw _privateConstructorUsedError;

  /// Create a copy of SessionMember
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SessionMemberCopyWith<SessionMember> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SessionMemberCopyWith<$Res> {
  factory $SessionMemberCopyWith(
    SessionMember value,
    $Res Function(SessionMember) then,
  ) = _$SessionMemberCopyWithImpl<$Res, SessionMember>;
  @useResult
  $Res call({
    int userId,
    String? firstName,
    String? lastName,
    DateTime joinedAt,
  });
}

/// @nodoc
class _$SessionMemberCopyWithImpl<$Res, $Val extends SessionMember>
    implements $SessionMemberCopyWith<$Res> {
  _$SessionMemberCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SessionMember
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userId = null,
    Object? firstName = freezed,
    Object? lastName = freezed,
    Object? joinedAt = null,
  }) {
    return _then(
      _value.copyWith(
            userId:
                null == userId
                    ? _value.userId
                    : userId // ignore: cast_nullable_to_non_nullable
                        as int,
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
            joinedAt:
                null == joinedAt
                    ? _value.joinedAt
                    : joinedAt // ignore: cast_nullable_to_non_nullable
                        as DateTime,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$SessionMemberImplCopyWith<$Res>
    implements $SessionMemberCopyWith<$Res> {
  factory _$$SessionMemberImplCopyWith(
    _$SessionMemberImpl value,
    $Res Function(_$SessionMemberImpl) then,
  ) = __$$SessionMemberImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int userId,
    String? firstName,
    String? lastName,
    DateTime joinedAt,
  });
}

/// @nodoc
class __$$SessionMemberImplCopyWithImpl<$Res>
    extends _$SessionMemberCopyWithImpl<$Res, _$SessionMemberImpl>
    implements _$$SessionMemberImplCopyWith<$Res> {
  __$$SessionMemberImplCopyWithImpl(
    _$SessionMemberImpl _value,
    $Res Function(_$SessionMemberImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of SessionMember
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userId = null,
    Object? firstName = freezed,
    Object? lastName = freezed,
    Object? joinedAt = null,
  }) {
    return _then(
      _$SessionMemberImpl(
        userId:
            null == userId
                ? _value.userId
                : userId // ignore: cast_nullable_to_non_nullable
                    as int,
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
        joinedAt:
            null == joinedAt
                ? _value.joinedAt
                : joinedAt // ignore: cast_nullable_to_non_nullable
                    as DateTime,
      ),
    );
  }
}

/// @nodoc

class _$SessionMemberImpl extends _SessionMember {
  const _$SessionMemberImpl({
    required this.userId,
    this.firstName,
    this.lastName,
    required this.joinedAt,
  }) : super._();

  @override
  final int userId;
  @override
  final String? firstName;
  @override
  final String? lastName;
  @override
  final DateTime joinedAt;

  @override
  String toString() {
    return 'SessionMember(userId: $userId, firstName: $firstName, lastName: $lastName, joinedAt: $joinedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SessionMemberImpl &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.firstName, firstName) ||
                other.firstName == firstName) &&
            (identical(other.lastName, lastName) ||
                other.lastName == lastName) &&
            (identical(other.joinedAt, joinedAt) ||
                other.joinedAt == joinedAt));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, userId, firstName, lastName, joinedAt);

  /// Create a copy of SessionMember
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SessionMemberImplCopyWith<_$SessionMemberImpl> get copyWith =>
      __$$SessionMemberImplCopyWithImpl<_$SessionMemberImpl>(this, _$identity);
}

abstract class _SessionMember extends SessionMember {
  const factory _SessionMember({
    required final int userId,
    final String? firstName,
    final String? lastName,
    required final DateTime joinedAt,
  }) = _$SessionMemberImpl;
  const _SessionMember._() : super._();

  @override
  int get userId;
  @override
  String? get firstName;
  @override
  String? get lastName;
  @override
  DateTime get joinedAt;

  /// Create a copy of SessionMember
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SessionMemberImplCopyWith<_$SessionMemberImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
