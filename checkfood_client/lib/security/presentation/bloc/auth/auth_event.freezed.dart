// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'auth_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$AuthEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() appStarted,
    required TResult Function(LoginParams params) loginRequested,
    required TResult Function(RegisterParams params) registerRequested,
    required TResult Function(RegisterParams params) registerOwnerRequested,
    required TResult Function(String token) verifyEmailRequested,
    required TResult Function(String email) resendCodeRequested,
    required TResult Function() googleLoginRequested,
    required TResult Function() appleLoginRequested,
    required TResult Function() logoutRequested,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? appStarted,
    TResult? Function(LoginParams params)? loginRequested,
    TResult? Function(RegisterParams params)? registerRequested,
    TResult? Function(RegisterParams params)? registerOwnerRequested,
    TResult? Function(String token)? verifyEmailRequested,
    TResult? Function(String email)? resendCodeRequested,
    TResult? Function()? googleLoginRequested,
    TResult? Function()? appleLoginRequested,
    TResult? Function()? logoutRequested,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? appStarted,
    TResult Function(LoginParams params)? loginRequested,
    TResult Function(RegisterParams params)? registerRequested,
    TResult Function(RegisterParams params)? registerOwnerRequested,
    TResult Function(String token)? verifyEmailRequested,
    TResult Function(String email)? resendCodeRequested,
    TResult Function()? googleLoginRequested,
    TResult Function()? appleLoginRequested,
    TResult Function()? logoutRequested,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AppStarted value) appStarted,
    required TResult Function(LoginRequested value) loginRequested,
    required TResult Function(RegisterRequested value) registerRequested,
    required TResult Function(RegisterOwnerRequested value)
    registerOwnerRequested,
    required TResult Function(VerifyEmailRequested value) verifyEmailRequested,
    required TResult Function(ResendCodeRequested value) resendCodeRequested,
    required TResult Function(GoogleLoginRequested value) googleLoginRequested,
    required TResult Function(AppleLoginRequested value) appleLoginRequested,
    required TResult Function(LogoutRequested value) logoutRequested,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AppStarted value)? appStarted,
    TResult? Function(LoginRequested value)? loginRequested,
    TResult? Function(RegisterRequested value)? registerRequested,
    TResult? Function(RegisterOwnerRequested value)? registerOwnerRequested,
    TResult? Function(VerifyEmailRequested value)? verifyEmailRequested,
    TResult? Function(ResendCodeRequested value)? resendCodeRequested,
    TResult? Function(GoogleLoginRequested value)? googleLoginRequested,
    TResult? Function(AppleLoginRequested value)? appleLoginRequested,
    TResult? Function(LogoutRequested value)? logoutRequested,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AppStarted value)? appStarted,
    TResult Function(LoginRequested value)? loginRequested,
    TResult Function(RegisterRequested value)? registerRequested,
    TResult Function(RegisterOwnerRequested value)? registerOwnerRequested,
    TResult Function(VerifyEmailRequested value)? verifyEmailRequested,
    TResult Function(ResendCodeRequested value)? resendCodeRequested,
    TResult Function(GoogleLoginRequested value)? googleLoginRequested,
    TResult Function(AppleLoginRequested value)? appleLoginRequested,
    TResult Function(LogoutRequested value)? logoutRequested,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AuthEventCopyWith<$Res> {
  factory $AuthEventCopyWith(AuthEvent value, $Res Function(AuthEvent) then) =
      _$AuthEventCopyWithImpl<$Res, AuthEvent>;
}

/// @nodoc
class _$AuthEventCopyWithImpl<$Res, $Val extends AuthEvent>
    implements $AuthEventCopyWith<$Res> {
  _$AuthEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AuthEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$AppStartedImplCopyWith<$Res> {
  factory _$$AppStartedImplCopyWith(
    _$AppStartedImpl value,
    $Res Function(_$AppStartedImpl) then,
  ) = __$$AppStartedImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$AppStartedImplCopyWithImpl<$Res>
    extends _$AuthEventCopyWithImpl<$Res, _$AppStartedImpl>
    implements _$$AppStartedImplCopyWith<$Res> {
  __$$AppStartedImplCopyWithImpl(
    _$AppStartedImpl _value,
    $Res Function(_$AppStartedImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AuthEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$AppStartedImpl implements AppStarted {
  const _$AppStartedImpl();

  @override
  String toString() {
    return 'AuthEvent.appStarted()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$AppStartedImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() appStarted,
    required TResult Function(LoginParams params) loginRequested,
    required TResult Function(RegisterParams params) registerRequested,
    required TResult Function(RegisterParams params) registerOwnerRequested,
    required TResult Function(String token) verifyEmailRequested,
    required TResult Function(String email) resendCodeRequested,
    required TResult Function() googleLoginRequested,
    required TResult Function() appleLoginRequested,
    required TResult Function() logoutRequested,
  }) {
    return appStarted();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? appStarted,
    TResult? Function(LoginParams params)? loginRequested,
    TResult? Function(RegisterParams params)? registerRequested,
    TResult? Function(RegisterParams params)? registerOwnerRequested,
    TResult? Function(String token)? verifyEmailRequested,
    TResult? Function(String email)? resendCodeRequested,
    TResult? Function()? googleLoginRequested,
    TResult? Function()? appleLoginRequested,
    TResult? Function()? logoutRequested,
  }) {
    return appStarted?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? appStarted,
    TResult Function(LoginParams params)? loginRequested,
    TResult Function(RegisterParams params)? registerRequested,
    TResult Function(RegisterParams params)? registerOwnerRequested,
    TResult Function(String token)? verifyEmailRequested,
    TResult Function(String email)? resendCodeRequested,
    TResult Function()? googleLoginRequested,
    TResult Function()? appleLoginRequested,
    TResult Function()? logoutRequested,
    required TResult orElse(),
  }) {
    if (appStarted != null) {
      return appStarted();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AppStarted value) appStarted,
    required TResult Function(LoginRequested value) loginRequested,
    required TResult Function(RegisterRequested value) registerRequested,
    required TResult Function(RegisterOwnerRequested value)
    registerOwnerRequested,
    required TResult Function(VerifyEmailRequested value) verifyEmailRequested,
    required TResult Function(ResendCodeRequested value) resendCodeRequested,
    required TResult Function(GoogleLoginRequested value) googleLoginRequested,
    required TResult Function(AppleLoginRequested value) appleLoginRequested,
    required TResult Function(LogoutRequested value) logoutRequested,
  }) {
    return appStarted(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AppStarted value)? appStarted,
    TResult? Function(LoginRequested value)? loginRequested,
    TResult? Function(RegisterRequested value)? registerRequested,
    TResult? Function(RegisterOwnerRequested value)? registerOwnerRequested,
    TResult? Function(VerifyEmailRequested value)? verifyEmailRequested,
    TResult? Function(ResendCodeRequested value)? resendCodeRequested,
    TResult? Function(GoogleLoginRequested value)? googleLoginRequested,
    TResult? Function(AppleLoginRequested value)? appleLoginRequested,
    TResult? Function(LogoutRequested value)? logoutRequested,
  }) {
    return appStarted?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AppStarted value)? appStarted,
    TResult Function(LoginRequested value)? loginRequested,
    TResult Function(RegisterRequested value)? registerRequested,
    TResult Function(RegisterOwnerRequested value)? registerOwnerRequested,
    TResult Function(VerifyEmailRequested value)? verifyEmailRequested,
    TResult Function(ResendCodeRequested value)? resendCodeRequested,
    TResult Function(GoogleLoginRequested value)? googleLoginRequested,
    TResult Function(AppleLoginRequested value)? appleLoginRequested,
    TResult Function(LogoutRequested value)? logoutRequested,
    required TResult orElse(),
  }) {
    if (appStarted != null) {
      return appStarted(this);
    }
    return orElse();
  }
}

