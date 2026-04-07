// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'restaurant_filters.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$RestaurantFilters {
  String? get searchQuery => throw _privateConstructorUsedError;
  List<CuisineType> get cuisineTypes => throw _privateConstructorUsedError;
  double? get minRating => throw _privateConstructorUsedError;
  bool get openNow => throw _privateConstructorUsedError;
  bool get favouritesOnly => throw _privateConstructorUsedError;

  /// Create a copy of RestaurantFilters
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $RestaurantFiltersCopyWith<RestaurantFilters> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RestaurantFiltersCopyWith<$Res> {
  factory $RestaurantFiltersCopyWith(
    RestaurantFilters value,
    $Res Function(RestaurantFilters) then,
  ) = _$RestaurantFiltersCopyWithImpl<$Res, RestaurantFilters>;
  @useResult
  $Res call({
    String? searchQuery,
    List<CuisineType> cuisineTypes,
    double? minRating,
    bool openNow,
    bool favouritesOnly,
  });
}

/// @nodoc
class _$RestaurantFiltersCopyWithImpl<$Res, $Val extends RestaurantFilters>
    implements $RestaurantFiltersCopyWith<$Res> {
  _$RestaurantFiltersCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of RestaurantFilters
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? searchQuery = freezed,
    Object? cuisineTypes = null,
    Object? minRating = freezed,
    Object? openNow = null,
    Object? favouritesOnly = null,
  }) {
    return _then(
      _value.copyWith(
            searchQuery:
                freezed == searchQuery
                    ? _value.searchQuery
                    : searchQuery // ignore: cast_nullable_to_non_nullable
                        as String?,
            cuisineTypes:
                null == cuisineTypes
                    ? _value.cuisineTypes
                    : cuisineTypes // ignore: cast_nullable_to_non_nullable
                        as List<CuisineType>,
            minRating:
                freezed == minRating
                    ? _value.minRating
                    : minRating // ignore: cast_nullable_to_non_nullable
                        as double?,
            openNow:
                null == openNow
                    ? _value.openNow
                    : openNow // ignore: cast_nullable_to_non_nullable
                        as bool,
            favouritesOnly:
                null == favouritesOnly
                    ? _value.favouritesOnly
                    : favouritesOnly // ignore: cast_nullable_to_non_nullable
                        as bool,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$RestaurantFiltersImplCopyWith<$Res>
    implements $RestaurantFiltersCopyWith<$Res> {
  factory _$$RestaurantFiltersImplCopyWith(
    _$RestaurantFiltersImpl value,
    $Res Function(_$RestaurantFiltersImpl) then,
  ) = __$$RestaurantFiltersImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String? searchQuery,
    List<CuisineType> cuisineTypes,
    double? minRating,
    bool openNow,
    bool favouritesOnly,
  });
}

/// @nodoc
class __$$RestaurantFiltersImplCopyWithImpl<$Res>
    extends _$RestaurantFiltersCopyWithImpl<$Res, _$RestaurantFiltersImpl>
    implements _$$RestaurantFiltersImplCopyWith<$Res> {
  __$$RestaurantFiltersImplCopyWithImpl(
    _$RestaurantFiltersImpl _value,
    $Res Function(_$RestaurantFiltersImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of RestaurantFilters
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? searchQuery = freezed,
    Object? cuisineTypes = null,
    Object? minRating = freezed,
    Object? openNow = null,
    Object? favouritesOnly = null,
  }) {
    return _then(
      _$RestaurantFiltersImpl(
        searchQuery:
            freezed == searchQuery
                ? _value.searchQuery
                : searchQuery // ignore: cast_nullable_to_non_nullable
                    as String?,
        cuisineTypes:
            null == cuisineTypes
                ? _value._cuisineTypes
                : cuisineTypes // ignore: cast_nullable_to_non_nullable
                    as List<CuisineType>,
        minRating:
            freezed == minRating
                ? _value.minRating
                : minRating // ignore: cast_nullable_to_non_nullable
                    as double?,
        openNow:
            null == openNow
                ? _value.openNow
                : openNow // ignore: cast_nullable_to_non_nullable
                    as bool,
        favouritesOnly:
            null == favouritesOnly
                ? _value.favouritesOnly
                : favouritesOnly // ignore: cast_nullable_to_non_nullable
                    as bool,
      ),
    );
  }
}

/// @nodoc

class _$RestaurantFiltersImpl extends _RestaurantFilters {
  const _$RestaurantFiltersImpl({
    this.searchQuery,
    final List<CuisineType> cuisineTypes = const [],
    this.minRating,
    this.openNow = false,
    this.favouritesOnly = false,
  }) : _cuisineTypes = cuisineTypes,
       super._();

  @override
  final String? searchQuery;
  final List<CuisineType> _cuisineTypes;
  @override
  @JsonKey()
  List<CuisineType> get cuisineTypes {
    if (_cuisineTypes is EqualUnmodifiableListView) return _cuisineTypes;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_cuisineTypes);
  }

  @override
  final double? minRating;
  @override
  @JsonKey()
  final bool openNow;
  @override
  @JsonKey()
  final bool favouritesOnly;

  @override
  String toString() {
    return 'RestaurantFilters(searchQuery: $searchQuery, cuisineTypes: $cuisineTypes, minRating: $minRating, openNow: $openNow, favouritesOnly: $favouritesOnly)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RestaurantFiltersImpl &&
            (identical(other.searchQuery, searchQuery) ||
                other.searchQuery == searchQuery) &&
            const DeepCollectionEquality().equals(
              other._cuisineTypes,
              _cuisineTypes,
            ) &&
            (identical(other.minRating, minRating) ||
                other.minRating == minRating) &&
            (identical(other.openNow, openNow) || other.openNow == openNow) &&
            (identical(other.favouritesOnly, favouritesOnly) ||
                other.favouritesOnly == favouritesOnly));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    searchQuery,
    const DeepCollectionEquality().hash(_cuisineTypes),
    minRating,
    openNow,
    favouritesOnly,
  );

  /// Create a copy of RestaurantFilters
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$RestaurantFiltersImplCopyWith<_$RestaurantFiltersImpl> get copyWith =>
      __$$RestaurantFiltersImplCopyWithImpl<_$RestaurantFiltersImpl>(
        this,
        _$identity,
      );
}

abstract class _RestaurantFilters extends RestaurantFilters {
  const factory _RestaurantFilters({
    final String? searchQuery,
    final List<CuisineType> cuisineTypes,
    final double? minRating,
    final bool openNow,
    final bool favouritesOnly,
  }) = _$RestaurantFiltersImpl;
  const _RestaurantFilters._() : super._();

  @override
  String? get searchQuery;
  @override
  List<CuisineType> get cuisineTypes;
  @override
  double? get minRating;
  @override
  bool get openNow;
  @override
  bool get favouritesOnly;

  /// Create a copy of RestaurantFilters
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RestaurantFiltersImplCopyWith<_$RestaurantFiltersImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
