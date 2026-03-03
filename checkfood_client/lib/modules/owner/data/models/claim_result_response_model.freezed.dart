// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'claim_result_response_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

ClaimResultResponseModel _$ClaimResultResponseModelFromJson(
  Map<String, dynamic> json,
) {
  return _ClaimResultResponseModel.fromJson(json);
}

/// @nodoc
mixin _$ClaimResultResponseModel {
  bool get success => throw _privateConstructorUsedError;
  bool get matched => throw _privateConstructorUsedError;
  bool get membershipCreated => throw _privateConstructorUsedError;
  bool get emailFallbackAvailable => throw _privateConstructorUsedError;
  String? get emailHint => throw _privateConstructorUsedError;

  /// Serializes this ClaimResultResponseModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ClaimResultResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ClaimResultResponseModelCopyWith<ClaimResultResponseModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ClaimResultResponseModelCopyWith<$Res> {
  factory $ClaimResultResponseModelCopyWith(
    ClaimResultResponseModel value,
    $Res Function(ClaimResultResponseModel) then,
  ) = _$ClaimResultResponseModelCopyWithImpl<$Res, ClaimResultResponseModel>;
  @useResult
  $Res call({
    bool success,
    bool matched,
    bool membershipCreated,
    bool emailFallbackAvailable,
    String? emailHint,
  });
}

/// @nodoc
class _$ClaimResultResponseModelCopyWithImpl<
  $Res,
  $Val extends ClaimResultResponseModel
>
    implements $ClaimResultResponseModelCopyWith<$Res> {
  _$ClaimResultResponseModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ClaimResultResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? success = null,
    Object? matched = null,
    Object? membershipCreated = null,
    Object? emailFallbackAvailable = null,
    Object? emailHint = freezed,
  }) {
    return _then(
      _value.copyWith(
            success:
                null == success
                    ? _value.success
                    : success // ignore: cast_nullable_to_non_nullable
                        as bool,
            matched:
                null == matched
                    ? _value.matched
                    : matched // ignore: cast_nullable_to_non_nullable
                        as bool,
            membershipCreated:
                null == membershipCreated
                    ? _value.membershipCreated
                    : membershipCreated // ignore: cast_nullable_to_non_nullable
                        as bool,
            emailFallbackAvailable:
                null == emailFallbackAvailable
                    ? _value.emailFallbackAvailable
                    : emailFallbackAvailable // ignore: cast_nullable_to_non_nullable
                        as bool,
            emailHint:
                freezed == emailHint
                    ? _value.emailHint
                    : emailHint // ignore: cast_nullable_to_non_nullable
                        as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ClaimResultResponseModelImplCopyWith<$Res>
    implements $ClaimResultResponseModelCopyWith<$Res> {
  factory _$$ClaimResultResponseModelImplCopyWith(
    _$ClaimResultResponseModelImpl value,
    $Res Function(_$ClaimResultResponseModelImpl) then,
  ) = __$$ClaimResultResponseModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    bool success,
    bool matched,
    bool membershipCreated,
    bool emailFallbackAvailable,
    String? emailHint,
  });
}

/// @nodoc
class __$$ClaimResultResponseModelImplCopyWithImpl<$Res>
    extends
        _$ClaimResultResponseModelCopyWithImpl<
          $Res,
          _$ClaimResultResponseModelImpl
        >
    implements _$$ClaimResultResponseModelImplCopyWith<$Res> {
  __$$ClaimResultResponseModelImplCopyWithImpl(
    _$ClaimResultResponseModelImpl _value,
    $Res Function(_$ClaimResultResponseModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ClaimResultResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? success = null,
    Object? matched = null,
    Object? membershipCreated = null,
    Object? emailFallbackAvailable = null,
    Object? emailHint = freezed,
  }) {
    return _then(
      _$ClaimResultResponseModelImpl(
        success:
            null == success
                ? _value.success
                : success // ignore: cast_nullable_to_non_nullable
                    as bool,
        matched:
            null == matched
                ? _value.matched
                : matched // ignore: cast_nullable_to_non_nullable
                    as bool,
        membershipCreated:
            null == membershipCreated
                ? _value.membershipCreated
                : membershipCreated // ignore: cast_nullable_to_non_nullable
                    as bool,
        emailFallbackAvailable:
            null == emailFallbackAvailable
                ? _value.emailFallbackAvailable
                : emailFallbackAvailable // ignore: cast_nullable_to_non_nullable
                    as bool,
        emailHint:
            freezed == emailHint
                ? _value.emailHint
                : emailHint // ignore: cast_nullable_to_non_nullable
                    as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ClaimResultResponseModelImpl extends _ClaimResultResponseModel {
  const _$ClaimResultResponseModelImpl({
    this.success = false,
    this.matched = false,
    this.membershipCreated = false,
    this.emailFallbackAvailable = false,
    this.emailHint,
  }) : super._();

  factory _$ClaimResultResponseModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$ClaimResultResponseModelImplFromJson(json);

  @override
  @JsonKey()
  final bool success;
  @override
  @JsonKey()
  final bool matched;
  @override
  @JsonKey()
  final bool membershipCreated;
  @override
  @JsonKey()
  final bool emailFallbackAvailable;
  @override
  final String? emailHint;

  @override
  String toString() {
    return 'ClaimResultResponseModel(success: $success, matched: $matched, membershipCreated: $membershipCreated, emailFallbackAvailable: $emailFallbackAvailable, emailHint: $emailHint)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ClaimResultResponseModelImpl &&
            (identical(other.success, success) || other.success == success) &&
            (identical(other.matched, matched) || other.matched == matched) &&
            (identical(other.membershipCreated, membershipCreated) ||
                other.membershipCreated == membershipCreated) &&
            (identical(other.emailFallbackAvailable, emailFallbackAvailable) ||
                other.emailFallbackAvailable == emailFallbackAvailable) &&
            (identical(other.emailHint, emailHint) ||
                other.emailHint == emailHint));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    success,
    matched,
    membershipCreated,
    emailFallbackAvailable,
    emailHint,
  );

  /// Create a copy of ClaimResultResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ClaimResultResponseModelImplCopyWith<_$ClaimResultResponseModelImpl>
  get copyWith => __$$ClaimResultResponseModelImplCopyWithImpl<
    _$ClaimResultResponseModelImpl
  >(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ClaimResultResponseModelImplToJson(this);
  }
}

abstract class _ClaimResultResponseModel extends ClaimResultResponseModel {
  const factory _ClaimResultResponseModel({
    final bool success,
    final bool matched,
    final bool membershipCreated,
    final bool emailFallbackAvailable,
    final String? emailHint,
  }) = _$ClaimResultResponseModelImpl;
  const _ClaimResultResponseModel._() : super._();

  factory _ClaimResultResponseModel.fromJson(Map<String, dynamic> json) =
      _$ClaimResultResponseModelImpl.fromJson;

  @override
  bool get success;
  @override
  bool get matched;
  @override
  bool get membershipCreated;
  @override
  bool get emailFallbackAvailable;
  @override
  String? get emailHint;

  /// Create a copy of ClaimResultResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ClaimResultResponseModelImplCopyWith<_$ClaimResultResponseModelImpl>
  get copyWith => throw _privateConstructorUsedError;
}