abstract class AppStarted implements AuthEvent {
  const factory AppStarted() = _$AppStartedImpl;
}

/// @nodoc
abstract class _$$LoginRequestedImplCopyWith<$Res> {
  factory _$$LoginRequestedImplCopyWith(
    _$LoginRequestedImpl value,
    $Res Function(_$LoginRequestedImpl) then,
  ) = __$$LoginRequestedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({LoginParams params});
}

/// @nodoc
class __$$LoginRequestedImplCopyWithImpl<$Res>
    extends _$AuthEventCopyWithImpl<$Res, _$LoginRequestedImpl>
    implements _$$LoginRequestedImplCopyWith<$Res> {
  __$$LoginRequestedImplCopyWithImpl(
    _$LoginRequestedImpl _value,
    $Res Function(_$LoginRequestedImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AuthEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? params = null}) {
    return _then(
      _$LoginRequestedImpl(
        null == params
            ? _value.params
            : params // ignore: cast_nullable_to_non_nullable
                as LoginParams,
      ),
    );
  }
}

/// @nodoc

class _$LoginRequestedImpl implements LoginRequested {
  const _$LoginRequestedImpl(this.params);

  @override
  final LoginParams params;

  @override
  String toString() {
    return 'AuthEvent.loginRequested(params: $params)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoginRequestedImpl &&
            (identical(other.params, params) || other.params == params));
  }

  @override
  int get hashCode => Object.hash(runtimeType, params);

  /// Create a copy of AuthEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LoginRequestedImplCopyWith<_$LoginRequestedImpl> get copyWith =>
      __$$LoginRequestedImplCopyWithImpl<_$LoginRequestedImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() appStarted,
    required TResult Function(LoginParams params) loginRequested,
    required TResult Function(RegisterParams params) registerRequested,
    required TResult Function(RegisterParams params) registerOwnerRequested,
    required TResult Function(String token) verifyEmailRequested,
    required TResult Function(String email) resendCodeRequested,
    required TResult Function() googleLoginRequested,
    required TResult Function() appleLoginRequested,
    required TResult Function() logoutRequested,
  }) {
    return loginRequested(params);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? appStarted,
    TResult? Function(LoginParams params)? loginRequested,
    TResult? Function(RegisterParams params)? registerRequested,
    TResult? Function(RegisterParams params)? registerOwnerRequested,
    TResult? Function(String token)? verifyEmailRequested,
    TResult? Function(String email)? resendCodeRequested,
    TResult? Function()? googleLoginRequested,
    TResult? Function()? appleLoginRequested,
    TResult? Function()? logoutRequested,
  }) {
    return loginRequested?.call(params);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? appStarted,
    TResult Function(LoginParams params)? loginRequested,
    TResult Function(RegisterParams params)? registerRequested,
    TResult Function(RegisterParams params)? registerOwnerRequested,
    TResult Function(String token)? verifyEmailRequested,
    TResult Function(String email)? resendCodeRequested,
    TResult Function()? googleLoginRequested,
    TResult Function()? appleLoginRequested,
    TResult Function()? logoutRequested,
    required TResult orElse(),
  }) {
    if (loginRequested != null) {
      return loginRequested(params);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AppStarted value) appStarted,
    required TResult Function(LoginRequested value) loginRequested,
    required TResult Function(RegisterRequested value) registerRequested,
    required TResult Function(RegisterOwnerRequested value)
    registerOwnerRequested,
    required TResult Function(VerifyEmailRequested value) verifyEmailRequested,
    required TResult Function(ResendCodeRequested value) resendCodeRequested,
    required TResult Function(GoogleLoginRequested value) googleLoginRequested,
    required TResult Function(AppleLoginRequested value) appleLoginRequested,
    required TResult Function(LogoutRequested value) logoutRequested,
  }) {
    return loginRequested(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AppStarted value)? appStarted,
    TResult? Function(LoginRequested value)? loginRequested,
    TResult? Function(RegisterRequested value)? registerRequested,
    TResult? Function(RegisterOwnerRequested value)? registerOwnerRequested,
    TResult? Function(VerifyEmailRequested value)? verifyEmailRequested,
    TResult? Function(ResendCodeRequested value)? resendCodeRequested,
    TResult? Function(GoogleLoginRequested value)? googleLoginRequested,
    TResult? Function(AppleLoginRequested value)? appleLoginRequested,
    TResult? Function(LogoutRequested value)? logoutRequested,
  }) {
    return loginRequested?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AppStarted value)? appStarted,
    TResult Function(LoginRequested value)? loginRequested,
    TResult Function(RegisterRequested value)? registerRequested,
    TResult Function(RegisterOwnerRequested value)? registerOwnerRequested,
    TResult Function(VerifyEmailRequested value)? verifyEmailRequested,
    TResult Function(ResendCodeRequested value)? resendCodeRequested,
    TResult Function(GoogleLoginRequested value)? googleLoginRequested,
    TResult Function(AppleLoginRequested value)? appleLoginRequested,
    TResult Function(LogoutRequested value)? logoutRequested,
    required TResult orElse(),
  }) {
    if (loginRequested != null) {
      return loginRequested(this);
    }
    return orElse();
  }
}

