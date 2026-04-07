// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'restaurant.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$Restaurant {
  String get id => throw _privateConstructorUsedError;
  String get ownerId => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  CuisineType get cuisineType => throw _privateConstructorUsedError;
  String? get logoUrl => throw _privateConstructorUsedError;
  String? get coverImageUrl => throw _privateConstructorUsedError;
  String get status => throw _privateConstructorUsedError;
  bool get isActive => throw _privateConstructorUsedError;
  double? get rating => throw _privateConstructorUsedError;
  Address get address => throw _privateConstructorUsedError;
  List<OpeningHours> get openingHours => throw _privateConstructorUsedError;
  List<String> get tags => throw _privateConstructorUsedError;
  bool get isFavourite => throw _privateConstructorUsedError;
  List<Map<String, dynamic>> get specialDays =>
      throw _privateConstructorUsedError;

  /// Create a copy of Restaurant
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $RestaurantCopyWith<Restaurant> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RestaurantCopyWith<$Res> {
  factory $RestaurantCopyWith(
    Restaurant value,
    $Res Function(Restaurant) then,
  ) = _$RestaurantCopyWithImpl<$Res, Restaurant>;
  @useResult
  $Res call({
    String id,
    String ownerId,
    String name,
    String? description,
    CuisineType cuisineType,
    String? logoUrl,
    String? coverImageUrl,
    String status,
    bool isActive,
    double? rating,
    Address address,
    List<OpeningHours> openingHours,
    List<String> tags,
    bool isFavourite,
    List<Map<String, dynamic>> specialDays,
  });

  $AddressCopyWith<$Res> get address;
}

