// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'auth_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$AuthState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(User user) authenticated,
    required TResult Function() unauthenticated,
    required TResult Function(String email) verificationRequired,
    required TResult Function() registerSuccess,
    required TResult Function(String message) failure,
    required TResult Function(String message, String email, bool isExpired)
    unverifiedFailure,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(User user)? authenticated,
    TResult? Function()? unauthenticated,
    TResult? Function(String email)? verificationRequired,
    TResult? Function()? registerSuccess,
    TResult? Function(String message)? failure,
    TResult? Function(String message, String email, bool isExpired)?
    unverifiedFailure,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(User user)? authenticated,
    TResult Function()? unauthenticated,
    TResult Function(String email)? verificationRequired,
    TResult Function()? registerSuccess,
    TResult Function(String message)? failure,
    TResult Function(String message, String email, bool isExpired)?
    unverifiedFailure,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_Authenticated value) authenticated,
    required TResult Function(_Unauthenticated value) unauthenticated,
    required TResult Function(_VerificationRequired value) verificationRequired,
    required TResult Function(_RegisterSuccess value) registerSuccess,
    required TResult Function(_Failure value) failure,
    required TResult Function(_UnverifiedFailure value) unverifiedFailure,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Authenticated value)? authenticated,
    TResult? Function(_Unauthenticated value)? unauthenticated,
    TResult? Function(_VerificationRequired value)? verificationRequired,
    TResult? Function(_RegisterSuccess value)? registerSuccess,
    TResult? Function(_Failure value)? failure,
    TResult? Function(_UnverifiedFailure value)? unverifiedFailure,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_Authenticated value)? authenticated,
    TResult Function(_Unauthenticated value)? unauthenticated,
    TResult Function(_VerificationRequired value)? verificationRequired,
    TResult Function(_RegisterSuccess value)? registerSuccess,
    TResult Function(_Failure value)? failure,
    TResult Function(_UnverifiedFailure value)? unverifiedFailure,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AuthStateCopyWith<$Res> {
  factory $AuthStateCopyWith(AuthState value, $Res Function(AuthState) then) =
      _$AuthStateCopyWithImpl<$Res, AuthState>;
}