abstract class LoginRequested implements AuthEvent {
  const factory LoginRequested(final LoginParams params) = _$LoginRequestedImpl;

  LoginParams get params;

  /// Create a copy of AuthEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LoginRequestedImplCopyWith<_$LoginRequestedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$RegisterRequestedImplCopyWith<$Res> {
  factory _$$RegisterRequestedImplCopyWith(
    _$RegisterRequestedImpl value,
    $Res Function(_$RegisterRequestedImpl) then,
  ) = __$$RegisterRequestedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({RegisterParams params});
}

/// @nodoc
class __$$RegisterRequestedImplCopyWithImpl<$Res>
    extends _$AuthEventCopyWithImpl<$Res, _$RegisterRequestedImpl>
    implements _$$RegisterRequestedImplCopyWith<$Res> {
  __$$RegisterRequestedImplCopyWithImpl(
    _$RegisterRequestedImpl _value,
    $Res Function(_$RegisterRequestedImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AuthEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? params = null}) {
    return _then(
      _$RegisterRequestedImpl(
        null == params
            ? _value.params
            : params // ignore: cast_nullable_to_non_nullable
                as RegisterParams,
      ),
    );
  }
}

/// @nodoc

class _$RegisterRequestedImpl implements RegisterRequested {
  const _$RegisterRequestedImpl(this.params);

  @override
  final RegisterParams params;

  @override
  String toString() {
    return 'AuthEvent.registerRequested(params: $params)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RegisterRequestedImpl &&
            (identical(other.params, params) || other.params == params));
  }

  @override
  int get hashCode => Object.hash(runtimeType, params);

  /// Create a copy of AuthEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$RegisterRequestedImplCopyWith<_$RegisterRequestedImpl> get copyWith =>
      __$$RegisterRequestedImplCopyWithImpl<_$RegisterRequestedImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() appStarted,
    required TResult Function(LoginParams params) loginRequested,
    required TResult Function(RegisterParams params) registerRequested,
    required TResult Function(RegisterParams params) registerOwnerRequested,
    required TResult Function(String token) verifyEmailRequested,
    required TResult Function(String email) resendCodeRequested,
    required TResult Function() googleLoginRequested,
    required TResult Function() appleLoginRequested,
    required TResult Function() logoutRequested,
  }) {
    return registerRequested(params);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? appStarted,
    TResult? Function(LoginParams params)? loginRequested,
    TResult? Function(RegisterParams params)? registerRequested,
    TResult? Function(RegisterParams params)? registerOwnerRequested,
    TResult? Function(String token)? verifyEmailRequested,
    TResult? Function(String email)? resendCodeRequested,
    TResult? Function()? googleLoginRequested,
    TResult? Function()? appleLoginRequested,
    TResult? Function()? logoutRequested,
  }) {
    return registerRequested?.call(params);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? appStarted,
    TResult Function(LoginParams params)? loginRequested,
    TResult Function(RegisterParams params)? registerRequested,
    TResult Function(RegisterParams params)? registerOwnerRequested,
    TResult Function(String token)? verifyEmailRequested,
    TResult Function(String email)? resendCodeRequested,
    TResult Function()? googleLoginRequested,
    TResult Function()? appleLoginRequested,
    TResult Function()? logoutRequested,
    required TResult orElse(),
  }) {
    if (registerRequested != null) {
      return registerRequested(params);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AppStarted value) appStarted,
    required TResult Function(LoginRequested value) loginRequested,
    required TResult Function(RegisterRequested value) registerRequested,
    required TResult Function(RegisterOwnerRequested value)
    registerOwnerRequested,
    required TResult Function(VerifyEmailRequested value) verifyEmailRequested,
    required TResult Function(ResendCodeRequested value) resendCodeRequested,
    required TResult Function(GoogleLoginRequested value) googleLoginRequested,
    required TResult Function(AppleLoginRequested value) appleLoginRequested,
    required TResult Function(LogoutRequested value) logoutRequested,
  }) {
    return registerRequested(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AppStarted value)? appStarted,
    TResult? Function(LoginRequested value)? loginRequested,
    TResult? Function(RegisterRequested value)? registerRequested,
    TResult? Function(RegisterOwnerRequested value)? registerOwnerRequested,
    TResult? Function(VerifyEmailRequested value)? verifyEmailRequested,
    TResult? Function(ResendCodeRequested value)? resendCodeRequested,
    TResult? Function(GoogleLoginRequested value)? googleLoginRequested,
    TResult? Function(AppleLoginRequested value)? appleLoginRequested,
    TResult? Function(LogoutRequested value)? logoutRequested,
  }) {
    return registerRequested?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AppStarted value)? appStarted,
    TResult Function(LoginRequested value)? loginRequested,
    TResult Function(RegisterRequested value)? registerRequested,
    TResult Function(RegisterOwnerRequested value)? registerOwnerRequested,
    TResult Function(VerifyEmailRequested value)? verifyEmailRequested,
    TResult Function(ResendCodeRequested value)? resendCodeRequested,
    TResult Function(GoogleLoginRequested value)? googleLoginRequested,
    TResult Function(AppleLoginRequested value)? appleLoginRequested,
    TResult Function(LogoutRequested value)? logoutRequested,
    required TResult orElse(),
  }) {
    if (registerRequested != null) {
      return registerRequested(this);
    }
    return orElse();
  }
}

abstract class RegisterRequested implements AuthEvent {
  const factory RegisterRequested(final RegisterParams params) =
      _$RegisterRequestedImpl;

