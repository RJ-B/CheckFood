// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'panorama_session.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$PanoramaSession {
  String get id => throw _privateConstructorUsedError;
  String get status => throw _privateConstructorUsedError;
  int get photoCount => throw _privateConstructorUsedError;
  String? get resultUrl => throw _privateConstructorUsedError;
  String? get createdAt => throw _privateConstructorUsedError;
  String? get completedAt => throw _privateConstructorUsedError;

  /// Create a copy of PanoramaSession
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PanoramaSessionCopyWith<PanoramaSession> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PanoramaSessionCopyWith<$Res> {
  factory $PanoramaSessionCopyWith(
    PanoramaSession value,
    $Res Function(PanoramaSession) then,
  ) = _$PanoramaSessionCopyWithImpl<$Res, PanoramaSession>;
  @useResult
  $Res call({
    String id,
    String status,
    int photoCount,
    String? resultUrl,
    String? createdAt,
    String? completedAt,
  });
}

/// @nodoc
class _$PanoramaSessionCopyWithImpl<$Res, $Val extends PanoramaSession>
    implements $PanoramaSessionCopyWith<$Res> {
  _$PanoramaSessionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PanoramaSession
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? status = null,
    Object? photoCount = null,
    Object? resultUrl = freezed,
    Object? createdAt = freezed,
    Object? completedAt = freezed,
  }) {
    return _then(
      _value.copyWith(
            id:
                null == id
                    ? _value.id
                    : id // ignore: cast_nullable_to_non_nullable
                        as String,
            status:
                null == status
                    ? _value.status
                    : status // ignore: cast_nullable_to_non_nullable
                        as String,
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
abstract class _$$PanoramaSessionImplCopyWith<$Res>
    implements $PanoramaSessionCopyWith<$Res> {
  factory _$$PanoramaSessionImplCopyWith(
    _$PanoramaSessionImpl value,
    $Res Function(_$PanoramaSessionImpl) then,
  ) = __$$PanoramaSessionImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String status,
    int photoCount,
    String? resultUrl,
    String? createdAt,
    String? completedAt,
  });
}

/// @nodoc
class __$$PanoramaSessionImplCopyWithImpl<$Res>
    extends _$PanoramaSessionCopyWithImpl<$Res, _$PanoramaSessionImpl>
    implements _$$PanoramaSessionImplCopyWith<$Res> {
  __$$PanoramaSessionImplCopyWithImpl(
    _$PanoramaSessionImpl _value,
    $Res Function(_$PanoramaSessionImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of PanoramaSession
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? status = null,
    Object? photoCount = null,
    Object? resultUrl = freezed,
    Object? createdAt = freezed,
    Object? completedAt = freezed,
  }) {
    return _then(
      _$PanoramaSessionImpl(
        id:
            null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                    as String,
        status:
            null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                    as String,
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

class _$PanoramaSessionImpl implements _PanoramaSession {
  const _$PanoramaSessionImpl({
    required this.id,
    required this.status,
    this.photoCount = 0,
    this.resultUrl,
    this.createdAt,
    this.completedAt,
  });

  @override
  final String id;
  @override
  final String status;
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
    return 'PanoramaSession(id: $id, status: $status, photoCount: $photoCount, resultUrl: $resultUrl, createdAt: $createdAt, completedAt: $completedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PanoramaSessionImpl &&
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

  /// Create a copy of PanoramaSession
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PanoramaSessionImplCopyWith<_$PanoramaSessionImpl> get copyWith =>
      __$$PanoramaSessionImplCopyWithImpl<_$PanoramaSessionImpl>(
        this,
        _$identity,
      );
}

abstract class _PanoramaSession implements PanoramaSession {
  const factory _PanoramaSession({
    required final String id,
    required final String status,
    final int photoCount,
    final String? resultUrl,
    final String? createdAt,
    final String? completedAt,
  }) = _$PanoramaSessionImpl;

  @override
  String get id;
  @override
  String get status;
  @override
  int get photoCount;
  @override
  String? get resultUrl;
  @override
  String? get createdAt;
  @override
  String? get completedAt;

  /// Create a copy of PanoramaSession
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PanoramaSessionImplCopyWith<_$PanoramaSessionImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
