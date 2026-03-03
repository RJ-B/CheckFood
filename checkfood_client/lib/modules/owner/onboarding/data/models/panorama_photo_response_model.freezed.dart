// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'panorama_photo_response_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

PanoramaPhotoResponseModel _$PanoramaPhotoResponseModelFromJson(
  Map<String, dynamic> json,
) {
  return _PanoramaPhotoResponseModel.fromJson(json);
}

/// @nodoc
mixin _$PanoramaPhotoResponseModel {
  String? get id => throw _privateConstructorUsedError;
  int get angleIndex => throw _privateConstructorUsedError;
  double get targetAngle => throw _privateConstructorUsedError;
  double get actualAngle => throw _privateConstructorUsedError;
  String? get photoUrl => throw _privateConstructorUsedError;

  /// Serializes this PanoramaPhotoResponseModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PanoramaPhotoResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PanoramaPhotoResponseModelCopyWith<PanoramaPhotoResponseModel>
  get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PanoramaPhotoResponseModelCopyWith<$Res> {
  factory $PanoramaPhotoResponseModelCopyWith(
    PanoramaPhotoResponseModel value,
    $Res Function(PanoramaPhotoResponseModel) then,
  ) =
      _$PanoramaPhotoResponseModelCopyWithImpl<
        $Res,
        PanoramaPhotoResponseModel
      >;
  @useResult
  $Res call({
    String? id,
    int angleIndex,
    double targetAngle,
    double actualAngle,
    String? photoUrl,
  });
}

/// @nodoc
class _$PanoramaPhotoResponseModelCopyWithImpl<
  $Res,
  $Val extends PanoramaPhotoResponseModel
>
    implements $PanoramaPhotoResponseModelCopyWith<$Res> {
  _$PanoramaPhotoResponseModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PanoramaPhotoResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? angleIndex = null,
    Object? targetAngle = null,
    Object? actualAngle = null,
    Object? photoUrl = freezed,
  }) {
    return _then(
      _value.copyWith(
            id:
                freezed == id
                    ? _value.id
                    : id // ignore: cast_nullable_to_non_nullable
                        as String?,
            angleIndex:
                null == angleIndex
                    ? _value.angleIndex
                    : angleIndex // ignore: cast_nullable_to_non_nullable
                        as int,
            targetAngle:
                null == targetAngle
                    ? _value.targetAngle
                    : targetAngle // ignore: cast_nullable_to_non_nullable
                        as double,
            actualAngle:
                null == actualAngle
                    ? _value.actualAngle
                    : actualAngle // ignore: cast_nullable_to_non_nullable
                        as double,
            photoUrl:
                freezed == photoUrl
                    ? _value.photoUrl
                    : photoUrl // ignore: cast_nullable_to_non_nullable
                        as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$PanoramaPhotoResponseModelImplCopyWith<$Res>
    implements $PanoramaPhotoResponseModelCopyWith<$Res> {
  factory _$$PanoramaPhotoResponseModelImplCopyWith(
    _$PanoramaPhotoResponseModelImpl value,
    $Res Function(_$PanoramaPhotoResponseModelImpl) then,
  ) = __$$PanoramaPhotoResponseModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String? id,
    int angleIndex,
    double targetAngle,
    double actualAngle,
    String? photoUrl,
  });
}

/// @nodoc
class __$$PanoramaPhotoResponseModelImplCopyWithImpl<$Res>
    extends
        _$PanoramaPhotoResponseModelCopyWithImpl<
          $Res,
          _$PanoramaPhotoResponseModelImpl
        >
    implements _$$PanoramaPhotoResponseModelImplCopyWith<$Res> {
  __$$PanoramaPhotoResponseModelImplCopyWithImpl(
    _$PanoramaPhotoResponseModelImpl _value,
    $Res Function(_$PanoramaPhotoResponseModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of PanoramaPhotoResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? angleIndex = null,
    Object? targetAngle = null,
    Object? actualAngle = null,
    Object? photoUrl = freezed,
  }) {
    return _then(
      _$PanoramaPhotoResponseModelImpl(
        id:
            freezed == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                    as String?,
        angleIndex:
            null == angleIndex
                ? _value.angleIndex
                : angleIndex // ignore: cast_nullable_to_non_nullable
                    as int,
        targetAngle:
            null == targetAngle
                ? _value.targetAngle
                : targetAngle // ignore: cast_nullable_to_non_nullable
                    as double,
        actualAngle:
            null == actualAngle
                ? _value.actualAngle
                : actualAngle // ignore: cast_nullable_to_non_nullable
                    as double,
        photoUrl:
            freezed == photoUrl
                ? _value.photoUrl
                : photoUrl // ignore: cast_nullable_to_non_nullable
                    as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$PanoramaPhotoResponseModelImpl extends _PanoramaPhotoResponseModel {
  const _$PanoramaPhotoResponseModelImpl({
    this.id,
    this.angleIndex = 0,
    this.targetAngle = 0.0,
    this.actualAngle = 0.0,
    this.photoUrl,
  }) : super._();

  factory _$PanoramaPhotoResponseModelImpl.fromJson(
    Map<String, dynamic> json,
  ) => _$$PanoramaPhotoResponseModelImplFromJson(json);

  @override
  final String? id;
  @override
  @JsonKey()
  final int angleIndex;
  @override
  @JsonKey()
  final double targetAngle;
  @override
  @JsonKey()
  final double actualAngle;
  @override
  final String? photoUrl;

  @override
  String toString() {
    return 'PanoramaPhotoResponseModel(id: $id, angleIndex: $angleIndex, targetAngle: $targetAngle, actualAngle: $actualAngle, photoUrl: $photoUrl)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PanoramaPhotoResponseModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.angleIndex, angleIndex) ||
                other.angleIndex == angleIndex) &&
            (identical(other.targetAngle, targetAngle) ||
                other.targetAngle == targetAngle) &&
            (identical(other.actualAngle, actualAngle) ||
                other.actualAngle == actualAngle) &&
            (identical(other.photoUrl, photoUrl) ||
                other.photoUrl == photoUrl));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    angleIndex,
    targetAngle,
    actualAngle,
    photoUrl,
  );

  /// Create a copy of PanoramaPhotoResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PanoramaPhotoResponseModelImplCopyWith<_$PanoramaPhotoResponseModelImpl>
  get copyWith => __$$PanoramaPhotoResponseModelImplCopyWithImpl<
    _$PanoramaPhotoResponseModelImpl
  >(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PanoramaPhotoResponseModelImplToJson(this);
  }
}

abstract class _PanoramaPhotoResponseModel extends PanoramaPhotoResponseModel {
  const factory _PanoramaPhotoResponseModel({
    final String? id,
    final int angleIndex,
    final double targetAngle,
    final double actualAngle,
    final String? photoUrl,
  }) = _$PanoramaPhotoResponseModelImpl;
  const _PanoramaPhotoResponseModel._() : super._();

  factory _PanoramaPhotoResponseModel.fromJson(Map<String, dynamic> json) =
      _$PanoramaPhotoResponseModelImpl.fromJson;

  @override
  String? get id;
  @override
  int get angleIndex;
  @override
  double get targetAngle;
  @override
  double get actualAngle;
  @override
  String? get photoUrl;

  /// Create a copy of PanoramaPhotoResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PanoramaPhotoResponseModelImplCopyWith<_$PanoramaPhotoResponseModelImpl>
  get copyWith => throw _privateConstructorUsedError;
}
