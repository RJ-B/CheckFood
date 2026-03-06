// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$UserEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() profileRequested,
    required TResult Function() devicesRequested,
    required TResult Function(UpdateProfileRequestModel request) profileUpdated,
    required TResult Function(ChangePasswordRequestModel request)
    passwordChangeRequested,
    required TResult Function() allDevicesLogoutRequested,
    required TResult Function(int deviceId) deviceLoggedOut,
    required TResult Function() clearDataRequested,
    required TResult Function() notificationPreferenceRequested,
    required TResult Function(bool enabled) notificationToggled,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? profileRequested,
    TResult? Function()? devicesRequested,
    TResult? Function(UpdateProfileRequestModel request)? profileUpdated,
    TResult? Function(ChangePasswordRequestModel request)?
    passwordChangeRequested,
    TResult? Function()? allDevicesLogoutRequested,
    TResult? Function(int deviceId)? deviceLoggedOut,
    TResult? Function()? clearDataRequested,
    TResult? Function()? notificationPreferenceRequested,
    TResult? Function(bool enabled)? notificationToggled,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? profileRequested,
    TResult Function()? devicesRequested,
    TResult Function(UpdateProfileRequestModel request)? profileUpdated,
    TResult Function(ChangePasswordRequestModel request)?
    passwordChangeRequested,
    TResult Function()? allDevicesLogoutRequested,
    TResult Function(int deviceId)? deviceLoggedOut,
    TResult Function()? clearDataRequested,
    TResult Function()? notificationPreferenceRequested,
    TResult Function(bool enabled)? notificationToggled,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ProfileRequested value) profileRequested,
    required TResult Function(DevicesRequested value) devicesRequested,
    required TResult Function(ProfileUpdated value) profileUpdated,
    required TResult Function(PasswordChangeRequested value)
    passwordChangeRequested,
    required TResult Function(AllDevicesLogoutRequested value)
    allDevicesLogoutRequested,
    required TResult Function(DeviceLoggedOut value) deviceLoggedOut,
    required TResult Function(ClearDataRequested value) clearDataRequested,
    required TResult Function(NotificationPreferenceRequested value)
    notificationPreferenceRequested,
    required TResult Function(NotificationToggled value) notificationToggled,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ProfileRequested value)? profileRequested,
    TResult? Function(DevicesRequested value)? devicesRequested,
    TResult? Function(ProfileUpdated value)? profileUpdated,
    TResult? Function(PasswordChangeRequested value)? passwordChangeRequested,
    TResult? Function(AllDevicesLogoutRequested value)?
    allDevicesLogoutRequested,
    TResult? Function(DeviceLoggedOut value)? deviceLoggedOut,
    TResult? Function(ClearDataRequested value)? clearDataRequested,
    TResult? Function(NotificationPreferenceRequested value)?
    notificationPreferenceRequested,
    TResult? Function(NotificationToggled value)? notificationToggled,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ProfileRequested value)? profileRequested,
    TResult Function(DevicesRequested value)? devicesRequested,
    TResult Function(ProfileUpdated value)? profileUpdated,
    TResult Function(PasswordChangeRequested value)? passwordChangeRequested,
    TResult Function(AllDevicesLogoutRequested value)?
    allDevicesLogoutRequested,
    TResult Function(DeviceLoggedOut value)? deviceLoggedOut,
    TResult Function(ClearDataRequested value)? clearDataRequested,
    TResult Function(NotificationPreferenceRequested value)?
    notificationPreferenceRequested,
    TResult Function(NotificationToggled value)? notificationToggled,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserEventCopyWith<$Res> {
  factory $UserEventCopyWith(UserEvent value, $Res Function(UserEvent) then) =
      _$UserEventCopyWithImpl<$Res, UserEvent>;
}

/// @nodoc
class _$UserEventCopyWithImpl<$Res, $Val extends UserEvent>
    implements $UserEventCopyWith<$Res> {
  _$UserEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of UserEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$ProfileRequestedImplCopyWith<$Res> {
  factory _$$ProfileRequestedImplCopyWith(
    _$ProfileRequestedImpl value,
    $Res Function(_$ProfileRequestedImpl) then,
  ) = __$$ProfileRequestedImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$ProfileRequestedImplCopyWithImpl<$Res>
    extends _$UserEventCopyWithImpl<$Res, _$ProfileRequestedImpl>
    implements _$$ProfileRequestedImplCopyWith<$Res> {
  __$$ProfileRequestedImplCopyWithImpl(
    _$ProfileRequestedImpl _value,
    $Res Function(_$ProfileRequestedImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of UserEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$ProfileRequestedImpl implements ProfileRequested {
  const _$ProfileRequestedImpl();

  @override
  String toString() {
    return 'UserEvent.profileRequested()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$ProfileRequestedImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() profileRequested,
    required TResult Function() devicesRequested,
    required TResult Function(UpdateProfileRequestModel request) profileUpdated,
    required TResult Function(ChangePasswordRequestModel request)
    passwordChangeRequested,
    required TResult Function() allDevicesLogoutRequested,
    required TResult Function(int deviceId) deviceLoggedOut,
    required TResult Function() clearDataRequested,
    required TResult Function() notificationPreferenceRequested,
    required TResult Function(bool enabled) notificationToggled,
  }) {
    return profileRequested();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? profileRequested,
    TResult? Function()? devicesRequested,
    TResult? Function(UpdateProfileRequestModel request)? profileUpdated,
    TResult? Function(ChangePasswordRequestModel request)?
    passwordChangeRequested,
    TResult? Function()? allDevicesLogoutRequested,
    TResult? Function(int deviceId)? deviceLoggedOut,
    TResult? Function()? clearDataRequested,
    TResult? Function()? notificationPreferenceRequested,
    TResult? Function(bool enabled)? notificationToggled,
  }) {
    return profileRequested?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? profileRequested,
    TResult Function()? devicesRequested,
    TResult Function(UpdateProfileRequestModel request)? profileUpdated,
    TResult Function(ChangePasswordRequestModel request)?
    passwordChangeRequested,
    TResult Function()? allDevicesLogoutRequested,
    TResult Function(int deviceId)? deviceLoggedOut,
    TResult Function()? clearDataRequested,
    TResult Function()? notificationPreferenceRequested,
    TResult Function(bool enabled)? notificationToggled,
    required TResult orElse(),
  }) {
    if (profileRequested != null) {
      return profileRequested();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ProfileRequested value) profileRequested,
    required TResult Function(DevicesRequested value) devicesRequested,
    required TResult Function(ProfileUpdated value) profileUpdated,
    required TResult Function(PasswordChangeRequested value)
    passwordChangeRequested,
    required TResult Function(AllDevicesLogoutRequested value)
    allDevicesLogoutRequested,
    required TResult Function(DeviceLoggedOut value) deviceLoggedOut,
    required TResult Function(ClearDataRequested value) clearDataRequested,
    required TResult Function(NotificationPreferenceRequested value)
    notificationPreferenceRequested,
    required TResult Function(NotificationToggled value) notificationToggled,
  }) {
    return profileRequested(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ProfileRequested value)? profileRequested,
    TResult? Function(DevicesRequested value)? devicesRequested,
    TResult? Function(ProfileUpdated value)? profileUpdated,
    TResult? Function(PasswordChangeRequested value)? passwordChangeRequested,
    TResult? Function(AllDevicesLogoutRequested value)?
    allDevicesLogoutRequested,
    TResult? Function(DeviceLoggedOut value)? deviceLoggedOut,
    TResult? Function(ClearDataRequested value)? clearDataRequested,
    TResult? Function(NotificationPreferenceRequested value)?
    notificationPreferenceRequested,
    TResult? Function(NotificationToggled value)? notificationToggled,
  }) {
    return profileRequested?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ProfileRequested value)? profileRequested,
    TResult Function(DevicesRequested value)? devicesRequested,
    TResult Function(ProfileUpdated value)? profileUpdated,
    TResult Function(PasswordChangeRequested value)? passwordChangeRequested,
    TResult Function(AllDevicesLogoutRequested value)?
    allDevicesLogoutRequested,
    TResult Function(DeviceLoggedOut value)? deviceLoggedOut,
    TResult Function(ClearDataRequested value)? clearDataRequested,
    TResult Function(NotificationPreferenceRequested value)?
    notificationPreferenceRequested,
    TResult Function(NotificationToggled value)? notificationToggled,
    required TResult orElse(),
  }) {
    if (profileRequested != null) {
      return profileRequested(this);
    }
    return orElse();
  }
}

