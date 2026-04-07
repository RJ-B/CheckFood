// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'restaurant_request_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

RestaurantRequestModel _$RestaurantRequestModelFromJson(
  Map<String, dynamic> json,
) {
  return _RestaurantRequestModel.fromJson(json);
}

/// @nodoc
mixin _$RestaurantRequestModel {
  String get name => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  CuisineType get cuisineType => throw _privateConstructorUsedError;
  String? get logoUrl => throw _privateConstructorUsedError;
  String? get coverImageUrl => throw _privateConstructorUsedError;
  AddressModel get address => throw _privateConstructorUsedError;
  List<OpeningHoursModel>? get openingHours =>
      throw _privateConstructorUsedError;
  List<String>? get tags => throw _privateConstructorUsedError;

  /// Serializes this RestaurantRequestModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of RestaurantRequestModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $RestaurantRequestModelCopyWith<RestaurantRequestModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RestaurantRequestModelCopyWith<$Res> {
  factory $RestaurantRequestModelCopyWith(
    RestaurantRequestModel value,
    $Res Function(RestaurantRequestModel) then,
  ) = _$RestaurantRequestModelCopyWithImpl<$Res, RestaurantRequestModel>;
  @useResult
  $Res call({
    String name,
    String? description,
    CuisineType cuisineType,
    String? logoUrl,
    String? coverImageUrl,
    AddressModel address,
    List<OpeningHoursModel>? openingHours,
    List<String>? tags,
  });

  $AddressModelCopyWith<$Res> get address;
}

/// @nodoc
class _$RestaurantRequestModelCopyWithImpl<
  $Res,
  $Val extends RestaurantRequestModel