  RegisterParams get params;

  /// Create a copy of AuthEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RegisterRequestedImplCopyWith<_$RegisterRequestedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$RegisterOwnerRequestedImplCopyWith<$Res> {
  factory _$$RegisterOwnerRequestedImplCopyWith(
    _$RegisterOwnerRequestedImpl value,
    $Res Function(_$RegisterOwnerRequestedImpl) then,
  ) = __$$RegisterOwnerRequestedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({RegisterParams params});
}

/// @nodoc
class __$$RegisterOwnerRequestedImplCopyWithImpl<$Res>
    extends _$AuthEventCopyWithImpl<$Res, _$RegisterOwnerRequestedImpl>
    implements _$$RegisterOwnerRequestedImplCopyWith<$Res> {
  __$$RegisterOwnerRequestedImplCopyWithImpl(
    _$RegisterOwnerRequestedImpl _value,
    $Res Function(_$RegisterOwnerRequestedImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AuthEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? params = null}) {
    return _then(
      _$RegisterOwnerRequestedImpl(
        null == params
            ? _value.params
            : params // ignore: cast_nullable_to_non_nullable
                as RegisterParams,
      ),
    );
  }
}

/// @nodoc

class _$RegisterOwnerRequestedImpl implements RegisterOwnerRequested {
  const _$RegisterOwnerRequestedImpl(this.params);

  @override
  final RegisterParams params;

  @override
  String toString() {
    return 'AuthEvent.registerOwnerRequested(params: $params)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RegisterOwnerRequestedImpl &&
            (identical(other.params, params) || other.params == params));
  }

  @override
  int get hashCode => Object.hash(runtimeType, params);

  /// Create a copy of AuthEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$RegisterOwnerRequestedImplCopyWith<_$RegisterOwnerRequestedImpl>
  get copyWith =>
      __$$RegisterOwnerRequestedImplCopyWithImpl<_$RegisterOwnerRequestedImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() appStarted,
    required TResult Function(LoginParams params) loginRequested,
    required TResult Function(RegisterParams params) registerRequested,
    required TResult Function(RegisterParams params) registerOwnerRequested,
    required TResult Function(String token) verifyEmailRequested,
    required TResult Function(String email) resendCodeRequested,
    required TResult Function() googleLoginRequested,
    required TResult Function() appleLoginRequested,
    required TResult Function() logoutRequested,
  }) {
    return registerOwnerRequested(params);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? appStarted,
    TResult? Function(LoginParams params)? loginRequested,
    TResult? Function(RegisterParams params)? registerRequested,
    TResult? Function(RegisterParams params)? registerOwnerRequested,
    TResult? Function(String token)? verifyEmailRequested,
    TResult? Function(String email)? resendCodeRequested,
    TResult? Function()? googleLoginRequested,
    TResult? Function()? appleLoginRequested,
    TResult? Function()? logoutRequested,
  }) {
    return registerOwnerRequested?.call(params);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? appStarted,
    TResult Function(LoginParams params)? loginRequested,
    TResult Function(RegisterParams params)? registerRequested,
    TResult Function(RegisterParams params)? registerOwnerRequested,
    TResult Function(String token)? verifyEmailRequested,
    TResult Function(String email)? resendCodeRequested,
    TResult Function()? googleLoginRequested,
    TResult Function()? appleLoginRequested,
    TResult Function()? logoutRequested,
    required TResult orElse(),
  }) {
    if (registerOwnerRequested != null) {
      return registerOwnerRequested(params);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AppStarted value) appStarted,
    required TResult Function(LoginRequested value) loginRequested,
    required TResult Function(RegisterRequested value) registerRequested,
    required TResult Function(RegisterOwnerRequested value)
    registerOwnerRequested,
    required TResult Function(VerifyEmailRequested value) verifyEmailRequested,
    required TResult Function(ResendCodeRequested value) resendCodeRequested,
    required TResult Function(GoogleLoginRequested value) googleLoginRequested,
    required TResult Function(AppleLoginRequested value) appleLoginRequested,
    required TResult Function(LogoutRequested value) logoutRequested,
  }) {
    return registerOwnerRequested(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AppStarted value)? appStarted,
    TResult? Function(LoginRequested value)? loginRequested,
    TResult? Function(RegisterRequested value)? registerRequested,
    TResult? Function(RegisterOwnerRequested value)? registerOwnerRequested,
    TResult? Function(VerifyEmailRequested value)? verifyEmailRequested,
    TResult? Function(ResendCodeRequested value)? resendCodeRequested,
    TResult? Function(GoogleLoginRequested value)? googleLoginRequested,
    TResult? Function(AppleLoginRequested value)? appleLoginRequested,
    TResult? Function(LogoutRequested value)? logoutRequested,
  }) {
    return registerOwnerRequested?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AppStarted value)? appStarted,
    TResult Function(LoginRequested value)? loginRequested,
    TResult Function(RegisterRequested value)? registerRequested,
    TResult Function(RegisterOwnerRequested value)? registerOwnerRequested,
    TResult Function(VerifyEmailRequested value)? verifyEmailRequested,
    TResult Function(ResendCodeRequested value)? resendCodeRequested,
    TResult Function(GoogleLoginRequested value)? googleLoginRequested,
    TResult Function(AppleLoginRequested value)? appleLoginRequested,
    TResult Function(LogoutRequested value)? logoutRequested,
    required TResult orElse(),
  }) {
    if (registerOwnerRequested != null) {
      return registerOwnerRequested(this);
    }
    return orElse();
  }
}

abstract class RegisterOwnerRequested implements AuthEvent {
  const factory RegisterOwnerRequested(final RegisterParams params) =
      _$RegisterOwnerRequestedImpl;

  RegisterParams get params;

  /// Create a copy of AuthEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RegisterOwnerRequestedImplCopyWith<_$RegisterOwnerRequestedImpl>
  get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$VerifyEmailRequestedImplCopyWith<$Res> {
  factory _$$VerifyEmailRequestedImplCopyWith(
    _$VerifyEmailRequestedImpl value,
    $Res Function(_$VerifyEmailRequestedImpl) then,
  ) = __$$VerifyEmailRequestedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String token});
}