abstract class ProfileRequested implements UserEvent {
  const factory ProfileRequested() = _$ProfileRequestedImpl;
}

/// @nodoc
abstract class _$$DevicesRequestedImplCopyWith<$Res> {
  factory _$$DevicesRequestedImplCopyWith(
    _$DevicesRequestedImpl value,
    $Res Function(_$DevicesRequestedImpl) then,
  ) = __$$DevicesRequestedImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$DevicesRequestedImplCopyWithImpl<$Res>
    extends _$UserEventCopyWithImpl<$Res, _$DevicesRequestedImpl>
    implements _$$DevicesRequestedImplCopyWith<$Res> {
  __$$DevicesRequestedImplCopyWithImpl(
    _$DevicesRequestedImpl _value,
    $Res Function(_$DevicesRequestedImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of UserEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$DevicesRequestedImpl implements DevicesRequested {
  const _$DevicesRequestedImpl();

  @override
  String toString() {
    return 'UserEvent.devicesRequested()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$DevicesRequestedImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() profileRequested,
    required TResult Function() devicesRequested,
    required TResult Function(UpdateProfileRequestModel request) profileUpdated,
    required TResult Function(ChangePasswordRequestModel request)
    passwordChangeRequested,
    required TResult Function() allDevicesLogoutRequested,
    required TResult Function(int deviceId) deviceLoggedOut,
    required TResult Function() clearDataRequested,
    required TResult Function() notificationPreferenceRequested,
    required TResult Function(bool enabled) notificationToggled,
  }) {
    return devicesRequested();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? profileRequested,
    TResult? Function()? devicesRequested,
    TResult? Function(UpdateProfileRequestModel request)? profileUpdated,
    TResult? Function(ChangePasswordRequestModel request)?
    passwordChangeRequested,
    TResult? Function()? allDevicesLogoutRequested,
    TResult? Function(int deviceId)? deviceLoggedOut,
    TResult? Function()? clearDataRequested,
    TResult? Function()? notificationPreferenceRequested,
    TResult? Function(bool enabled)? notificationToggled,
  }) {
    return devicesRequested?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? profileRequested,
    TResult Function()? devicesRequested,
    TResult Function(UpdateProfileRequestModel request)? profileUpdated,
    TResult Function(ChangePasswordRequestModel request)?
    passwordChangeRequested,
    TResult Function()? allDevicesLogoutRequested,
    TResult Function(int deviceId)? deviceLoggedOut,
    TResult Function()? clearDataRequested,
    TResult Function()? notificationPreferenceRequested,
    TResult Function(bool enabled)? notificationToggled,
    required TResult orElse(),
  }) {
    if (devicesRequested != null) {
      return devicesRequested();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ProfileRequested value) profileRequested,
    required TResult Function(DevicesRequested value) devicesRequested,
    required TResult Function(ProfileUpdated value) profileUpdated,
    required TResult Function(PasswordChangeRequested value)
    passwordChangeRequested,
    required TResult Function(AllDevicesLogoutRequested value)
    allDevicesLogoutRequested,
    required TResult Function(DeviceLoggedOut value) deviceLoggedOut,
    required TResult Function(ClearDataRequested value) clearDataRequested,
    required TResult Function(NotificationPreferenceRequested value)
    notificationPreferenceRequested,
    required TResult Function(NotificationToggled value) notificationToggled,
  }) {
    return devicesRequested(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ProfileRequested value)? profileRequested,
    TResult? Function(DevicesRequested value)? devicesRequested,
    TResult? Function(ProfileUpdated value)? profileUpdated,
    TResult? Function(PasswordChangeRequested value)? passwordChangeRequested,
    TResult? Function(AllDevicesLogoutRequested value)?
    allDevicesLogoutRequested,
    TResult? Function(DeviceLoggedOut value)? deviceLoggedOut,
    TResult? Function(ClearDataRequested value)? clearDataRequested,
    TResult? Function(NotificationPreferenceRequested value)?
    notificationPreferenceRequested,
    TResult? Function(NotificationToggled value)? notificationToggled,
  }) {
    return devicesRequested?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ProfileRequested value)? profileRequested,
    TResult Function(DevicesRequested value)? devicesRequested,
    TResult Function(ProfileUpdated value)? profileUpdated,
    TResult Function(PasswordChangeRequested value)? passwordChangeRequested,
    TResult Function(AllDevicesLogoutRequested value)?
    allDevicesLogoutRequested,
    TResult Function(DeviceLoggedOut value)? deviceLoggedOut,
    TResult Function(ClearDataRequested value)? clearDataRequested,
    TResult Function(NotificationPreferenceRequested value)?
    notificationPreferenceRequested,
    TResult Function(NotificationToggled value)? notificationToggled,
    required TResult orElse(),
  }) {
    if (devicesRequested != null) {
      return devicesRequested(this);
    }
    return orElse();
  }
}

