// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'restaurant_response_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

RestaurantResponseModel _$RestaurantResponseModelFromJson(
  Map<String, dynamic> json,
) {
  return _RestaurantResponseModel.fromJson(json);
}

/// @nodoc
mixin _$RestaurantResponseModel {
  String? get id => throw _privateConstructorUsedError;
  String? get ownerId => throw _privateConstructorUsedError;
  String? get name => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  CuisineType? get cuisineType => throw _privateConstructorUsedError;
  String? get logoUrl => throw _privateConstructorUsedError;
  String? get coverImageUrl => throw _privateConstructorUsedError;
  String? get panoramaUrl => throw _privateConstructorUsedError;
  String? get status => throw _privateConstructorUsedError;
  @JsonKey(name: 'active')
  bool? get isActive => throw _privateConstructorUsedError;
  double? get rating => throw _privateConstructorUsedError;
  AddressModel? get address => throw _privateConstructorUsedError;
  List<OpeningHoursModel> get openingHours =>
      throw _privateConstructorUsedError;
  List<String> get tags => throw _privateConstructorUsedError;
  bool get isFavourite => throw _privateConstructorUsedError;
  List<Map<String, dynamic>> get specialDays =>
      throw _privateConstructorUsedError;
  List<RestaurantPhotoResponseModel> get gallery =>
      throw _privateConstructorUsedError;

  /// Serializes this RestaurantResponseModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of RestaurantResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $RestaurantResponseModelCopyWith<RestaurantResponseModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RestaurantResponseModelCopyWith<$Res> {
  factory $RestaurantResponseModelCopyWith(
    RestaurantResponseModel value,
    $Res Function(RestaurantResponseModel) then,
  ) = _$RestaurantResponseModelCopyWithImpl<$Res, RestaurantResponseModel>;
  @useResult
  $Res call({
    String? id,
    String? ownerId,
    String? name,
    String? description,
    CuisineType? cuisineType,
    String? logoUrl,
    String? coverImageUrl,
    String? panoramaUrl,
    String? status,
    @JsonKey(name: 'active') bool? isActive,
    double? rating,
    AddressModel? address,
    List<OpeningHoursModel> openingHours,
    List<String> tags,
    bool isFavourite,
    List<Map<String, dynamic>> specialDays,
    List<RestaurantPhotoResponseModel> gallery,
  });

  $AddressModelCopyWith<$Res>? get address;
}

/// @nodoc
class _$RestaurantResponseModelCopyWithImpl<
  $Res,
  $Val extends RestaurantResponseModel