/// @nodoc
class __$$VerifyEmailRequestedImplCopyWithImpl<$Res>
    extends _$AuthEventCopyWithImpl<$Res, _$VerifyEmailRequestedImpl>
    implements _$$VerifyEmailRequestedImplCopyWith<$Res> {
  __$$VerifyEmailRequestedImplCopyWithImpl(
    _$VerifyEmailRequestedImpl _value,
    $Res Function(_$VerifyEmailRequestedImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AuthEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? token = null}) {
    return _then(
      _$VerifyEmailRequestedImpl(
        token:
            null == token
                ? _value.token
                : token // ignore: cast_nullable_to_non_nullable
                    as String,
      ),
    );
  }
}

/// @nodoc

class _$VerifyEmailRequestedImpl implements VerifyEmailRequested {
  const _$VerifyEmailRequestedImpl({required this.token});

  @override
  final String token;

  @override
  String toString() {
    return 'AuthEvent.verifyEmailRequested(token: $token)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$VerifyEmailRequestedImpl &&
            (identical(other.token, token) || other.token == token));
  }

  @override
  int get hashCode => Object.hash(runtimeType, token);

  /// Create a copy of AuthEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$VerifyEmailRequestedImplCopyWith<_$VerifyEmailRequestedImpl>
  get copyWith =>
      __$$VerifyEmailRequestedImplCopyWithImpl<_$VerifyEmailRequestedImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() appStarted,
    required TResult Function(LoginParams params) loginRequested,
    required TResult Function(RegisterParams params) registerRequested,
    required TResult Function(RegisterParams params) registerOwnerRequested,
    required TResult Function(String token) verifyEmailRequested,
    required TResult Function(String email) resendCodeRequested,
    required TResult Function() googleLoginRequested,
    required TResult Function() appleLoginRequested,
    required TResult Function() logoutRequested,
  }) {
    return verifyEmailRequested(token);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? appStarted,
    TResult? Function(LoginParams params)? loginRequested,
    TResult? Function(RegisterParams params)? registerRequested,
    TResult? Function(RegisterParams params)? registerOwnerRequested,
    TResult? Function(String token)? verifyEmailRequested,
    TResult? Function(String email)? resendCodeRequested,
    TResult? Function()? googleLoginRequested,
    TResult? Function()? appleLoginRequested,
    TResult? Function()? logoutRequested,
  }) {
    return verifyEmailRequested?.call(token);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? appStarted,
    TResult Function(LoginParams params)? loginRequested,
    TResult Function(RegisterParams params)? registerRequested,
    TResult Function(RegisterParams params)? registerOwnerRequested,
    TResult Function(String token)? verifyEmailRequested,
    TResult Function(String email)? resendCodeRequested,
    TResult Function()? googleLoginRequested,
    TResult Function()? appleLoginRequested,
    TResult Function()? logoutRequested,
    required TResult orElse(),
  }) {
    if (verifyEmailRequested != null) {
      return verifyEmailRequested(token);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AppStarted value) appStarted,
    required TResult Function(LoginRequested value) loginRequested,
    required TResult Function(RegisterRequested value) registerRequested,
    required TResult Function(RegisterOwnerRequested value)
    registerOwnerRequested,
    required TResult Function(VerifyEmailRequested value) verifyEmailRequested,
    required TResult Function(ResendCodeRequested value) resendCodeRequested,
    required TResult Function(GoogleLoginRequested value) googleLoginRequested,
    required TResult Function(AppleLoginRequested value) appleLoginRequested,
    required TResult Function(LogoutRequested value) logoutRequested,
  }) {
    return verifyEmailRequested(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AppStarted value)? appStarted,
    TResult? Function(LoginRequested value)? loginRequested,
    TResult? Function(RegisterRequested value)? registerRequested,
    TResult? Function(RegisterOwnerRequested value)? registerOwnerRequested,
    TResult? Function(VerifyEmailRequested value)? verifyEmailRequested,
    TResult? Function(ResendCodeRequested value)? resendCodeRequested,
    TResult? Function(GoogleLoginRequested value)? googleLoginRequested,
    TResult? Function(AppleLoginRequested value)? appleLoginRequested,
    TResult? Function(LogoutRequested value)? logoutRequested,
  }) {
    return verifyEmailRequested?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AppStarted value)? appStarted,
    TResult Function(LoginRequested value)? loginRequested,
    TResult Function(RegisterRequested value)? registerRequested,
    TResult Function(RegisterOwnerRequested value)? registerOwnerRequested,
    TResult Function(VerifyEmailRequested value)? verifyEmailRequested,
    TResult Function(ResendCodeRequested value)? resendCodeRequested,
    TResult Function(GoogleLoginRequested value)? googleLoginRequested,
    TResult Function(AppleLoginRequested value)? appleLoginRequested,
    TResult Function(LogoutRequested value)? logoutRequested,
    required TResult orElse(),
  }) {
    if (verifyEmailRequested != null) {
      return verifyEmailRequested(this);
    }
    return orElse();
  }
}

abstract class VerifyEmailRequested implements AuthEvent {
  const factory VerifyEmailRequested({required final String token}) =
      _$VerifyEmailRequestedImpl;

  String get token;

  /// Create a copy of AuthEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$VerifyEmailRequestedImplCopyWith<_$VerifyEmailRequestedImpl>
  get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ResendCodeRequestedImplCopyWith<$Res> {
  factory _$$ResendCodeRequestedImplCopyWith(
    _$ResendCodeRequestedImpl value,
    $Res Function(_$ResendCodeRequestedImpl) then,
  ) = __$$ResendCodeRequestedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String email});
}

/// @nodoc
class __$$ResendCodeRequestedImplCopyWithImpl<$Res>
    extends _$AuthEventCopyWithImpl<$Res, _$ResendCodeRequestedImpl>
    implements _$$ResendCodeRequestedImplCopyWith<$Res> {
  __$$ResendCodeRequestedImplCopyWithImpl(
    _$ResendCodeRequestedImpl _value,
    $Res Function(_$ResendCodeRequestedImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AuthEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? email = null}) {
    return _then(
      _$ResendCodeRequestedImpl(
        email:
            null == email
                ? _value.email
                : email // ignore: cast_nullable_to_non_nullable
                    as String,
      ),
    );
  }
}

