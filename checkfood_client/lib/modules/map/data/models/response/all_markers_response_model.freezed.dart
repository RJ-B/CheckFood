// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'all_markers_response_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

AllMarkersResponseModel _$AllMarkersResponseModelFromJson(
  Map<String, dynamic> json,
) {
  return _AllMarkersResponseModel.fromJson(json);
}

/// @nodoc
mixin _$AllMarkersResponseModel {
  int get version => throw _privateConstructorUsedError;
  List<RestaurantMarkerLight> get data => throw _privateConstructorUsedError;

  /// Serializes this AllMarkersResponseModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of AllMarkersResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AllMarkersResponseModelCopyWith<AllMarkersResponseModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AllMarkersResponseModelCopyWith<$Res> {
  factory $AllMarkersResponseModelCopyWith(
    AllMarkersResponseModel value,
    $Res Function(AllMarkersResponseModel) then,
  ) = _$AllMarkersResponseModelCopyWithImpl<$Res, AllMarkersResponseModel>;
  @useResult
  $Res call({int version, List<RestaurantMarkerLight> data});
}

/// @nodoc
class _$AllMarkersResponseModelCopyWithImpl<
  $Res,
  $Val extends AllMarkersResponseModel
>
    implements $AllMarkersResponseModelCopyWith<$Res> {
  _$AllMarkersResponseModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AllMarkersResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? version = null, Object? data = null}) {
    return _then(
      _value.copyWith(
            version:
                null == version
                    ? _value.version
                    : version // ignore: cast_nullable_to_non_nullable
                        as int,
            data:
                null == data
                    ? _value.data
                    : data // ignore: cast_nullable_to_non_nullable
                        as List<RestaurantMarkerLight>,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$AllMarkersResponseModelImplCopyWith<$Res>
    implements $AllMarkersResponseModelCopyWith<$Res> {
  factory _$$AllMarkersResponseModelImplCopyWith(
    _$AllMarkersResponseModelImpl value,
    $Res Function(_$AllMarkersResponseModelImpl) then,
  ) = __$$AllMarkersResponseModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int version, List<RestaurantMarkerLight> data});
}

/// @nodoc
class __$$AllMarkersResponseModelImplCopyWithImpl<$Res>
    extends
        _$AllMarkersResponseModelCopyWithImpl<
          $Res,
          _$AllMarkersResponseModelImpl
        >
    implements _$$AllMarkersResponseModelImplCopyWith<$Res> {
  __$$AllMarkersResponseModelImplCopyWithImpl(
    _$AllMarkersResponseModelImpl _value,
    $Res Function(_$AllMarkersResponseModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AllMarkersResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? version = null, Object? data = null}) {
    return _then(
      _$AllMarkersResponseModelImpl(
        version:
            null == version
                ? _value.version
                : version // ignore: cast_nullable_to_non_nullable
                    as int,
        data:
            null == data
                ? _value._data
                : data // ignore: cast_nullable_to_non_nullable
                    as List<RestaurantMarkerLight>,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$AllMarkersResponseModelImpl implements _AllMarkersResponseModel {
  const _$AllMarkersResponseModelImpl({
    required this.version,
    required final List<RestaurantMarkerLight> data,
  }) : _data = data;

  factory _$AllMarkersResponseModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$AllMarkersResponseModelImplFromJson(json);

  @override
  final int version;
  final List<RestaurantMarkerLight> _data;
  @override
  List<RestaurantMarkerLight> get data {
    if (_data is EqualUnmodifiableListView) return _data;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_data);
  }

  @override
  String toString() {
    return 'AllMarkersResponseModel(version: $version, data: $data)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AllMarkersResponseModelImpl &&
            (identical(other.version, version) || other.version == version) &&
            const DeepCollectionEquality().equals(other._data, _data));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    version,
    const DeepCollectionEquality().hash(_data),
  );

  /// Create a copy of AllMarkersResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AllMarkersResponseModelImplCopyWith<_$AllMarkersResponseModelImpl>
  get copyWith => __$$AllMarkersResponseModelImplCopyWithImpl<
    _$AllMarkersResponseModelImpl
  >(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AllMarkersResponseModelImplToJson(this);
  }
}

abstract class _AllMarkersResponseModel implements AllMarkersResponseModel {
  const factory _AllMarkersResponseModel({
    required final int version,
    required final List<RestaurantMarkerLight> data,
  }) = _$AllMarkersResponseModelImpl;

  factory _AllMarkersResponseModel.fromJson(Map<String, dynamic> json) =
      _$AllMarkersResponseModelImpl.fromJson;

  @override
  int get version;
  @override
  List<RestaurantMarkerLight> get data;

  /// Create a copy of AllMarkersResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AllMarkersResponseModelImplCopyWith<_$AllMarkersResponseModelImpl>
  get copyWith => throw _privateConstructorUsedError;
}
