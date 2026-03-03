// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'owner_claim_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$OwnerClaimState {
  bool get loading => throw _privateConstructorUsedError;
  AresCompany? get aresCompany => throw _privateConstructorUsedError;
  String? get aresError => throw _privateConstructorUsedError;
  bool get bankIdVerifying => throw _privateConstructorUsedError;
  ClaimResult? get claimResult => throw _privateConstructorUsedError;
  String? get claimError => throw _privateConstructorUsedError;
  bool get emailSending => throw _privateConstructorUsedError;
  bool get emailCodeSent => throw _privateConstructorUsedError;
  bool get emailConfirming => throw _privateConstructorUsedError;
  bool get claimSuccess => throw _privateConstructorUsedError;

  /// Create a copy of OwnerClaimState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $OwnerClaimStateCopyWith<OwnerClaimState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OwnerClaimStateCopyWith<$Res> {
  factory $OwnerClaimStateCopyWith(
    OwnerClaimState value,
    $Res Function(OwnerClaimState) then,
  ) = _$OwnerClaimStateCopyWithImpl<$Res, OwnerClaimState>;
  @useResult
  $Res call({
    bool loading,
    AresCompany? aresCompany,
    String? aresError,
    bool bankIdVerifying,
    ClaimResult? claimResult,
    String? claimError,
    bool emailSending,
    bool emailCodeSent,
    bool emailConfirming,
    bool claimSuccess,
  });

  $AresCompanyCopyWith<$Res>? get aresCompany;
  $ClaimResultCopyWith<$Res>? get claimResult;
}