>
    implements $RestaurantRequestModelCopyWith<$Res> {
  _$RestaurantRequestModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of RestaurantRequestModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? description = freezed,
    Object? cuisineType = null,
    Object? logoUrl = freezed,
    Object? coverImageUrl = freezed,
    Object? address = null,
    Object? openingHours = freezed,
    Object? tags = freezed,
  }) {
    return _then(
      _value.copyWith(
            name:
                null == name
                    ? _value.name
                    : name // ignore: cast_nullable_to_non_nullable
                        as String,
            description:
                freezed == description
                    ? _value.description
                    : description // ignore: cast_nullable_to_non_nullable
                        as String?,
            cuisineType:
                null == cuisineType
                    ? _value.cuisineType
                    : cuisineType // ignore: cast_nullable_to_non_nullable
                        as CuisineType,
            logoUrl:
                freezed == logoUrl
                    ? _value.logoUrl
                    : logoUrl // ignore: cast_nullable_to_non_nullable
                        as String?,
            coverImageUrl:
                freezed == coverImageUrl
                    ? _value.coverImageUrl
                    : coverImageUrl // ignore: cast_nullable_to_non_nullable
                        as String?,
            address:
                null == address
                    ? _value.address
                    : address // ignore: cast_nullable_to_non_nullable
                        as AddressModel,
            openingHours:
                freezed == openingHours
                    ? _value.openingHours
                    : openingHours // ignore: cast_nullable_to_non_nullable
                        as List<OpeningHoursModel>?,
            tags:
                freezed == tags
                    ? _value.tags
                    : tags // ignore: cast_nullable_to_non_nullable
                        as List<String>?,
          )
          as $Val,
    );
  }

  /// Create a copy of RestaurantRequestModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $AddressModelCopyWith<$Res> get address {
    return $AddressModelCopyWith<$Res>(_value.address, (value) {
      return _then(_value.copyWith(address: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$RestaurantRequestModelImplCopyWith<$Res>
    implements $RestaurantRequestModelCopyWith<$Res> {
  factory _$$RestaurantRequestModelImplCopyWith(
    _$RestaurantRequestModelImpl value,
    $Res Function(_$RestaurantRequestModelImpl) then,
  ) = __$$RestaurantRequestModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String name,
    String? description,
    CuisineType cuisineType,
    String? logoUrl,
    String? coverImageUrl,
    AddressModel address,
    List<OpeningHoursModel>? openingHours,
    List<String>? tags,
  });

  @override
  $AddressModelCopyWith<$Res> get address;
}

/// @nodoc
class __$$RestaurantRequestModelImplCopyWithImpl<$Res>
    extends
        _$RestaurantRequestModelCopyWithImpl<$Res, _$RestaurantRequestModelImpl>
    implements _$$RestaurantRequestModelImplCopyWith<$Res> {
  __$$RestaurantRequestModelImplCopyWithImpl(
    _$RestaurantRequestModelImpl _value,
    $Res Function(_$RestaurantRequestModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of RestaurantRequestModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? description = freezed,
    Object? cuisineType = null,
    Object? logoUrl = freezed,
    Object? coverImageUrl = freezed,
    Object? address = null,
    Object? openingHours = freezed,
    Object? tags = freezed,
  }) {
    return _then(
      _$RestaurantRequestModelImpl(
        name:
            null == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                    as String,
        description:
            freezed == description
                ? _value.description
                : description // ignore: cast_nullable_to_non_nullable
                    as String?,
        cuisineType:
            null == cuisineType
                ? _value.cuisineType
                : cuisineType // ignore: cast_nullable_to_non_nullable
                    as CuisineType,
        logoUrl:
            freezed == logoUrl
                ? _value.logoUrl
                : logoUrl // ignore: cast_nullable_to_non_nullable
                    as String?,
        coverImageUrl:
            freezed == coverImageUrl
                ? _value.coverImageUrl
                : coverImageUrl // ignore: cast_nullable_to_non_nullable
                    as String?,
        address:
            null == address
                ? _value.address
                : address // ignore: cast_nullable_to_non_nullable
                    as AddressModel,
        openingHours:
            freezed == openingHours
                ? _value._openingHours
                : openingHours // ignore: cast_nullable_to_non_nullable
                    as List<OpeningHoursModel>?,
        tags:
            freezed == tags
                ? _value._tags
                : tags // ignore: cast_nullable_to_non_nullable
                    as List<String>?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$RestaurantRequestModelImpl implements _RestaurantRequestModel {
  const _$RestaurantRequestModelImpl({
    required this.name,
    this.description,
    required this.cuisineType,
    this.logoUrl,
    this.coverImageUrl,
    required this.address,
    final List<OpeningHoursModel>? openingHours,
    final List<String>? tags,
  }) : _openingHours = openingHours,
       _tags = tags;

  factory _$RestaurantRequestModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$RestaurantRequestModelImplFromJson(json);

  @override
  final String name;
  @override
  final String? description;
  @override
  final CuisineType cuisineType;
  @override
  final String? logoUrl;
  @override
  final String? coverImageUrl;
  @override
  final AddressModel address;
  final List<OpeningHoursModel>? _openingHours;
  @override
  List<OpeningHoursModel>? get openingHours {
    final value = _openingHours;
    if (value == null) return null;
    if (_openingHours is EqualUnmodifiableListView) return _openingHours;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final List<String>? _tags;
  @override
  List<String>? get tags {
    final value = _tags;
    if (value == null) return null;
    if (_tags is EqualUnmodifiableListView) return _tags;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'RestaurantRequestModel(name: $name, description: $description, cuisineType: $cuisineType, logoUrl: $logoUrl, coverImageUrl: $coverImageUrl, address: $address, openingHours: $openingHours, tags: $tags)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RestaurantRequestModelImpl &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.cuisineType, cuisineType) ||
                other.cuisineType == cuisineType) &&
            (identical(other.logoUrl, logoUrl) || other.logoUrl == logoUrl) &&
            (identical(other.coverImageUrl, coverImageUrl) ||
                other.coverImageUrl == coverImageUrl) &&
            (identical(other.address, address) || other.address == address) &&
            const DeepCollectionEquality().equals(
              other._openingHours,
              _openingHours,
            ) &&
            const DeepCollectionEquality().equals(other._tags, _tags));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    name,
    description,
    cuisineType,
    logoUrl,
    coverImageUrl,
    address,
    const DeepCollectionEquality().hash(_openingHours),
    const DeepCollectionEquality().hash(_tags),
  );

  /// Create a copy of RestaurantRequestModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$RestaurantRequestModelImplCopyWith<_$RestaurantRequestModelImpl>
  get copyWith =>
      __$$RestaurantRequestModelImplCopyWithImpl<_$RestaurantRequestModelImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$RestaurantRequestModelImplToJson(this);
  }
}

abstract class _RestaurantRequestModel implements RestaurantRequestModel {
  const factory _RestaurantRequestModel({
    required final String name,
    final String? description,
    required final CuisineType cuisineType,
    final String? logoUrl,
    final String? coverImageUrl,
    required final AddressModel address,
    final List<OpeningHoursModel>? openingHours,
    final List<String>? tags,
  }) = _$RestaurantRequestModelImpl;

  factory _RestaurantRequestModel.fromJson(Map<String, dynamic> json) =
      _$RestaurantRequestModelImpl.fromJson;

  @override
  String get name;
  @override
  String? get description;
  @override
  CuisineType get cuisineType;
  @override
  String? get logoUrl;
  @override
  String? get coverImageUrl;
  @override
  AddressModel get address;
  @override
  List<OpeningHoursModel>? get openingHours;
  @override
  List<String>? get tags;

  /// Create a copy of RestaurantRequestModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RestaurantRequestModelImplCopyWith<_$RestaurantRequestModelImpl>
  get copyWith => throw _privateConstructorUsedError;
}