/// @nodoc

class _$ResendCodeRequestedImpl implements ResendCodeRequested {
  const _$ResendCodeRequestedImpl({required this.email});

  @override
  final String email;

  @override
  String toString() {
    return 'AuthEvent.resendCodeRequested(email: $email)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ResendCodeRequestedImpl &&
            (identical(other.email, email) || other.email == email));
  }

  @override
  int get hashCode => Object.hash(runtimeType, email);

  /// Create a copy of AuthEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ResendCodeRequestedImplCopyWith<_$ResendCodeRequestedImpl> get copyWith =>
      __$$ResendCodeRequestedImplCopyWithImpl<_$ResendCodeRequestedImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() appStarted,
    required TResult Function(LoginParams params) loginRequested,
    required TResult Function(RegisterParams params) registerRequested,
    required TResult Function(RegisterParams params) registerOwnerRequested,
    required TResult Function(String token) verifyEmailRequested,
    required TResult Function(String email) resendCodeRequested,
    required TResult Function() googleLoginRequested,
    required TResult Function() appleLoginRequested,
    required TResult Function() logoutRequested,
  }) {
    return resendCodeRequested(email);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? appStarted,
    TResult? Function(LoginParams params)? loginRequested,
    TResult? Function(RegisterParams params)? registerRequested,
    TResult? Function(RegisterParams params)? registerOwnerRequested,
    TResult? Function(String token)? verifyEmailRequested,
    TResult? Function(String email)? resendCodeRequested,
    TResult? Function()? googleLoginRequested,
    TResult? Function()? appleLoginRequested,
    TResult? Function()? logoutRequested,
  }) {
    return resendCodeRequested?.call(email);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? appStarted,
    TResult Function(LoginParams params)? loginRequested,
    TResult Function(RegisterParams params)? registerRequested,
    TResult Function(RegisterParams params)? registerOwnerRequested,
    TResult Function(String token)? verifyEmailRequested,
    TResult Function(String email)? resendCodeRequested,
    TResult Function()? googleLoginRequested,
    TResult Function()? appleLoginRequested,
    TResult Function()? logoutRequested,
    required TResult orElse(),
  }) {
    if (resendCodeRequested != null) {
      return resendCodeRequested(email);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AppStarted value) appStarted,
    required TResult Function(LoginRequested value) loginRequested,
    required TResult Function(RegisterRequested value) registerRequested,
    required TResult Function(RegisterOwnerRequested value)
    registerOwnerRequested,
    required TResult Function(VerifyEmailRequested value) verifyEmailRequested,
    required TResult Function(ResendCodeRequested value) resendCodeRequested,
    required TResult Function(GoogleLoginRequested value) googleLoginRequested,
    required TResult Function(AppleLoginRequested value) appleLoginRequested,
    required TResult Function(LogoutRequested value) logoutRequested,
  }) {
    return resendCodeRequested(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AppStarted value)? appStarted,
    TResult? Function(LoginRequested value)? loginRequested,
    TResult? Function(RegisterRequested value)? registerRequested,
    TResult? Function(RegisterOwnerRequested value)? registerOwnerRequested,
    TResult? Function(VerifyEmailRequested value)? verifyEmailRequested,
    TResult? Function(ResendCodeRequested value)? resendCodeRequested,
    TResult? Function(GoogleLoginRequested value)? googleLoginRequested,
    TResult? Function(AppleLoginRequested value)? appleLoginRequested,
    TResult? Function(LogoutRequested value)? logoutRequested,
  }) {
    return resendCodeRequested?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AppStarted value)? appStarted,
    TResult Function(LoginRequested value)? loginRequested,
    TResult Function(RegisterRequested value)? registerRequested,
    TResult Function(RegisterOwnerRequested value)? registerOwnerRequested,
    TResult Function(VerifyEmailRequested value)? verifyEmailRequested,
    TResult Function(ResendCodeRequested value)? resendCodeRequested,
    TResult Function(GoogleLoginRequested value)? googleLoginRequested,
    TResult Function(AppleLoginRequested value)? appleLoginRequested,
    TResult Function(LogoutRequested value)? logoutRequested,
    required TResult orElse(),
  }) {
    if (resendCodeRequested != null) {
      return resendCodeRequested(this);
    }
    return orElse();
  }
}

abstract class ResendCodeRequested implements AuthEvent {
  const factory ResendCodeRequested({required final String email}) =
      _$ResendCodeRequestedImpl;

  String get email;