abstract class DevicesRequested implements UserEvent {
  const factory DevicesRequested() = _$DevicesRequestedImpl;
}

/// @nodoc
abstract class _$$ProfileUpdatedImplCopyWith<$Res> {
  factory _$$ProfileUpdatedImplCopyWith(
    _$ProfileUpdatedImpl value,
    $Res Function(_$ProfileUpdatedImpl) then,
  ) = __$$ProfileUpdatedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({UpdateProfileRequestModel request});

  $UpdateProfileRequestModelCopyWith<$Res> get request;
}

/// @nodoc
class __$$ProfileUpdatedImplCopyWithImpl<$Res>
    extends _$UserEventCopyWithImpl<$Res, _$ProfileUpdatedImpl>
    implements _$$ProfileUpdatedImplCopyWith<$Res> {
  __$$ProfileUpdatedImplCopyWithImpl(
    _$ProfileUpdatedImpl _value,
    $Res Function(_$ProfileUpdatedImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of UserEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? request = null}) {
    return _then(
      _$ProfileUpdatedImpl(
        null == request
            ? _value.request
            : request // ignore: cast_nullable_to_non_nullable
                as UpdateProfileRequestModel,
      ),
    );
  }

  /// Create a copy of UserEvent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $UpdateProfileRequestModelCopyWith<$Res> get request {
    return $UpdateProfileRequestModelCopyWith<$Res>(_value.request, (value) {
      return _then(_value.copyWith(request: value));
    });
  }
}

/// @nodoc

class _$ProfileUpdatedImpl implements ProfileUpdated {
  const _$ProfileUpdatedImpl(this.request);

  @override
  final UpdateProfileRequestModel request;

  @override
  String toString() {
    return 'UserEvent.profileUpdated(request: $request)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ProfileUpdatedImpl &&
            (identical(other.request, request) || other.request == request));
  }

  @override
  int get hashCode => Object.hash(runtimeType, request);

  /// Create a copy of UserEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ProfileUpdatedImplCopyWith<_$ProfileUpdatedImpl> get copyWith =>
      __$$ProfileUpdatedImplCopyWithImpl<_$ProfileUpdatedImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() profileRequested,
    required TResult Function() devicesRequested,
    required TResult Function(UpdateProfileRequestModel request) profileUpdated,
    required TResult Function(ChangePasswordRequestModel request)
    passwordChangeRequested,
    required TResult Function() allDevicesLogoutRequested,
    required TResult Function(int deviceId) deviceLoggedOut,
    required TResult Function() clearDataRequested,
    required TResult Function() notificationPreferenceRequested,
    required TResult Function(bool enabled) notificationToggled,
  }) {
    return profileUpdated(request);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? profileRequested,
    TResult? Function()? devicesRequested,
    TResult? Function(UpdateProfileRequestModel request)? profileUpdated,
    TResult? Function(ChangePasswordRequestModel request)?
    passwordChangeRequested,
    TResult? Function()? allDevicesLogoutRequested,
    TResult? Function(int deviceId)? deviceLoggedOut,
    TResult? Function()? clearDataRequested,
    TResult? Function()? notificationPreferenceRequested,
    TResult? Function(bool enabled)? notificationToggled,
  }) {
    return profileUpdated?.call(request);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? profileRequested,
    TResult Function()? devicesRequested,
    TResult Function(UpdateProfileRequestModel request)? profileUpdated,
    TResult Function(ChangePasswordRequestModel request)?
    passwordChangeRequested,
    TResult Function()? allDevicesLogoutRequested,
    TResult Function(int deviceId)? deviceLoggedOut,
    TResult Function()? clearDataRequested,
    TResult Function()? notificationPreferenceRequested,
    TResult Function(bool enabled)? notificationToggled,
    required TResult orElse(),
  }) {
    if (profileUpdated != null) {
      return profileUpdated(request);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ProfileRequested value) profileRequested,
    required TResult Function(DevicesRequested value) devicesRequested,
    required TResult Function(ProfileUpdated value) profileUpdated,
    required TResult Function(PasswordChangeRequested value)
    passwordChangeRequested,
    required TResult Function(AllDevicesLogoutRequested value)
    allDevicesLogoutRequested,
    required TResult Function(DeviceLoggedOut value) deviceLoggedOut,
    required TResult Function(ClearDataRequested value) clearDataRequested,
    required TResult Function(NotificationPreferenceRequested value)
    notificationPreferenceRequested,
    required TResult Function(NotificationToggled value) notificationToggled,
  }) {
    return profileUpdated(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ProfileRequested value)? profileRequested,
    TResult? Function(DevicesRequested value)? devicesRequested,
    TResult? Function(ProfileUpdated value)? profileUpdated,
    TResult? Function(PasswordChangeRequested value)? passwordChangeRequested,
    TResult? Function(AllDevicesLogoutRequested value)?
    allDevicesLogoutRequested,
    TResult? Function(DeviceLoggedOut value)? deviceLoggedOut,
    TResult? Function(ClearDataRequested value)? clearDataRequested,
    TResult? Function(NotificationPreferenceRequested value)?
    notificationPreferenceRequested,
    TResult? Function(NotificationToggled value)? notificationToggled,
  }) {
    return profileUpdated?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ProfileRequested value)? profileRequested,
    TResult Function(DevicesRequested value)? devicesRequested,
    TResult Function(ProfileUpdated value)? profileUpdated,
    TResult Function(PasswordChangeRequested value)? passwordChangeRequested,
    TResult Function(AllDevicesLogoutRequested value)?
    allDevicesLogoutRequested,
    TResult Function(DeviceLoggedOut value)? deviceLoggedOut,
    TResult Function(ClearDataRequested value)? clearDataRequested,
    TResult Function(NotificationPreferenceRequested value)?
    notificationPreferenceRequested,
    TResult Function(NotificationToggled value)? notificationToggled,
    required TResult orElse(),
  }) {
    if (profileUpdated != null) {
      return profileUpdated(this);
    }
    return orElse();
  }
}

abstract class ProfileUpdated implements UserEvent {
  const factory ProfileUpdated(final UpdateProfileRequestModel request) =
      _$ProfileUpdatedImpl;

  UpdateProfileRequestModel get request;

  /// Create a copy of UserEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ProfileUpdatedImplCopyWith<_$ProfileUpdatedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$PasswordChangeRequestedImplCopyWith<$Res> {
  factory _$$PasswordChangeRequestedImplCopyWith(
    _$PasswordChangeRequestedImpl value,
    $Res Function(_$PasswordChangeRequestedImpl) then,
  ) = __$$PasswordChangeRequestedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({ChangePasswordRequestModel request});

