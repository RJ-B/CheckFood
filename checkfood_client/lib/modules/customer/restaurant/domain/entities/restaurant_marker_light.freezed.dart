// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'restaurant_marker_light.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

RestaurantMarkerLight _$RestaurantMarkerLightFromJson(
  Map<String, dynamic> json,
) {
  return _RestaurantMarkerLight.fromJson(json);
}

/// @nodoc
mixin _$RestaurantMarkerLight {
  String get id => throw _privateConstructorUsedError;
  double get latitude => throw _privateConstructorUsedError;
  double get longitude => throw _privateConstructorUsedError;
  String? get name => throw _privateConstructorUsedError;
  @JsonKey(name: 'logoUrl')
  String? get logoUrl => throw _privateConstructorUsedError;

  /// Serializes this RestaurantMarkerLight to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of RestaurantMarkerLight
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $RestaurantMarkerLightCopyWith<RestaurantMarkerLight> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RestaurantMarkerLightCopyWith<$Res> {
  factory $RestaurantMarkerLightCopyWith(
    RestaurantMarkerLight value,
    $Res Function(RestaurantMarkerLight) then,
  ) = _$RestaurantMarkerLightCopyWithImpl<$Res, RestaurantMarkerLight>;
  @useResult
  $Res call({
    String id,
    double latitude,
    double longitude,
    String? name,
    @JsonKey(name: 'logoUrl') String? logoUrl,
  });
}

/// @nodoc
class _$RestaurantMarkerLightCopyWithImpl<
  $Res,
  $Val extends RestaurantMarkerLight
>
    implements $RestaurantMarkerLightCopyWith<$Res> {
  _$RestaurantMarkerLightCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of RestaurantMarkerLight
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? latitude = null,
    Object? longitude = null,
    Object? name = freezed,
    Object? logoUrl = freezed,
  }) {
    return _then(
      _value.copyWith(
            id:
                null == id
                    ? _value.id
                    : id // ignore: cast_nullable_to_non_nullable
                        as String,
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
            name:
                freezed == name
                    ? _value.name
                    : name // ignore: cast_nullable_to_non_nullable
                        as String?,
            logoUrl:
                freezed == logoUrl
                    ? _value.logoUrl
                    : logoUrl // ignore: cast_nullable_to_non_nullable
                        as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$RestaurantMarkerLightImplCopyWith<$Res>
    implements $RestaurantMarkerLightCopyWith<$Res> {
  factory _$$RestaurantMarkerLightImplCopyWith(
    _$RestaurantMarkerLightImpl value,
    $Res Function(_$RestaurantMarkerLightImpl) then,
  ) = __$$RestaurantMarkerLightImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    double latitude,
    double longitude,
    String? name,
    @JsonKey(name: 'logoUrl') String? logoUrl,
  });
}

/// @nodoc
class __$$RestaurantMarkerLightImplCopyWithImpl<$Res>
    extends
        _$RestaurantMarkerLightCopyWithImpl<$Res, _$RestaurantMarkerLightImpl>
    implements _$$RestaurantMarkerLightImplCopyWith<$Res> {
  __$$RestaurantMarkerLightImplCopyWithImpl(
    _$RestaurantMarkerLightImpl _value,
    $Res Function(_$RestaurantMarkerLightImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of RestaurantMarkerLight
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? latitude = null,
    Object? longitude = null,
    Object? name = freezed,
    Object? logoUrl = freezed,
  }) {
    return _then(
      _$RestaurantMarkerLightImpl(
        id:
            null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                    as String,
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
        name:
            freezed == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                    as String?,
        logoUrl:
            freezed == logoUrl
                ? _value.logoUrl
                : logoUrl // ignore: cast_nullable_to_non_nullable
                    as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$RestaurantMarkerLightImpl implements _RestaurantMarkerLight {
  const _$RestaurantMarkerLightImpl({
    required this.id,
    required this.latitude,
    required this.longitude,
    this.name,
    @JsonKey(name: 'logoUrl') this.logoUrl,
  });

  factory _$RestaurantMarkerLightImpl.fromJson(Map<String, dynamic> json) =>
      _$$RestaurantMarkerLightImplFromJson(json);

  @override
  final String id;
  @override
  final double latitude;
  @override
  final double longitude;
  @override
  final String? name;
  @override
  @JsonKey(name: 'logoUrl')
  final String? logoUrl;

  @override
  String toString() {
    return 'RestaurantMarkerLight(id: $id, latitude: $latitude, longitude: $longitude, name: $name, logoUrl: $logoUrl)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RestaurantMarkerLightImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.latitude, latitude) ||
                other.latitude == latitude) &&
            (identical(other.longitude, longitude) ||
                other.longitude == longitude) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.logoUrl, logoUrl) || other.logoUrl == logoUrl));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, latitude, longitude, name, logoUrl);

  /// Create a copy of RestaurantMarkerLight
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$RestaurantMarkerLightImplCopyWith<_$RestaurantMarkerLightImpl>
  get copyWith =>
      __$$RestaurantMarkerLightImplCopyWithImpl<_$RestaurantMarkerLightImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$RestaurantMarkerLightImplToJson(this);
  }
}

abstract class _RestaurantMarkerLight implements RestaurantMarkerLight {
  const factory _RestaurantMarkerLight({
    required final String id,
    required final double latitude,
    required final double longitude,
    final String? name,
    @JsonKey(name: 'logoUrl') final String? logoUrl,
  }) = _$RestaurantMarkerLightImpl;

  factory _RestaurantMarkerLight.fromJson(Map<String, dynamic> json) =
      _$RestaurantMarkerLightImpl.fromJson;

  @override
  String get id;
  @override
  double get latitude;
  @override
  double get longitude;
  @override
  String? get name;
  @override
  @JsonKey(name: 'logoUrl')
  String? get logoUrl;

  /// Create a copy of RestaurantMarkerLight
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RestaurantMarkerLightImplCopyWith<_$RestaurantMarkerLightImpl>
  get copyWith => throw _privateConstructorUsedError;
}