  /// Create a copy of AuthEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ResendCodeRequestedImplCopyWith<_$ResendCodeRequestedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$GoogleLoginRequestedImplCopyWith<$Res> {
  factory _$$GoogleLoginRequestedImplCopyWith(
    _$GoogleLoginRequestedImpl value,
    $Res Function(_$GoogleLoginRequestedImpl) then,
  ) = __$$GoogleLoginRequestedImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$GoogleLoginRequestedImplCopyWithImpl<$Res>
    extends _$AuthEventCopyWithImpl<$Res, _$GoogleLoginRequestedImpl>
    implements _$$GoogleLoginRequestedImplCopyWith<$Res> {
  __$$GoogleLoginRequestedImplCopyWithImpl(
    _$GoogleLoginRequestedImpl _value,
    $Res Function(_$GoogleLoginRequestedImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AuthEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$GoogleLoginRequestedImpl implements GoogleLoginRequested {
  const _$GoogleLoginRequestedImpl();

  @override
  String toString() {
    return 'AuthEvent.googleLoginRequested()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GoogleLoginRequestedImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() appStarted,
    required TResult Function(LoginParams params) loginRequested,
    required TResult Function(RegisterParams params) registerRequested,
    required TResult Function(RegisterParams params) registerOwnerRequested,
    required TResult Function(String token) verifyEmailRequested,
    required TResult Function(String email) resendCodeRequested,
    required TResult Function() googleLoginRequested,
    required TResult Function() appleLoginRequested,
    required TResult Function() logoutRequested,
  }) {
    return googleLoginRequested();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? appStarted,
    TResult? Function(LoginParams params)? loginRequested,
    TResult? Function(RegisterParams params)? registerRequested,
    TResult? Function(RegisterParams params)? registerOwnerRequested,
    TResult? Function(String token)? verifyEmailRequested,
    TResult? Function(String email)? resendCodeRequested,
    TResult? Function()? googleLoginRequested,
    TResult? Function()? appleLoginRequested,
    TResult? Function()? logoutRequested,
  }) {
    return googleLoginRequested?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? appStarted,
    TResult Function(LoginParams params)? loginRequested,
    TResult Function(RegisterParams params)? registerRequested,
    TResult Function(RegisterParams params)? registerOwnerRequested,
    TResult Function(String token)? verifyEmailRequested,
    TResult Function(String email)? resendCodeRequested,
    TResult Function()? googleLoginRequested,
    TResult Function()? appleLoginRequested,
    TResult Function()? logoutRequested,
    required TResult orElse(),
  }) {
    if (googleLoginRequested != null) {
      return googleLoginRequested();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AppStarted value) appStarted,
    required TResult Function(LoginRequested value) loginRequested,
    required TResult Function(RegisterRequested value) registerRequested,
    required TResult Function(RegisterOwnerRequested value)
    registerOwnerRequested,
    required TResult Function(VerifyEmailRequested value) verifyEmailRequested,
    required TResult Function(ResendCodeRequested value) resendCodeRequested,
    required TResult Function(GoogleLoginRequested value) googleLoginRequested,
    required TResult Function(AppleLoginRequested value) appleLoginRequested,
    required TResult Function(LogoutRequested value) logoutRequested,
  }) {
    return googleLoginRequested(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AppStarted value)? appStarted,
    TResult? Function(LoginRequested value)? loginRequested,
    TResult? Function(RegisterRequested value)? registerRequested,
    TResult? Function(RegisterOwnerRequested value)? registerOwnerRequested,
    TResult? Function(VerifyEmailRequested value)? verifyEmailRequested,
    TResult? Function(ResendCodeRequested value)? resendCodeRequested,
    TResult? Function(GoogleLoginRequested value)? googleLoginRequested,
    TResult? Function(AppleLoginRequested value)? appleLoginRequested,
    TResult? Function(LogoutRequested value)? logoutRequested,
  }) {
    return googleLoginRequested?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AppStarted value)? appStarted,
    TResult Function(LoginRequested value)? loginRequested,
    TResult Function(RegisterRequested value)? registerRequested,
    TResult Function(RegisterOwnerRequested value)? registerOwnerRequested,
    TResult Function(VerifyEmailRequested value)? verifyEmailRequested,
    TResult Function(ResendCodeRequested value)? resendCodeRequested,
    TResult Function(GoogleLoginRequested value)? googleLoginRequested,
    TResult Function(AppleLoginRequested value)? appleLoginRequested,
    TResult Function(LogoutRequested value)? logoutRequested,
    required TResult orElse(),
  }) {
    if (googleLoginRequested != null) {
      return googleLoginRequested(this);
    }
    return orElse();
  }
}

abstract class GoogleLoginRequested implements AuthEvent {
  const factory GoogleLoginRequested() = _$GoogleLoginRequestedImpl;
}

/// @nodoc
abstract class _$$AppleLoginRequestedImplCopyWith<$Res> {
  factory _$$AppleLoginRequestedImplCopyWith(
    _$AppleLoginRequestedImpl value,
    $Res Function(_$AppleLoginRequestedImpl) then,
  ) = __$$AppleLoginRequestedImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$AppleLoginRequestedImplCopyWithImpl<$Res>
    extends _$AuthEventCopyWithImpl<$Res, _$AppleLoginRequestedImpl>
    implements _$$AppleLoginRequestedImplCopyWith<$Res> {
  __$$AppleLoginRequestedImplCopyWithImpl(
    _$AppleLoginRequestedImpl _value,
    $Res Function(_$AppleLoginRequestedImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AuthEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$AppleLoginRequestedImpl implements AppleLoginRequested {
  const _$AppleLoginRequestedImpl();

  @override
  String toString() {
    return 'AuthEvent.appleLoginRequested()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AppleLoginRequestedImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() appStarted,
    required TResult Function(LoginParams params) loginRequested,
    required TResult Function(RegisterParams params) registerRequested,
    required TResult Function(RegisterParams params) registerOwnerRequested,
    required TResult Function(String token) verifyEmailRequested,
    required TResult Function(String email) resendCodeRequested,
    required TResult Function() googleLoginRequested,
    required TResult Function() appleLoginRequested,
    required TResult Function() logoutRequested,
  }) {
    return appleLoginRequested();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? appStarted,
    TResult? Function(LoginParams params)? loginRequested,
    TResult? Function(RegisterParams params)? registerRequested,
    TResult? Function(RegisterParams params)? registerOwnerRequested,
    TResult? Function(String token)? verifyEmailRequested,
    TResult? Function(String email)? resendCodeRequested,
    TResult? Function()? googleLoginRequested,
    TResult? Function()? appleLoginRequested,
    TResult? Function()? logoutRequested,
  }) {
    return appleLoginRequested?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? appStarted,
    TResult Function(LoginParams params)? loginRequested,
    TResult Function(RegisterParams params)? registerRequested,
    TResult Function(RegisterParams params)? registerOwnerRequested,
    TResult Function(String token)? verifyEmailRequested,
    TResult Function(String email)? resendCodeRequested,
    TResult Function()? googleLoginRequested,
    TResult Function()? appleLoginRequested,
    TResult Function()? logoutRequested,
    required TResult orElse(),
  }) {
    if (appleLoginRequested != null) {
      return appleLoginRequested();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AppStarted value) appStarted,
    required TResult Function(LoginRequested value) loginRequested,
    required TResult Function(RegisterRequested value) registerRequested,
    required TResult Function(RegisterOwnerRequested value)
    registerOwnerRequested,
    required TResult Function(VerifyEmailRequested value) verifyEmailRequested,
    required TResult Function(ResendCodeRequested value) resendCodeRequested,
    required TResult Function(GoogleLoginRequested value) googleLoginRequested,
    required TResult Function(AppleLoginRequested value) appleLoginRequested,
    required TResult Function(LogoutRequested value) logoutRequested,
  }) {
    return appleLoginRequested(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AppStarted value)? appStarted,
    TResult? Function(LoginRequested value)? loginRequested,
    TResult? Function(RegisterRequested value)? registerRequested,
    TResult? Function(RegisterOwnerRequested value)? registerOwnerRequested,
    TResult? Function(VerifyEmailRequested value)? verifyEmailRequested,
    TResult? Function(ResendCodeRequested value)? resendCodeRequested,
    TResult? Function(GoogleLoginRequested value)? googleLoginRequested,
    TResult? Function(AppleLoginRequested value)? appleLoginRequested,
    TResult? Function(LogoutRequested value)? logoutRequested,
  }) {
    return appleLoginRequested?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AppStarted value)? appStarted,
    TResult Function(LoginRequested value)? loginRequested,
    TResult Function(RegisterRequested value)? registerRequested,
    TResult Function(RegisterOwnerRequested value)? registerOwnerRequested,
    TResult Function(VerifyEmailRequested value)? verifyEmailRequested,
    TResult Function(ResendCodeRequested value)? resendCodeRequested,
    TResult Function(GoogleLoginRequested value)? googleLoginRequested,
    TResult Function(AppleLoginRequested value)? appleLoginRequested,
    TResult Function(LogoutRequested value)? logoutRequested,
    required TResult orElse(),
  }) {
    if (appleLoginRequested != null) {
      return appleLoginRequested(this);
    }
    return orElse();
  }
}