>
    implements $RestaurantResponseModelCopyWith<$Res> {
  _$RestaurantResponseModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of RestaurantResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? ownerId = freezed,
    Object? name = freezed,
    Object? description = freezed,
    Object? cuisineType = freezed,
    Object? logoUrl = freezed,
    Object? coverImageUrl = freezed,
    Object? panoramaUrl = freezed,
    Object? status = freezed,
    Object? isActive = freezed,
    Object? rating = freezed,
    Object? address = freezed,
    Object? openingHours = null,
    Object? tags = null,
    Object? isFavourite = null,
    Object? specialDays = null,
    Object? gallery = null,
  }) {
    return _then(
      _value.copyWith(
            id:
                freezed == id
                    ? _value.id
                    : id // ignore: cast_nullable_to_non_nullable
                        as String?,
            ownerId:
                freezed == ownerId
                    ? _value.ownerId
                    : ownerId // ignore: cast_nullable_to_non_nullable
                        as String?,
            name:
                freezed == name
                    ? _value.name
                    : name // ignore: cast_nullable_to_non_nullable
                        as String?,
            description:
                freezed == description
                    ? _value.description
                    : description // ignore: cast_nullable_to_non_nullable
                        as String?,
            cuisineType:
                freezed == cuisineType
                    ? _value.cuisineType
                    : cuisineType // ignore: cast_nullable_to_non_nullable
                        as CuisineType?,
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
            panoramaUrl:
                freezed == panoramaUrl
                    ? _value.panoramaUrl
                    : panoramaUrl // ignore: cast_nullable_to_non_nullable
                        as String?,
            status:
                freezed == status
                    ? _value.status
                    : status // ignore: cast_nullable_to_non_nullable
                        as String?,
            isActive:
                freezed == isActive
                    ? _value.isActive
                    : isActive // ignore: cast_nullable_to_non_nullable
                        as bool?,
            rating:
                freezed == rating
                    ? _value.rating
                    : rating // ignore: cast_nullable_to_non_nullable
                        as double?,
            address:
                freezed == address
                    ? _value.address
                    : address // ignore: cast_nullable_to_non_nullable
                        as AddressModel?,
            openingHours:
                null == openingHours
                    ? _value.openingHours
                    : openingHours // ignore: cast_nullable_to_non_nullable
                        as List<OpeningHoursModel>,
            tags:
                null == tags
                    ? _value.tags
                    : tags // ignore: cast_nullable_to_non_nullable
                        as List<String>,
            isFavourite:
                null == isFavourite
                    ? _value.isFavourite
                    : isFavourite // ignore: cast_nullable_to_non_nullable
                        as bool,
            specialDays:
                null == specialDays
                    ? _value.specialDays
                    : specialDays // ignore: cast_nullable_to_non_nullable
                        as List<Map<String, dynamic>>,
            gallery:
                null == gallery
                    ? _value.gallery
                    : gallery // ignore: cast_nullable_to_non_nullable
                        as List<RestaurantPhotoResponseModel>,
          )
          as $Val,
    );
  }

  /// Create a copy of RestaurantResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $AddressModelCopyWith<$Res>? get address {
    if (_value.address == null) {
      return null;
    }

    return $AddressModelCopyWith<$Res>(_value.address!, (value) {
      return _then(_value.copyWith(address: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$RestaurantResponseModelImplCopyWith<$Res>
    implements $RestaurantResponseModelCopyWith<$Res> {
  factory _$$RestaurantResponseModelImplCopyWith(
    _$RestaurantResponseModelImpl value,
    $Res Function(_$RestaurantResponseModelImpl) then,
  ) = __$$RestaurantResponseModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String? id,
    String? ownerId,
    String? name,
    String? description,
    CuisineType? cuisineType,
    String? logoUrl,
    String? coverImageUrl,
    String? panoramaUrl,
    String? status,
    @JsonKey(name: 'active') bool? isActive,
    double? rating,
    AddressModel? address,
    List<OpeningHoursModel> openingHours,
    List<String> tags,
    bool isFavourite,
    List<Map<String, dynamic>> specialDays,
    List<RestaurantPhotoResponseModel> gallery,
  });

  @override
  $AddressModelCopyWith<$Res>? get address;
}

/// @nodoc
class __$$RestaurantResponseModelImplCopyWithImpl<$Res>
    extends
        _$RestaurantResponseModelCopyWithImpl<
          $Res,
          _$RestaurantResponseModelImpl
        >
    implements _$$RestaurantResponseModelImplCopyWith<$Res> {
  __$$RestaurantResponseModelImplCopyWithImpl(
    _$RestaurantResponseModelImpl _value,
    $Res Function(_$RestaurantResponseModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of RestaurantResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? ownerId = freezed,
    Object? name = freezed,
    Object? description = freezed,
    Object? cuisineType = freezed,
    Object? logoUrl = freezed,
    Object? coverImageUrl = freezed,
    Object? panoramaUrl = freezed,
    Object? status = freezed,
    Object? isActive = freezed,
    Object? rating = freezed,
    Object? address = freezed,
    Object? openingHours = null,
    Object? tags = null,
    Object? isFavourite = null,
    Object? specialDays = null,
    Object? gallery = null,
  }) {
    return _then(
      _$RestaurantResponseModelImpl(
        id:
            freezed == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                    as String?,
        ownerId:
            freezed == ownerId
                ? _value.ownerId
                : ownerId // ignore: cast_nullable_to_non_nullable
                    as String?,
        name:
            freezed == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                    as String?,
        description:
            freezed == description
                ? _value.description
                : description // ignore: cast_nullable_to_non_nullable
                    as String?,
        cuisineType:
            freezed == cuisineType
                ? _value.cuisineType
                : cuisineType // ignore: cast_nullable_to_non_nullable
                    as CuisineType?,
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
        panoramaUrl:
            freezed == panoramaUrl
                ? _value.panoramaUrl
                : panoramaUrl // ignore: cast_nullable_to_non_nullable
                    as String?,
        status:
            freezed == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                    as String?,
        isActive:
            freezed == isActive
                ? _value.isActive
                : isActive // ignore: cast_nullable_to_non_nullable
                    as bool?,
        rating:
            freezed == rating
                ? _value.rating
                : rating // ignore: cast_nullable_to_non_nullable
                    as double?,
        address:
            freezed == address
                ? _value.address
                : address // ignore: cast_nullable_to_non_nullable
                    as AddressModel?,
        openingHours:
            null == openingHours
                ? _value._openingHours
                : openingHours // ignore: cast_nullable_to_non_nullable
                    as List<OpeningHoursModel>,
        tags:
            null == tags
                ? _value._tags
                : tags // ignore: cast_nullable_to_non_nullable
                    as List<String>,
        isFavourite:
            null == isFavourite
                ? _value.isFavourite
                : isFavourite // ignore: cast_nullable_to_non_nullable
                    as bool,
        specialDays:
            null == specialDays
                ? _value._specialDays
                : specialDays // ignore: cast_nullable_to_non_nullable
                    as List<Map<String, dynamic>>,
        gallery:
            null == gallery
                ? _value._gallery
                : gallery // ignore: cast_nullable_to_non_nullable
                    as List<RestaurantPhotoResponseModel>,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$RestaurantResponseModelImpl extends _RestaurantResponseModel {
  const _$RestaurantResponseModelImpl({
    this.id,
    this.ownerId,
    this.name,
    this.description,
    this.cuisineType,
    this.logoUrl,
    this.coverImageUrl,
    this.panoramaUrl,
    this.status,
    @JsonKey(name: 'active') this.isActive,
    this.rating,
    this.address,
    final List<OpeningHoursModel> openingHours = const [],
    final List<String> tags = const [],
    this.isFavourite = false,
    final List<Map<String, dynamic>> specialDays = const [],
    final List<RestaurantPhotoResponseModel> gallery = const [],
  }) : _openingHours = openingHours,
       _tags = tags,
       _specialDays = specialDays,
       _gallery = gallery,
       super._();

  factory _$RestaurantResponseModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$RestaurantResponseModelImplFromJson(json);

  @override
  final String? id;
  @override
  final String? ownerId;
  @override
  final String? name;
  @override
  final String? description;
  @override
  final CuisineType? cuisineType;
  @override
  final String? logoUrl;
  @override
  final String? coverImageUrl;
  @override
  final String? panoramaUrl;
  @override
  final String? status;
  @override
  @JsonKey(name: 'active')
  final bool? isActive;
  @override
  final double? rating;
  @override
  final AddressModel? address;
  final List<OpeningHoursModel> _openingHours;
  @override
  @JsonKey()
  List<OpeningHoursModel> get openingHours {
    if (_openingHours is EqualUnmodifiableListView) return _openingHours;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_openingHours);
  }

  final List<String> _tags;
  @override
  @JsonKey()
  List<String> get tags {
    if (_tags is EqualUnmodifiableListView) return _tags;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_tags);
  }

  @override
  @JsonKey()
  final bool isFavourite;
  final List<Map<String, dynamic>> _specialDays;
  @override
  @JsonKey()
  List<Map<String, dynamic>> get specialDays {
    if (_specialDays is EqualUnmodifiableListView) return _specialDays;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_specialDays);
  }

  final List<RestaurantPhotoResponseModel> _gallery;
  @override
  @JsonKey()
  List<RestaurantPhotoResponseModel> get gallery {
    if (_gallery is EqualUnmodifiableListView) return _gallery;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_gallery);
  }

  @override
  String toString() {
    return 'RestaurantResponseModel(id: $id, ownerId: $ownerId, name: $name, description: $description, cuisineType: $cuisineType, logoUrl: $logoUrl, coverImageUrl: $coverImageUrl, panoramaUrl: $panoramaUrl, status: $status, isActive: $isActive, rating: $rating, address: $address, openingHours: $openingHours, tags: $tags, isFavourite: $isFavourite, specialDays: $specialDays, gallery: $gallery)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RestaurantResponseModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.ownerId, ownerId) || other.ownerId == ownerId) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.cuisineType, cuisineType) ||
                other.cuisineType == cuisineType) &&
            (identical(other.logoUrl, logoUrl) || other.logoUrl == logoUrl) &&
            (identical(other.coverImageUrl, coverImageUrl) ||
                other.coverImageUrl == coverImageUrl) &&
            (identical(other.panoramaUrl, panoramaUrl) ||
                other.panoramaUrl == panoramaUrl) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.isActive, isActive) ||
                other.isActive == isActive) &&
            (identical(other.rating, rating) || other.rating == rating) &&
            (identical(other.address, address) || other.address == address) &&
            const DeepCollectionEquality().equals(
              other._openingHours,
              _openingHours,
            ) &&
            const DeepCollectionEquality().equals(other._tags, _tags) &&
            (identical(other.isFavourite, isFavourite) ||
                other.isFavourite == isFavourite) &&
            const DeepCollectionEquality().equals(
              other._specialDays,
              _specialDays,
            ) &&
            const DeepCollectionEquality().equals(other._gallery, _gallery));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    ownerId,
    name,
    description,
    cuisineType,
    logoUrl,
    coverImageUrl,
    panoramaUrl,
    status,
    isActive,
    rating,
    address,
    const DeepCollectionEquality().hash(_openingHours),
    const DeepCollectionEquality().hash(_tags),
    isFavourite,
    const DeepCollectionEquality().hash(_specialDays),
    const DeepCollectionEquality().hash(_gallery),
  );

  /// Create a copy of RestaurantResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$RestaurantResponseModelImplCopyWith<_$RestaurantResponseModelImpl>
  get copyWith => __$$RestaurantResponseModelImplCopyWithImpl<
    _$RestaurantResponseModelImpl
  >(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$RestaurantResponseModelImplToJson(this);
  }
}