  $ChangePasswordRequestModelCopyWith<$Res> get request;
}

/// @nodoc
class __$$PasswordChangeRequestedImplCopyWithImpl<$Res>
    extends _$UserEventCopyWithImpl<$Res, _$PasswordChangeRequestedImpl>
    implements _$$PasswordChangeRequestedImplCopyWith<$Res> {
  __$$PasswordChangeRequestedImplCopyWithImpl(
    _$PasswordChangeRequestedImpl _value,
    $Res Function(_$PasswordChangeRequestedImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of UserEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? request = null}) {
    return _then(
      _$PasswordChangeRequestedImpl(
        null == request
            ? _value.request
            : request // ignore: cast_nullable_to_non_nullable
                as ChangePasswordRequestModel,
      ),
    );
  }

  /// Create a copy of UserEvent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ChangePasswordRequestModelCopyWith<$Res> get request {
    return $ChangePasswordRequestModelCopyWith<$Res>(_value.request, (value) {
      return _then(_value.copyWith(request: value));
    });
  }
}

/// @nodoc

class _$PasswordChangeRequestedImpl implements PasswordChangeRequested {
  const _$PasswordChangeRequestedImpl(this.request);

  @override
  final ChangePasswordRequestModel request;

  @override
  String toString() {
    return 'UserEvent.passwordChangeRequested(request: $request)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PasswordChangeRequestedImpl &&
            (identical(other.request, request) || other.request == request));
  }

  @override
  int get hashCode => Object.hash(runtimeType, request);

  /// Create a copy of UserEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PasswordChangeRequestedImplCopyWith<_$PasswordChangeRequestedImpl>
  get copyWith => __$$PasswordChangeRequestedImplCopyWithImpl<
    _$PasswordChangeRequestedImpl
  >(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() profileRequested,
    required TResult Function() devicesRequested,
    required TResult Function(UpdateProfileRequestModel request) profileUpdated,
    required TResult Function(ChangePasswordRequestModel request)
    passwordChangeRequested,
    required TResult Function() allDevicesLogoutRequested,
    required TResult Function(int deviceId) deviceLoggedOut,
    required TResult Function() clearDataRequested,
    required TResult Function() notificationPreferenceRequested,
    required TResult Function(bool enabled) notificationToggled,
  }) {
    return passwordChangeRequested(request);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? profileRequested,
    TResult? Function()? devicesRequested,
    TResult? Function(UpdateProfileRequestModel request)? profileUpdated,
    TResult? Function(ChangePasswordRequestModel request)?
    passwordChangeRequested,
    TResult? Function()? allDevicesLogoutRequested,
    TResult? Function(int deviceId)? deviceLoggedOut,
    TResult? Function()? clearDataRequested,
    TResult? Function()? notificationPreferenceRequested,
    TResult? Function(bool enabled)? notificationToggled,
  }) {
    return passwordChangeRequested?.call(request);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? profileRequested,
    TResult Function()? devicesRequested,
    TResult Function(UpdateProfileRequestModel request)? profileUpdated,
    TResult Function(ChangePasswordRequestModel request)?
    passwordChangeRequested,
    TResult Function()? allDevicesLogoutRequested,
    TResult Function(int deviceId)? deviceLoggedOut,
    TResult Function()? clearDataRequested,
    TResult Function()? notificationPreferenceRequested,
    TResult Function(bool enabled)? notificationToggled,
    required TResult orElse(),
  }) {
    if (passwordChangeRequested != null) {
      return passwordChangeRequested(request);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ProfileRequested value) profileRequested,
    required TResult Function(DevicesRequested value) devicesRequested,
    required TResult Function(ProfileUpdated value) profileUpdated,
    required TResult Function(PasswordChangeRequested value)
    passwordChangeRequested,
    required TResult Function(AllDevicesLogoutRequested value)
    allDevicesLogoutRequested,
    required TResult Function(DeviceLoggedOut value) deviceLoggedOut,
    required TResult Function(ClearDataRequested value) clearDataRequested,
    required TResult Function(NotificationPreferenceRequested value)
    notificationPreferenceRequested,
    required TResult Function(NotificationToggled value) notificationToggled,
  }) {
    return passwordChangeRequested(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ProfileRequested value)? profileRequested,
    TResult? Function(DevicesRequested value)? devicesRequested,
    TResult? Function(ProfileUpdated value)? profileUpdated,
    TResult? Function(PasswordChangeRequested value)? passwordChangeRequested,
    TResult? Function(AllDevicesLogoutRequested value)?
    allDevicesLogoutRequested,
    TResult? Function(DeviceLoggedOut value)? deviceLoggedOut,
    TResult? Function(ClearDataRequested value)? clearDataRequested,
    TResult? Function(NotificationPreferenceRequested value)?
    notificationPreferenceRequested,
    TResult? Function(NotificationToggled value)? notificationToggled,
  }) {
    return passwordChangeRequested?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ProfileRequested value)? profileRequested,
    TResult Function(DevicesRequested value)? devicesRequested,
    TResult Function(ProfileUpdated value)? profileUpdated,
    TResult Function(PasswordChangeRequested value)? passwordChangeRequested,
    TResult Function(AllDevicesLogoutRequested value)?
    allDevicesLogoutRequested,
    TResult Function(DeviceLoggedOut value)? deviceLoggedOut,
    TResult Function(ClearDataRequested value)? clearDataRequested,
    TResult Function(NotificationPreferenceRequested value)?
    notificationPreferenceRequested,
    TResult Function(NotificationToggled value)? notificationToggled,
    required TResult orElse(),
  }) {
    if (passwordChangeRequested != null) {
      return passwordChangeRequested(this);
    }
    return orElse();
  }
}

abstract class PasswordChangeRequested implements UserEvent {
  const factory PasswordChangeRequested(
    final ChangePasswordRequestModel request,
  ) = _$PasswordChangeRequestedImpl;

  ChangePasswordRequestModel get request;