/// @nodoc
class _$AuthStateCopyWithImpl<$Res, $Val extends AuthState>
    implements $AuthStateCopyWith<$Res> {
  _$AuthStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AuthState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$InitialImplCopyWith<$Res> {
  factory _$$InitialImplCopyWith(
    _$InitialImpl value,
    $Res Function(_$InitialImpl) then,
  ) = __$$InitialImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$InitialImplCopyWithImpl<$Res>
    extends _$AuthStateCopyWithImpl<$Res, _$InitialImpl>
    implements _$$InitialImplCopyWith<$Res> {
  __$$InitialImplCopyWithImpl(
    _$InitialImpl _value,
    $Res Function(_$InitialImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AuthState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$InitialImpl implements _Initial {
  const _$InitialImpl();

  @override
  String toString() {
    return 'AuthState.initial()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$InitialImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(User user) authenticated,
    required TResult Function() unauthenticated,
    required TResult Function(String email) verificationRequired,
    required TResult Function() registerSuccess,
    required TResult Function(String message) failure,
    required TResult Function(String message, String email, bool isExpired)
    unverifiedFailure,
  }) {
    return initial();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(User user)? authenticated,
    TResult? Function()? unauthenticated,
    TResult? Function(String email)? verificationRequired,
    TResult? Function()? registerSuccess,
    TResult? Function(String message)? failure,
    TResult? Function(String message, String email, bool isExpired)?
    unverifiedFailure,
  }) {
    return initial?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(User user)? authenticated,
    TResult Function()? unauthenticated,
    TResult Function(String email)? verificationRequired,
    TResult Function()? registerSuccess,
    TResult Function(String message)? failure,
    TResult Function(String message, String email, bool isExpired)?
    unverifiedFailure,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_Authenticated value) authenticated,
    required TResult Function(_Unauthenticated value) unauthenticated,
    required TResult Function(_VerificationRequired value) verificationRequired,
    required TResult Function(_RegisterSuccess value) registerSuccess,
    required TResult Function(_Failure value) failure,
    required TResult Function(_UnverifiedFailure value) unverifiedFailure,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Authenticated value)? authenticated,
    TResult? Function(_Unauthenticated value)? unauthenticated,
    TResult? Function(_VerificationRequired value)? verificationRequired,
    TResult? Function(_RegisterSuccess value)? registerSuccess,
    TResult? Function(_Failure value)? failure,
    TResult? Function(_UnverifiedFailure value)? unverifiedFailure,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_Authenticated value)? authenticated,
    TResult Function(_Unauthenticated value)? unauthenticated,
    TResult Function(_VerificationRequired value)? verificationRequired,
    TResult Function(_RegisterSuccess value)? registerSuccess,
    TResult Function(_Failure value)? failure,
    TResult Function(_UnverifiedFailure value)? unverifiedFailure,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class _Initial implements AuthState {
  const factory _Initial() = _$InitialImpl;
}

/// @nodoc
abstract class _$$LoadingImplCopyWith<$Res> {
  factory _$$LoadingImplCopyWith(
    _$LoadingImpl value,
    $Res Function(_$LoadingImpl) then,
  ) = __$$LoadingImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$LoadingImplCopyWithImpl<$Res>
    extends _$AuthStateCopyWithImpl<$Res, _$LoadingImpl>
    implements _$$LoadingImplCopyWith<$Res> {
  __$$LoadingImplCopyWithImpl(
    _$LoadingImpl _value,
    $Res Function(_$LoadingImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AuthState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$LoadingImpl implements _Loading {
  const _$LoadingImpl();

  @override
  String toString() {
    return 'AuthState.loading()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$LoadingImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(User user) authenticated,
    required TResult Function() unauthenticated,
    required TResult Function(String email) verificationRequired,
    required TResult Function() registerSuccess,
    required TResult Function(String message) failure,
    required TResult Function(String message, String email, bool isExpired)
    unverifiedFailure,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(User user)? authenticated,
    TResult? Function()? unauthenticated,
    TResult? Function(String email)? verificationRequired,
    TResult? Function()? registerSuccess,
    TResult? Function(String message)? failure,
    TResult? Function(String message, String email, bool isExpired)?
    unverifiedFailure,
  }) {
    return loading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(User user)? authenticated,
    TResult Function()? unauthenticated,
    TResult Function(String email)? verificationRequired,
    TResult Function()? registerSuccess,
    TResult Function(String message)? failure,
    TResult Function(String message, String email, bool isExpired)?
    unverifiedFailure,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_Authenticated value) authenticated,
    required TResult Function(_Unauthenticated value) unauthenticated,
    required TResult Function(_VerificationRequired value) verificationRequired,
    required TResult Function(_RegisterSuccess value) registerSuccess,
    required TResult Function(_Failure value) failure,
    required TResult Function(_UnverifiedFailure value) unverifiedFailure,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Authenticated value)? authenticated,
    TResult? Function(_Unauthenticated value)? unauthenticated,
    TResult? Function(_VerificationRequired value)? verificationRequired,
    TResult? Function(_RegisterSuccess value)? registerSuccess,
    TResult? Function(_Failure value)? failure,
    TResult? Function(_UnverifiedFailure value)? unverifiedFailure,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_Authenticated value)? authenticated,
    TResult Function(_Unauthenticated value)? unauthenticated,
    TResult Function(_VerificationRequired value)? verificationRequired,
    TResult Function(_RegisterSuccess value)? registerSuccess,
    TResult Function(_Failure value)? failure,
    TResult Function(_UnverifiedFailure value)? unverifiedFailure,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class _Loading implements AuthState {
  const factory _Loading() = _$LoadingImpl;
}

/// @nodoc
abstract class _$$AuthenticatedImplCopyWith<$Res> {
  factory _$$AuthenticatedImplCopyWith(
    _$AuthenticatedImpl value,
    $Res Function(_$AuthenticatedImpl) then,
  ) = __$$AuthenticatedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({User user});

  $UserCopyWith<$Res> get user;
}

/// @nodoc
class __$$AuthenticatedImplCopyWithImpl<$Res>
    extends _$AuthStateCopyWithImpl<$Res, _$AuthenticatedImpl>
    implements _$$AuthenticatedImplCopyWith<$Res> {
  __$$AuthenticatedImplCopyWithImpl(
    _$AuthenticatedImpl _value,
    $Res Function(_$AuthenticatedImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AuthState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? user = null}) {
    return _then(
      _$AuthenticatedImpl(
        null == user
            ? _value.user
            : user // ignore: cast_nullable_to_non_nullable
                as User,
      ),
    );
  }

  /// Create a copy of AuthState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $UserCopyWith<$Res> get user {
    return $UserCopyWith<$Res>(_value.user, (value) {
      return _then(_value.copyWith(user: value));
    });
  }
}

/// @nodoc

class _$AuthenticatedImpl implements _Authenticated {
  const _$AuthenticatedImpl(this.user);

  @override
  final User user;

  @override
  String toString() {
    return 'AuthState.authenticated(user: $user)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AuthenticatedImpl &&
            (identical(other.user, user) || other.user == user));
  }

  @override
  int get hashCode => Object.hash(runtimeType, user);

  /// Create a copy of AuthState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AuthenticatedImplCopyWith<_$AuthenticatedImpl> get copyWith =>
      __$$AuthenticatedImplCopyWithImpl<_$AuthenticatedImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(User user) authenticated,
    required TResult Function() unauthenticated,
    required TResult Function(String email) verificationRequired,
    required TResult Function() registerSuccess,
    required TResult Function(String message) failure,
    required TResult Function(String message, String email, bool isExpired)
    unverifiedFailure,
  }) {
    return authenticated(user);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(User user)? authenticated,
    TResult? Function()? unauthenticated,
    TResult? Function(String email)? verificationRequired,
    TResult? Function()? registerSuccess,
    TResult? Function(String message)? failure,
    TResult? Function(String message, String email, bool isExpired)?
    unverifiedFailure,
  }) {
    return authenticated?.call(user);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(User user)? authenticated,
    TResult Function()? unauthenticated,
    TResult Function(String email)? verificationRequired,
    TResult Function()? registerSuccess,
    TResult Function(String message)? failure,
    TResult Function(String message, String email, bool isExpired)?
    unverifiedFailure,
    required TResult orElse(),
  }) {
    if (authenticated != null) {
      return authenticated(user);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_Authenticated value) authenticated,
    required TResult Function(_Unauthenticated value) unauthenticated,
    required TResult Function(_VerificationRequired value) verificationRequired,
    required TResult Function(_RegisterSuccess value) registerSuccess,
    required TResult Function(_Failure value) failure,
    required TResult Function(_UnverifiedFailure value) unverifiedFailure,
  }) {
    return authenticated(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Authenticated value)? authenticated,
    TResult? Function(_Unauthenticated value)? unauthenticated,
    TResult? Function(_VerificationRequired value)? verificationRequired,
    TResult? Function(_RegisterSuccess value)? registerSuccess,
    TResult? Function(_Failure value)? failure,
    TResult? Function(_UnverifiedFailure value)? unverifiedFailure,
  }) {
    return authenticated?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_Authenticated value)? authenticated,
    TResult Function(_Unauthenticated value)? unauthenticated,
    TResult Function(_VerificationRequired value)? verificationRequired,
    TResult Function(_RegisterSuccess value)? registerSuccess,
    TResult Function(_Failure value)? failure,
    TResult Function(_UnverifiedFailure value)? unverifiedFailure,
    required TResult orElse(),
  }) {
    if (authenticated != null) {
      return authenticated(this);
    }
    return orElse();
  }
}

