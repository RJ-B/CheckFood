// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'restaurant_marker.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$RestaurantMarker {
  /// ID je null, pokud se jedná o shluk (cluster).
  /// Pokud count == 1, obsahuje reálné ID restaurace.
  String? get id => throw _privateConstructorUsedError;
  double get latitude => throw _privateConstructorUsedError;
  double get longitude => throw _privateConstructorUsedError;

  /// Počet restaurací v tomto bodě.
  /// 1 = samostatná restaurace
  /// >1 = shluk
  int get count => throw _privateConstructorUsedError;

  /// Create a copy of RestaurantMarker
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $RestaurantMarkerCopyWith<RestaurantMarker> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RestaurantMarkerCopyWith<$Res> {
  factory $RestaurantMarkerCopyWith(
    RestaurantMarker value,
    $Res Function(RestaurantMarker) then,
  ) = _$RestaurantMarkerCopyWithImpl<$Res, RestaurantMarker>;
  @useResult
  $Res call({String? id, double latitude, double longitude, int count});
}

/// @nodoc
class _$RestaurantMarkerCopyWithImpl<$Res, $Val extends RestaurantMarker>
    implements $RestaurantMarkerCopyWith<$Res> {
  _$RestaurantMarkerCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of RestaurantMarker
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? latitude = null,
    Object? longitude = null,
    Object? count = null,
  }) {
    return _then(
      _value.copyWith(
            id:
                freezed == id
                    ? _value.id
                    : id // ignore: cast_nullable_to_non_nullable
                        as String?,
            latitude:
                null == latitude
                    ? _value.latitude
                    : latitude // ignore: cast_nullable_to_non_nullable
                        as double,
            longitude:
                null == longitude
                    ? _value.longitude
                    : longitude // ignore: cast_nullable_to_non_nullable
                        as double,
            count:
                null == count
                    ? _value.count
                    : count // ignore: cast_nullable_to_non_nullable
                        as int,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$RestaurantMarkerImplCopyWith<$Res>
    implements $RestaurantMarkerCopyWith<$Res> {
  factory _$$RestaurantMarkerImplCopyWith(
    _$RestaurantMarkerImpl value,
    $Res Function(_$RestaurantMarkerImpl) then,
  ) = __$$RestaurantMarkerImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? id, double latitude, double longitude, int count});
}

/// @nodoc
class __$$RestaurantMarkerImplCopyWithImpl<$Res>
    extends _$RestaurantMarkerCopyWithImpl<$Res, _$RestaurantMarkerImpl>
    implements _$$RestaurantMarkerImplCopyWith<$Res> {
  __$$RestaurantMarkerImplCopyWithImpl(
    _$RestaurantMarkerImpl _value,
    $Res Function(_$RestaurantMarkerImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of RestaurantMarker
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? latitude = null,
    Object? longitude = null,
    Object? count = null,
  }) {
    return _then(
      _$RestaurantMarkerImpl(
        id:
            freezed == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                    as String?,
        latitude:
            null == latitude
                ? _value.latitude
                : latitude // ignore: cast_nullable_to_non_nullable
                    as double,
        longitude:
            null == longitude
                ? _value.longitude
                : longitude // ignore: cast_nullable_to_non_nullable
                    as double,
        count:
            null == count
                ? _value.count
                : count // ignore: cast_nullable_to_non_nullable
                    as int,
      ),
    );
  }
}

/// @nodoc

class _$RestaurantMarkerImpl extends _RestaurantMarker {
  const _$RestaurantMarkerImpl({
    this.id,
    required this.latitude,
    required this.longitude,
    required this.count,
  }) : super._();

  /// ID je null, pokud se jedná o shluk (cluster).
  /// Pokud count == 1, obsahuje reálné ID restaurace.
  @override
  final String? id;
  @override
  final double latitude;
  @override
  final double longitude;

  /// Počet restaurací v tomto bodě.
  /// 1 = samostatná restaurace
  /// >1 = shluk
  @override
  final int count;

  @override
  String toString() {
    return 'RestaurantMarker(id: $id, latitude: $latitude, longitude: $longitude, count: $count)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RestaurantMarkerImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.latitude, latitude) ||
                other.latitude == latitude) &&
            (identical(other.longitude, longitude) ||
                other.longitude == longitude) &&
            (identical(other.count, count) || other.count == count));
  }

  @override
  int get hashCode => Object.hash(runtimeType, id, latitude, longitude, count);

  /// Create a copy of RestaurantMarker
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$RestaurantMarkerImplCopyWith<_$RestaurantMarkerImpl> get copyWith =>
      __$$RestaurantMarkerImplCopyWithImpl<_$RestaurantMarkerImpl>(
        this,
        _$identity,
      );
}

abstract class _RestaurantMarker extends RestaurantMarker {
  const factory _RestaurantMarker({
    final String? id,
    required final double latitude,
    required final double longitude,
    required final int count,
  }) = _$RestaurantMarkerImpl;
  const _RestaurantMarker._() : super._();

  /// ID je null, pokud se jedná o shluk (cluster).
  /// Pokud count == 1, obsahuje reálné ID restaurace.
  @override
  String? get id;
  @override
  double get latitude;
  @override
  double get longitude;

  /// Počet restaurací v tomto bodě.
  /// 1 = samostatná restaurace
  /// >1 = shluk
  @override
  int get count;

  /// Create a copy of RestaurantMarker
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RestaurantMarkerImplCopyWith<_$RestaurantMarkerImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