  /// Create a copy of UserEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PasswordChangeRequestedImplCopyWith<_$PasswordChangeRequestedImpl>
  get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$AllDevicesLogoutRequestedImplCopyWith<$Res> {
  factory _$$AllDevicesLogoutRequestedImplCopyWith(
    _$AllDevicesLogoutRequestedImpl value,
    $Res Function(_$AllDevicesLogoutRequestedImpl) then,
  ) = __$$AllDevicesLogoutRequestedImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$AllDevicesLogoutRequestedImplCopyWithImpl<$Res>
    extends _$UserEventCopyWithImpl<$Res, _$AllDevicesLogoutRequestedImpl>
    implements _$$AllDevicesLogoutRequestedImplCopyWith<$Res> {
  __$$AllDevicesLogoutRequestedImplCopyWithImpl(
    _$AllDevicesLogoutRequestedImpl _value,
    $Res Function(_$AllDevicesLogoutRequestedImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of UserEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$AllDevicesLogoutRequestedImpl implements AllDevicesLogoutRequested {
  const _$AllDevicesLogoutRequestedImpl();

  @override
  String toString() {
    return 'UserEvent.allDevicesLogoutRequested()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AllDevicesLogoutRequestedImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() profileRequested,
    required TResult Function() devicesRequested,
    required TResult Function(UpdateProfileRequestModel request) profileUpdated,
    required TResult Function(ChangePasswordRequestModel request)
    passwordChangeRequested,
    required TResult Function() allDevicesLogoutRequested,
    required TResult Function(int deviceId) deviceLoggedOut,
    required TResult Function() clearDataRequested,
    required TResult Function() notificationPreferenceRequested,
    required TResult Function(bool enabled) notificationToggled,
  }) {
    return allDevicesLogoutRequested();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? profileRequested,
    TResult? Function()? devicesRequested,
    TResult? Function(UpdateProfileRequestModel request)? profileUpdated,
    TResult? Function(ChangePasswordRequestModel request)?
    passwordChangeRequested,
    TResult? Function()? allDevicesLogoutRequested,
    TResult? Function(int deviceId)? deviceLoggedOut,
    TResult? Function()? clearDataRequested,
    TResult? Function()? notificationPreferenceRequested,
    TResult? Function(bool enabled)? notificationToggled,
  }) {
    return allDevicesLogoutRequested?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? profileRequested,
    TResult Function()? devicesRequested,
    TResult Function(UpdateProfileRequestModel request)? profileUpdated,
    TResult Function(ChangePasswordRequestModel request)?
    passwordChangeRequested,
    TResult Function()? allDevicesLogoutRequested,
    TResult Function(int deviceId)? deviceLoggedOut,
    TResult Function()? clearDataRequested,
    TResult Function()? notificationPreferenceRequested,
    TResult Function(bool enabled)? notificationToggled,
    required TResult orElse(),
  }) {
    if (allDevicesLogoutRequested != null) {
      return allDevicesLogoutRequested();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ProfileRequested value) profileRequested,
    required TResult Function(DevicesRequested value) devicesRequested,
    required TResult Function(ProfileUpdated value) profileUpdated,
    required TResult Function(PasswordChangeRequested value)
    passwordChangeRequested,
    required TResult Function(AllDevicesLogoutRequested value)
    allDevicesLogoutRequested,
    required TResult Function(DeviceLoggedOut value) deviceLoggedOut,
    required TResult Function(ClearDataRequested value) clearDataRequested,
    required TResult Function(NotificationPreferenceRequested value)
    notificationPreferenceRequested,
    required TResult Function(NotificationToggled value) notificationToggled,
  }) {
    return allDevicesLogoutRequested(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ProfileRequested value)? profileRequested,
    TResult? Function(DevicesRequested value)? devicesRequested,
    TResult? Function(ProfileUpdated value)? profileUpdated,
    TResult? Function(PasswordChangeRequested value)? passwordChangeRequested,
    TResult? Function(AllDevicesLogoutRequested value)?
    allDevicesLogoutRequested,
    TResult? Function(DeviceLoggedOut value)? deviceLoggedOut,
    TResult? Function(ClearDataRequested value)? clearDataRequested,
    TResult? Function(NotificationPreferenceRequested value)?
    notificationPreferenceRequested,
    TResult? Function(NotificationToggled value)? notificationToggled,
  }) {
    return allDevicesLogoutRequested?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ProfileRequested value)? profileRequested,
    TResult Function(DevicesRequested value)? devicesRequested,
    TResult Function(ProfileUpdated value)? profileUpdated,
    TResult Function(PasswordChangeRequested value)? passwordChangeRequested,
    TResult Function(AllDevicesLogoutRequested value)?
    allDevicesLogoutRequested,
    TResult Function(DeviceLoggedOut value)? deviceLoggedOut,
    TResult Function(ClearDataRequested value)? clearDataRequested,
    TResult Function(NotificationPreferenceRequested value)?
    notificationPreferenceRequested,
    TResult Function(NotificationToggled value)? notificationToggled,
    required TResult orElse(),
  }) {
    if (allDevicesLogoutRequested != null) {
      return allDevicesLogoutRequested(this);
    }
    return orElse();
  }
}

abstract class AllDevicesLogoutRequested implements UserEvent {
  const factory AllDevicesLogoutRequested() = _$AllDevicesLogoutRequestedImpl;
}

/// @nodoc
abstract class _$$DeviceLoggedOutImplCopyWith<$Res> {
  factory _$$DeviceLoggedOutImplCopyWith(
    _$DeviceLoggedOutImpl value,
    $Res Function(_$DeviceLoggedOutImpl) then,
  ) = __$$DeviceLoggedOutImplCopyWithImpl<$Res>;
  @useResult
  $Res call({int deviceId});
}

/// @nodoc
class __$$DeviceLoggedOutImplCopyWithImpl<$Res>
    extends _$UserEventCopyWithImpl<$Res, _$DeviceLoggedOutImpl>
    implements _$$DeviceLoggedOutImplCopyWith<$Res> {
  __$$DeviceLoggedOutImplCopyWithImpl(
    _$DeviceLoggedOutImpl _value,
    $Res Function(_$DeviceLoggedOutImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of UserEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? deviceId = null}) {
    return _then(
      _$DeviceLoggedOutImpl(
        null == deviceId
            ? _value.deviceId
            : deviceId // ignore: cast_nullable_to_non_nullable
                as int,
      ),
    );
  }
}

/// @nodoc

class _$DeviceLoggedOutImpl implements DeviceLoggedOut {
  const _$DeviceLoggedOutImpl(this.deviceId);

  @override
  final int deviceId;