abstract class _Authenticated implements AuthState {
  const factory _Authenticated(final User user) = _$AuthenticatedImpl;

  User get user;

  /// Create a copy of AuthState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AuthenticatedImplCopyWith<_$AuthenticatedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$UnauthenticatedImplCopyWith<$Res> {
  factory _$$UnauthenticatedImplCopyWith(
    _$UnauthenticatedImpl value,
    $Res Function(_$UnauthenticatedImpl) then,
  ) = __$$UnauthenticatedImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$UnauthenticatedImplCopyWithImpl<$Res>
    extends _$AuthStateCopyWithImpl<$Res, _$UnauthenticatedImpl>
    implements _$$UnauthenticatedImplCopyWith<$Res> {
  __$$UnauthenticatedImplCopyWithImpl(
    _$UnauthenticatedImpl _value,
    $Res Function(_$UnauthenticatedImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AuthState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$UnauthenticatedImpl implements _Unauthenticated {
  const _$UnauthenticatedImpl();

  @override
  String toString() {
    return 'AuthState.unauthenticated()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$UnauthenticatedImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(User user) authenticated,
    required TResult Function() unauthenticated,
    required TResult Function(String email) verificationRequired,
    required TResult Function() registerSuccess,
    required TResult Function(String message) failure,
    required TResult Function(String message, String email, bool isExpired)
    unverifiedFailure,
  }) {
    return unauthenticated();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(User user)? authenticated,
    TResult? Function()? unauthenticated,
    TResult? Function(String email)? verificationRequired,
    TResult? Function()? registerSuccess,
    TResult? Function(String message)? failure,
    TResult? Function(String message, String email, bool isExpired)?
    unverifiedFailure,
  }) {
    return unauthenticated?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(User user)? authenticated,
    TResult Function()? unauthenticated,
    TResult Function(String email)? verificationRequired,
    TResult Function()? registerSuccess,
    TResult Function(String message)? failure,
    TResult Function(String message, String email, bool isExpired)?
    unverifiedFailure,
    required TResult orElse(),
  }) {
    if (unauthenticated != null) {
      return unauthenticated();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_Authenticated value) authenticated,
    required TResult Function(_Unauthenticated value) unauthenticated,
    required TResult Function(_VerificationRequired value) verificationRequired,
    required TResult Function(_RegisterSuccess value) registerSuccess,
    required TResult Function(_Failure value) failure,
    required TResult Function(_UnverifiedFailure value) unverifiedFailure,
  }) {
    return unauthenticated(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Authenticated value)? authenticated,
    TResult? Function(_Unauthenticated value)? unauthenticated,
    TResult? Function(_VerificationRequired value)? verificationRequired,
    TResult? Function(_RegisterSuccess value)? registerSuccess,
    TResult? Function(_Failure value)? failure,
    TResult? Function(_UnverifiedFailure value)? unverifiedFailure,
  }) {
    return unauthenticated?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_Authenticated value)? authenticated,
    TResult Function(_Unauthenticated value)? unauthenticated,
    TResult Function(_VerificationRequired value)? verificationRequired,
    TResult Function(_RegisterSuccess value)? registerSuccess,
    TResult Function(_Failure value)? failure,
    TResult Function(_UnverifiedFailure value)? unverifiedFailure,
    required TResult orElse(),
  }) {
    if (unauthenticated != null) {
      return unauthenticated(this);
    }
    return orElse();
  }
}