abstract class AppleLoginRequested implements AuthEvent {
  const factory AppleLoginRequested() = _$AppleLoginRequestedImpl;
}

/// @nodoc
abstract class _$$LogoutRequestedImplCopyWith<$Res> {
  factory _$$LogoutRequestedImplCopyWith(
    _$LogoutRequestedImpl value,
    $Res Function(_$LogoutRequestedImpl) then,
  ) = __$$LogoutRequestedImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$LogoutRequestedImplCopyWithImpl<$Res>
    extends _$AuthEventCopyWithImpl<$Res, _$LogoutRequestedImpl>
    implements _$$LogoutRequestedImplCopyWith<$Res> {
  __$$LogoutRequestedImplCopyWithImpl(
    _$LogoutRequestedImpl _value,
    $Res Function(_$LogoutRequestedImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AuthEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$LogoutRequestedImpl implements LogoutRequested {
  const _$LogoutRequestedImpl();

  @override
  String toString() {
    return 'AuthEvent.logoutRequested()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$LogoutRequestedImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() appStarted,
    required TResult Function(LoginParams params) loginRequested,
    required TResult Function(RegisterParams params) registerRequested,
    required TResult Function(RegisterParams params) registerOwnerRequested,
    required TResult Function(String token) verifyEmailRequested,
    required TResult Function(String email) resendCodeRequested,
    required TResult Function() googleLoginRequested,
    required TResult Function() appleLoginRequested,
    required TResult Function() logoutRequested,
  }) {
    return logoutRequested();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? appStarted,
    TResult? Function(LoginParams params)? loginRequested,
    TResult? Function(RegisterParams params)? registerRequested,
    TResult? Function(RegisterParams params)? registerOwnerRequested,
    TResult? Function(String token)? verifyEmailRequested,
    TResult? Function(String email)? resendCodeRequested,
    TResult? Function()? googleLoginRequested,
    TResult? Function()? appleLoginRequested,
    TResult? Function()? logoutRequested,
  }) {
    return logoutRequested?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? appStarted,
    TResult Function(LoginParams params)? loginRequested,
    TResult Function(RegisterParams params)? registerRequested,
    TResult Function(RegisterParams params)? registerOwnerRequested,
    TResult Function(String token)? verifyEmailRequested,
    TResult Function(String email)? resendCodeRequested,
    TResult Function()? googleLoginRequested,
    TResult Function()? appleLoginRequested,
    TResult Function()? logoutRequested,
    required TResult orElse(),
  }) {
    if (logoutRequested != null) {
      return logoutRequested();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AppStarted value) appStarted,
    required TResult Function(LoginRequested value) loginRequested,
    required TResult Function(RegisterRequested value) registerRequested,
    required TResult Function(RegisterOwnerRequested value)
    registerOwnerRequested,
    required TResult Function(VerifyEmailRequested value) verifyEmailRequested,
    required TResult Function(ResendCodeRequested value) resendCodeRequested,
    required TResult Function(GoogleLoginRequested value) googleLoginRequested,
    required TResult Function(AppleLoginRequested value) appleLoginRequested,
    required TResult Function(LogoutRequested value) logoutRequested,
  }) {
    return logoutRequested(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AppStarted value)? appStarted,
    TResult? Function(LoginRequested value)? loginRequested,
    TResult? Function(RegisterRequested value)? registerRequested,
    TResult? Function(RegisterOwnerRequested value)? registerOwnerRequested,
    TResult? Function(VerifyEmailRequested value)? verifyEmailRequested,
    TResult? Function(ResendCodeRequested value)? resendCodeRequested,
    TResult? Function(GoogleLoginRequested value)? googleLoginRequested,
    TResult? Function(AppleLoginRequested value)? appleLoginRequested,
    TResult? Function(LogoutRequested value)? logoutRequested,
  }) {
    return logoutRequested?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AppStarted value)? appStarted,
    TResult Function(LoginRequested value)? loginRequested,
    TResult Function(RegisterRequested value)? registerRequested,
    TResult Function(RegisterOwnerRequested value)? registerOwnerRequested,
    TResult Function(VerifyEmailRequested value)? verifyEmailRequested,
    TResult Function(ResendCodeRequested value)? resendCodeRequested,
    TResult Function(GoogleLoginRequested value)? googleLoginRequested,
    TResult Function(AppleLoginRequested value)? appleLoginRequested,
    TResult Function(LogoutRequested value)? logoutRequested,
    required TResult orElse(),
  }) {
    if (logoutRequested != null) {
      return logoutRequested(this);
    }
    return orElse();
  }
}

abstract class LogoutRequested implements AuthEvent {
  const factory LogoutRequested() = _$LogoutRequestedImpl;
}