  @override
  String toString() {
    return 'UserEvent.deviceLoggedOut(deviceId: $deviceId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DeviceLoggedOutImpl &&
            (identical(other.deviceId, deviceId) ||
                other.deviceId == deviceId));
  }

  @override
  int get hashCode => Object.hash(runtimeType, deviceId);

  /// Create a copy of UserEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DeviceLoggedOutImplCopyWith<_$DeviceLoggedOutImpl> get copyWith =>
      __$$DeviceLoggedOutImplCopyWithImpl<_$DeviceLoggedOutImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() profileRequested,
    required TResult Function() devicesRequested,
    required TResult Function(UpdateProfileRequestModel request) profileUpdated,
    required TResult Function(ChangePasswordRequestModel request)
    passwordChangeRequested,
    required TResult Function() allDevicesLogoutRequested,
    required TResult Function(int deviceId) deviceLoggedOut,
    required TResult Function() clearDataRequested,
    required TResult Function() notificationPreferenceRequested,
    required TResult Function(bool enabled) notificationToggled,
  }) {
    return deviceLoggedOut(deviceId);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? profileRequested,
    TResult? Function()? devicesRequested,
    TResult? Function(UpdateProfileRequestModel request)? profileUpdated,
    TResult? Function(ChangePasswordRequestModel request)?
    passwordChangeRequested,
    TResult? Function()? allDevicesLogoutRequested,
    TResult? Function(int deviceId)? deviceLoggedOut,
    TResult? Function()? clearDataRequested,
    TResult? Function()? notificationPreferenceRequested,
    TResult? Function(bool enabled)? notificationToggled,
  }) {
    return deviceLoggedOut?.call(deviceId);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? profileRequested,
    TResult Function()? devicesRequested,
    TResult Function(UpdateProfileRequestModel request)? profileUpdated,
    TResult Function(ChangePasswordRequestModel request)?
    passwordChangeRequested,
    TResult Function()? allDevicesLogoutRequested,
    TResult Function(int deviceId)? deviceLoggedOut,
    TResult Function()? clearDataRequested,
    TResult Function()? notificationPreferenceRequested,
    TResult Function(bool enabled)? notificationToggled,
    required TResult orElse(),
  }) {
    if (deviceLoggedOut != null) {
      return deviceLoggedOut(deviceId);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ProfileRequested value) profileRequested,
    required TResult Function(DevicesRequested value) devicesRequested,
    required TResult Function(ProfileUpdated value) profileUpdated,
    required TResult Function(PasswordChangeRequested value)
    passwordChangeRequested,
    required TResult Function(AllDevicesLogoutRequested value)
    allDevicesLogoutRequested,
    required TResult Function(DeviceLoggedOut value) deviceLoggedOut,
    required TResult Function(ClearDataRequested value) clearDataRequested,
    required TResult Function(NotificationPreferenceRequested value)
    notificationPreferenceRequested,
    required TResult Function(NotificationToggled value) notificationToggled,
  }) {
    return deviceLoggedOut(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ProfileRequested value)? profileRequested,
    TResult? Function(DevicesRequested value)? devicesRequested,
    TResult? Function(ProfileUpdated value)? profileUpdated,
    TResult? Function(PasswordChangeRequested value)? passwordChangeRequested,
    TResult? Function(AllDevicesLogoutRequested value)?
    allDevicesLogoutRequested,
    TResult? Function(DeviceLoggedOut value)? deviceLoggedOut,
    TResult? Function(ClearDataRequested value)? clearDataRequested,
    TResult? Function(NotificationPreferenceRequested value)?
    notificationPreferenceRequested,
    TResult? Function(NotificationToggled value)? notificationToggled,
  }) {
    return deviceLoggedOut?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ProfileRequested value)? profileRequested,
    TResult Function(DevicesRequested value)? devicesRequested,
    TResult Function(ProfileUpdated value)? profileUpdated,
    TResult Function(PasswordChangeRequested value)? passwordChangeRequested,
    TResult Function(AllDevicesLogoutRequested value)?
    allDevicesLogoutRequested,
    TResult Function(DeviceLoggedOut value)? deviceLoggedOut,
    TResult Function(ClearDataRequested value)? clearDataRequested,
    TResult Function(NotificationPreferenceRequested value)?
    notificationPreferenceRequested,
    TResult Function(NotificationToggled value)? notificationToggled,
    required TResult orElse(),
  }) {
    if (deviceLoggedOut != null) {
      return deviceLoggedOut(this);
    }
    return orElse();
  }
}

abstract class DeviceLoggedOut implements UserEvent {
  const factory DeviceLoggedOut(final int deviceId) = _$DeviceLoggedOutImpl;

  int get deviceId;

  /// Create a copy of UserEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DeviceLoggedOutImplCopyWith<_$DeviceLoggedOutImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ClearDataRequestedImplCopyWith<$Res> {
  factory _$$ClearDataRequestedImplCopyWith(
    _$ClearDataRequestedImpl value,
    $Res Function(_$ClearDataRequestedImpl) then,
  ) = __$$ClearDataRequestedImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$ClearDataRequestedImplCopyWithImpl<$Res>
    extends _$UserEventCopyWithImpl<$Res, _$ClearDataRequestedImpl>
    implements _$$ClearDataRequestedImplCopyWith<$Res> {
  __$$ClearDataRequestedImplCopyWithImpl(
    _$ClearDataRequestedImpl _value,
    $Res Function(_$ClearDataRequestedImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of UserEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$ClearDataRequestedImpl implements ClearDataRequested {
  const _$ClearDataRequestedImpl();

  @override
  String toString() {
    return 'UserEvent.clearDataRequested()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$ClearDataRequestedImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() profileRequested,
    required TResult Function() devicesRequested,
    required TResult Function(UpdateProfileRequestModel request) profileUpdated,
    required TResult Function(ChangePasswordRequestModel request)
    passwordChangeRequested,
    required TResult Function() allDevicesLogoutRequested,
    required TResult Function(int deviceId) deviceLoggedOut,
    required TResult Function() clearDataRequested,
    required TResult Function() notificationPreferenceRequested,
    required TResult Function(bool enabled) notificationToggled,
  }) {
    return clearDataRequested();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? profileRequested,
    TResult? Function()? devicesRequested,
    TResult? Function(UpdateProfileRequestModel request)? profileUpdated,
    TResult? Function(ChangePasswordRequestModel request)?
    passwordChangeRequested,
    TResult? Function()? allDevicesLogoutRequested,
    TResult? Function(int deviceId)? deviceLoggedOut,
    TResult? Function()? clearDataRequested,
    TResult? Function()? notificationPreferenceRequested,
    TResult? Function(bool enabled)? notificationToggled,
  }) {
    return clearDataRequested?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? profileRequested,
    TResult Function()? devicesRequested,
    TResult Function(UpdateProfileRequestModel request)? profileUpdated,
    TResult Function(ChangePasswordRequestModel request)?
    passwordChangeRequested,
    TResult Function()? allDevicesLogoutRequested,
    TResult Function(int deviceId)? deviceLoggedOut,
    TResult Function()? clearDataRequested,
    TResult Function()? notificationPreferenceRequested,
    TResult Function(bool enabled)? notificationToggled,
    required TResult orElse(),
  }) {
    if (clearDataRequested != null) {
      return clearDataRequested();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ProfileRequested value) profileRequested,
    required TResult Function(DevicesRequested value) devicesRequested,
    required TResult Function(ProfileUpdated value) profileUpdated,
    required TResult Function(PasswordChangeRequested value)
    passwordChangeRequested,
    required TResult Function(AllDevicesLogoutRequested value)
    allDevicesLogoutRequested,
    required TResult Function(DeviceLoggedOut value) deviceLoggedOut,
    required TResult Function(ClearDataRequested value) clearDataRequested,
    required TResult Function(NotificationPreferenceRequested value)
    notificationPreferenceRequested,
    required TResult Function(NotificationToggled value) notificationToggled,
  }) {
    return clearDataRequested(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ProfileRequested value)? profileRequested,
    TResult? Function(DevicesRequested value)? devicesRequested,
    TResult? Function(ProfileUpdated value)? profileUpdated,
    TResult? Function(PasswordChangeRequested value)? passwordChangeRequested,
    TResult? Function(AllDevicesLogoutRequested value)?
    allDevicesLogoutRequested,
    TResult? Function(DeviceLoggedOut value)? deviceLoggedOut,
    TResult? Function(ClearDataRequested value)? clearDataRequested,
    TResult? Function(NotificationPreferenceRequested value)?
    notificationPreferenceRequested,
    TResult? Function(NotificationToggled value)? notificationToggled,
  }) {
    return clearDataRequested?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ProfileRequested value)? profileRequested,
    TResult Function(DevicesRequested value)? devicesRequested,
    TResult Function(ProfileUpdated value)? profileUpdated,
    TResult Function(PasswordChangeRequested value)? passwordChangeRequested,
    TResult Function(AllDevicesLogoutRequested value)?
    allDevicesLogoutRequested,
    TResult Function(DeviceLoggedOut value)? deviceLoggedOut,
    TResult Function(ClearDataRequested value)? clearDataRequested,
    TResult Function(NotificationPreferenceRequested value)?
    notificationPreferenceRequested,
    TResult Function(NotificationToggled value)? notificationToggled,
    required TResult orElse(),
  }) {
    if (clearDataRequested != null) {
      return clearDataRequested(this);
    }
    return orElse();
  }
}