abstract class _Unauthenticated implements AuthState {
  const factory _Unauthenticated() = _$UnauthenticatedImpl;
}

/// @nodoc
abstract class _$$VerificationRequiredImplCopyWith<$Res> {
  factory _$$VerificationRequiredImplCopyWith(
    _$VerificationRequiredImpl value,
    $Res Function(_$VerificationRequiredImpl) then,
  ) = __$$VerificationRequiredImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String email});
}

/// @nodoc
class __$$VerificationRequiredImplCopyWithImpl<$Res>
    extends _$AuthStateCopyWithImpl<$Res, _$VerificationRequiredImpl>
    implements _$$VerificationRequiredImplCopyWith<$Res> {
  __$$VerificationRequiredImplCopyWithImpl(
    _$VerificationRequiredImpl _value,
    $Res Function(_$VerificationRequiredImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AuthState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? email = null}) {
    return _then(
      _$VerificationRequiredImpl(
        null == email
            ? _value.email
            : email // ignore: cast_nullable_to_non_nullable
                as String,
      ),
    );
  }
}

/// @nodoc

class _$VerificationRequiredImpl implements _VerificationRequired {
  const _$VerificationRequiredImpl(this.email);

  @override
  final String email;

  @override
  String toString() {
    return 'AuthState.verificationRequired(email: $email)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$VerificationRequiredImpl &&
            (identical(other.email, email) || other.email == email));
  }

  @override
  int get hashCode => Object.hash(runtimeType, email);

  /// Create a copy of AuthState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$VerificationRequiredImplCopyWith<_$VerificationRequiredImpl>
  get copyWith =>
      __$$VerificationRequiredImplCopyWithImpl<_$VerificationRequiredImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(User user) authenticated,
    required TResult Function() unauthenticated,
    required TResult Function(String email) verificationRequired,
    required TResult Function() registerSuccess,
    required TResult Function(String message) failure,
    required TResult Function(String message, String email, bool isExpired)
    unverifiedFailure,
  }) {
    return verificationRequired(email);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(User user)? authenticated,
    TResult? Function()? unauthenticated,
    TResult? Function(String email)? verificationRequired,
    TResult? Function()? registerSuccess,
    TResult? Function(String message)? failure,
    TResult? Function(String message, String email, bool isExpired)?
    unverifiedFailure,
  }) {
    return verificationRequired?.call(email);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(User user)? authenticated,
    TResult Function()? unauthenticated,
    TResult Function(String email)? verificationRequired,
    TResult Function()? registerSuccess,
    TResult Function(String message)? failure,
    TResult Function(String message, String email, bool isExpired)?
    unverifiedFailure,
    required TResult orElse(),
  }) {
    if (verificationRequired != null) {
      return verificationRequired(email);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_Authenticated value) authenticated,
    required TResult Function(_Unauthenticated value) unauthenticated,
    required TResult Function(_VerificationRequired value) verificationRequired,
    required TResult Function(_RegisterSuccess value) registerSuccess,
    required TResult Function(_Failure value) failure,
    required TResult Function(_UnverifiedFailure value) unverifiedFailure,
  }) {
    return verificationRequired(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Authenticated value)? authenticated,
    TResult? Function(_Unauthenticated value)? unauthenticated,
    TResult? Function(_VerificationRequired value)? verificationRequired,
    TResult? Function(_RegisterSuccess value)? registerSuccess,
    TResult? Function(_Failure value)? failure,
    TResult? Function(_UnverifiedFailure value)? unverifiedFailure,
  }) {
    return verificationRequired?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_Authenticated value)? authenticated,
    TResult Function(_Unauthenticated value)? unauthenticated,
    TResult Function(_VerificationRequired value)? verificationRequired,
    TResult Function(_RegisterSuccess value)? registerSuccess,
    TResult Function(_Failure value)? failure,
    TResult Function(_UnverifiedFailure value)? unverifiedFailure,
    required TResult orElse(),
  }) {
    if (verificationRequired != null) {
      return verificationRequired(this);
    }
    return orElse();
  }
}

