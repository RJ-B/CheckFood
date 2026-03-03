// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'auth_error_response_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

AuthErrorResponseModel _$AuthErrorResponseModelFromJson(
  Map<String, dynamic> json,
) {
  return _AuthErrorResponseModel.fromJson(json);
}

/// @nodoc
mixin _$AuthErrorResponseModel {
  @JsonKey(name: SecurityJsonKeys.message)
  String get message => throw _privateConstructorUsedError;
  @JsonKey(name: SecurityJsonKeys.email)
  String? get email => throw _privateConstructorUsedError;
  @JsonKey(name: SecurityJsonKeys.isExpired)
  bool get isExpired => throw _privateConstructorUsedError;

  /// Serializes this AuthErrorResponseModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of AuthErrorResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AuthErrorResponseModelCopyWith<AuthErrorResponseModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AuthErrorResponseModelCopyWith<$Res> {
  factory $AuthErrorResponseModelCopyWith(
    AuthErrorResponseModel value,
    $Res Function(AuthErrorResponseModel) then,
  ) = _$AuthErrorResponseModelCopyWithImpl<$Res, AuthErrorResponseModel>;
  @useResult
  $Res call({
    @JsonKey(name: SecurityJsonKeys.message) String message,
    @JsonKey(name: SecurityJsonKeys.email) String? email,
    @JsonKey(name: SecurityJsonKeys.isExpired) bool isExpired,
  });
}

/// @nodoc
class _$AuthErrorResponseModelCopyWithImpl<
  $Res,
  $Val extends AuthErrorResponseModel
>
    implements $AuthErrorResponseModelCopyWith<$Res> {
  _$AuthErrorResponseModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AuthErrorResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
    Object? email = freezed,
    Object? isExpired = null,
  }) {
    return _then(
      _value.copyWith(
            message:
                null == message
                    ? _value.message
                    : message // ignore: cast_nullable_to_non_nullable
                        as String,
            email:
                freezed == email
                    ? _value.email
                    : email // ignore: cast_nullable_to_non_nullable
                        as String?,
            isExpired:
                null == isExpired
                    ? _value.isExpired
                    : isExpired // ignore: cast_nullable_to_non_nullable
                        as bool,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$AuthErrorResponseModelImplCopyWith<$Res>
    implements $AuthErrorResponseModelCopyWith<$Res> {
  factory _$$AuthErrorResponseModelImplCopyWith(
    _$AuthErrorResponseModelImpl value,
    $Res Function(_$AuthErrorResponseModelImpl) then,
  ) = __$$AuthErrorResponseModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @JsonKey(name: SecurityJsonKeys.message) String message,
    @JsonKey(name: SecurityJsonKeys.email) String? email,
    @JsonKey(name: SecurityJsonKeys.isExpired) bool isExpired,
  });
}

/// @nodoc
class __$$AuthErrorResponseModelImplCopyWithImpl<$Res>
    extends
        _$AuthErrorResponseModelCopyWithImpl<$Res, _$AuthErrorResponseModelImpl>
    implements _$$AuthErrorResponseModelImplCopyWith<$Res> {
  __$$AuthErrorResponseModelImplCopyWithImpl(
    _$AuthErrorResponseModelImpl _value,
    $Res Function(_$AuthErrorResponseModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AuthErrorResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
    Object? email = freezed,
    Object? isExpired = null,
  }) {
    return _then(
      _$AuthErrorResponseModelImpl(
        message:
            null == message
                ? _value.message
                : message // ignore: cast_nullable_to_non_nullable
                    as String,
        email:
            freezed == email
                ? _value.email
                : email // ignore: cast_nullable_to_non_nullable
                    as String?,
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

@JsonSerializable(explicitToJson: true)
class _$AuthErrorResponseModelImpl extends _AuthErrorResponseModel {
  const _$AuthErrorResponseModelImpl({
    @JsonKey(name: SecurityJsonKeys.message) required this.message,
    @JsonKey(name: SecurityJsonKeys.email) this.email,
    @JsonKey(name: SecurityJsonKeys.isExpired) this.isExpired = false,
  }) : super._();

  factory _$AuthErrorResponseModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$AuthErrorResponseModelImplFromJson(json);

  @override
  @JsonKey(name: SecurityJsonKeys.message)
  final String message;
  @override
  @JsonKey(name: SecurityJsonKeys.email)
  final String? email;
  @override
  @JsonKey(name: SecurityJsonKeys.isExpired)
  final bool isExpired;

  @override
  String toString() {
    return 'AuthErrorResponseModel(message: $message, email: $email, isExpired: $isExpired)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AuthErrorResponseModelImpl &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.isExpired, isExpired) ||
                other.isExpired == isExpired));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, message, email, isExpired);

  /// Create a copy of AuthErrorResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AuthErrorResponseModelImplCopyWith<_$AuthErrorResponseModelImpl>
  get copyWith =>
      __$$AuthErrorResponseModelImplCopyWithImpl<_$AuthErrorResponseModelImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$AuthErrorResponseModelImplToJson(this);
  }
}

abstract class _AuthErrorResponseModel extends AuthErrorResponseModel {
  const factory _AuthErrorResponseModel({
    @JsonKey(name: SecurityJsonKeys.message) required final String message,
    @JsonKey(name: SecurityJsonKeys.email) final String? email,
    @JsonKey(name: SecurityJsonKeys.isExpired) final bool isExpired,
  }) = _$AuthErrorResponseModelImpl;
  const _AuthErrorResponseModel._() : super._();

  factory _AuthErrorResponseModel.fromJson(Map<String, dynamic> json) =
      _$AuthErrorResponseModelImpl.fromJson;

  @override
  @JsonKey(name: SecurityJsonKeys.message)
  String get message;
  @override
  @JsonKey(name: SecurityJsonKeys.email)
  String? get email;
  @override
  @JsonKey(name: SecurityJsonKeys.isExpired)
  bool get isExpired;

  /// Create a copy of AuthErrorResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AuthErrorResponseModelImplCopyWith<_$AuthErrorResponseModelImpl>
  get copyWith => throw _privateConstructorUsedError;
}
