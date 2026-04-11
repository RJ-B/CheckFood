// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'restaurant_photo_response_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

RestaurantPhotoResponseModel _$RestaurantPhotoResponseModelFromJson(
  Map<String, dynamic> json,
) {
  return _RestaurantPhotoResponseModel.fromJson(json);
}

/// @nodoc
mixin _$RestaurantPhotoResponseModel {
  String get id => throw _privateConstructorUsedError;
  String get url => throw _privateConstructorUsedError;
  int get sortOrder => throw _privateConstructorUsedError;

  /// Serializes this RestaurantPhotoResponseModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of RestaurantPhotoResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $RestaurantPhotoResponseModelCopyWith<RestaurantPhotoResponseModel>
  get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RestaurantPhotoResponseModelCopyWith<$Res> {
  factory $RestaurantPhotoResponseModelCopyWith(
    RestaurantPhotoResponseModel value,
    $Res Function(RestaurantPhotoResponseModel) then,
  ) =
      _$RestaurantPhotoResponseModelCopyWithImpl<
        $Res,
        RestaurantPhotoResponseModel
      >;
  @useResult
  $Res call({String id, String url, int sortOrder});
}

/// @nodoc
class _$RestaurantPhotoResponseModelCopyWithImpl<
  $Res,
  $Val extends RestaurantPhotoResponseModel
>
    implements $RestaurantPhotoResponseModelCopyWith<$Res> {
  _$RestaurantPhotoResponseModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of RestaurantPhotoResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? id = null, Object? url = null, Object? sortOrder = null}) {
    return _then(
      _value.copyWith(
            id:
                null == id
                    ? _value.id
                    : id // ignore: cast_nullable_to_non_nullable
                        as String,
            url:
                null == url
                    ? _value.url
                    : url // ignore: cast_nullable_to_non_nullable
                        as String,
            sortOrder:
                null == sortOrder
                    ? _value.sortOrder
                    : sortOrder // ignore: cast_nullable_to_non_nullable
                        as int,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$RestaurantPhotoResponseModelImplCopyWith<$Res>
    implements $RestaurantPhotoResponseModelCopyWith<$Res> {
  factory _$$RestaurantPhotoResponseModelImplCopyWith(
    _$RestaurantPhotoResponseModelImpl value,
    $Res Function(_$RestaurantPhotoResponseModelImpl) then,
  ) = __$$RestaurantPhotoResponseModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String id, String url, int sortOrder});
}

/// @nodoc
class __$$RestaurantPhotoResponseModelImplCopyWithImpl<$Res>
    extends
        _$RestaurantPhotoResponseModelCopyWithImpl<
          $Res,
          _$RestaurantPhotoResponseModelImpl
        >
    implements _$$RestaurantPhotoResponseModelImplCopyWith<$Res> {
  __$$RestaurantPhotoResponseModelImplCopyWithImpl(
    _$RestaurantPhotoResponseModelImpl _value,
    $Res Function(_$RestaurantPhotoResponseModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of RestaurantPhotoResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? id = null, Object? url = null, Object? sortOrder = null}) {
    return _then(
      _$RestaurantPhotoResponseModelImpl(
        id:
            null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                    as String,
        url:
            null == url
                ? _value.url
                : url // ignore: cast_nullable_to_non_nullable
                    as String,
        sortOrder:
            null == sortOrder
                ? _value.sortOrder
                : sortOrder // ignore: cast_nullable_to_non_nullable
                    as int,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$RestaurantPhotoResponseModelImpl extends _RestaurantPhotoResponseModel {
  const _$RestaurantPhotoResponseModelImpl({
    required this.id,
    required this.url,
    this.sortOrder = 0,
  }) : super._();

  factory _$RestaurantPhotoResponseModelImpl.fromJson(
    Map<String, dynamic> json,
  ) => _$$RestaurantPhotoResponseModelImplFromJson(json);

  @override
  final String id;
  @override
  final String url;
  @override
  @JsonKey()
  final int sortOrder;

  @override
  String toString() {
    return 'RestaurantPhotoResponseModel(id: $id, url: $url, sortOrder: $sortOrder)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RestaurantPhotoResponseModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.url, url) || other.url == url) &&
            (identical(other.sortOrder, sortOrder) ||
                other.sortOrder == sortOrder));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, url, sortOrder);

  /// Create a copy of RestaurantPhotoResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$RestaurantPhotoResponseModelImplCopyWith<
    _$RestaurantPhotoResponseModelImpl
  >
  get copyWith => __$$RestaurantPhotoResponseModelImplCopyWithImpl<
    _$RestaurantPhotoResponseModelImpl
  >(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$RestaurantPhotoResponseModelImplToJson(this);
  }
}

abstract class _RestaurantPhotoResponseModel
    extends RestaurantPhotoResponseModel {
  const factory _RestaurantPhotoResponseModel({
    required final String id,
    required final String url,
    final int sortOrder,
  }) = _$RestaurantPhotoResponseModelImpl;
  const _RestaurantPhotoResponseModel._() : super._();

  factory _RestaurantPhotoResponseModel.fromJson(Map<String, dynamic> json) =
      _$RestaurantPhotoResponseModelImpl.fromJson;

  @override
  String get id;
  @override
  String get url;
  @override
  int get sortOrder;

  /// Create a copy of RestaurantPhotoResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RestaurantPhotoResponseModelImplCopyWith<
    _$RestaurantPhotoResponseModelImpl
  >
  get copyWith => throw _privateConstructorUsedError;
}