abstract class _VerificationRequired implements AuthState {
  const factory _VerificationRequired(final String email) =
      _$VerificationRequiredImpl;

  String get email;

  /// Create a copy of AuthState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$VerificationRequiredImplCopyWith<_$VerificationRequiredImpl>
  get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$RegisterSuccessImplCopyWith<$Res> {
  factory _$$RegisterSuccessImplCopyWith(
    _$RegisterSuccessImpl value,
    $Res Function(_$RegisterSuccessImpl) then,
  ) = __$$RegisterSuccessImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$RegisterSuccessImplCopyWithImpl<$Res>
    extends _$AuthStateCopyWithImpl<$Res, _$RegisterSuccessImpl>
    implements _$$RegisterSuccessImplCopyWith<$Res> {
  __$$RegisterSuccessImplCopyWithImpl(
    _$RegisterSuccessImpl _value,
    $Res Function(_$RegisterSuccessImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AuthState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$RegisterSuccessImpl implements _RegisterSuccess {
  const _$RegisterSuccessImpl();

  @override
  String toString() {
    return 'AuthState.registerSuccess()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$RegisterSuccessImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(User user) authenticated,
    required TResult Function() unauthenticated,
    required TResult Function(String email) verificationRequired,
    required TResult Function() registerSuccess,
    required TResult Function(String message) failure,
    required TResult Function(String message, String email, bool isExpired)
    unverifiedFailure,
  }) {
    return registerSuccess();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(User user)? authenticated,
    TResult? Function()? unauthenticated,
    TResult? Function(String email)? verificationRequired,
    TResult? Function()? registerSuccess,
    TResult? Function(String message)? failure,
    TResult? Function(String message, String email, bool isExpired)?
    unverifiedFailure,
  }) {
    return registerSuccess?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(User user)? authenticated,
    TResult Function()? unauthenticated,
    TResult Function(String email)? verificationRequired,
    TResult Function()? registerSuccess,
    TResult Function(String message)? failure,
    TResult Function(String message, String email, bool isExpired)?
    unverifiedFailure,
    required TResult orElse(),
  }) {
    if (registerSuccess != null) {
      return registerSuccess();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_Authenticated value) authenticated,
    required TResult Function(_Unauthenticated value) unauthenticated,
    required TResult Function(_VerificationRequired value) verificationRequired,
    required TResult Function(_RegisterSuccess value) registerSuccess,
    required TResult Function(_Failure value) failure,
    required TResult Function(_UnverifiedFailure value) unverifiedFailure,
  }) {
    return registerSuccess(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Authenticated value)? authenticated,
    TResult? Function(_Unauthenticated value)? unauthenticated,
    TResult? Function(_VerificationRequired value)? verificationRequired,
    TResult? Function(_RegisterSuccess value)? registerSuccess,
    TResult? Function(_Failure value)? failure,
    TResult? Function(_UnverifiedFailure value)? unverifiedFailure,
  }) {
    return registerSuccess?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_Authenticated value)? authenticated,
    TResult Function(_Unauthenticated value)? unauthenticated,
    TResult Function(_VerificationRequired value)? verificationRequired,
    TResult Function(_RegisterSuccess value)? registerSuccess,
    TResult Function(_Failure value)? failure,
    TResult Function(_UnverifiedFailure value)? unverifiedFailure,
    required TResult orElse(),
  }) {
    if (registerSuccess != null) {
      return registerSuccess(this);
    }
    return orElse();
  }
}

