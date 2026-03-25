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
  /// Google Places z API
  List<GooglePlace> get places => throw _privateConstructorUsedError;

  /// Markery pro mapu (shluky nebo restaurace)
  List<RestaurantMarker> get markers => throw _privateConstructorUsedError;

  /// Aktualni poloha uzivatele
  Position get userPosition => throw _privateConstructorUsedError;

  /// Zda probiha aktualizace markeru na mape
  bool get isMapLoading => throw _privateConstructorUsedError;

  /// ID vybraneho mista (null = zadny vyber)
  String? get selectedPlaceId => throw _privateConstructorUsedError;

  /// Vybrane misto pro preview card
  GooglePlace? get selectedPlace => throw _privateConstructorUsedError;

  /// Aktivni search query
  String? get searchQuery => throw _privateConstructorUsedError;

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
    List<GooglePlace> places,
    List<RestaurantMarker> markers,
    Position userPosition,
    bool isMapLoading,
    String? selectedPlaceId,
    GooglePlace? selectedPlace,
    String? searchQuery,
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
    Object? places = null,
    Object? markers = null,
    Object? userPosition = null,
    Object? isMapLoading = null,
    Object? selectedPlaceId = freezed,
    Object? selectedPlace = freezed,
    Object? searchQuery = freezed,
  }) {
    return _then(
      _value.copyWith(
            places:
                null == places
                    ? _value.places
                    : places // ignore: cast_nullable_to_non_nullable
                        as List<GooglePlace>,
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
            selectedPlaceId:
                freezed == selectedPlaceId
                    ? _value.selectedPlaceId
                    : selectedPlaceId // ignore: cast_nullable_to_non_nullable
                        as String?,
            selectedPlace:
                freezed == selectedPlace
                    ? _value.selectedPlace
                    : selectedPlace // ignore: cast_nullable_to_non_nullable
                        as GooglePlace?,
            searchQuery:
                freezed == searchQuery
                    ? _value.searchQuery
                    : searchQuery // ignore: cast_nullable_to_non_nullable
                        as String?,
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
    List<GooglePlace> places,
    List<RestaurantMarker> markers,
    Position userPosition,
    bool isMapLoading,
    String? selectedPlaceId,
    GooglePlace? selectedPlace,
    String? searchQuery,
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
    Object? places = null,
    Object? markers = null,
    Object? userPosition = null,
    Object? isMapLoading = null,
    Object? selectedPlaceId = freezed,
    Object? selectedPlace = freezed,
    Object? searchQuery = freezed,
  }) {
    return _then(
      _$ExploreDataImpl(
        places:
            null == places
                ? _value._places
                : places // ignore: cast_nullable_to_non_nullable
                    as List<GooglePlace>,
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
        selectedPlaceId:
            freezed == selectedPlaceId
                ? _value.selectedPlaceId
                : selectedPlaceId // ignore: cast_nullable_to_non_nullable
                    as String?,
        selectedPlace:
            freezed == selectedPlace
                ? _value.selectedPlace
                : selectedPlace // ignore: cast_nullable_to_non_nullable
                    as GooglePlace?,
        searchQuery:
            freezed == searchQuery
                ? _value.searchQuery
                : searchQuery // ignore: cast_nullable_to_non_nullable
                    as String?,
      ),
    );
  }
}

/// @nodoc

class _$ExploreDataImpl implements _ExploreData {
  const _$ExploreDataImpl({
    required final List<GooglePlace> places,
    required final List<RestaurantMarker> markers,
    required this.userPosition,
    this.isMapLoading = false,
    this.selectedPlaceId = null,
    this.selectedPlace = null,
    this.searchQuery = null,
  }) : _places = places,
       _markers = markers;

  /// Google Places z API
  final List<GooglePlace> _places;

  /// Google Places z API
  @override
  List<GooglePlace> get places {
    if (_places is EqualUnmodifiableListView) return _places;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_places);
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

  /// ID vybraneho mista (null = zadny vyber)
  @override
  @JsonKey()
  final String? selectedPlaceId;

  /// Vybrane misto pro preview card
  @override
  @JsonKey()
  final GooglePlace? selectedPlace;

  /// Aktivni search query
  @override
  @JsonKey()
  final String? searchQuery;

  @override
  String toString() {
    return 'ExploreData(places: $places, markers: $markers, userPosition: $userPosition, isMapLoading: $isMapLoading, selectedPlaceId: $selectedPlaceId, selectedPlace: $selectedPlace, searchQuery: $searchQuery)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ExploreDataImpl &&
            const DeepCollectionEquality().equals(other._places, _places) &&
            const DeepCollectionEquality().equals(other._markers, _markers) &&
            (identical(other.userPosition, userPosition) ||
                other.userPosition == userPosition) &&
            (identical(other.isMapLoading, isMapLoading) ||
                other.isMapLoading == isMapLoading) &&
            (identical(other.selectedPlaceId, selectedPlaceId) ||
                other.selectedPlaceId == selectedPlaceId) &&
            (identical(other.selectedPlace, selectedPlace) ||
                other.selectedPlace == selectedPlace) &&
            (identical(other.searchQuery, searchQuery) ||
                other.searchQuery == searchQuery));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    const DeepCollectionEquality().hash(_places),
    const DeepCollectionEquality().hash(_markers),
    userPosition,
    isMapLoading,
    selectedPlaceId,
    selectedPlace,
    searchQuery,
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
    required final List<GooglePlace> places,
    required final List<RestaurantMarker> markers,
    required final Position userPosition,
    final bool isMapLoading,
    final String? selectedPlaceId,
    final GooglePlace? selectedPlace,
    final String? searchQuery,
  }) = _$ExploreDataImpl;

  /// Google Places z API
  @override
  List<GooglePlace> get places;

  /// Markery pro mapu (shluky nebo restaurace)
  @override
  List<RestaurantMarker> get markers;

  /// Aktualni poloha uzivatele
  @override
  Position get userPosition;

  /// Zda probiha aktualizace markeru na mape
  @override
  bool get isMapLoading;

  /// ID vybraneho mista (null = zadny vyber)
  @override
  String? get selectedPlaceId;

  /// Vybrane misto pro preview card
  @override
  GooglePlace? get selectedPlace;

  /// Aktivni search query
  @override
  String? get searchQuery;

  /// Create a copy of ExploreData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ExploreDataImplCopyWith<_$ExploreDataImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