/// @nodoc
class _$RestaurantCopyWithImpl<$Res, $Val extends Restaurant>
    implements $RestaurantCopyWith<$Res> {
  _$RestaurantCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Restaurant
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? ownerId = null,
    Object? name = null,
    Object? description = freezed,
    Object? cuisineType = null,
    Object? logoUrl = freezed,
    Object? coverImageUrl = freezed,
    Object? status = null,
    Object? isActive = null,
    Object? rating = freezed,
    Object? address = null,
    Object? openingHours = null,
    Object? tags = null,
    Object? isFavourite = null,
    Object? specialDays = null,
  }) {
    return _then(
      _value.copyWith(
            id:
                null == id
                    ? _value.id
                    : id // ignore: cast_nullable_to_non_nullable
                        as String,
            ownerId:
                null == ownerId
                    ? _value.ownerId
                    : ownerId // ignore: cast_nullable_to_non_nullable
                        as String,
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
            status:
                null == status
                    ? _value.status
                    : status // ignore: cast_nullable_to_non_nullable
                        as String,
            isActive:
                null == isActive
                    ? _value.isActive
                    : isActive // ignore: cast_nullable_to_non_nullable
                        as bool,
            rating:
                freezed == rating
                    ? _value.rating
                    : rating // ignore: cast_nullable_to_non_nullable
                        as double?,
            address:
                null == address
                    ? _value.address
                    : address // ignore: cast_nullable_to_non_nullable
                        as Address,
            openingHours:
                null == openingHours
                    ? _value.openingHours
                    : openingHours // ignore: cast_nullable_to_non_nullable
                        as List<OpeningHours>,
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
          )
          as $Val,
    );
  }

  /// Create a copy of Restaurant
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $AddressCopyWith<$Res> get address {
    return $AddressCopyWith<$Res>(_value.address, (value) {
      return _then(_value.copyWith(address: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$RestaurantImplCopyWith<$Res>
    implements $RestaurantCopyWith<$Res> {
  factory _$$RestaurantImplCopyWith(
    _$RestaurantImpl value,
    $Res Function(_$RestaurantImpl) then,
  ) = __$$RestaurantImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String ownerId,
    String name,
    String? description,
    CuisineType cuisineType,
    String? logoUrl,
    String? coverImageUrl,
    String status,
    bool isActive,
    double? rating,
    Address address,
    List<OpeningHours> openingHours,
    List<String> tags,
    bool isFavourite,
    List<Map<String, dynamic>> specialDays,
  });

  @override
  $AddressCopyWith<$Res> get address;
}

/// @nodoc
class __$$RestaurantImplCopyWithImpl<$Res>
    extends _$RestaurantCopyWithImpl<$Res, _$RestaurantImpl>
    implements _$$RestaurantImplCopyWith<$Res> {
  __$$RestaurantImplCopyWithImpl(
    _$RestaurantImpl _value,
    $Res Function(_$RestaurantImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Restaurant
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? ownerId = null,
    Object? name = null,
    Object? description = freezed,
    Object? cuisineType = null,
    Object? logoUrl = freezed,
    Object? coverImageUrl = freezed,
    Object? status = null,
    Object? isActive = null,
    Object? rating = freezed,
    Object? address = null,
    Object? openingHours = null,
    Object? tags = null,
    Object? isFavourite = null,
    Object? specialDays = null,
  }) {
    return _then(
      _$RestaurantImpl(
        id:
            null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                    as String,
        ownerId:
            null == ownerId
                ? _value.ownerId
                : ownerId // ignore: cast_nullable_to_non_nullable
                    as String,
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
        status:
            null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                    as String,
        isActive:
            null == isActive
                ? _value.isActive
                : isActive // ignore: cast_nullable_to_non_nullable
                    as bool,
        rating:
            freezed == rating
                ? _value.rating
                : rating // ignore: cast_nullable_to_non_nullable
                    as double?,
        address:
            null == address
                ? _value.address
                : address // ignore: cast_nullable_to_non_nullable
                    as Address,
        openingHours:
            null == openingHours
                ? _value._openingHours
                : openingHours // ignore: cast_nullable_to_non_nullable
                    as List<OpeningHours>,
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
      ),
    );
  }
}

/// @nodoc

class _$RestaurantImpl extends _Restaurant {
  const _$RestaurantImpl({
    required this.id,
    required this.ownerId,
    required this.name,
    this.description,
    required this.cuisineType,
    this.logoUrl,
    this.coverImageUrl,
    required this.status,
    required this.isActive,
    this.rating,
    required this.address,
    required final List<OpeningHours> openingHours,
    final List<String> tags = const [],
    this.isFavourite = false,
    final List<Map<String, dynamic>> specialDays = const [],
  }) : _openingHours = openingHours,
       _tags = tags,
       _specialDays = specialDays,
       super._();

  @override
  final String id;
  @override
  final String ownerId;
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
  final String status;
  @override
  final bool isActive;
  @override
  final double? rating;
  @override
  final Address address;
  final List<OpeningHours> _openingHours;
  @override
  List<OpeningHours> get openingHours {
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

  @override
  String toString() {
    return 'Restaurant(id: $id, ownerId: $ownerId, name: $name, description: $description, cuisineType: $cuisineType, logoUrl: $logoUrl, coverImageUrl: $coverImageUrl, status: $status, isActive: $isActive, rating: $rating, address: $address, openingHours: $openingHours, tags: $tags, isFavourite: $isFavourite, specialDays: $specialDays)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RestaurantImpl &&
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
            ));
  }

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
    status,
    isActive,
    rating,
    address,
    const DeepCollectionEquality().hash(_openingHours),
    const DeepCollectionEquality().hash(_tags),
    isFavourite,
    const DeepCollectionEquality().hash(_specialDays),
  );

  /// Create a copy of Restaurant
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$RestaurantImplCopyWith<_$RestaurantImpl> get copyWith =>
      __$$RestaurantImplCopyWithImpl<_$RestaurantImpl>(this, _$identity);
}

abstract class _Restaurant extends Restaurant {
  const factory _Restaurant({
    required final String id,
    required final String ownerId,
    required final String name,
    final String? description,
    required final CuisineType cuisineType,
    final String? logoUrl,
    final String? coverImageUrl,
    required final String status,
    required final bool isActive,
    final double? rating,
    required final Address address,
    required final List<OpeningHours> openingHours,
    final List<String> tags,
    final bool isFavourite,
    final List<Map<String, dynamic>> specialDays,
  }) = _$RestaurantImpl;
  const _Restaurant._() : super._();

  @override
  String get id;
  @override
  String get ownerId;
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
  String get status;
  @override
  bool get isActive;
  @override
  double? get rating;
  @override
  Address get address;
  @override
  List<OpeningHours> get openingHours;
  @override
  List<String> get tags;
  @override
  bool get isFavourite;
  @override
  List<Map<String, dynamic>> get specialDays;

  /// Create a copy of Restaurant
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RestaurantImplCopyWith<_$RestaurantImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