abstract class _RegisterSuccess implements AuthState {
  const factory _RegisterSuccess() = _$RegisterSuccessImpl;
}

/// @nodoc
abstract class _$$FailureImplCopyWith<$Res> {
  factory _$$FailureImplCopyWith(
    _$FailureImpl value,
    $Res Function(_$FailureImpl) then,
  ) = __$$FailureImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String message});
}

/// @nodoc
class __$$FailureImplCopyWithImpl<$Res>
    extends _$AuthStateCopyWithImpl<$Res, _$FailureImpl>
    implements _$$FailureImplCopyWith<$Res> {
  __$$FailureImplCopyWithImpl(
    _$FailureImpl _value,
    $Res Function(_$FailureImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AuthState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? message = null}) {
    return _then(
      _$FailureImpl(
        null == message
            ? _value.message
            : message // ignore: cast_nullable_to_non_nullable
                as String,
      ),
    );
  }
}

/// @nodoc

class _$FailureImpl implements _Failure {
  const _$FailureImpl(this.message);

  @override
  final String message;

  @override
  String toString() {
    return 'AuthState.failure(message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FailureImpl &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  /// Create a copy of AuthState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$FailureImplCopyWith<_$FailureImpl> get copyWith =>
      __$$FailureImplCopyWithImpl<_$FailureImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(User user) authenticated,
    required TResult Function() unauthenticated,
    required TResult Function(String email) verificationRequired,
    required TResult Function() registerSuccess,
    required TResult Function(String message) failure,
    required TResult Function(String message, String email, bool isExpired)
    unverifiedFailure,
  }) {
    return failure(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(User user)? authenticated,
    TResult? Function()? unauthenticated,
    TResult? Function(String email)? verificationRequired,
    TResult? Function()? registerSuccess,
    TResult? Function(String message)? failure,
    TResult? Function(String message, String email, bool isExpired)?
    unverifiedFailure,
  }) {
    return failure?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(User user)? authenticated,
    TResult Function()? unauthenticated,
    TResult Function(String email)? verificationRequired,
    TResult Function()? registerSuccess,
    TResult Function(String message)? failure,
    TResult Function(String message, String email, bool isExpired)?
    unverifiedFailure,
    required TResult orElse(),
  }) {
    if (failure != null) {
      return failure(message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_Authenticated value) authenticated,
    required TResult Function(_Unauthenticated value) unauthenticated,
    required TResult Function(_VerificationRequired value) verificationRequired,
    required TResult Function(_RegisterSuccess value) registerSuccess,
    required TResult Function(_Failure value) failure,
    required TResult Function(_UnverifiedFailure value) unverifiedFailure,
  }) {
    return failure(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Authenticated value)? authenticated,
    TResult? Function(_Unauthenticated value)? unauthenticated,
    TResult? Function(_VerificationRequired value)? verificationRequired,
    TResult? Function(_RegisterSuccess value)? registerSuccess,
    TResult? Function(_Failure value)? failure,
    TResult? Function(_UnverifiedFailure value)? unverifiedFailure,
  }) {
    return failure?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_Authenticated value)? authenticated,
    TResult Function(_Unauthenticated value)? unauthenticated,
    TResult Function(_VerificationRequired value)? verificationRequired,
    TResult Function(_RegisterSuccess value)? registerSuccess,
    TResult Function(_Failure value)? failure,
    TResult Function(_UnverifiedFailure value)? unverifiedFailure,
    required TResult orElse(),
  }) {
    if (failure != null) {
      return failure(this);
    }
    return orElse();
  }
}

