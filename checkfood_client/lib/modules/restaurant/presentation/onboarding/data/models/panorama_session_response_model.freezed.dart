// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'panorama_session_response_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

PanoramaSessionResponseModel _$PanoramaSessionResponseModelFromJson(
  Map<String, dynamic> json,
) {
  return _PanoramaSessionResponseModel.fromJson(json);
}

/// @nodoc
mixin _$PanoramaSessionResponseModel {
  String? get id => throw _privateConstructorUsedError;
  String? get status => throw _privateConstructorUsedError;
  int get photoCount => throw _privateConstructorUsedError;
  String? get resultUrl => throw _privateConstructorUsedError;
  String? get createdAt => throw _privateConstructorUsedError;
  String? get completedAt => throw _privateConstructorUsedError;

  /// Serializes this PanoramaSessionResponseModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PanoramaSessionResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PanoramaSessionResponseModelCopyWith<PanoramaSessionResponseModel>
  get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PanoramaSessionResponseModelCopyWith<$Res> {
  factory $PanoramaSessionResponseModelCopyWith(
    PanoramaSessionResponseModel value,
    $Res Function(PanoramaSessionResponseModel) then,
  ) =
      _$PanoramaSessionResponseModelCopyWithImpl<
        $Res,
        PanoramaSessionResponseModel
      >;
  @useResult
  $Res call({
    String? id,
    String? status,
    int photoCount,
    String? resultUrl,
    String? createdAt,
    String? completedAt,
  });
}

/// @nodoc
class _$PanoramaSessionResponseModelCopyWithImpl<
  $Res,
  $Val extends PanoramaSessionResponseModel
>
    implements $PanoramaSessionResponseModelCopyWith<$Res> {
  _$PanoramaSessionResponseModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PanoramaSessionResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? status = freezed,
    Object? photoCount = null,
    Object? resultUrl = freezed,
    Object? createdAt = freezed,
    Object? completedAt = freezed,
  }) {
    return _then(
      _value.copyWith(
            id:
                freezed == id
                    ? _value.id
                    : id // ignore: cast_nullable_to_non_nullable
                        as String?,
            status:
                freezed == status
                    ? _value.status
                    : status // ignore: cast_nullable_to_non_nullable
                        as String?,
            photoCount:
                null == photoCount
                    ? _value.photoCount
                    : photoCount // ignore: cast_nullable_to_non_nullable
                        as int,
            resultUrl:
                freezed == resultUrl
                    ? _value.resultUrl
                    : resultUrl // ignore: cast_nullable_to_non_nullable
                        as String?,
            createdAt:
                freezed == createdAt
                    ? _value.createdAt
                    : createdAt // ignore: cast_nullable_to_non_nullable
                        as String?,
            completedAt:
                freezed == completedAt
                    ? _value.completedAt
                    : completedAt // ignore: cast_nullable_to_non_nullable
                        as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$PanoramaSessionResponseModelImplCopyWith<$Res>
    implements $PanoramaSessionResponseModelCopyWith<$Res> {
  factory _$$PanoramaSessionResponseModelImplCopyWith(
    _$PanoramaSessionResponseModelImpl value,
    $Res Function(_$PanoramaSessionResponseModelImpl) then,
  ) = __$$PanoramaSessionResponseModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String? id,
    String? status,
    int photoCount,
    String? resultUrl,
    String? createdAt,
    String? completedAt,
  });
}

/// @nodoc
class __$$PanoramaSessionResponseModelImplCopyWithImpl<$Res>
    extends
        _$PanoramaSessionResponseModelCopyWithImpl<
          $Res,
          _$PanoramaSessionResponseModelImpl
        >
    implements _$$PanoramaSessionResponseModelImplCopyWith<$Res> {
  __$$PanoramaSessionResponseModelImplCopyWithImpl(
    _$PanoramaSessionResponseModelImpl _value,
    $Res Function(_$PanoramaSessionResponseModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of PanoramaSessionResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? status = freezed,
    Object? photoCount = null,
    Object? resultUrl = freezed,
    Object? createdAt = freezed,
    Object? completedAt = freezed,
  }) {
    return _then(
      _$PanoramaSessionResponseModelImpl(
        id:
            freezed == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                    as String?,
        status:
            freezed == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                    as String?,
        photoCount:
            null == photoCount
                ? _value.photoCount
                : photoCount // ignore: cast_nullable_to_non_nullable
                    as int,
        resultUrl:
            freezed == resultUrl
                ? _value.resultUrl
                : resultUrl // ignore: cast_nullable_to_non_nullable
                    as String?,
        createdAt:
            freezed == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                    as String?,
        completedAt:
            freezed == completedAt
                ? _value.completedAt
                : completedAt // ignore: cast_nullable_to_non_nullable
                    as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$PanoramaSessionResponseModelImpl extends _PanoramaSessionResponseModel {
  const _$PanoramaSessionResponseModelImpl({
    this.id,
    this.status,
    this.photoCount = 0,
    this.resultUrl,
    this.createdAt,
    this.completedAt,
  }) : super._();

  factory _$PanoramaSessionResponseModelImpl.fromJson(
    Map<String, dynamic> json,
  ) => _$$PanoramaSessionResponseModelImplFromJson(json);

  @override
  final String? id;
  @override
  final String? status;
  @override
  @JsonKey()
  final int photoCount;
  @override
  final String? resultUrl;
  @override
  final String? createdAt;
  @override
  final String? completedAt;

  @override
  String toString() {
    return 'PanoramaSessionResponseModel(id: $id, status: $status, photoCount: $photoCount, resultUrl: $resultUrl, createdAt: $createdAt, completedAt: $completedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PanoramaSessionResponseModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.photoCount, photoCount) ||
                other.photoCount == photoCount) &&
            (identical(other.resultUrl, resultUrl) ||
                other.resultUrl == resultUrl) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.completedAt, completedAt) ||
                other.completedAt == completedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    status,
    photoCount,
    resultUrl,
    createdAt,
    completedAt,
  );

  /// Create a copy of PanoramaSessionResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PanoramaSessionResponseModelImplCopyWith<
    _$PanoramaSessionResponseModelImpl
  >
  get copyWith => __$$PanoramaSessionResponseModelImplCopyWithImpl<
    _$PanoramaSessionResponseModelImpl
  >(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PanoramaSessionResponseModelImplToJson(this);
  }
}

abstract class _PanoramaSessionResponseModel
    extends PanoramaSessionResponseModel {
  const factory _PanoramaSessionResponseModel({
    final String? id,
    final String? status,
    final int photoCount,
    final String? resultUrl,
    final String? createdAt,
    final String? completedAt,
  }) = _$PanoramaSessionResponseModelImpl;
  const _PanoramaSessionResponseModel._() : super._();

  factory _PanoramaSessionResponseModel.fromJson(Map<String, dynamic> json) =
      _$PanoramaSessionResponseModelImpl.fromJson;

  @override
  String? get id;
  @override
  String? get status;
  @override
  int get photoCount;
  @override
  String? get resultUrl;
  @override
  String? get createdAt;
  @override
  String? get completedAt;

  /// Create a copy of PanoramaSessionResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PanoramaSessionResponseModelImplCopyWith<
    _$PanoramaSessionResponseModelImpl
  >
  get copyWith => throw _privateConstructorUsedError;
}
