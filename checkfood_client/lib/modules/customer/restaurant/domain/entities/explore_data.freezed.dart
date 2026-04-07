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
  /// Restaurace z DB
  List<Restaurant> get restaurants => throw _privateConstructorUsedError;

  /// Markery pro mapu (shluky nebo restaurace)
  List<RestaurantMarker> get markers => throw _privateConstructorUsedError;

  /// Aktualni poloha uzivatele
  Position get userPosition => throw _privateConstructorUsedError;

  /// Zda probiha aktualizace markeru na mape
  bool get isMapLoading => throw _privateConstructorUsedError;

  /// ID vybrane restaurace (null = zadny vyber)
  String? get selectedRestaurantId => throw _privateConstructorUsedError;

  /// Vybrana restaurace pro preview card
  Restaurant? get selectedRestaurant => throw _privateConstructorUsedError;

  /// Aktivni search query
  String? get searchQuery => throw _privateConstructorUsedError;

  /// Zda je client-side clustering engine pripraveny (data nactena z disku/backendu)
  bool get clusterEngineReady => throw _privateConstructorUsedError;

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
    List<Restaurant> restaurants,
    List<RestaurantMarker> markers,
    Position userPosition,
    bool isMapLoading,
    String? selectedRestaurantId,
    Restaurant? selectedRestaurant,
    String? searchQuery,
    bool clusterEngineReady,
  });

  $RestaurantCopyWith<$Res>? get selectedRestaurant;
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
    Object? restaurants = null,
    Object? markers = null,
    Object? userPosition = null,
    Object? isMapLoading = null,
    Object? selectedRestaurantId = freezed,
    Object? selectedRestaurant = freezed,
    Object? searchQuery = freezed,
    Object? clusterEngineReady = null,
  }) {
    return _then(
      _value.copyWith(
            restaurants:
                null == restaurants
                    ? _value.restaurants
                    : restaurants // ignore: cast_nullable_to_non_nullable
                        as List<Restaurant>,
            markers:
                null == markers
                    ? _value.markers
                    : markers // ignore: cast_nullable_to_non_nullable
                        as List<RestaurantMarker>,
            userPosition:
                null == userPosition
                    ? _value.userPosition
                    : userPosition // ignore: cast_nullable_to_non_nullable
                        as Position,
            isMapLoading:
                null == isMapLoading
                    ? _value.isMapLoading
                    : isMapLoading // ignore: cast_nullable_to_non_nullable
                        as bool,
            selectedRestaurantId:
                freezed == selectedRestaurantId
                    ? _value.selectedRestaurantId
                    : selectedRestaurantId // ignore: cast_nullable_to_non_nullable
                        as String?,
            selectedRestaurant:
                freezed == selectedRestaurant
                    ? _value.selectedRestaurant
                    : selectedRestaurant // ignore: cast_nullable_to_non_nullable
                        as Restaurant?,
            searchQuery:
                freezed == searchQuery
                    ? _value.searchQuery
                    : searchQuery // ignore: cast_nullable_to_non_nullable
                        as String?,
            clusterEngineReady:
                null == clusterEngineReady
                    ? _value.clusterEngineReady
                    : clusterEngineReady // ignore: cast_nullable_to_non_nullable
                        as bool,
          )
          as $Val,
    );
  }

  /// Create a copy of ExploreData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $RestaurantCopyWith<$Res>? get selectedRestaurant {
    if (_value.selectedRestaurant == null) {
      return null;
    }

    return $RestaurantCopyWith<$Res>(_value.selectedRestaurant!, (value) {
      return _then(_value.copyWith(selectedRestaurant: value) as $Val);
    });
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
    List<Restaurant> restaurants,
    List<RestaurantMarker> markers,
    Position userPosition,
    bool isMapLoading,
    String? selectedRestaurantId,
    Restaurant? selectedRestaurant,
    String? searchQuery,
    bool clusterEngineReady,
  });

  @override
  $RestaurantCopyWith<$Res>? get selectedRestaurant;
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
    Object? restaurants = null,
    Object? markers = null,
    Object? userPosition = null,
    Object? isMapLoading = null,
    Object? selectedRestaurantId = freezed,
    Object? selectedRestaurant = freezed,
    Object? searchQuery = freezed,
    Object? clusterEngineReady = null,
  }) {
    return _then(
      _$ExploreDataImpl(
        restaurants:
            null == restaurants
                ? _value._restaurants
                : restaurants // ignore: cast_nullable_to_non_nullable
                    as List<Restaurant>,
        markers:
            null == markers
                ? _value._markers
                : markers // ignore: cast_nullable_to_non_nullable
                    as List<RestaurantMarker>,
        userPosition:
            null == userPosition
                ? _value.userPosition
                : userPosition // ignore: cast_nullable_to_non_nullable
                    as Position,
        isMapLoading:
            null == isMapLoading
                ? _value.isMapLoading
                : isMapLoading // ignore: cast_nullable_to_non_nullable
                    as bool,
        selectedRestaurantId:
            freezed == selectedRestaurantId
                ? _value.selectedRestaurantId
                : selectedRestaurantId // ignore: cast_nullable_to_non_nullable
                    as String?,
        selectedRestaurant:
            freezed == selectedRestaurant
                ? _value.selectedRestaurant
                : selectedRestaurant // ignore: cast_nullable_to_non_nullable
                    as Restaurant?,
        searchQuery:
            freezed == searchQuery
                ? _value.searchQuery
                : searchQuery // ignore: cast_nullable_to_non_nullable
                    as String?,
        clusterEngineReady:
            null == clusterEngineReady
                ? _value.clusterEngineReady
                : clusterEngineReady // ignore: cast_nullable_to_non_nullable
                    as bool,
      ),
    );
  }
}