abstract class _Failure implements AuthState {
  const factory _Failure(final String message) = _$FailureImpl;

  String get message;

  /// Create a copy of AuthState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$FailureImplCopyWith<_$FailureImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$UnverifiedFailureImplCopyWith<$Res> {
  factory _$$UnverifiedFailureImplCopyWith(
    _$UnverifiedFailureImpl value,
    $Res Function(_$UnverifiedFailureImpl) then,
  ) = __$$UnverifiedFailureImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String message, String email, bool isExpired});
}

/// @nodoc
class __$$UnverifiedFailureImplCopyWithImpl<$Res>
    extends _$AuthStateCopyWithImpl<$Res, _$UnverifiedFailureImpl>
    implements _$$UnverifiedFailureImplCopyWith<$Res> {
  __$$UnverifiedFailureImplCopyWithImpl(
    _$UnverifiedFailureImpl _value,
    $Res Function(_$UnverifiedFailureImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AuthState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
    Object? email = null,
    Object? isExpired = null,
  }) {
    return _then(
      _$UnverifiedFailureImpl(
        message:
            null == message
                ? _value.message
                : message // ignore: cast_nullable_to_non_nullable
                    as String,
        email:
            null == email
                ? _value.email
                : email // ignore: cast_nullable_to_non_nullable
                    as String,
        isExpired:
            null == isExpired
                ? _value.isExpired
                : isExpired // ignore: cast_nullable_to_non_nullable
                    as bool,
      ),
    );
  }
}