abstract class ClearDataRequested implements UserEvent {
  const factory ClearDataRequested() = _$ClearDataRequestedImpl;
}

/// @nodoc
abstract class _$$NotificationPreferenceRequestedImplCopyWith<$Res> {
  factory _$$NotificationPreferenceRequestedImplCopyWith(
    _$NotificationPreferenceRequestedImpl value,
    $Res Function(_$NotificationPreferenceRequestedImpl) then,
  ) = __$$NotificationPreferenceRequestedImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$NotificationPreferenceRequestedImplCopyWithImpl<$Res>
    extends _$UserEventCopyWithImpl<$Res, _$NotificationPreferenceRequestedImpl>
    implements _$$NotificationPreferenceRequestedImplCopyWith<$Res> {
  __$$NotificationPreferenceRequestedImplCopyWithImpl(
    _$NotificationPreferenceRequestedImpl _value,
    $Res Function(_$NotificationPreferenceRequestedImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of UserEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$NotificationPreferenceRequestedImpl
    implements NotificationPreferenceRequested {
  const _$NotificationPreferenceRequestedImpl();

  @override
  String toString() {
    return 'UserEvent.notificationPreferenceRequested()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NotificationPreferenceRequestedImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() profileRequested,
    required TResult Function() devicesRequested,
    required TResult Function(UpdateProfileRequestModel request) profileUpdated,
    required TResult Function(ChangePasswordRequestModel request)
    passwordChangeRequested,
    required TResult Function() allDevicesLogoutRequested,
    required TResult Function(int deviceId) deviceLoggedOut,
    required TResult Function() clearDataRequested,
    required TResult Function() notificationPreferenceRequested,
    required TResult Function(bool enabled) notificationToggled,
  }) {
    return notificationPreferenceRequested();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? profileRequested,
    TResult? Function()? devicesRequested,
    TResult? Function(UpdateProfileRequestModel request)? profileUpdated,
    TResult? Function(ChangePasswordRequestModel request)?
    passwordChangeRequested,
    TResult? Function()? allDevicesLogoutRequested,
    TResult? Function(int deviceId)? deviceLoggedOut,
    TResult? Function()? clearDataRequested,
    TResult? Function()? notificationPreferenceRequested,
    TResult? Function(bool enabled)? notificationToggled,
  }) {
    return notificationPreferenceRequested?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? profileRequested,
    TResult Function()? devicesRequested,
    TResult Function(UpdateProfileRequestModel request)? profileUpdated,
    TResult Function(ChangePasswordRequestModel request)?
    passwordChangeRequested,
    TResult Function()? allDevicesLogoutRequested,
    TResult Function(int deviceId)? deviceLoggedOut,
    TResult Function()? clearDataRequested,
    TResult Function()? notificationPreferenceRequested,
    TResult Function(bool enabled)? notificationToggled,
    required TResult orElse(),
  }) {
    if (notificationPreferenceRequested != null) {
      return notificationPreferenceRequested();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ProfileRequested value) profileRequested,
    required TResult Function(DevicesRequested value) devicesRequested,
    required TResult Function(ProfileUpdated value) profileUpdated,
    required TResult Function(PasswordChangeRequested value)
    passwordChangeRequested,
    required TResult Function(AllDevicesLogoutRequested value)
    allDevicesLogoutRequested,
    required TResult Function(DeviceLoggedOut value) deviceLoggedOut,
    required TResult Function(ClearDataRequested value) clearDataRequested,
    required TResult Function(NotificationPreferenceRequested value)
    notificationPreferenceRequested,
    required TResult Function(NotificationToggled value) notificationToggled,
  }) {
    return notificationPreferenceRequested(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ProfileRequested value)? profileRequested,
    TResult? Function(DevicesRequested value)? devicesRequested,
    TResult? Function(ProfileUpdated value)? profileUpdated,
    TResult? Function(PasswordChangeRequested value)? passwordChangeRequested,
    TResult? Function(AllDevicesLogoutRequested value)?
    allDevicesLogoutRequested,
    TResult? Function(DeviceLoggedOut value)? deviceLoggedOut,
    TResult? Function(ClearDataRequested value)? clearDataRequested,
    TResult? Function(NotificationPreferenceRequested value)?
    notificationPreferenceRequested,
    TResult? Function(NotificationToggled value)? notificationToggled,
  }) {
    return notificationPreferenceRequested?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ProfileRequested value)? profileRequested,
    TResult Function(DevicesRequested value)? devicesRequested,
    TResult Function(ProfileUpdated value)? profileUpdated,
    TResult Function(PasswordChangeRequested value)? passwordChangeRequested,
    TResult Function(AllDevicesLogoutRequested value)?
    allDevicesLogoutRequested,
    TResult Function(DeviceLoggedOut value)? deviceLoggedOut,
    TResult Function(ClearDataRequested value)? clearDataRequested,
    TResult Function(NotificationPreferenceRequested value)?
    notificationPreferenceRequested,
    TResult Function(NotificationToggled value)? notificationToggled,
    required TResult orElse(),
  }) {
    if (notificationPreferenceRequested != null) {
      return notificationPreferenceRequested(this);
    }
    return orElse();
  }
}

