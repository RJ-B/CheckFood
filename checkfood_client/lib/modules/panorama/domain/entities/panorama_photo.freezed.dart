// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'panorama_photo.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$PanoramaPhoto {
  String get id => throw _privateConstructorUsedError;
  int get angleIndex => throw _privateConstructorUsedError;
  double get targetAngle => throw _privateConstructorUsedError;
  double get actualAngle => throw _privateConstructorUsedError;
  String? get photoUrl => throw _privateConstructorUsedError;

  /// Create a copy of PanoramaPhoto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PanoramaPhotoCopyWith<PanoramaPhoto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PanoramaPhotoCopyWith<$Res> {
  factory $PanoramaPhotoCopyWith(
    PanoramaPhoto value,
    $Res Function(PanoramaPhoto) then,
  ) = _$PanoramaPhotoCopyWithImpl<$Res, PanoramaPhoto>;
  @useResult
  $Res call({
    String id,
    int angleIndex,
    double targetAngle,
    double actualAngle,
    String? photoUrl,
  });
}

/// @nodoc
class _$PanoramaPhotoCopyWithImpl<$Res, $Val extends PanoramaPhoto>
    implements $PanoramaPhotoCopyWith<$Res> {
  _$PanoramaPhotoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PanoramaPhoto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? angleIndex = null,
    Object? targetAngle = null,
    Object? actualAngle = null,
    Object? photoUrl = freezed,
  }) {
    return _then(
      _value.copyWith(
            id:
                null == id
                    ? _value.id
                    : id // ignore: cast_nullable_to_non_nullable
                        as String,
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
abstract class _$$PanoramaPhotoImplCopyWith<$Res>
    implements $PanoramaPhotoCopyWith<$Res> {
  factory _$$PanoramaPhotoImplCopyWith(
    _$PanoramaPhotoImpl value,
    $Res Function(_$PanoramaPhotoImpl) then,
  ) = __$$PanoramaPhotoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    int angleIndex,
    double targetAngle,
    double actualAngle,
    String? photoUrl,
  });
}

/// @nodoc
class __$$PanoramaPhotoImplCopyWithImpl<$Res>
    extends _$PanoramaPhotoCopyWithImpl<$Res, _$PanoramaPhotoImpl>
    implements _$$PanoramaPhotoImplCopyWith<$Res> {
  __$$PanoramaPhotoImplCopyWithImpl(
    _$PanoramaPhotoImpl _value,
    $Res Function(_$PanoramaPhotoImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of PanoramaPhoto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? angleIndex = null,
    Object? targetAngle = null,
    Object? actualAngle = null,
    Object? photoUrl = freezed,
  }) {
    return _then(
      _$PanoramaPhotoImpl(
        id:
            null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                    as String,
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

class _$PanoramaPhotoImpl implements _PanoramaPhoto {
  const _$PanoramaPhotoImpl({
    required this.id,
    this.angleIndex = 0,
    this.targetAngle = 0.0,
    this.actualAngle = 0.0,
    this.photoUrl,
  });

  @override
  final String id;
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
    return 'PanoramaPhoto(id: $id, angleIndex: $angleIndex, targetAngle: $targetAngle, actualAngle: $actualAngle, photoUrl: $photoUrl)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PanoramaPhotoImpl &&
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

  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    angleIndex,
    targetAngle,
    actualAngle,
    photoUrl,
  );

  /// Create a copy of PanoramaPhoto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PanoramaPhotoImplCopyWith<_$PanoramaPhotoImpl> get copyWith =>
      __$$PanoramaPhotoImplCopyWithImpl<_$PanoramaPhotoImpl>(this, _$identity);
}

abstract class _PanoramaPhoto implements PanoramaPhoto {
  const factory _PanoramaPhoto({
    required final String id,
    final int angleIndex,
    final double targetAngle,
    final double actualAngle,
    final String? photoUrl,
  }) = _$PanoramaPhotoImpl;

  @override
  String get id;
  @override
  int get angleIndex;
  @override
  double get targetAngle;
  @override
  double get actualAngle;
  @override
  String? get photoUrl;

  /// Create a copy of PanoramaPhoto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PanoramaPhotoImplCopyWith<_$PanoramaPhotoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
