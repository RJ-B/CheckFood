// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'map_params_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$MapParamsModel {
  LatLngBounds get bounds => throw _privateConstructorUsedError;
  int get zoom => throw _privateConstructorUsedError;

  /// Create a copy of MapParamsModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $MapParamsModelCopyWith<MapParamsModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MapParamsModelCopyWith<$Res> {
  factory $MapParamsModelCopyWith(
    MapParamsModel value,
    $Res Function(MapParamsModel) then,
  ) = _$MapParamsModelCopyWithImpl<$Res, MapParamsModel>;
  @useResult
  $Res call({LatLngBounds bounds, int zoom});
}

/// @nodoc
class _$MapParamsModelCopyWithImpl<$Res, $Val extends MapParamsModel>
    implements $MapParamsModelCopyWith<$Res> {
  _$MapParamsModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of MapParamsModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? bounds = null, Object? zoom = null}) {
    return _then(
      _value.copyWith(
            bounds:
                null == bounds
                    ? _value.bounds
                    : bounds // ignore: cast_nullable_to_non_nullable
                        as LatLngBounds,
            zoom:
                null == zoom
                    ? _value.zoom
                    : zoom // ignore: cast_nullable_to_non_nullable
                        as int,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$MapParamsModelImplCopyWith<$Res>
    implements $MapParamsModelCopyWith<$Res> {
  factory _$$MapParamsModelImplCopyWith(
    _$MapParamsModelImpl value,
    $Res Function(_$MapParamsModelImpl) then,
  ) = __$$MapParamsModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({LatLngBounds bounds, int zoom});
}

/// @nodoc
class __$$MapParamsModelImplCopyWithImpl<$Res>
    extends _$MapParamsModelCopyWithImpl<$Res, _$MapParamsModelImpl>
    implements _$$MapParamsModelImplCopyWith<$Res> {
  __$$MapParamsModelImplCopyWithImpl(
    _$MapParamsModelImpl _value,
    $Res Function(_$MapParamsModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of MapParamsModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? bounds = null, Object? zoom = null}) {
    return _then(
      _$MapParamsModelImpl(
        bounds:
            null == bounds
                ? _value.bounds
                : bounds // ignore: cast_nullable_to_non_nullable
                    as LatLngBounds,
        zoom:
            null == zoom
                ? _value.zoom
                : zoom // ignore: cast_nullable_to_non_nullable
                    as int,
      ),
    );
  }
}

/// @nodoc

class _$MapParamsModelImpl extends _MapParamsModel {
  const _$MapParamsModelImpl({required this.bounds, required this.zoom})
    : super._();

  @override
  final LatLngBounds bounds;
  @override
  final int zoom;

  @override
  String toString() {
    return 'MapParamsModel(bounds: $bounds, zoom: $zoom)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MapParamsModelImpl &&
            (identical(other.bounds, bounds) || other.bounds == bounds) &&
            (identical(other.zoom, zoom) || other.zoom == zoom));
  }

  @override
  int get hashCode => Object.hash(runtimeType, bounds, zoom);

  /// Create a copy of MapParamsModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MapParamsModelImplCopyWith<_$MapParamsModelImpl> get copyWith =>
      __$$MapParamsModelImplCopyWithImpl<_$MapParamsModelImpl>(
        this,
        _$identity,
      );
}

abstract class _MapParamsModel extends MapParamsModel {
  const factory _MapParamsModel({
    required final LatLngBounds bounds,
    required final int zoom,
  }) = _$MapParamsModelImpl;
  const _MapParamsModel._() : super._();

  @override
  LatLngBounds get bounds;
  @override
  int get zoom;

  /// Create a copy of MapParamsModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MapParamsModelImplCopyWith<_$MapParamsModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