/// @nodoc

class _$ExploreDataImpl implements _ExploreData {
  const _$ExploreDataImpl({
    required final List<Restaurant> restaurants,
    required final List<RestaurantMarker> markers,
    required this.userPosition,
    this.isMapLoading = false,
    this.selectedRestaurantId = null,
    this.selectedRestaurant = null,
    this.searchQuery = null,
    this.clusterEngineReady = false,
  }) : _restaurants = restaurants,
       _markers = markers;

  /// Restaurace z DB
  final List<Restaurant> _restaurants;

  /// Restaurace z DB
  @override
  List<Restaurant> get restaurants {
    if (_restaurants is EqualUnmodifiableListView) return _restaurants;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_restaurants);
  }

  /// Markery pro mapu (shluky nebo restaurace)
  final List<RestaurantMarker> _markers;

  /// Markery pro mapu (shluky nebo restaurace)
  @override
  List<RestaurantMarker> get markers {
    if (_markers is EqualUnmodifiableListView) return _markers;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_markers);
  }

  /// Aktualni poloha uzivatele
  @override
  final Position userPosition;

  /// Zda probiha aktualizace markeru na mape
  @override
  @JsonKey()
  final bool isMapLoading;

  /// ID vybrane restaurace (null = zadny vyber)
  @override
  @JsonKey()
  final String? selectedRestaurantId;

  /// Vybrana restaurace pro preview card
  @override
  @JsonKey()
  final Restaurant? selectedRestaurant;

  /// Aktivni search query
  @override
  @JsonKey()
  final String? searchQuery;

  /// Zda je client-side clustering engine pripraveny (data nactena z disku/backendu)
  @override
  @JsonKey()
  final bool clusterEngineReady;

  @override
  String toString() {
    return 'ExploreData(restaurants: $restaurants, markers: $markers, userPosition: $userPosition, isMapLoading: $isMapLoading, selectedRestaurantId: $selectedRestaurantId, selectedRestaurant: $selectedRestaurant, searchQuery: $searchQuery, clusterEngineReady: $clusterEngineReady)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ExploreDataImpl &&
            const DeepCollectionEquality().equals(
              other._restaurants,
              _restaurants,
            ) &&
            const DeepCollectionEquality().equals(other._markers, _markers) &&
            (identical(other.userPosition, userPosition) ||
                other.userPosition == userPosition) &&
            (identical(other.isMapLoading, isMapLoading) ||
                other.isMapLoading == isMapLoading) &&
            (identical(other.selectedRestaurantId, selectedRestaurantId) ||
                other.selectedRestaurantId == selectedRestaurantId) &&
            (identical(other.selectedRestaurant, selectedRestaurant) ||
                other.selectedRestaurant == selectedRestaurant) &&
            (identical(other.searchQuery, searchQuery) ||
                other.searchQuery == searchQuery) &&
            (identical(other.clusterEngineReady, clusterEngineReady) ||
                other.clusterEngineReady == clusterEngineReady));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    const DeepCollectionEquality().hash(_restaurants),
    const DeepCollectionEquality().hash(_markers),
    userPosition,
    isMapLoading,
    selectedRestaurantId,
    selectedRestaurant,
    searchQuery,
    clusterEngineReady,
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
    required final List<Restaurant> restaurants,
    required final List<RestaurantMarker> markers,
    required final Position userPosition,
    final bool isMapLoading,
    final String? selectedRestaurantId,
    final Restaurant? selectedRestaurant,
    final String? searchQuery,
    final bool clusterEngineReady,
  }) = _$ExploreDataImpl;

  /// Restaurace z DB
  @override
  List<Restaurant> get restaurants;

  /// Markery pro mapu (shluky nebo restaurace)
  @override
  List<RestaurantMarker> get markers;

  /// Aktualni poloha uzivatele
  @override
  Position get userPosition;

  /// Zda probiha aktualizace markeru na mape
  @override
  bool get isMapLoading;

  /// ID vybrane restaurace (null = zadny vyber)
  @override
  String? get selectedRestaurantId;

  /// Vybrana restaurace pro preview card
  @override
  Restaurant? get selectedRestaurant;

  /// Aktivni search query
  @override
  String? get searchQuery;

  /// Zda je client-side clustering engine pripraveny (data nactena z disku/backendu)
  @override
  bool get clusterEngineReady;

  /// Create a copy of ExploreData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ExploreDataImplCopyWith<_$ExploreDataImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