abstract class _RestaurantResponseModel extends RestaurantResponseModel {
  const factory _RestaurantResponseModel({
    final String? id,
    final String? ownerId,
    final String? name,
    final String? description,
    final CuisineType? cuisineType,
    final String? logoUrl,
    final String? coverImageUrl,
    final String? panoramaUrl,
    final String? status,
    @JsonKey(name: 'active') final bool? isActive,
    final double? rating,
    final AddressModel? address,
    final List<OpeningHoursModel> openingHours,
    final List<String> tags,
    final bool isFavourite,
    final List<Map<String, dynamic>> specialDays,
    final List<RestaurantPhotoResponseModel> gallery,
  }) = _$RestaurantResponseModelImpl;
  const _RestaurantResponseModel._() : super._();

  factory _RestaurantResponseModel.fromJson(Map<String, dynamic> json) =
      _$RestaurantResponseModelImpl.fromJson;

  @override
  String? get id;
  @override
  String? get ownerId;
  @override
  String? get name;
  @override
  String? get description;
  @override
  CuisineType? get cuisineType;
  @override
  String? get logoUrl;
  @override
  String? get coverImageUrl;
  @override
  String? get panoramaUrl;
  @override
  String? get status;
  @override
  @JsonKey(name: 'active')
  bool? get isActive;
  @override
  double? get rating;
  @override
  AddressModel? get address;
  @override
  List<OpeningHoursModel> get openingHours;
  @override
  List<String> get tags;
  @override
  bool get isFavourite;
  @override
  List<Map<String, dynamic>> get specialDays;
  @override
  List<RestaurantPhotoResponseModel> get gallery;

  /// Create a copy of RestaurantResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RestaurantResponseModelImplCopyWith<_$RestaurantResponseModelImpl>
  get copyWith => throw _privateConstructorUsedError;
}
