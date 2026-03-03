// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'explore_data.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$ExploreData {
  /// Markery pro mapu (shluky nebo restaurace)
  List<RestaurantMarker> get markers => throw _privateConstructorUsedError;

  /// Seznam nejbližších restaurací (pod mapou)
  List<Restaurant> get nearestRestaurants => throw _privateConstructorUsedError;

  /// Aktuální poloha uživatele
  Position get userPosition => throw _privateConstructorUsedError;

  /// Aktuální stránka pro pagination
  int get currentPage => throw _privateConstructorUsedError;

  /// Zda je k dispozici další stránka
  bool get hasMore => throw _privateConstructorUsedError;

  /// Zda se načítá další stránka (aby se nevolalo 2x)
  bool get isPaginationLoading => throw _privateConstructorUsedError;

  /// Zda probíhá aktualizace markerů na mapě (pro plynulé UI)
  bool get isMapLoading => throw _privateConstructorUsedError;

  /// Create a copy of ExploreData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ExploreDataCopyWith<ExploreData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ExploreDataCopyWith<$Res> {
  factory $ExploreDataCopyWith(
    ExploreData value,
    $Res Function(ExploreData) then,
  ) = _$ExploreDataCopyWithImpl<$Res, ExploreData>;
  @useResult
  $Res call({
    List<RestaurantMarker> markers,
    List<Restaurant> nearestRestaurants,
    Position userPosition,
    int currentPage,
    bool hasMore,
    bool isPaginationLoading,
    bool isMapLoading,
  });
}

