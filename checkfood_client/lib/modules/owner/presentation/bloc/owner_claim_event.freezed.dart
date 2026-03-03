// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'owner_claim_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$OwnerClaimEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String ico) lookupAres,
    required TResult Function() verifyBankId,
    required TResult Function() startEmailClaim,
    required TResult Function(String code) confirmEmailCode,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String ico)? lookupAres,
    TResult? Function()? verifyBankId,
    TResult? Function()? startEmailClaim,
    TResult? Function(String code)? confirmEmailCode,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String ico)? lookupAres,
    TResult Function()? verifyBankId,
    TResult Function()? startEmailClaim,
    TResult Function(String code)? confirmEmailCode,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(LookupAres value) lookupAres,
    required TResult Function(VerifyBankId value) verifyBankId,
    required TResult Function(StartEmailClaim value) startEmailClaim,
    required TResult Function(ConfirmEmailCode value) confirmEmailCode,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(LookupAres value)? lookupAres,
    TResult? Function(VerifyBankId value)? verifyBankId,
    TResult? Function(StartEmailClaim value)? startEmailClaim,
    TResult? Function(ConfirmEmailCode value)? confirmEmailCode,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LookupAres value)? lookupAres,
    TResult Function(VerifyBankId value)? verifyBankId,
    TResult Function(StartEmailClaim value)? startEmailClaim,
    TResult Function(ConfirmEmailCode value)? confirmEmailCode,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OwnerClaimEventCopyWith<$Res> {
  factory $OwnerClaimEventCopyWith(
    OwnerClaimEvent value,
    $Res Function(OwnerClaimEvent) then,
  ) = _$OwnerClaimEventCopyWithImpl<$Res, OwnerClaimEvent>;
}

/// @nodoc
class _$OwnerClaimEventCopyWithImpl<$Res, $Val extends OwnerClaimEvent>
    implements $OwnerClaimEventCopyWith<$Res> {
  _$OwnerClaimEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of OwnerClaimEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$LookupAresImplCopyWith<$Res> {
  factory _$$LookupAresImplCopyWith(
    _$LookupAresImpl value,
    $Res Function(_$LookupAresImpl) then,
  ) = __$$LookupAresImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String ico});
}

/// @nodoc
class __$$LookupAresImplCopyWithImpl<$Res>
    extends _$OwnerClaimEventCopyWithImpl<$Res, _$LookupAresImpl>
    implements _$$LookupAresImplCopyWith<$Res> {
  __$$LookupAresImplCopyWithImpl(
    _$LookupAresImpl _value,
    $Res Function(_$LookupAresImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of OwnerClaimEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? ico = null}) {
    return _then(
      _$LookupAresImpl(
        ico:
            null == ico
                ? _value.ico
                : ico // ignore: cast_nullable_to_non_nullable
                    as String,
      ),
    );
  }
}

/// @nodoc

class _$LookupAresImpl implements LookupAres {
  const _$LookupAresImpl({required this.ico});

  @override
  final String ico;

  @override
  String toString() {
    return 'OwnerClaimEvent.lookupAres(ico: $ico)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LookupAresImpl &&
            (identical(other.ico, ico) || other.ico == ico));
  }

  @override
  int get hashCode => Object.hash(runtimeType, ico);

  /// Create a copy of OwnerClaimEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LookupAresImplCopyWith<_$LookupAresImpl> get copyWith =>
      __$$LookupAresImplCopyWithImpl<_$LookupAresImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String ico) lookupAres,
    required TResult Function() verifyBankId,
    required TResult Function() startEmailClaim,
    required TResult Function(String code) confirmEmailCode,
  }) {
    return lookupAres(ico);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String ico)? lookupAres,
    TResult? Function()? verifyBankId,
    TResult? Function()? startEmailClaim,
    TResult? Function(String code)? confirmEmailCode,
  }) {
    return lookupAres?.call(ico);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String ico)? lookupAres,
    TResult Function()? verifyBankId,
    TResult Function()? startEmailClaim,
    TResult Function(String code)? confirmEmailCode,
    required TResult orElse(),
  }) {
    if (lookupAres != null) {
      return lookupAres(ico);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(LookupAres value) lookupAres,
    required TResult Function(VerifyBankId value) verifyBankId,
    required TResult Function(StartEmailClaim value) startEmailClaim,
    required TResult Function(ConfirmEmailCode value) confirmEmailCode,
  }) {
    return lookupAres(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(LookupAres value)? lookupAres,
    TResult? Function(VerifyBankId value)? verifyBankId,
    TResult? Function(StartEmailClaim value)? startEmailClaim,
    TResult? Function(ConfirmEmailCode value)? confirmEmailCode,
  }) {
    return lookupAres?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LookupAres value)? lookupAres,
    TResult Function(VerifyBankId value)? verifyBankId,
    TResult Function(StartEmailClaim value)? startEmailClaim,
    TResult Function(ConfirmEmailCode value)? confirmEmailCode,
    required TResult orElse(),
  }) {
    if (lookupAres != null) {
      return lookupAres(this);
    }
    return orElse();
  }
}