/// @nodoc
class _$OwnerClaimStateCopyWithImpl<$Res, $Val extends OwnerClaimState>
    implements $OwnerClaimStateCopyWith<$Res> {
  _$OwnerClaimStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of OwnerClaimState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? loading = null,
    Object? aresCompany = freezed,
    Object? aresError = freezed,
    Object? bankIdVerifying = null,
    Object? claimResult = freezed,
    Object? claimError = freezed,
    Object? emailSending = null,
    Object? emailCodeSent = null,
    Object? emailConfirming = null,
    Object? claimSuccess = null,
  }) {
    return _then(
      _value.copyWith(
            loading:
                null == loading
                    ? _value.loading
                    : loading // ignore: cast_nullable_to_non_nullable
                        as bool,
            aresCompany:
                freezed == aresCompany
                    ? _value.aresCompany
                    : aresCompany // ignore: cast_nullable_to_non_nullable
                        as AresCompany?,
            aresError:
                freezed == aresError
                    ? _value.aresError
                    : aresError // ignore: cast_nullable_to_non_nullable
                        as String?,
            bankIdVerifying:
                null == bankIdVerifying
                    ? _value.bankIdVerifying
                    : bankIdVerifying // ignore: cast_nullable_to_non_nullable
                        as bool,
            claimResult:
                freezed == claimResult
                    ? _value.claimResult
                    : claimResult // ignore: cast_nullable_to_non_nullable
                        as ClaimResult?,
            claimError:
                freezed == claimError
                    ? _value.claimError
                    : claimError // ignore: cast_nullable_to_non_nullable
                        as String?,
            emailSending:
                null == emailSending
                    ? _value.emailSending
                    : emailSending // ignore: cast_nullable_to_non_nullable
                        as bool,
            emailCodeSent:
                null == emailCodeSent
                    ? _value.emailCodeSent
                    : emailCodeSent // ignore: cast_nullable_to_non_nullable
                        as bool,
            emailConfirming:
                null == emailConfirming
                    ? _value.emailConfirming
                    : emailConfirming // ignore: cast_nullable_to_non_nullable
                        as bool,
            claimSuccess:
                null == claimSuccess
                    ? _value.claimSuccess
                    : claimSuccess // ignore: cast_nullable_to_non_nullable
                        as bool,
          )
          as $Val,
    );
  }

  /// Create a copy of OwnerClaimState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $AresCompanyCopyWith<$Res>? get aresCompany {
    if (_value.aresCompany == null) {
      return null;
    }

    return $AresCompanyCopyWith<$Res>(_value.aresCompany!, (value) {
      return _then(_value.copyWith(aresCompany: value) as $Val);
    });
  }

  /// Create a copy of OwnerClaimState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ClaimResultCopyWith<$Res>? get claimResult {
    if (_value.claimResult == null) {
      return null;
    }

    return $ClaimResultCopyWith<$Res>(_value.claimResult!, (value) {
      return _then(_value.copyWith(claimResult: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$OwnerClaimStateImplCopyWith<$Res>
    implements $OwnerClaimStateCopyWith<$Res> {
  factory _$$OwnerClaimStateImplCopyWith(
    _$OwnerClaimStateImpl value,
    $Res Function(_$OwnerClaimStateImpl) then,
  ) = __$$OwnerClaimStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    bool loading,
    AresCompany? aresCompany,
    String? aresError,
    bool bankIdVerifying,
    ClaimResult? claimResult,
    String? claimError,
    bool emailSending,
    bool emailCodeSent,
    bool emailConfirming,
    bool claimSuccess,
  });

  @override
  $AresCompanyCopyWith<$Res>? get aresCompany;
  @override
  $ClaimResultCopyWith<$Res>? get claimResult;
}

/// @nodoc
class __$$OwnerClaimStateImplCopyWithImpl<$Res>
    extends _$OwnerClaimStateCopyWithImpl<$Res, _$OwnerClaimStateImpl>
    implements _$$OwnerClaimStateImplCopyWith<$Res> {
  __$$OwnerClaimStateImplCopyWithImpl(
    _$OwnerClaimStateImpl _value,
    $Res Function(_$OwnerClaimStateImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of OwnerClaimState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? loading = null,
    Object? aresCompany = freezed,
    Object? aresError = freezed,
    Object? bankIdVerifying = null,
    Object? claimResult = freezed,
    Object? claimError = freezed,
    Object? emailSending = null,
    Object? emailCodeSent = null,
    Object? emailConfirming = null,
    Object? claimSuccess = null,
  }) {
    return _then(
      _$OwnerClaimStateImpl(
        loading:
            null == loading
                ? _value.loading
                : loading // ignore: cast_nullable_to_non_nullable
                    as bool,
        aresCompany:
            freezed == aresCompany
                ? _value.aresCompany
                : aresCompany // ignore: cast_nullable_to_non_nullable
                    as AresCompany?,
        aresError:
            freezed == aresError
                ? _value.aresError
                : aresError // ignore: cast_nullable_to_non_nullable
                    as String?,
        bankIdVerifying:
            null == bankIdVerifying
                ? _value.bankIdVerifying
                : bankIdVerifying // ignore: cast_nullable_to_non_nullable
                    as bool,
        claimResult:
            freezed == claimResult
                ? _value.claimResult
                : claimResult // ignore: cast_nullable_to_non_nullable
                    as ClaimResult?,
        claimError:
            freezed == claimError
                ? _value.claimError
                : claimError // ignore: cast_nullable_to_non_nullable
                    as String?,
        emailSending:
            null == emailSending
                ? _value.emailSending
                : emailSending // ignore: cast_nullable_to_non_nullable
                    as bool,
        emailCodeSent:
            null == emailCodeSent
                ? _value.emailCodeSent
                : emailCodeSent // ignore: cast_nullable_to_non_nullable
                    as bool,
        emailConfirming:
            null == emailConfirming
                ? _value.emailConfirming
                : emailConfirming // ignore: cast_nullable_to_non_nullable
                    as bool,
        claimSuccess:
            null == claimSuccess
                ? _value.claimSuccess
                : claimSuccess // ignore: cast_nullable_to_non_nullable
                    as bool,
      ),
    );
  }
}

/// @nodoc

class _$OwnerClaimStateImpl implements _OwnerClaimState {
  const _$OwnerClaimStateImpl({
    this.loading = false,
    this.aresCompany,
    this.aresError,
    this.bankIdVerifying = false,
    this.claimResult,
    this.claimError,
    this.emailSending = false,
    this.emailCodeSent = false,
    this.emailConfirming = false,
    this.claimSuccess = false,
  });

  @override
  @JsonKey()
  final bool loading;
  @override
  final AresCompany? aresCompany;
  @override
  final String? aresError;
  @override
  @JsonKey()
  final bool bankIdVerifying;
  @override
  final ClaimResult? claimResult;
  @override
  final String? claimError;
  @override
  @JsonKey()
  final bool emailSending;
  @override
  @JsonKey()
  final bool emailCodeSent;
  @override
  @JsonKey()
  final bool emailConfirming;
  @override
  @JsonKey()
  final bool claimSuccess;

  @override
  String toString() {
    return 'OwnerClaimState(loading: $loading, aresCompany: $aresCompany, aresError: $aresError, bankIdVerifying: $bankIdVerifying, claimResult: $claimResult, claimError: $claimError, emailSending: $emailSending, emailCodeSent: $emailCodeSent, emailConfirming: $emailConfirming, claimSuccess: $claimSuccess)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OwnerClaimStateImpl &&
            (identical(other.loading, loading) || other.loading == loading) &&
            (identical(other.aresCompany, aresCompany) ||
                other.aresCompany == aresCompany) &&
            (identical(other.aresError, aresError) ||
                other.aresError == aresError) &&
            (identical(other.bankIdVerifying, bankIdVerifying) ||
                other.bankIdVerifying == bankIdVerifying) &&
            (identical(other.claimResult, claimResult) ||
                other.claimResult == claimResult) &&
            (identical(other.claimError, claimError) ||
                other.claimError == claimError) &&
            (identical(other.emailSending, emailSending) ||
                other.emailSending == emailSending) &&
            (identical(other.emailCodeSent, emailCodeSent) ||
                other.emailCodeSent == emailCodeSent) &&
            (identical(other.emailConfirming, emailConfirming) ||
                other.emailConfirming == emailConfirming) &&
            (identical(other.claimSuccess, claimSuccess) ||
                other.claimSuccess == claimSuccess));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    loading,
    aresCompany,
    aresError,
    bankIdVerifying,
    claimResult,
    claimError,
    emailSending,
    emailCodeSent,
    emailConfirming,
    claimSuccess,
  );

  /// Create a copy of OwnerClaimState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$OwnerClaimStateImplCopyWith<_$OwnerClaimStateImpl> get copyWith =>
      __$$OwnerClaimStateImplCopyWithImpl<_$OwnerClaimStateImpl>(
        this,
        _$identity,
      );
}

abstract class _OwnerClaimState implements OwnerClaimState {
  const factory _OwnerClaimState({
    final bool loading,
    final AresCompany? aresCompany,
    final String? aresError,
    final bool bankIdVerifying,
    final ClaimResult? claimResult,
    final String? claimError,
    final bool emailSending,
    final bool emailCodeSent,
    final bool emailConfirming,
    final bool claimSuccess,
  }) = _$OwnerClaimStateImpl;

  @override
  bool get loading;
  @override
  AresCompany? get aresCompany;
  @override
  String? get aresError;
  @override
  bool get bankIdVerifying;
  @override
  ClaimResult? get claimResult;
  @override
  String? get claimError;
  @override
  bool get emailSending;
  @override
  bool get emailCodeSent;
  @override
  bool get emailConfirming;
  @override
  bool get claimSuccess;

  /// Create a copy of OwnerClaimState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$OwnerClaimStateImplCopyWith<_$OwnerClaimStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
