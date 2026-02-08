// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'token_response_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

TokenResponseModel _$TokenResponseModelFromJson(Map<String, dynamic> json) {
  return _TokenResponseModel.fromJson(json);
}

/// @nodoc
mixin _$TokenResponseModel {
  @JsonKey(name: 'accessToken')
  String get accessToken => throw _privateConstructorUsedError;
  @JsonKey(name: 'refreshToken')
  String get refreshToken => throw _privateConstructorUsedError;
  @JsonKey(name: 'expiresIn')
  @DurationEpochConverter()
  Duration get expiresIn => throw _privateConstructorUsedError;

  /// Serializes this TokenResponseModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of TokenResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TokenResponseModelCopyWith<TokenResponseModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TokenResponseModelCopyWith<$Res> {
  factory $TokenResponseModelCopyWith(
    TokenResponseModel value,
    $Res Function(TokenResponseModel) then,
  ) = _$TokenResponseModelCopyWithImpl<$Res, TokenResponseModel>;
  @useResult
  $Res call({
    @JsonKey(name: 'accessToken') String accessToken,
    @JsonKey(name: 'refreshToken') String refreshToken,
    @JsonKey(name: 'expiresIn') @DurationEpochConverter() Duration expiresIn,
  });
}

/// @nodoc
class _$TokenResponseModelCopyWithImpl<$Res, $Val extends TokenResponseModel>
    implements $TokenResponseModelCopyWith<$Res> {
  _$TokenResponseModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TokenResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? accessToken = null,
    Object? refreshToken = null,
    Object? expiresIn = null,
  }) {
    return _then(
      _value.copyWith(
            accessToken:
                null == accessToken
                    ? _value.accessToken
                    : accessToken // ignore: cast_nullable_to_non_nullable
                        as String,
            refreshToken:
                null == refreshToken
                    ? _value.refreshToken
                    : refreshToken // ignore: cast_nullable_to_non_nullable
                        as String,
            expiresIn:
                null == expiresIn
                    ? _value.expiresIn
                    : expiresIn // ignore: cast_nullable_to_non_nullable
                        as Duration,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$TokenResponseModelImplCopyWith<$Res>
    implements $TokenResponseModelCopyWith<$Res> {
  factory _$$TokenResponseModelImplCopyWith(
    _$TokenResponseModelImpl value,
    $Res Function(_$TokenResponseModelImpl) then,
  ) = __$$TokenResponseModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @JsonKey(name: 'accessToken') String accessToken,
    @JsonKey(name: 'refreshToken') String refreshToken,
    @JsonKey(name: 'expiresIn') @DurationEpochConverter() Duration expiresIn,
  });
}

/// @nodoc
class __$$TokenResponseModelImplCopyWithImpl<$Res>
    extends _$TokenResponseModelCopyWithImpl<$Res, _$TokenResponseModelImpl>
    implements _$$TokenResponseModelImplCopyWith<$Res> {
  __$$TokenResponseModelImplCopyWithImpl(
    _$TokenResponseModelImpl _value,
    $Res Function(_$TokenResponseModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of TokenResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? accessToken = null,
    Object? refreshToken = null,
    Object? expiresIn = null,
  }) {
    return _then(
      _$TokenResponseModelImpl(
        accessToken:
            null == accessToken
                ? _value.accessToken
                : accessToken // ignore: cast_nullable_to_non_nullable
                    as String,
        refreshToken:
            null == refreshToken
                ? _value.refreshToken
                : refreshToken // ignore: cast_nullable_to_non_nullable
                    as String,
        expiresIn:
            null == expiresIn
                ? _value.expiresIn
                : expiresIn // ignore: cast_nullable_to_non_nullable
                    as Duration,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$TokenResponseModelImpl extends _TokenResponseModel {
  const _$TokenResponseModelImpl({
    @JsonKey(name: 'accessToken') required this.accessToken,
    @JsonKey(name: 'refreshToken') required this.refreshToken,
    @JsonKey(name: 'expiresIn')
    @DurationEpochConverter()
    required this.expiresIn,
  }) : super._();

  factory _$TokenResponseModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$TokenResponseModelImplFromJson(json);

  @override
  @JsonKey(name: 'accessToken')
  final String accessToken;
  @override
  @JsonKey(name: 'refreshToken')
  final String refreshToken;
  @override
  @JsonKey(name: 'expiresIn')
  @DurationEpochConverter()
  final Duration expiresIn;

  @override
  String toString() {
    return 'TokenResponseModel(accessToken: $accessToken, refreshToken: $refreshToken, expiresIn: $expiresIn)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TokenResponseModelImpl &&
            (identical(other.accessToken, accessToken) ||
                other.accessToken == accessToken) &&
            (identical(other.refreshToken, refreshToken) ||
                other.refreshToken == refreshToken) &&
            (identical(other.expiresIn, expiresIn) ||
                other.expiresIn == expiresIn));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, accessToken, refreshToken, expiresIn);

  /// Create a copy of TokenResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TokenResponseModelImplCopyWith<_$TokenResponseModelImpl> get copyWith =>
      __$$TokenResponseModelImplCopyWithImpl<_$TokenResponseModelImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$TokenResponseModelImplToJson(this);
  }
}

abstract class _TokenResponseModel extends TokenResponseModel {
  const factory _TokenResponseModel({
    @JsonKey(name: 'accessToken') required final String accessToken,
    @JsonKey(name: 'refreshToken') required final String refreshToken,
    @JsonKey(name: 'expiresIn')
    @DurationEpochConverter()
    required final Duration expiresIn,
  }) = _$TokenResponseModelImpl;
  const _TokenResponseModel._() : super._();

  factory _TokenResponseModel.fromJson(Map<String, dynamic> json) =
      _$TokenResponseModelImpl.fromJson;

  @override
  @JsonKey(name: 'accessToken')
  String get accessToken;
  @override
  @JsonKey(name: 'refreshToken')
  String get refreshToken;
  @override
  @JsonKey(name: 'expiresIn')
  @DurationEpochConverter()
  Duration get expiresIn;

  /// Create a copy of TokenResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TokenResponseModelImplCopyWith<_$TokenResponseModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