abstract class LookupAres implements OwnerClaimEvent {
  const factory LookupAres({required final String ico}) = _$LookupAresImpl;

  String get ico;

  /// Create a copy of OwnerClaimEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LookupAresImplCopyWith<_$LookupAresImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$VerifyBankIdImplCopyWith<$Res> {
  factory _$$VerifyBankIdImplCopyWith(
    _$VerifyBankIdImpl value,
    $Res Function(_$VerifyBankIdImpl) then,
  ) = __$$VerifyBankIdImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$VerifyBankIdImplCopyWithImpl<$Res>
    extends _$OwnerClaimEventCopyWithImpl<$Res, _$VerifyBankIdImpl>
    implements _$$VerifyBankIdImplCopyWith<$Res> {
  __$$VerifyBankIdImplCopyWithImpl(
    _$VerifyBankIdImpl _value,
    $Res Function(_$VerifyBankIdImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of OwnerClaimEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$VerifyBankIdImpl implements VerifyBankId {
  const _$VerifyBankIdImpl();

  @override
  String toString() {
    return 'OwnerClaimEvent.verifyBankId()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$VerifyBankIdImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String ico) lookupAres,
    required TResult Function() verifyBankId,
    required TResult Function() startEmailClaim,
    required TResult Function(String code) confirmEmailCode,
  }) {
    return verifyBankId();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String ico)? lookupAres,
    TResult? Function()? verifyBankId,
    TResult? Function()? startEmailClaim,
    TResult? Function(String code)? confirmEmailCode,
  }) {
    return verifyBankId?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String ico)? lookupAres,
    TResult Function()? verifyBankId,
    TResult Function()? startEmailClaim,
    TResult Function(String code)? confirmEmailCode,
    required TResult orElse(),
  }) {
    if (verifyBankId != null) {
      return verifyBankId();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(LookupAres value) lookupAres,
    required TResult Function(VerifyBankId value) verifyBankId,
    required TResult Function(StartEmailClaim value) startEmailClaim,
    required TResult Function(ConfirmEmailCode value) confirmEmailCode,
  }) {
    return verifyBankId(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(LookupAres value)? lookupAres,
    TResult? Function(VerifyBankId value)? verifyBankId,
    TResult? Function(StartEmailClaim value)? startEmailClaim,
    TResult? Function(ConfirmEmailCode value)? confirmEmailCode,
  }) {
    return verifyBankId?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LookupAres value)? lookupAres,
    TResult Function(VerifyBankId value)? verifyBankId,
    TResult Function(StartEmailClaim value)? startEmailClaim,
    TResult Function(ConfirmEmailCode value)? confirmEmailCode,
    required TResult orElse(),
  }) {
    if (verifyBankId != null) {
      return verifyBankId(this);
    }
    return orElse();
  }
}

abstract class VerifyBankId implements OwnerClaimEvent {
  const factory VerifyBankId() = _$VerifyBankIdImpl;
}

/// @nodoc
abstract class _$$StartEmailClaimImplCopyWith<$Res> {
  factory _$$StartEmailClaimImplCopyWith(
    _$StartEmailClaimImpl value,
    $Res Function(_$StartEmailClaimImpl) then,
  ) = __$$StartEmailClaimImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$StartEmailClaimImplCopyWithImpl<$Res>
    extends _$OwnerClaimEventCopyWithImpl<$Res, _$StartEmailClaimImpl>
    implements _$$StartEmailClaimImplCopyWith<$Res> {
  __$$StartEmailClaimImplCopyWithImpl(
    _$StartEmailClaimImpl _value,
    $Res Function(_$StartEmailClaimImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of OwnerClaimEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$StartEmailClaimImpl implements StartEmailClaim {
  const _$StartEmailClaimImpl();

  @override
  String toString() {
    return 'OwnerClaimEvent.startEmailClaim()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$StartEmailClaimImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String ico) lookupAres,
    required TResult Function() verifyBankId,
    required TResult Function() startEmailClaim,
    required TResult Function(String code) confirmEmailCode,
  }) {
    return startEmailClaim();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String ico)? lookupAres,
    TResult? Function()? verifyBankId,
    TResult? Function()? startEmailClaim,
    TResult? Function(String code)? confirmEmailCode,
  }) {
    return startEmailClaim?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String ico)? lookupAres,
    TResult Function()? verifyBankId,
    TResult Function()? startEmailClaim,
    TResult Function(String code)? confirmEmailCode,
    required TResult orElse(),
  }) {
    if (startEmailClaim != null) {
      return startEmailClaim();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(LookupAres value) lookupAres,
    required TResult Function(VerifyBankId value) verifyBankId,
    required TResult Function(StartEmailClaim value) startEmailClaim,
    required TResult Function(ConfirmEmailCode value) confirmEmailCode,
  }) {
    return startEmailClaim(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(LookupAres value)? lookupAres,
    TResult? Function(VerifyBankId value)? verifyBankId,
    TResult? Function(StartEmailClaim value)? startEmailClaim,
    TResult? Function(ConfirmEmailCode value)? confirmEmailCode,
  }) {
    return startEmailClaim?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LookupAres value)? lookupAres,
    TResult Function(VerifyBankId value)? verifyBankId,
    TResult Function(StartEmailClaim value)? startEmailClaim,
    TResult Function(ConfirmEmailCode value)? confirmEmailCode,
    required TResult orElse(),
  }) {
    if (startEmailClaim != null) {
      return startEmailClaim(this);
    }
    return orElse();
  }
}