/// @nodoc

class _$UnverifiedFailureImpl implements _UnverifiedFailure {
  const _$UnverifiedFailureImpl({
    required this.message,
    required this.email,
    this.isExpired = false,
  });

  @override
  final String message;
  @override
  final String email;
  @override
  @JsonKey()
  final bool isExpired;

  @override
  String toString() {
    return 'AuthState.unverifiedFailure(message: $message, email: $email, isExpired: $isExpired)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UnverifiedFailureImpl &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.isExpired, isExpired) ||
                other.isExpired == isExpired));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message, email, isExpired);

  /// Create a copy of AuthState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UnverifiedFailureImplCopyWith<_$UnverifiedFailureImpl> get copyWith =>
      __$$UnverifiedFailureImplCopyWithImpl<_$UnverifiedFailureImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(User user) authenticated,
    required TResult Function() unauthenticated,
    required TResult Function(String email) verificationRequired,
    required TResult Function() registerSuccess,
    required TResult Function(String message) failure,
    required TResult Function(String message, String email, bool isExpired)
    unverifiedFailure,
  }) {
    return unverifiedFailure(message, email, isExpired);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(User user)? authenticated,
    TResult? Function()? unauthenticated,
    TResult? Function(String email)? verificationRequired,
    TResult? Function()? registerSuccess,
    TResult? Function(String message)? failure,
    TResult? Function(String message, String email, bool isExpired)?
    unverifiedFailure,
  }) {
    return unverifiedFailure?.call(message, email, isExpired);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(User user)? authenticated,
    TResult Function()? unauthenticated,
    TResult Function(String email)? verificationRequired,
    TResult Function()? registerSuccess,
    TResult Function(String message)? failure,
    TResult Function(String message, String email, bool isExpired)?
    unverifiedFailure,
    required TResult orElse(),
  }) {
    if (unverifiedFailure != null) {
      return unverifiedFailure(message, email, isExpired);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_Authenticated value) authenticated,
    required TResult Function(_Unauthenticated value) unauthenticated,
    required TResult Function(_VerificationRequired value) verificationRequired,
    required TResult Function(_RegisterSuccess value) registerSuccess,
    required TResult Function(_Failure value) failure,
    required TResult Function(_UnverifiedFailure value) unverifiedFailure,
  }) {
    return unverifiedFailure(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Authenticated value)? authenticated,
    TResult? Function(_Unauthenticated value)? unauthenticated,
    TResult? Function(_VerificationRequired value)? verificationRequired,
    TResult? Function(_RegisterSuccess value)? registerSuccess,
    TResult? Function(_Failure value)? failure,
    TResult? Function(_UnverifiedFailure value)? unverifiedFailure,
  }) {
    return unverifiedFailure?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_Authenticated value)? authenticated,
    TResult Function(_Unauthenticated value)? unauthenticated,
    TResult Function(_VerificationRequired value)? verificationRequired,
    TResult Function(_RegisterSuccess value)? registerSuccess,
    TResult Function(_Failure value)? failure,
    TResult Function(_UnverifiedFailure value)? unverifiedFailure,
    required TResult orElse(),
  }) {
    if (unverifiedFailure != null) {
      return unverifiedFailure(this);
    }
    return orElse();
  }
}

abstract class _UnverifiedFailure implements AuthState {
  const factory _UnverifiedFailure({
    required final String message,
    required final String email,
    final bool isExpired,
  }) = _$UnverifiedFailureImpl;

  String get message;
  String get email;
  bool get isExpired;

  /// Create a copy of AuthState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UnverifiedFailureImplCopyWith<_$UnverifiedFailureImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