abstract class NotificationPreferenceRequested implements UserEvent {
  const factory NotificationPreferenceRequested() =
      _$NotificationPreferenceRequestedImpl;
}

/// @nodoc
abstract class _$$NotificationToggledImplCopyWith<$Res> {
  factory _$$NotificationToggledImplCopyWith(
    _$NotificationToggledImpl value,
    $Res Function(_$NotificationToggledImpl) then,
  ) = __$$NotificationToggledImplCopyWithImpl<$Res>;
  @useResult
  $Res call({bool enabled});
}

/// @nodoc
class __$$NotificationToggledImplCopyWithImpl<$Res>
    extends _$UserEventCopyWithImpl<$Res, _$NotificationToggledImpl>
    implements _$$NotificationToggledImplCopyWith<$Res> {
  __$$NotificationToggledImplCopyWithImpl(
    _$NotificationToggledImpl _value,
    $Res Function(_$NotificationToggledImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of UserEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? enabled = null}) {
    return _then(
      _$NotificationToggledImpl(
        null == enabled
            ? _value.enabled
            : enabled // ignore: cast_nullable_to_non_nullable
                as bool,
      ),
    );
  }
}

/// @nodoc

class _$NotificationToggledImpl implements NotificationToggled {
  const _$NotificationToggledImpl(this.enabled);

  @override
  final bool enabled;

  @override
  String toString() {
    return 'UserEvent.notificationToggled(enabled: $enabled)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NotificationToggledImpl &&
            (identical(other.enabled, enabled) || other.enabled == enabled));
  }

  @override
  int get hashCode => Object.hash(runtimeType, enabled);

  /// Create a copy of UserEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$NotificationToggledImplCopyWith<_$NotificationToggledImpl> get copyWith =>
      __$$NotificationToggledImplCopyWithImpl<_$NotificationToggledImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() profileRequested,
    required TResult Function() devicesRequested,
    required TResult Function(UpdateProfileRequestModel request) profileUpdated,
    required TResult Function(ChangePasswordRequestModel request)
    passwordChangeRequested,
    required TResult Function() allDevicesLogoutRequested,
    required TResult Function(int deviceId) deviceLoggedOut,
    required TResult Function() clearDataRequested,
    required TResult Function() notificationPreferenceRequested,
    required TResult Function(bool enabled) notificationToggled,
  }) {
    return notificationToggled(enabled);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? profileRequested,
    TResult? Function()? devicesRequested,
    TResult? Function(UpdateProfileRequestModel request)? profileUpdated,
    TResult? Function(ChangePasswordRequestModel request)?
    passwordChangeRequested,
    TResult? Function()? allDevicesLogoutRequested,
    TResult? Function(int deviceId)? deviceLoggedOut,
    TResult? Function()? clearDataRequested,
    TResult? Function()? notificationPreferenceRequested,
    TResult? Function(bool enabled)? notificationToggled,
  }) {
    return notificationToggled?.call(enabled);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? profileRequested,
    TResult Function()? devicesRequested,
    TResult Function(UpdateProfileRequestModel request)? profileUpdated,
    TResult Function(ChangePasswordRequestModel request)?
    passwordChangeRequested,
    TResult Function()? allDevicesLogoutRequested,
    TResult Function(int deviceId)? deviceLoggedOut,
    TResult Function()? clearDataRequested,
    TResult Function()? notificationPreferenceRequested,
    TResult Function(bool enabled)? notificationToggled,
    required TResult orElse(),
  }) {
    if (notificationToggled != null) {
      return notificationToggled(enabled);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ProfileRequested value) profileRequested,
    required TResult Function(DevicesRequested value) devicesRequested,
    required TResult Function(ProfileUpdated value) profileUpdated,
    required TResult Function(PasswordChangeRequested value)
    passwordChangeRequested,
    required TResult Function(AllDevicesLogoutRequested value)
    allDevicesLogoutRequested,
    required TResult Function(DeviceLoggedOut value) deviceLoggedOut,
    required TResult Function(ClearDataRequested value) clearDataRequested,
    required TResult Function(NotificationPreferenceRequested value)
    notificationPreferenceRequested,
    required TResult Function(NotificationToggled value) notificationToggled,
  }) {
    return notificationToggled(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ProfileRequested value)? profileRequested,
    TResult? Function(DevicesRequested value)? devicesRequested,
    TResult? Function(ProfileUpdated value)? profileUpdated,
    TResult? Function(PasswordChangeRequested value)? passwordChangeRequested,
    TResult? Function(AllDevicesLogoutRequested value)?
    allDevicesLogoutRequested,
    TResult? Function(DeviceLoggedOut value)? deviceLoggedOut,
    TResult? Function(ClearDataRequested value)? clearDataRequested,
    TResult? Function(NotificationPreferenceRequested value)?
    notificationPreferenceRequested,
    TResult? Function(NotificationToggled value)? notificationToggled,
  }) {
    return notificationToggled?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ProfileRequested value)? profileRequested,
    TResult Function(DevicesRequested value)? devicesRequested,
    TResult Function(ProfileUpdated value)? profileUpdated,
    TResult Function(PasswordChangeRequested value)? passwordChangeRequested,
    TResult Function(AllDevicesLogoutRequested value)?
    allDevicesLogoutRequested,
    TResult Function(DeviceLoggedOut value)? deviceLoggedOut,
    TResult Function(ClearDataRequested value)? clearDataRequested,
    TResult Function(NotificationPreferenceRequested value)?
    notificationPreferenceRequested,
    TResult Function(NotificationToggled value)? notificationToggled,
    required TResult orElse(),
  }) {
    if (notificationToggled != null) {
      return notificationToggled(this);
    }
    return orElse();
  }
}

abstract class NotificationToggled implements UserEvent {
  const factory NotificationToggled(final bool enabled) =
      _$NotificationToggledImpl;

  bool get enabled;

  /// Create a copy of UserEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$NotificationToggledImplCopyWith<_$NotificationToggledImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
