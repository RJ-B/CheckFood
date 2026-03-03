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

OwnerRestaurantResponseModel _$OwnerRestaurantResponseModelFromJson(
  Map<String, dynamic> json,
) {
  return _OwnerRestaurantResponseModel.fromJson(json);
}

/// @nodoc
mixin _$OwnerRestaurantResponseModel {
  String? get id => throw _privateConstructorUsedError;
  String? get name => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  String? get cuisineType => throw _privateConstructorUsedError;
  String? get logoUrl => throw _privateConstructorUsedError;
  String? get coverImageUrl => throw _privateConstructorUsedError;
  String? get panoramaUrl => throw _privateConstructorUsedError;
  String? get status => throw _privateConstructorUsedError;
  bool get active => throw _privateConstructorUsedError;
  double? get rating => throw _privateConstructorUsedError;
  AddressModel? get address => throw _privateConstructorUsedError;
  List<OpeningHoursModel> get openingHours =>
      throw _privateConstructorUsedError;
  List<String> get tags => throw _privateConstructorUsedError;
  bool get onboardingCompleted => throw _privateConstructorUsedError;

  /// Serializes this OwnerRestaurantResponseModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of OwnerRestaurantResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $OwnerRestaurantResponseModelCopyWith<OwnerRestaurantResponseModel>
  get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OwnerRestaurantResponseModelCopyWith<$Res> {
  factory $OwnerRestaurantResponseModelCopyWith(
    OwnerRestaurantResponseModel value,
    $Res Function(OwnerRestaurantResponseModel) then,
  ) =
      _$OwnerRestaurantResponseModelCopyWithImpl<
        $Res,
        OwnerRestaurantResponseModel
      >;
  @useResult
  $Res call({
    String? id,
    String? name,
    String? description,
    String? cuisineType,
    String? logoUrl,
    String? coverImageUrl,
    String? panoramaUrl,
    String? status,
    bool active,
    double? rating,
    AddressModel? address,
    List<OpeningHoursModel> openingHours,
    List<String> tags,
    bool onboardingCompleted,
  });

  $AddressModelCopyWith<$Res>? get address;
}

/// @nodoc
class _$OwnerRestaurantResponseModelCopyWithImpl<
  $Res,
  $Val extends OwnerRestaurantResponseModel
>
    implements $OwnerRestaurantResponseModelCopyWith<$Res> {
  _$OwnerRestaurantResponseModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of OwnerRestaurantResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? name = freezed,
    Object? description = freezed,
    Object? cuisineType = freezed,
    Object? logoUrl = freezed,
    Object? coverImageUrl = freezed,
    Object? panoramaUrl = freezed,
    Object? status = freezed,
    Object? active = null,
    Object? rating = freezed,
    Object? address = freezed,
    Object? openingHours = null,
    Object? tags = null,
    Object? onboardingCompleted = null,
  }) {
    return _then(
      _value.copyWith(
            id:
                freezed == id
                    ? _value.id
                    : id // ignore: cast_nullable_to_non_nullable
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
                        as String?,
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
            active:
                null == active
                    ? _value.active
                    : active // ignore: cast_nullable_to_non_nullable
                        as bool,
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
            onboardingCompleted:
                null == onboardingCompleted
                    ? _value.onboardingCompleted
                    : onboardingCompleted // ignore: cast_nullable_to_non_nullable
                        as bool,
          )
          as $Val,
    );
  }

  /// Create a copy of OwnerRestaurantResponseModel
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
abstract class _$$OwnerRestaurantResponseModelImplCopyWith<$Res>
    implements $OwnerRestaurantResponseModelCopyWith<$Res> {
  factory _$$OwnerRestaurantResponseModelImplCopyWith(
    _$OwnerRestaurantResponseModelImpl value,
    $Res Function(_$OwnerRestaurantResponseModelImpl) then,
  ) = __$$OwnerRestaurantResponseModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String? id,
    String? name,
    String? description,
    String? cuisineType,
    String? logoUrl,
    String? coverImageUrl,
    String? panoramaUrl,
    String? status,
    bool active,
    double? rating,
    AddressModel? address,
    List<OpeningHoursModel> openingHours,
    List<String> tags,
    bool onboardingCompleted,
  });

  @override
  $AddressModelCopyWith<$Res>? get address;
}