/// @nodoc
class _$ExploreDataCopyWithImpl<$Res, $Val extends ExploreData>
    implements $ExploreDataCopyWith<$Res> {
  _$ExploreDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ExploreData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? markers = null,
    Object? nearestRestaurants = null,
    Object? userPosition = null,
    Object? currentPage = null,
    Object? hasMore = null,
    Object? isPaginationLoading = null,
    Object? isMapLoading = null,
  }) {
    return _then(
      _value.copyWith(
            markers:
                null == markers
                    ? _value.markers
                    : markers // ignore: cast_nullable_to_non_nullable
                        as List<RestaurantMarker>,
            nearestRestaurants:
                null == nearestRestaurants
                    ? _value.nearestRestaurants
                    : nearestRestaurants // ignore: cast_nullable_to_non_nullable
                        as List<Restaurant>,
            userPosition:
                null == userPosition
                    ? _value.userPosition
                    : userPosition // ignore: cast_nullable_to_non_nullable
                        as Position,
            currentPage:
                null == currentPage
                    ? _value.currentPage
                    : currentPage // ignore: cast_nullable_to_non_nullable
                        as int,
            hasMore:
                null == hasMore
                    ? _value.hasMore
                    : hasMore // ignore: cast_nullable_to_non_nullable
                        as bool,
            isPaginationLoading:
                null == isPaginationLoading
                    ? _value.isPaginationLoading
                    : isPaginationLoading // ignore: cast_nullable_to_non_nullable
                        as bool,
            isMapLoading:
                null == isMapLoading
                    ? _value.isMapLoading
                    : isMapLoading // ignore: cast_nullable_to_non_nullable
                        as bool,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ExploreDataImplCopyWith<$Res>
    implements $ExploreDataCopyWith<$Res> {
  factory _$$ExploreDataImplCopyWith(
    _$ExploreDataImpl value,
    $Res Function(_$ExploreDataImpl) then,
  ) = __$$ExploreDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    List<RestaurantMarker> markers,
    List<Restaurant> nearestRestaurants,
    Position userPosition,
    int currentPage,
    bool hasMore,
    bool isPaginationLoading,
    bool isMapLoading,
  });
}

/// @nodoc
class __$$ExploreDataImplCopyWithImpl<$Res>
    extends _$ExploreDataCopyWithImpl<$Res, _$ExploreDataImpl>
    implements _$$ExploreDataImplCopyWith<$Res> {
  __$$ExploreDataImplCopyWithImpl(
    _$ExploreDataImpl _value,
    $Res Function(_$ExploreDataImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ExploreData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? markers = null,
    Object? nearestRestaurants = null,
    Object? userPosition = null,
    Object? currentPage = null,
    Object? hasMore = null,
    Object? isPaginationLoading = null,
    Object? isMapLoading = null,
  }) {
    return _then(
      _$ExploreDataImpl(
        markers:
            null == markers
                ? _value._markers
                : markers // ignore: cast_nullable_to_non_nullable
                    as List<RestaurantMarker>,
        nearestRestaurants:
            null == nearestRestaurants
                ? _value._nearestRestaurants
                : nearestRestaurants // ignore: cast_nullable_to_non_nullable
                    as List<Restaurant>,
        userPosition:
            null == userPosition
                ? _value.userPosition
                : userPosition // ignore: cast_nullable_to_non_nullable
                    as Position,
        currentPage:
            null == currentPage
                ? _value.currentPage
                : currentPage // ignore: cast_nullable_to_non_nullable
                    as int,
        hasMore:
            null == hasMore
                ? _value.hasMore
                : hasMore // ignore: cast_nullable_to_non_nullable
                    as bool,
        isPaginationLoading:
            null == isPaginationLoading
                ? _value.isPaginationLoading
                : isPaginationLoading // ignore: cast_nullable_to_non_nullable
                    as bool,
        isMapLoading:
            null == isMapLoading
                ? _value.isMapLoading
                : isMapLoading // ignore: cast_nullable_to_non_nullable
                    as bool,
      ),
    );
  }
}

/// @nodoc

class _$ExploreDataImpl implements _ExploreData {
  const _$ExploreDataImpl({
    required final List<RestaurantMarker> markers,
    required final List<Restaurant> nearestRestaurants,
    required this.userPosition,
    required this.currentPage,
    required this.hasMore,
    required this.isPaginationLoading,
    this.isMapLoading = false,
  }) : _markers = markers,
       _nearestRestaurants = nearestRestaurants;

  /// Markery pro mapu (shluky nebo restaurace)
  final List<RestaurantMarker> _markers;

  /// Markery pro mapu (shluky nebo restaurace)
  @override
  List<RestaurantMarker> get markers {
    if (_markers is EqualUnmodifiableListView) return _markers;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_markers);
  }

  /// Seznam nejbližších restaurací (pod mapou)
  final List<Restaurant> _nearestRestaurants;

  /// Seznam nejbližších restaurací (pod mapou)
  @override
  List<Restaurant> get nearestRestaurants {
    if (_nearestRestaurants is EqualUnmodifiableListView)
      return _nearestRestaurants;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_nearestRestaurants);
  }

  /// Aktuální poloha uživatele
  @override
  final Position userPosition;

  /// Aktuální stránka pro pagination
  @override
  final int currentPage;

  /// Zda je k dispozici další stránka
  @override
  final bool hasMore;

  /// Zda se načítá další stránka (aby se nevolalo 2x)
  @override
  final bool isPaginationLoading;

  /// Zda probíhá aktualizace markerů na mapě (pro plynulé UI)
  @override
  @JsonKey()
  final bool isMapLoading;

  @override
  String toString() {
    return 'ExploreData(markers: $markers, nearestRestaurants: $nearestRestaurants, userPosition: $userPosition, currentPage: $currentPage, hasMore: $hasMore, isPaginationLoading: $isPaginationLoading, isMapLoading: $isMapLoading)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ExploreDataImpl &&
            const DeepCollectionEquality().equals(other._markers, _markers) &&
            const DeepCollectionEquality().equals(
              other._nearestRestaurants,
              _nearestRestaurants,
            ) &&
            (identical(other.userPosition, userPosition) ||
                other.userPosition == userPosition) &&
            (identical(other.currentPage, currentPage) ||
                other.currentPage == currentPage) &&
            (identical(other.hasMore, hasMore) || other.hasMore == hasMore) &&
            (identical(other.isPaginationLoading, isPaginationLoading) ||
                other.isPaginationLoading == isPaginationLoading) &&
            (identical(other.isMapLoading, isMapLoading) ||
                other.isMapLoading == isMapLoading));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    const DeepCollectionEquality().hash(_markers),
    const DeepCollectionEquality().hash(_nearestRestaurants),
    userPosition,
    currentPage,
    hasMore,
    isPaginationLoading,
    isMapLoading,
  );

  /// Create a copy of ExploreData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ExploreDataImplCopyWith<_$ExploreDataImpl> get copyWith =>
      __$$ExploreDataImplCopyWithImpl<_$ExploreDataImpl>(this, _$identity);
}

abstract class _ExploreData implements ExploreData {
  const factory _ExploreData({
    required final List<RestaurantMarker> markers,
    required final List<Restaurant> nearestRestaurants,
    required final Position userPosition,
    required final int currentPage,
    required final bool hasMore,
    required final bool isPaginationLoading,
    final bool isMapLoading,
  }) = _$ExploreDataImpl;

  /// Markery pro mapu (shluky nebo restaurace)
  @override
  List<RestaurantMarker> get markers;

  /// Seznam nejbližších restaurací (pod mapou)
  @override
  List<Restaurant> get nearestRestaurants;

  /// Aktuální poloha uživatele
  @override
  Position get userPosition;

  /// Aktuální stránka pro pagination
  @override
  int get currentPage;

  /// Zda je k dispozici další stránka
  @override
  bool get hasMore;

  /// Zda se načítá další stránka (aby se nevolalo 2x)
  @override
  bool get isPaginationLoading;

  /// Zda probíhá aktualizace markerů na mapě (pro plynulé UI)
  @override
  bool get isMapLoading;

  /// Create a copy of ExploreData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ExploreDataImplCopyWith<_$ExploreDataImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
