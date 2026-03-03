// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'restaurant_marker_response_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

RestaurantMarkerResponseModel _$RestaurantMarkerResponseModelFromJson(
  Map<String, dynamic> json,
) {
  return _RestaurantMarkerResponseModel.fromJson(json);
}

/// @nodoc
mixin _$RestaurantMarkerResponseModel {
  /// Může přijít null z backendu, pokud jde o agregovaný bod
  String? get id => throw _privateConstructorUsedError;
  double get latitude => throw _privateConstructorUsedError;
  double get longitude => throw _privateConstructorUsedError;

  /// Backend nyní vrací počet prvků
  int get count => throw _privateConstructorUsedError;

  /// Serializes this RestaurantMarkerResponseModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of RestaurantMarkerResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $RestaurantMarkerResponseModelCopyWith<RestaurantMarkerResponseModel>
  get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RestaurantMarkerResponseModelCopyWith<$Res> {
  factory $RestaurantMarkerResponseModelCopyWith(
    RestaurantMarkerResponseModel value,
    $Res Function(RestaurantMarkerResponseModel) then,
  ) =
      _$RestaurantMarkerResponseModelCopyWithImpl<
        $Res,
        RestaurantMarkerResponseModel
      >;
  @useResult
  $Res call({String? id, double latitude, double longitude, int count});
}

/// @nodoc
class _$RestaurantMarkerResponseModelCopyWithImpl<
  $Res,
  $Val extends RestaurantMarkerResponseModel
>
    implements $RestaurantMarkerResponseModelCopyWith<$Res> {
  _$RestaurantMarkerResponseModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of RestaurantMarkerResponseModel
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
abstract class _$$RestaurantMarkerResponseModelImplCopyWith<$Res>
    implements $RestaurantMarkerResponseModelCopyWith<$Res> {
  factory _$$RestaurantMarkerResponseModelImplCopyWith(
    _$RestaurantMarkerResponseModelImpl value,
    $Res Function(_$RestaurantMarkerResponseModelImpl) then,
  ) = __$$RestaurantMarkerResponseModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? id, double latitude, double longitude, int count});
}

/// @nodoc
class __$$RestaurantMarkerResponseModelImplCopyWithImpl<$Res>
    extends
        _$RestaurantMarkerResponseModelCopyWithImpl<
          $Res,
          _$RestaurantMarkerResponseModelImpl
        >
    implements _$$RestaurantMarkerResponseModelImplCopyWith<$Res> {
  __$$RestaurantMarkerResponseModelImplCopyWithImpl(
    _$RestaurantMarkerResponseModelImpl _value,
    $Res Function(_$RestaurantMarkerResponseModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of RestaurantMarkerResponseModel
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
      _$RestaurantMarkerResponseModelImpl(
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
@JsonSerializable()
class _$RestaurantMarkerResponseModelImpl
    extends _RestaurantMarkerResponseModel {
  const _$RestaurantMarkerResponseModelImpl({
    this.id,
    required this.latitude,
    required this.longitude,
    required this.count,
  }) : super._();

  factory _$RestaurantMarkerResponseModelImpl.fromJson(
    Map<String, dynamic> json,
  ) => _$$RestaurantMarkerResponseModelImplFromJson(json);

  /// Může přijít null z backendu, pokud jde o agregovaný bod
  @override
  final String? id;
  @override
  final double latitude;
  @override
  final double longitude;

  /// Backend nyní vrací počet prvků
  @override
  final int count;

  @override
  String toString() {
    return 'RestaurantMarkerResponseModel(id: $id, latitude: $latitude, longitude: $longitude, count: $count)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RestaurantMarkerResponseModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.latitude, latitude) ||
                other.latitude == latitude) &&
            (identical(other.longitude, longitude) ||
                other.longitude == longitude) &&
            (identical(other.count, count) || other.count == count));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, latitude, longitude, count);

  /// Create a copy of RestaurantMarkerResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$RestaurantMarkerResponseModelImplCopyWith<
    _$RestaurantMarkerResponseModelImpl
  >
  get copyWith => __$$RestaurantMarkerResponseModelImplCopyWithImpl<
    _$RestaurantMarkerResponseModelImpl
  >(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$RestaurantMarkerResponseModelImplToJson(this);
  }
}

abstract class _RestaurantMarkerResponseModel
    extends RestaurantMarkerResponseModel {
  const factory _RestaurantMarkerResponseModel({
    final String? id,
    required final double latitude,
    required final double longitude,
    required final int count,
  }) = _$RestaurantMarkerResponseModelImpl;
  const _RestaurantMarkerResponseModel._() : super._();

  factory _RestaurantMarkerResponseModel.fromJson(Map<String, dynamic> json) =
      _$RestaurantMarkerResponseModelImpl.fromJson;

  /// Může přijít null z backendu, pokud jde o agregovaný bod
  @override
  String? get id;
  @override
  double get latitude;
  @override
  double get longitude;

  /// Backend nyní vrací počet prvků
  @override
  int get count;

  /// Create a copy of RestaurantMarkerResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RestaurantMarkerResponseModelImplCopyWith<
    _$RestaurantMarkerResponseModelImpl
  >
  get copyWith => throw _privateConstructorUsedError;
}