abstract class StartEmailClaim implements OwnerClaimEvent {
  const factory StartEmailClaim() = _$StartEmailClaimImpl;
}

/// @nodoc
abstract class _$$ConfirmEmailCodeImplCopyWith<$Res> {
  factory _$$ConfirmEmailCodeImplCopyWith(
    _$ConfirmEmailCodeImpl value,
    $Res Function(_$ConfirmEmailCodeImpl) then,
  ) = __$$ConfirmEmailCodeImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String code});
}

/// @nodoc
class __$$ConfirmEmailCodeImplCopyWithImpl<$Res>
    extends _$OwnerClaimEventCopyWithImpl<$Res, _$ConfirmEmailCodeImpl>
    implements _$$ConfirmEmailCodeImplCopyWith<$Res> {
  __$$ConfirmEmailCodeImplCopyWithImpl(
    _$ConfirmEmailCodeImpl _value,
    $Res Function(_$ConfirmEmailCodeImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of OwnerClaimEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? code = null}) {
    return _then(
      _$ConfirmEmailCodeImpl(
        code:
            null == code
                ? _value.code
                : code // ignore: cast_nullable_to_non_nullable
                    as String,
      ),
    );
  }
}

/// @nodoc

class _$ConfirmEmailCodeImpl implements ConfirmEmailCode {
  const _$ConfirmEmailCodeImpl({required this.code});

  @override
  final String code;

  @override
  String toString() {
    return 'OwnerClaimEvent.confirmEmailCode(code: $code)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ConfirmEmailCodeImpl &&
            (identical(other.code, code) || other.code == code));
  }

  @override
  int get hashCode => Object.hash(runtimeType, code);

  /// Create a copy of OwnerClaimEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ConfirmEmailCodeImplCopyWith<_$ConfirmEmailCodeImpl> get copyWith =>
      __$$ConfirmEmailCodeImplCopyWithImpl<_$ConfirmEmailCodeImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String ico) lookupAres,
    required TResult Function() verifyBankId,
    required TResult Function() startEmailClaim,
    required TResult Function(String code) confirmEmailCode,
  }) {
    return confirmEmailCode(code);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String ico)? lookupAres,
    TResult? Function()? verifyBankId,
    TResult? Function()? startEmailClaim,
    TResult? Function(String code)? confirmEmailCode,
  }) {
    return confirmEmailCode?.call(code);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String ico)? lookupAres,
    TResult Function()? verifyBankId,
    TResult Function()? startEmailClaim,
    TResult Function(String code)? confirmEmailCode,
    required TResult orElse(),
  }) {
    if (confirmEmailCode != null) {
      return confirmEmailCode(code);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(LookupAres value) lookupAres,
    required TResult Function(VerifyBankId value) verifyBankId,
    required TResult Function(StartEmailClaim value) startEmailClaim,
    required TResult Function(ConfirmEmailCode value) confirmEmailCode,
  }) {
    return confirmEmailCode(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(LookupAres value)? lookupAres,
    TResult? Function(VerifyBankId value)? verifyBankId,
    TResult? Function(StartEmailClaim value)? startEmailClaim,
    TResult? Function(ConfirmEmailCode value)? confirmEmailCode,
  }) {
    return confirmEmailCode?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LookupAres value)? lookupAres,
    TResult Function(VerifyBankId value)? verifyBankId,
    TResult Function(StartEmailClaim value)? startEmailClaim,
    TResult Function(ConfirmEmailCode value)? confirmEmailCode,
    required TResult orElse(),
  }) {
    if (confirmEmailCode != null) {
      return confirmEmailCode(this);
    }
    return orElse();
  }
}

abstract class ConfirmEmailCode implements OwnerClaimEvent {
  const factory ConfirmEmailCode({required final String code}) =
      _$ConfirmEmailCodeImpl;

  String get code;

  /// Create a copy of OwnerClaimEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ConfirmEmailCodeImplCopyWith<_$ConfirmEmailCodeImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