/// @nodoc
class __$$OwnerRestaurantResponseModelImplCopyWithImpl<$Res>
    extends
        _$OwnerRestaurantResponseModelCopyWithImpl<
          $Res,
          _$OwnerRestaurantResponseModelImpl
        >
    implements _$$OwnerRestaurantResponseModelImplCopyWith<$Res> {
  __$$OwnerRestaurantResponseModelImplCopyWithImpl(
    _$OwnerRestaurantResponseModelImpl _value,
    $Res Function(_$OwnerRestaurantResponseModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of OwnerRestaurantResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? name = freezed,
    Object? description = freezed,
    Object? cuisineType = freezed,
    Object? logoUrl = freezed,
    Object? coverImageUrl = freezed,
    Object? panoramaUrl = freezed,
    Object? status = freezed,
    Object? active = null,
    Object? rating = freezed,
    Object? address = freezed,
    Object? openingHours = null,
    Object? tags = null,
    Object? onboardingCompleted = null,
  }) {
    return _then(
      _$OwnerRestaurantResponseModelImpl(
        id:
            freezed == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
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
                    as String?,
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
        active:
            null == active
                ? _value.active
                : active // ignore: cast_nullable_to_non_nullable
                    as bool,
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
        onboardingCompleted:
            null == onboardingCompleted
                ? _value.onboardingCompleted
                : onboardingCompleted // ignore: cast_nullable_to_non_nullable
                    as bool,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$OwnerRestaurantResponseModelImpl
    implements _OwnerRestaurantResponseModel {
  const _$OwnerRestaurantResponseModelImpl({
    this.id,
    this.name,
    this.description,
    this.cuisineType,
    this.logoUrl,
    this.coverImageUrl,
    this.panoramaUrl,
    this.status,
    this.active = false,
    this.rating,
    this.address,
    final List<OpeningHoursModel> openingHours = const [],
    final List<String> tags = const [],
    this.onboardingCompleted = false,
  }) : _openingHours = openingHours,
       _tags = tags;

  factory _$OwnerRestaurantResponseModelImpl.fromJson(
    Map<String, dynamic> json,
  ) => _$$OwnerRestaurantResponseModelImplFromJson(json);

  @override
  final String? id;
  @override
  final String? name;
  @override
  final String? description;
  @override
  final String? cuisineType;
  @override
  final String? logoUrl;
  @override
  final String? coverImageUrl;
  @override
  final String? panoramaUrl;
  @override
  final String? status;
  @override
  @JsonKey()
  final bool active;
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
  final bool onboardingCompleted;

  @override
  String toString() {
    return 'OwnerRestaurantResponseModel(id: $id, name: $name, description: $description, cuisineType: $cuisineType, logoUrl: $logoUrl, coverImageUrl: $coverImageUrl, panoramaUrl: $panoramaUrl, status: $status, active: $active, rating: $rating, address: $address, openingHours: $openingHours, tags: $tags, onboardingCompleted: $onboardingCompleted)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OwnerRestaurantResponseModelImpl &&
            (identical(other.id, id) || other.id == id) &&
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
            (identical(other.active, active) || other.active == active) &&
            (identical(other.rating, rating) || other.rating == rating) &&
            (identical(other.address, address) || other.address == address) &&
            const DeepCollectionEquality().equals(
              other._openingHours,
              _openingHours,
            ) &&
            const DeepCollectionEquality().equals(other._tags, _tags) &&
            (identical(other.onboardingCompleted, onboardingCompleted) ||
                other.onboardingCompleted == onboardingCompleted));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    name,
    description,
    cuisineType,
    logoUrl,
    coverImageUrl,
    panoramaUrl,
    status,
    active,
    rating,
    address,
    const DeepCollectionEquality().hash(_openingHours),
    const DeepCollectionEquality().hash(_tags),
    onboardingCompleted,
  );

  /// Create a copy of OwnerRestaurantResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$OwnerRestaurantResponseModelImplCopyWith<
    _$OwnerRestaurantResponseModelImpl
  >
  get copyWith => __$$OwnerRestaurantResponseModelImplCopyWithImpl<
    _$OwnerRestaurantResponseModelImpl
  >(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$OwnerRestaurantResponseModelImplToJson(this);
  }
}

abstract class _OwnerRestaurantResponseModel
    implements OwnerRestaurantResponseModel {
  const factory _OwnerRestaurantResponseModel({
    final String? id,
    final String? name,
    final String? description,
    final String? cuisineType,
    final String? logoUrl,
    final String? coverImageUrl,
    final String? panoramaUrl,
    final String? status,
    final bool active,
    final double? rating,
    final AddressModel? address,
    final List<OpeningHoursModel> openingHours,
    final List<String> tags,
    final bool onboardingCompleted,
  }) = _$OwnerRestaurantResponseModelImpl;

  factory _OwnerRestaurantResponseModel.fromJson(Map<String, dynamic> json) =
      _$OwnerRestaurantResponseModelImpl.fromJson;

  @override
  String? get id;
  @override
  String? get name;
  @override
  String? get description;
  @override
  String? get cuisineType;
  @override
  String? get logoUrl;
  @override
  String? get coverImageUrl;
  @override
  String? get panoramaUrl;
  @override
  String? get status;
  @override
  bool get active;
  @override
  double? get rating;
  @override
  AddressModel? get address;
  @override
  List<OpeningHoursModel> get openingHours;
  @override
  List<String> get tags;
  @override
  bool get onboardingCompleted;

  /// Create a copy of OwnerRestaurantResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$OwnerRestaurantResponseModelImplCopyWith<
    _$OwnerRestaurantResponseModelImpl
  >
  get copyWith => throw _privateConstructorUsedError;
}
