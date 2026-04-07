// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'explore_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$ExploreEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initializeRequested,
    required TResult Function(bool granted) permissionResultReceived,
    required TResult Function(MapParamsModel params) mapBoundsChanged,
    required TResult Function() refreshRequested,
    required TResult Function(String query) searchChanged,
    required TResult Function(RestaurantFilters filters) filtersChanged,
    required TResult Function(String? restaurantId) markerSelected,
    required TResult Function(
      double minLat,
      double maxLat,
      double minLng,
      double maxLng,
      int zoom,
    )
    viewportChanged,
    required TResult Function(int version) markersRefreshed,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initializeRequested,
    TResult? Function(bool granted)? permissionResultReceived,
    TResult? Function(MapParamsModel params)? mapBoundsChanged,
    TResult? Function()? refreshRequested,
    TResult? Function(String query)? searchChanged,
    TResult? Function(RestaurantFilters filters)? filtersChanged,
    TResult? Function(String? restaurantId)? markerSelected,
    TResult? Function(
      double minLat,
      double maxLat,
      double minLng,
      double maxLng,
      int zoom,
    )?
    viewportChanged,
    TResult? Function(int version)? markersRefreshed,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initializeRequested,
    TResult Function(bool granted)? permissionResultReceived,
    TResult Function(MapParamsModel params)? mapBoundsChanged,
    TResult Function()? refreshRequested,
    TResult Function(String query)? searchChanged,
    TResult Function(RestaurantFilters filters)? filtersChanged,
    TResult Function(String? restaurantId)? markerSelected,
    TResult Function(
      double minLat,
      double maxLat,
      double minLng,
      double maxLng,
      int zoom,
    )?
    viewportChanged,
    TResult Function(int version)? markersRefreshed,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(InitializeRequested value) initializeRequested,
    required TResult Function(PermissionResultReceived value)
    permissionResultReceived,
    required TResult Function(MapBoundsChanged value) mapBoundsChanged,
    required TResult Function(RefreshRequested value) refreshRequested,
    required TResult Function(SearchChanged value) searchChanged,
    required TResult Function(FiltersChanged value) filtersChanged,
    required TResult Function(MarkerSelected value) markerSelected,
    required TResult Function(ViewportChanged value) viewportChanged,
    required TResult Function(MarkersRefreshed value) markersRefreshed,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(InitializeRequested value)? initializeRequested,
    TResult? Function(PermissionResultReceived value)? permissionResultReceived,
    TResult? Function(MapBoundsChanged value)? mapBoundsChanged,
    TResult? Function(RefreshRequested value)? refreshRequested,
    TResult? Function(SearchChanged value)? searchChanged,
    TResult? Function(FiltersChanged value)? filtersChanged,
    TResult? Function(MarkerSelected value)? markerSelected,
    TResult? Function(ViewportChanged value)? viewportChanged,
    TResult? Function(MarkersRefreshed value)? markersRefreshed,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(InitializeRequested value)? initializeRequested,
    TResult Function(PermissionResultReceived value)? permissionResultReceived,
    TResult Function(MapBoundsChanged value)? mapBoundsChanged,
    TResult Function(RefreshRequested value)? refreshRequested,
    TResult Function(SearchChanged value)? searchChanged,
    TResult Function(FiltersChanged value)? filtersChanged,
    TResult Function(MarkerSelected value)? markerSelected,
    TResult Function(ViewportChanged value)? viewportChanged,
    TResult Function(MarkersRefreshed value)? markersRefreshed,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ExploreEventCopyWith<$Res> {
  factory $ExploreEventCopyWith(
    ExploreEvent value,
    $Res Function(ExploreEvent) then,
  ) = _$ExploreEventCopyWithImpl<$Res, ExploreEvent>;
}

/// @nodoc
class _$ExploreEventCopyWithImpl<$Res, $Val extends ExploreEvent>
    implements $ExploreEventCopyWith<$Res> {
  _$ExploreEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ExploreEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$InitializeRequestedImplCopyWith<$Res> {
  factory _$$InitializeRequestedImplCopyWith(
    _$InitializeRequestedImpl value,
    $Res Function(_$InitializeRequestedImpl) then,
  ) = __$$InitializeRequestedImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$InitializeRequestedImplCopyWithImpl<$Res>
    extends _$ExploreEventCopyWithImpl<$Res, _$InitializeRequestedImpl>
    implements _$$InitializeRequestedImplCopyWith<$Res> {
  __$$InitializeRequestedImplCopyWithImpl(
    _$InitializeRequestedImpl _value,
    $Res Function(_$InitializeRequestedImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ExploreEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$InitializeRequestedImpl implements InitializeRequested {
  const _$InitializeRequestedImpl();

  @override
  String toString() {
    return 'ExploreEvent.initializeRequested()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$InitializeRequestedImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initializeRequested,
    required TResult Function(bool granted) permissionResultReceived,
    required TResult Function(MapParamsModel params) mapBoundsChanged,
    required TResult Function() refreshRequested,
    required TResult Function(String query) searchChanged,
    required TResult Function(RestaurantFilters filters) filtersChanged,
    required TResult Function(String? restaurantId) markerSelected,
    required TResult Function(
      double minLat,
      double maxLat,
      double minLng,
      double maxLng,
      int zoom,
    )
    viewportChanged,
    required TResult Function(int version) markersRefreshed,
  }) {
    return initializeRequested();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initializeRequested,
    TResult? Function(bool granted)? permissionResultReceived,
    TResult? Function(MapParamsModel params)? mapBoundsChanged,
    TResult? Function()? refreshRequested,
    TResult? Function(String query)? searchChanged,
    TResult? Function(RestaurantFilters filters)? filtersChanged,
    TResult? Function(String? restaurantId)? markerSelected,
    TResult? Function(
      double minLat,
      double maxLat,
      double minLng,
      double maxLng,
      int zoom,
    )?
    viewportChanged,
    TResult? Function(int version)? markersRefreshed,
  }) {
    return initializeRequested?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initializeRequested,
    TResult Function(bool granted)? permissionResultReceived,
    TResult Function(MapParamsModel params)? mapBoundsChanged,
    TResult Function()? refreshRequested,
    TResult Function(String query)? searchChanged,
    TResult Function(RestaurantFilters filters)? filtersChanged,
    TResult Function(String? restaurantId)? markerSelected,
    TResult Function(
      double minLat,
      double maxLat,
      double minLng,
      double maxLng,
      int zoom,
    )?
    viewportChanged,
    TResult Function(int version)? markersRefreshed,
    required TResult orElse(),
  }) {
    if (initializeRequested != null) {
      return initializeRequested();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(InitializeRequested value) initializeRequested,
    required TResult Function(PermissionResultReceived value)
    permissionResultReceived,
    required TResult Function(MapBoundsChanged value) mapBoundsChanged,
    required TResult Function(RefreshRequested value) refreshRequested,
    required TResult Function(SearchChanged value) searchChanged,
    required TResult Function(FiltersChanged value) filtersChanged,
    required TResult Function(MarkerSelected value) markerSelected,
    required TResult Function(ViewportChanged value) viewportChanged,
    required TResult Function(MarkersRefreshed value) markersRefreshed,
  }) {
    return initializeRequested(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(InitializeRequested value)? initializeRequested,
    TResult? Function(PermissionResultReceived value)? permissionResultReceived,
    TResult? Function(MapBoundsChanged value)? mapBoundsChanged,
    TResult? Function(RefreshRequested value)? refreshRequested,
    TResult? Function(SearchChanged value)? searchChanged,
    TResult? Function(FiltersChanged value)? filtersChanged,
    TResult? Function(MarkerSelected value)? markerSelected,
    TResult? Function(ViewportChanged value)? viewportChanged,
    TResult? Function(MarkersRefreshed value)? markersRefreshed,
  }) {
    return initializeRequested?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(InitializeRequested value)? initializeRequested,
    TResult Function(PermissionResultReceived value)? permissionResultReceived,
    TResult Function(MapBoundsChanged value)? mapBoundsChanged,
    TResult Function(RefreshRequested value)? refreshRequested,
    TResult Function(SearchChanged value)? searchChanged,
    TResult Function(FiltersChanged value)? filtersChanged,
    TResult Function(MarkerSelected value)? markerSelected,
    TResult Function(ViewportChanged value)? viewportChanged,
    TResult Function(MarkersRefreshed value)? markersRefreshed,
    required TResult orElse(),
  }) {
    if (initializeRequested != null) {
      return initializeRequested(this);
    }
    return orElse();
  }
}

abstract class InitializeRequested implements ExploreEvent {
  const factory InitializeRequested() = _$InitializeRequestedImpl;
}

/// @nodoc
abstract class _$$PermissionResultReceivedImplCopyWith<$Res> {
  factory _$$PermissionResultReceivedImplCopyWith(
    _$PermissionResultReceivedImpl value,
    $Res Function(_$PermissionResultReceivedImpl) then,
  ) = __$$PermissionResultReceivedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({bool granted});
}

/// @nodoc
class __$$PermissionResultReceivedImplCopyWithImpl<$Res>
    extends _$ExploreEventCopyWithImpl<$Res, _$PermissionResultReceivedImpl>
    implements _$$PermissionResultReceivedImplCopyWith<$Res> {
  __$$PermissionResultReceivedImplCopyWithImpl(
    _$PermissionResultReceivedImpl _value,
    $Res Function(_$PermissionResultReceivedImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ExploreEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? granted = null}) {
    return _then(
      _$PermissionResultReceivedImpl(
        granted:
            null == granted
                ? _value.granted
                : granted // ignore: cast_nullable_to_non_nullable
                    as bool,
      ),
    );
  }
}

/// @nodoc

class _$PermissionResultReceivedImpl implements PermissionResultReceived {
  const _$PermissionResultReceivedImpl({required this.granted});

  @override
  final bool granted;

  @override
  String toString() {
    return 'ExploreEvent.permissionResultReceived(granted: $granted)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PermissionResultReceivedImpl &&
            (identical(other.granted, granted) || other.granted == granted));
  }

  @override
  int get hashCode => Object.hash(runtimeType, granted);

  /// Create a copy of ExploreEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PermissionResultReceivedImplCopyWith<_$PermissionResultReceivedImpl>
  get copyWith => __$$PermissionResultReceivedImplCopyWithImpl<
    _$PermissionResultReceivedImpl
  >(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initializeRequested,
    required TResult Function(bool granted) permissionResultReceived,
    required TResult Function(MapParamsModel params) mapBoundsChanged,
    required TResult Function() refreshRequested,
    required TResult Function(String query) searchChanged,
    required TResult Function(RestaurantFilters filters) filtersChanged,
    required TResult Function(String? restaurantId) markerSelected,
    required TResult Function(
      double minLat,
      double maxLat,
      double minLng,
      double maxLng,
      int zoom,
    )
    viewportChanged,
    required TResult Function(int version) markersRefreshed,
  }) {
    return permissionResultReceived(granted);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initializeRequested,
    TResult? Function(bool granted)? permissionResultReceived,
    TResult? Function(MapParamsModel params)? mapBoundsChanged,
    TResult? Function()? refreshRequested,
    TResult? Function(String query)? searchChanged,
    TResult? Function(RestaurantFilters filters)? filtersChanged,
    TResult? Function(String? restaurantId)? markerSelected,
    TResult? Function(
      double minLat,
      double maxLat,
      double minLng,
      double maxLng,
      int zoom,
    )?
    viewportChanged,
    TResult? Function(int version)? markersRefreshed,
  }) {
    return permissionResultReceived?.call(granted);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initializeRequested,
    TResult Function(bool granted)? permissionResultReceived,
    TResult Function(MapParamsModel params)? mapBoundsChanged,
    TResult Function()? refreshRequested,
    TResult Function(String query)? searchChanged,
    TResult Function(RestaurantFilters filters)? filtersChanged,
    TResult Function(String? restaurantId)? markerSelected,
    TResult Function(
      double minLat,
      double maxLat,
      double minLng,
      double maxLng,
      int zoom,
    )?
    viewportChanged,
    TResult Function(int version)? markersRefreshed,
    required TResult orElse(),
  }) {
    if (permissionResultReceived != null) {
      return permissionResultReceived(granted);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(InitializeRequested value) initializeRequested,
    required TResult Function(PermissionResultReceived value)
    permissionResultReceived,
    required TResult Function(MapBoundsChanged value) mapBoundsChanged,
    required TResult Function(RefreshRequested value) refreshRequested,
    required TResult Function(SearchChanged value) searchChanged,
    required TResult Function(FiltersChanged value) filtersChanged,
    required TResult Function(MarkerSelected value) markerSelected,
    required TResult Function(ViewportChanged value) viewportChanged,
    required TResult Function(MarkersRefreshed value) markersRefreshed,
  }) {
    return permissionResultReceived(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(InitializeRequested value)? initializeRequested,
    TResult? Function(PermissionResultReceived value)? permissionResultReceived,
    TResult? Function(MapBoundsChanged value)? mapBoundsChanged,
    TResult? Function(RefreshRequested value)? refreshRequested,
    TResult? Function(SearchChanged value)? searchChanged,
    TResult? Function(FiltersChanged value)? filtersChanged,
    TResult? Function(MarkerSelected value)? markerSelected,
    TResult? Function(ViewportChanged value)? viewportChanged,
    TResult? Function(MarkersRefreshed value)? markersRefreshed,
  }) {
    return permissionResultReceived?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(InitializeRequested value)? initializeRequested,
    TResult Function(PermissionResultReceived value)? permissionResultReceived,
    TResult Function(MapBoundsChanged value)? mapBoundsChanged,
    TResult Function(RefreshRequested value)? refreshRequested,
    TResult Function(SearchChanged value)? searchChanged,
    TResult Function(FiltersChanged value)? filtersChanged,
    TResult Function(MarkerSelected value)? markerSelected,
    TResult Function(ViewportChanged value)? viewportChanged,
    TResult Function(MarkersRefreshed value)? markersRefreshed,
    required TResult orElse(),
  }) {
    if (permissionResultReceived != null) {
      return permissionResultReceived(this);
    }
    return orElse();
  }
}

abstract class PermissionResultReceived implements ExploreEvent {
  const factory PermissionResultReceived({required final bool granted}) =
      _$PermissionResultReceivedImpl;

  bool get granted;

  /// Create a copy of ExploreEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PermissionResultReceivedImplCopyWith<_$PermissionResultReceivedImpl>
  get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$MapBoundsChangedImplCopyWith<$Res> {
  factory _$$MapBoundsChangedImplCopyWith(
    _$MapBoundsChangedImpl value,
    $Res Function(_$MapBoundsChangedImpl) then,
  ) = __$$MapBoundsChangedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({MapParamsModel params});

  $MapParamsModelCopyWith<$Res> get params;
}

/// @nodoc
class __$$MapBoundsChangedImplCopyWithImpl<$Res>
    extends _$ExploreEventCopyWithImpl<$Res, _$MapBoundsChangedImpl>
    implements _$$MapBoundsChangedImplCopyWith<$Res> {
  __$$MapBoundsChangedImplCopyWithImpl(
    _$MapBoundsChangedImpl _value,
    $Res Function(_$MapBoundsChangedImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ExploreEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? params = null}) {
    return _then(
      _$MapBoundsChangedImpl(
        params:
            null == params
                ? _value.params
                : params // ignore: cast_nullable_to_non_nullable
                    as MapParamsModel,
      ),
    );
  }

  /// Create a copy of ExploreEvent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $MapParamsModelCopyWith<$Res> get params {
    return $MapParamsModelCopyWith<$Res>(_value.params, (value) {
      return _then(_value.copyWith(params: value));
    });
  }
}

/// @nodoc

class _$MapBoundsChangedImpl implements MapBoundsChanged {
  const _$MapBoundsChangedImpl({required this.params});

  @override
  final MapParamsModel params;

  @override
  String toString() {
    return 'ExploreEvent.mapBoundsChanged(params: $params)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MapBoundsChangedImpl &&
            (identical(other.params, params) || other.params == params));
  }

  @override
  int get hashCode => Object.hash(runtimeType, params);

  /// Create a copy of ExploreEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MapBoundsChangedImplCopyWith<_$MapBoundsChangedImpl> get copyWith =>
      __$$MapBoundsChangedImplCopyWithImpl<_$MapBoundsChangedImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initializeRequested,
    required TResult Function(bool granted) permissionResultReceived,
    required TResult Function(MapParamsModel params) mapBoundsChanged,
    required TResult Function() refreshRequested,
    required TResult Function(String query) searchChanged,
    required TResult Function(RestaurantFilters filters) filtersChanged,
    required TResult Function(String? restaurantId) markerSelected,
    required TResult Function(
      double minLat,
      double maxLat,
      double minLng,
      double maxLng,
      int zoom,
    )
    viewportChanged,
    required TResult Function(int version) markersRefreshed,
  }) {
    return mapBoundsChanged(params);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initializeRequested,
    TResult? Function(bool granted)? permissionResultReceived,
    TResult? Function(MapParamsModel params)? mapBoundsChanged,
    TResult? Function()? refreshRequested,
    TResult? Function(String query)? searchChanged,
    TResult? Function(RestaurantFilters filters)? filtersChanged,
    TResult? Function(String? restaurantId)? markerSelected,
    TResult? Function(
      double minLat,
      double maxLat,
      double minLng,
      double maxLng,
      int zoom,
    )?
    viewportChanged,
    TResult? Function(int version)? markersRefreshed,
  }) {
    return mapBoundsChanged?.call(params);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initializeRequested,
    TResult Function(bool granted)? permissionResultReceived,
    TResult Function(MapParamsModel params)? mapBoundsChanged,
    TResult Function()? refreshRequested,
    TResult Function(String query)? searchChanged,
    TResult Function(RestaurantFilters filters)? filtersChanged,
    TResult Function(String? restaurantId)? markerSelected,
    TResult Function(
      double minLat,
      double maxLat,
      double minLng,
      double maxLng,
      int zoom,
    )?
    viewportChanged,
    TResult Function(int version)? markersRefreshed,
    required TResult orElse(),
  }) {
    if (mapBoundsChanged != null) {
      return mapBoundsChanged(params);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(InitializeRequested value) initializeRequested,
    required TResult Function(PermissionResultReceived value)
    permissionResultReceived,
    required TResult Function(MapBoundsChanged value) mapBoundsChanged,
    required TResult Function(RefreshRequested value) refreshRequested,
    required TResult Function(SearchChanged value) searchChanged,
    required TResult Function(FiltersChanged value) filtersChanged,
    required TResult Function(MarkerSelected value) markerSelected,
    required TResult Function(ViewportChanged value) viewportChanged,
    required TResult Function(MarkersRefreshed value) markersRefreshed,
  }) {
    return mapBoundsChanged(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(InitializeRequested value)? initializeRequested,
    TResult? Function(PermissionResultReceived value)? permissionResultReceived,
    TResult? Function(MapBoundsChanged value)? mapBoundsChanged,
    TResult? Function(RefreshRequested value)? refreshRequested,
    TResult? Function(SearchChanged value)? searchChanged,
    TResult? Function(FiltersChanged value)? filtersChanged,
    TResult? Function(MarkerSelected value)? markerSelected,
    TResult? Function(ViewportChanged value)? viewportChanged,
    TResult? Function(MarkersRefreshed value)? markersRefreshed,
  }) {
    return mapBoundsChanged?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(InitializeRequested value)? initializeRequested,
    TResult Function(PermissionResultReceived value)? permissionResultReceived,
    TResult Function(MapBoundsChanged value)? mapBoundsChanged,
    TResult Function(RefreshRequested value)? refreshRequested,
    TResult Function(SearchChanged value)? searchChanged,
    TResult Function(FiltersChanged value)? filtersChanged,
    TResult Function(MarkerSelected value)? markerSelected,
    TResult Function(ViewportChanged value)? viewportChanged,
    TResult Function(MarkersRefreshed value)? markersRefreshed,
    required TResult orElse(),
  }) {
    if (mapBoundsChanged != null) {
      return mapBoundsChanged(this);
    }
    return orElse();
  }
}

abstract class MapBoundsChanged implements ExploreEvent {
  const factory MapBoundsChanged({required final MapParamsModel params}) =
      _$MapBoundsChangedImpl;

  MapParamsModel get params;

  /// Create a copy of ExploreEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MapBoundsChangedImplCopyWith<_$MapBoundsChangedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$RefreshRequestedImplCopyWith<$Res> {
  factory _$$RefreshRequestedImplCopyWith(
    _$RefreshRequestedImpl value,
    $Res Function(_$RefreshRequestedImpl) then,
  ) = __$$RefreshRequestedImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$RefreshRequestedImplCopyWithImpl<$Res>
    extends _$ExploreEventCopyWithImpl<$Res, _$RefreshRequestedImpl>
    implements _$$RefreshRequestedImplCopyWith<$Res> {
  __$$RefreshRequestedImplCopyWithImpl(
    _$RefreshRequestedImpl _value,
    $Res Function(_$RefreshRequestedImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ExploreEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$RefreshRequestedImpl implements RefreshRequested {
  const _$RefreshRequestedImpl();

  @override
  String toString() {
    return 'ExploreEvent.refreshRequested()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$RefreshRequestedImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initializeRequested,
    required TResult Function(bool granted) permissionResultReceived,
    required TResult Function(MapParamsModel params) mapBoundsChanged,
    required TResult Function() refreshRequested,
    required TResult Function(String query) searchChanged,
    required TResult Function(RestaurantFilters filters) filtersChanged,
    required TResult Function(String? restaurantId) markerSelected,
    required TResult Function(
      double minLat,
      double maxLat,
      double minLng,
      double maxLng,
      int zoom,
    )
    viewportChanged,
    required TResult Function(int version) markersRefreshed,
  }) {
    return refreshRequested();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initializeRequested,
    TResult? Function(bool granted)? permissionResultReceived,
    TResult? Function(MapParamsModel params)? mapBoundsChanged,
    TResult? Function()? refreshRequested,
    TResult? Function(String query)? searchChanged,
    TResult? Function(RestaurantFilters filters)? filtersChanged,
    TResult? Function(String? restaurantId)? markerSelected,
    TResult? Function(
      double minLat,
      double maxLat,
      double minLng,
      double maxLng,
      int zoom,
    )?
    viewportChanged,
    TResult? Function(int version)? markersRefreshed,
  }) {
    return refreshRequested?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initializeRequested,
    TResult Function(bool granted)? permissionResultReceived,
    TResult Function(MapParamsModel params)? mapBoundsChanged,
    TResult Function()? refreshRequested,
    TResult Function(String query)? searchChanged,
    TResult Function(RestaurantFilters filters)? filtersChanged,
    TResult Function(String? restaurantId)? markerSelected,
    TResult Function(
      double minLat,
      double maxLat,
      double minLng,
      double maxLng,
      int zoom,
    )?
    viewportChanged,
    TResult Function(int version)? markersRefreshed,
    required TResult orElse(),
  }) {
    if (refreshRequested != null) {
      return refreshRequested();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(InitializeRequested value) initializeRequested,
    required TResult Function(PermissionResultReceived value)
    permissionResultReceived,
    required TResult Function(MapBoundsChanged value) mapBoundsChanged,
    required TResult Function(RefreshRequested value) refreshRequested,
    required TResult Function(SearchChanged value) searchChanged,
    required TResult Function(FiltersChanged value) filtersChanged,
    required TResult Function(MarkerSelected value) markerSelected,
    required TResult Function(ViewportChanged value) viewportChanged,
    required TResult Function(MarkersRefreshed value) markersRefreshed,
  }) {
    return refreshRequested(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(InitializeRequested value)? initializeRequested,
    TResult? Function(PermissionResultReceived value)? permissionResultReceived,
    TResult? Function(MapBoundsChanged value)? mapBoundsChanged,
    TResult? Function(RefreshRequested value)? refreshRequested,
    TResult? Function(SearchChanged value)? searchChanged,
    TResult? Function(FiltersChanged value)? filtersChanged,
    TResult? Function(MarkerSelected value)? markerSelected,
    TResult? Function(ViewportChanged value)? viewportChanged,
    TResult? Function(MarkersRefreshed value)? markersRefreshed,
  }) {
    return refreshRequested?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(InitializeRequested value)? initializeRequested,
    TResult Function(PermissionResultReceived value)? permissionResultReceived,
    TResult Function(MapBoundsChanged value)? mapBoundsChanged,
    TResult Function(RefreshRequested value)? refreshRequested,
    TResult Function(SearchChanged value)? searchChanged,
    TResult Function(FiltersChanged value)? filtersChanged,
    TResult Function(MarkerSelected value)? markerSelected,
    TResult Function(ViewportChanged value)? viewportChanged,
    TResult Function(MarkersRefreshed value)? markersRefreshed,
    required TResult orElse(),
  }) {
    if (refreshRequested != null) {
      return refreshRequested(this);
    }
    return orElse();
  }
}

abstract class RefreshRequested implements ExploreEvent {
  const factory RefreshRequested() = _$RefreshRequestedImpl;
}

/// @nodoc
abstract class _$$SearchChangedImplCopyWith<$Res> {
  factory _$$SearchChangedImplCopyWith(
    _$SearchChangedImpl value,
    $Res Function(_$SearchChangedImpl) then,
  ) = __$$SearchChangedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String query});
}

/// @nodoc
class __$$SearchChangedImplCopyWithImpl<$Res>
    extends _$ExploreEventCopyWithImpl<$Res, _$SearchChangedImpl>
    implements _$$SearchChangedImplCopyWith<$Res> {
  __$$SearchChangedImplCopyWithImpl(
    _$SearchChangedImpl _value,
    $Res Function(_$SearchChangedImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ExploreEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? query = null}) {
    return _then(
      _$SearchChangedImpl(
        query:
            null == query
                ? _value.query
                : query // ignore: cast_nullable_to_non_nullable
                    as String,
      ),
    );
  }
}

/// @nodoc

class _$SearchChangedImpl implements SearchChanged {
  const _$SearchChangedImpl({required this.query});

  @override
  final String query;

  @override
  String toString() {
    return 'ExploreEvent.searchChanged(query: $query)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SearchChangedImpl &&
            (identical(other.query, query) || other.query == query));
  }

  @override
  int get hashCode => Object.hash(runtimeType, query);

  /// Create a copy of ExploreEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SearchChangedImplCopyWith<_$SearchChangedImpl> get copyWith =>
      __$$SearchChangedImplCopyWithImpl<_$SearchChangedImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initializeRequested,
    required TResult Function(bool granted) permissionResultReceived,
    required TResult Function(MapParamsModel params) mapBoundsChanged,
    required TResult Function() refreshRequested,
    required TResult Function(String query) searchChanged,
    required TResult Function(RestaurantFilters filters) filtersChanged,
    required TResult Function(String? restaurantId) markerSelected,
    required TResult Function(
      double minLat,
      double maxLat,
      double minLng,
      double maxLng,
      int zoom,
    )
    viewportChanged,
    required TResult Function(int version) markersRefreshed,
  }) {
    return searchChanged(query);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initializeRequested,
    TResult? Function(bool granted)? permissionResultReceived,
    TResult? Function(MapParamsModel params)? mapBoundsChanged,
    TResult? Function()? refreshRequested,
    TResult? Function(String query)? searchChanged,
    TResult? Function(RestaurantFilters filters)? filtersChanged,
    TResult? Function(String? restaurantId)? markerSelected,
    TResult? Function(
      double minLat,
      double maxLat,
      double minLng,
      double maxLng,
      int zoom,
    )?
    viewportChanged,
    TResult? Function(int version)? markersRefreshed,
  }) {
    return searchChanged?.call(query);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initializeRequested,
    TResult Function(bool granted)? permissionResultReceived,
    TResult Function(MapParamsModel params)? mapBoundsChanged,
    TResult Function()? refreshRequested,
    TResult Function(String query)? searchChanged,
    TResult Function(RestaurantFilters filters)? filtersChanged,
    TResult Function(String? restaurantId)? markerSelected,
    TResult Function(
      double minLat,
      double maxLat,
      double minLng,
      double maxLng,
      int zoom,
    )?
    viewportChanged,
    TResult Function(int version)? markersRefreshed,
    required TResult orElse(),
  }) {
    if (searchChanged != null) {
      return searchChanged(query);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(InitializeRequested value) initializeRequested,
    required TResult Function(PermissionResultReceived value)
    permissionResultReceived,
    required TResult Function(MapBoundsChanged value) mapBoundsChanged,
    required TResult Function(RefreshRequested value) refreshRequested,
    required TResult Function(SearchChanged value) searchChanged,
    required TResult Function(FiltersChanged value) filtersChanged,
    required TResult Function(MarkerSelected value) markerSelected,
    required TResult Function(ViewportChanged value) viewportChanged,
    required TResult Function(MarkersRefreshed value) markersRefreshed,
  }) {
    return searchChanged(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(InitializeRequested value)? initializeRequested,
    TResult? Function(PermissionResultReceived value)? permissionResultReceived,
    TResult? Function(MapBoundsChanged value)? mapBoundsChanged,
    TResult? Function(RefreshRequested value)? refreshRequested,
    TResult? Function(SearchChanged value)? searchChanged,
    TResult? Function(FiltersChanged value)? filtersChanged,
    TResult? Function(MarkerSelected value)? markerSelected,
    TResult? Function(ViewportChanged value)? viewportChanged,
    TResult? Function(MarkersRefreshed value)? markersRefreshed,
  }) {
    return searchChanged?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(InitializeRequested value)? initializeRequested,
    TResult Function(PermissionResultReceived value)? permissionResultReceived,
    TResult Function(MapBoundsChanged value)? mapBoundsChanged,
    TResult Function(RefreshRequested value)? refreshRequested,
    TResult Function(SearchChanged value)? searchChanged,
    TResult Function(FiltersChanged value)? filtersChanged,
    TResult Function(MarkerSelected value)? markerSelected,
    TResult Function(ViewportChanged value)? viewportChanged,
    TResult Function(MarkersRefreshed value)? markersRefreshed,
    required TResult orElse(),
  }) {
    if (searchChanged != null) {
      return searchChanged(this);
    }
    return orElse();
  }
}

abstract class SearchChanged implements ExploreEvent {
  const factory SearchChanged({required final String query}) =
      _$SearchChangedImpl;

  String get query;

  /// Create a copy of ExploreEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SearchChangedImplCopyWith<_$SearchChangedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$FiltersChangedImplCopyWith<$Res> {
  factory _$$FiltersChangedImplCopyWith(
    _$FiltersChangedImpl value,
    $Res Function(_$FiltersChangedImpl) then,
  ) = __$$FiltersChangedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({RestaurantFilters filters});

  $RestaurantFiltersCopyWith<$Res> get filters;
}

/// @nodoc
class __$$FiltersChangedImplCopyWithImpl<$Res>
    extends _$ExploreEventCopyWithImpl<$Res, _$FiltersChangedImpl>
    implements _$$FiltersChangedImplCopyWith<$Res> {
  __$$FiltersChangedImplCopyWithImpl(
    _$FiltersChangedImpl _value,
    $Res Function(_$FiltersChangedImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ExploreEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? filters = null}) {
    return _then(
      _$FiltersChangedImpl(
        filters:
            null == filters
                ? _value.filters
                : filters // ignore: cast_nullable_to_non_nullable
                    as RestaurantFilters,
      ),
    );
  }

  /// Create a copy of ExploreEvent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $RestaurantFiltersCopyWith<$Res> get filters {
    return $RestaurantFiltersCopyWith<$Res>(_value.filters, (value) {
      return _then(_value.copyWith(filters: value));
    });
  }
}

/// @nodoc

class _$FiltersChangedImpl implements FiltersChanged {
  const _$FiltersChangedImpl({required this.filters});

  @override
  final RestaurantFilters filters;

  @override
  String toString() {
    return 'ExploreEvent.filtersChanged(filters: $filters)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FiltersChangedImpl &&
            (identical(other.filters, filters) || other.filters == filters));
  }

  @override
  int get hashCode => Object.hash(runtimeType, filters);

  /// Create a copy of ExploreEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$FiltersChangedImplCopyWith<_$FiltersChangedImpl> get copyWith =>
      __$$FiltersChangedImplCopyWithImpl<_$FiltersChangedImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initializeRequested,
    required TResult Function(bool granted) permissionResultReceived,
    required TResult Function(MapParamsModel params) mapBoundsChanged,
    required TResult Function() refreshRequested,
    required TResult Function(String query) searchChanged,
    required TResult Function(RestaurantFilters filters) filtersChanged,
    required TResult Function(String? restaurantId) markerSelected,
    required TResult Function(
      double minLat,
      double maxLat,
      double minLng,
      double maxLng,
      int zoom,
    )
    viewportChanged,
    required TResult Function(int version) markersRefreshed,
  }) {
    return filtersChanged(filters);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initializeRequested,
    TResult? Function(bool granted)? permissionResultReceived,
    TResult? Function(MapParamsModel params)? mapBoundsChanged,
    TResult? Function()? refreshRequested,
    TResult? Function(String query)? searchChanged,
    TResult? Function(RestaurantFilters filters)? filtersChanged,
    TResult? Function(String? restaurantId)? markerSelected,
    TResult? Function(
      double minLat,
      double maxLat,
      double minLng,
      double maxLng,
      int zoom,
    )?
    viewportChanged,
    TResult? Function(int version)? markersRefreshed,
  }) {
    return filtersChanged?.call(filters);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initializeRequested,
    TResult Function(bool granted)? permissionResultReceived,
    TResult Function(MapParamsModel params)? mapBoundsChanged,
    TResult Function()? refreshRequested,
    TResult Function(String query)? searchChanged,
    TResult Function(RestaurantFilters filters)? filtersChanged,
    TResult Function(String? restaurantId)? markerSelected,
    TResult Function(
      double minLat,
      double maxLat,
      double minLng,
      double maxLng,
      int zoom,
    )?
    viewportChanged,
    TResult Function(int version)? markersRefreshed,
    required TResult orElse(),
  }) {
    if (filtersChanged != null) {
      return filtersChanged(filters);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(InitializeRequested value) initializeRequested,
    required TResult Function(PermissionResultReceived value)
    permissionResultReceived,
    required TResult Function(MapBoundsChanged value) mapBoundsChanged,
    required TResult Function(RefreshRequested value) refreshRequested,
    required TResult Function(SearchChanged value) searchChanged,
    required TResult Function(FiltersChanged value) filtersChanged,
    required TResult Function(MarkerSelected value) markerSelected,
    required TResult Function(ViewportChanged value) viewportChanged,
    required TResult Function(MarkersRefreshed value) markersRefreshed,
  }) {
    return filtersChanged(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(InitializeRequested value)? initializeRequested,
    TResult? Function(PermissionResultReceived value)? permissionResultReceived,
    TResult? Function(MapBoundsChanged value)? mapBoundsChanged,
    TResult? Function(RefreshRequested value)? refreshRequested,
    TResult? Function(SearchChanged value)? searchChanged,
    TResult? Function(FiltersChanged value)? filtersChanged,
    TResult? Function(MarkerSelected value)? markerSelected,
    TResult? Function(ViewportChanged value)? viewportChanged,
    TResult? Function(MarkersRefreshed value)? markersRefreshed,
  }) {
    return filtersChanged?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(InitializeRequested value)? initializeRequested,
    TResult Function(PermissionResultReceived value)? permissionResultReceived,
    TResult Function(MapBoundsChanged value)? mapBoundsChanged,
    TResult Function(RefreshRequested value)? refreshRequested,
    TResult Function(SearchChanged value)? searchChanged,
    TResult Function(FiltersChanged value)? filtersChanged,
    TResult Function(MarkerSelected value)? markerSelected,
    TResult Function(ViewportChanged value)? viewportChanged,
    TResult Function(MarkersRefreshed value)? markersRefreshed,
    required TResult orElse(),
  }) {
    if (filtersChanged != null) {
      return filtersChanged(this);
    }
    return orElse();
  }
}

abstract class FiltersChanged implements ExploreEvent {
  const factory FiltersChanged({required final RestaurantFilters filters}) =
      _$FiltersChangedImpl;

  RestaurantFilters get filters;

  /// Create a copy of ExploreEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$FiltersChangedImplCopyWith<_$FiltersChangedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$MarkerSelectedImplCopyWith<$Res> {
  factory _$$MarkerSelectedImplCopyWith(
    _$MarkerSelectedImpl value,
    $Res Function(_$MarkerSelectedImpl) then,
  ) = __$$MarkerSelectedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String? restaurantId});
}

/// @nodoc
class __$$MarkerSelectedImplCopyWithImpl<$Res>
    extends _$ExploreEventCopyWithImpl<$Res, _$MarkerSelectedImpl>
    implements _$$MarkerSelectedImplCopyWith<$Res> {
  __$$MarkerSelectedImplCopyWithImpl(
    _$MarkerSelectedImpl _value,
    $Res Function(_$MarkerSelectedImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ExploreEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? restaurantId = freezed}) {
    return _then(
      _$MarkerSelectedImpl(
        restaurantId:
            freezed == restaurantId
                ? _value.restaurantId
                : restaurantId // ignore: cast_nullable_to_non_nullable
                    as String?,
      ),
    );
  }
}

/// @nodoc

class _$MarkerSelectedImpl implements MarkerSelected {
  const _$MarkerSelectedImpl({this.restaurantId});

  @override
  final String? restaurantId;

  @override
  String toString() {
    return 'ExploreEvent.markerSelected(restaurantId: $restaurantId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MarkerSelectedImpl &&
            (identical(other.restaurantId, restaurantId) ||
                other.restaurantId == restaurantId));
  }

  @override
  int get hashCode => Object.hash(runtimeType, restaurantId);

  /// Create a copy of ExploreEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MarkerSelectedImplCopyWith<_$MarkerSelectedImpl> get copyWith =>
      __$$MarkerSelectedImplCopyWithImpl<_$MarkerSelectedImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initializeRequested,
    required TResult Function(bool granted) permissionResultReceived,
    required TResult Function(MapParamsModel params) mapBoundsChanged,
    required TResult Function() refreshRequested,
    required TResult Function(String query) searchChanged,
    required TResult Function(RestaurantFilters filters) filtersChanged,
    required TResult Function(String? restaurantId) markerSelected,
    required TResult Function(
      double minLat,
      double maxLat,
      double minLng,
      double maxLng,
      int zoom,
    )
    viewportChanged,
    required TResult Function(int version) markersRefreshed,
  }) {
    return markerSelected(restaurantId);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initializeRequested,
    TResult? Function(bool granted)? permissionResultReceived,
    TResult? Function(MapParamsModel params)? mapBoundsChanged,
    TResult? Function()? refreshRequested,
    TResult? Function(String query)? searchChanged,
    TResult? Function(RestaurantFilters filters)? filtersChanged,
    TResult? Function(String? restaurantId)? markerSelected,
    TResult? Function(
      double minLat,
      double maxLat,
      double minLng,
      double maxLng,
      int zoom,
    )?
    viewportChanged,
    TResult? Function(int version)? markersRefreshed,
  }) {
    return markerSelected?.call(restaurantId);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initializeRequested,
    TResult Function(bool granted)? permissionResultReceived,
    TResult Function(MapParamsModel params)? mapBoundsChanged,
    TResult Function()? refreshRequested,
    TResult Function(String query)? searchChanged,
    TResult Function(RestaurantFilters filters)? filtersChanged,
    TResult Function(String? restaurantId)? markerSelected,
    TResult Function(
      double minLat,
      double maxLat,
      double minLng,
      double maxLng,
      int zoom,
    )?
    viewportChanged,
    TResult Function(int version)? markersRefreshed,
    required TResult orElse(),
  }) {
    if (markerSelected != null) {
      return markerSelected(restaurantId);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(InitializeRequested value) initializeRequested,
    required TResult Function(PermissionResultReceived value)
    permissionResultReceived,
    required TResult Function(MapBoundsChanged value) mapBoundsChanged,
    required TResult Function(RefreshRequested value) refreshRequested,
    required TResult Function(SearchChanged value) searchChanged,
    required TResult Function(FiltersChanged value) filtersChanged,
    required TResult Function(MarkerSelected value) markerSelected,
    required TResult Function(ViewportChanged value) viewportChanged,
    required TResult Function(MarkersRefreshed value) markersRefreshed,
  }) {
    return markerSelected(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(InitializeRequested value)? initializeRequested,
    TResult? Function(PermissionResultReceived value)? permissionResultReceived,
    TResult? Function(MapBoundsChanged value)? mapBoundsChanged,
    TResult? Function(RefreshRequested value)? refreshRequested,
    TResult? Function(SearchChanged value)? searchChanged,
    TResult? Function(FiltersChanged value)? filtersChanged,
    TResult? Function(MarkerSelected value)? markerSelected,
    TResult? Function(ViewportChanged value)? viewportChanged,
    TResult? Function(MarkersRefreshed value)? markersRefreshed,
  }) {
    return markerSelected?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(InitializeRequested value)? initializeRequested,
    TResult Function(PermissionResultReceived value)? permissionResultReceived,
    TResult Function(MapBoundsChanged value)? mapBoundsChanged,
    TResult Function(RefreshRequested value)? refreshRequested,
    TResult Function(SearchChanged value)? searchChanged,
    TResult Function(FiltersChanged value)? filtersChanged,
    TResult Function(MarkerSelected value)? markerSelected,
    TResult Function(ViewportChanged value)? viewportChanged,
    TResult Function(MarkersRefreshed value)? markersRefreshed,
    required TResult orElse(),
  }) {
    if (markerSelected != null) {
      return markerSelected(this);
    }
    return orElse();
  }
}

abstract class MarkerSelected implements ExploreEvent {
  const factory MarkerSelected({final String? restaurantId}) =
      _$MarkerSelectedImpl;

  String? get restaurantId;

  /// Create a copy of ExploreEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MarkerSelectedImplCopyWith<_$MarkerSelectedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ViewportChangedImplCopyWith<$Res> {
  factory _$$ViewportChangedImplCopyWith(
    _$ViewportChangedImpl value,
    $Res Function(_$ViewportChangedImpl) then,
  ) = __$$ViewportChangedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({
    double minLat,
    double maxLat,
    double minLng,
    double maxLng,
    int zoom,
  });
}

/// @nodoc
class __$$ViewportChangedImplCopyWithImpl<$Res>
    extends _$ExploreEventCopyWithImpl<$Res, _$ViewportChangedImpl>
    implements _$$ViewportChangedImplCopyWith<$Res> {
  __$$ViewportChangedImplCopyWithImpl(
    _$ViewportChangedImpl _value,
    $Res Function(_$ViewportChangedImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ExploreEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? minLat = null,
    Object? maxLat = null,
    Object? minLng = null,
    Object? maxLng = null,
    Object? zoom = null,
  }) {
    return _then(
      _$ViewportChangedImpl(
        minLat:
            null == minLat
                ? _value.minLat
                : minLat // ignore: cast_nullable_to_non_nullable
                    as double,
        maxLat:
            null == maxLat
                ? _value.maxLat
                : maxLat // ignore: cast_nullable_to_non_nullable
                    as double,
        minLng:
            null == minLng
                ? _value.minLng
                : minLng // ignore: cast_nullable_to_non_nullable
                    as double,
        maxLng:
            null == maxLng
                ? _value.maxLng
                : maxLng // ignore: cast_nullable_to_non_nullable
                    as double,
        zoom:
            null == zoom
                ? _value.zoom
                : zoom // ignore: cast_nullable_to_non_nullable
                    as int,
      ),
    );
  }
}

/// @nodoc

class _$ViewportChangedImpl implements ViewportChanged {
  const _$ViewportChangedImpl({
    required this.minLat,
    required this.maxLat,
    required this.minLng,
    required this.maxLng,
    required this.zoom,
  });

  @override
  final double minLat;
  @override
  final double maxLat;
  @override
  final double minLng;
  @override
  final double maxLng;
  @override
  final int zoom;

  @override
  String toString() {
    return 'ExploreEvent.viewportChanged(minLat: $minLat, maxLat: $maxLat, minLng: $minLng, maxLng: $maxLng, zoom: $zoom)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ViewportChangedImpl &&
            (identical(other.minLat, minLat) || other.minLat == minLat) &&
            (identical(other.maxLat, maxLat) || other.maxLat == maxLat) &&
            (identical(other.minLng, minLng) || other.minLng == minLng) &&
            (identical(other.maxLng, maxLng) || other.maxLng == maxLng) &&
            (identical(other.zoom, zoom) || other.zoom == zoom));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, minLat, maxLat, minLng, maxLng, zoom);

  /// Create a copy of ExploreEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ViewportChangedImplCopyWith<_$ViewportChangedImpl> get copyWith =>
      __$$ViewportChangedImplCopyWithImpl<_$ViewportChangedImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initializeRequested,
    required TResult Function(bool granted) permissionResultReceived,
    required TResult Function(MapParamsModel params) mapBoundsChanged,
    required TResult Function() refreshRequested,
    required TResult Function(String query) searchChanged,
    required TResult Function(RestaurantFilters filters) filtersChanged,
    required TResult Function(String? restaurantId) markerSelected,
    required TResult Function(
      double minLat,
      double maxLat,
      double minLng,
      double maxLng,
      int zoom,
    )
    viewportChanged,
    required TResult Function(int version) markersRefreshed,
  }) {
    return viewportChanged(minLat, maxLat, minLng, maxLng, zoom);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initializeRequested,
    TResult? Function(bool granted)? permissionResultReceived,
    TResult? Function(MapParamsModel params)? mapBoundsChanged,
    TResult? Function()? refreshRequested,
    TResult? Function(String query)? searchChanged,
    TResult? Function(RestaurantFilters filters)? filtersChanged,
    TResult? Function(String? restaurantId)? markerSelected,
    TResult? Function(
      double minLat,
      double maxLat,
      double minLng,
      double maxLng,
      int zoom,
    )?
    viewportChanged,
    TResult? Function(int version)? markersRefreshed,
  }) {
    return viewportChanged?.call(minLat, maxLat, minLng, maxLng, zoom);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initializeRequested,
    TResult Function(bool granted)? permissionResultReceived,
    TResult Function(MapParamsModel params)? mapBoundsChanged,
    TResult Function()? refreshRequested,
    TResult Function(String query)? searchChanged,
    TResult Function(RestaurantFilters filters)? filtersChanged,
    TResult Function(String? restaurantId)? markerSelected,
    TResult Function(
      double minLat,
      double maxLat,
      double minLng,
      double maxLng,
      int zoom,
    )?
    viewportChanged,
    TResult Function(int version)? markersRefreshed,
    required TResult orElse(),
  }) {
    if (viewportChanged != null) {
      return viewportChanged(minLat, maxLat, minLng, maxLng, zoom);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(InitializeRequested value) initializeRequested,
    required TResult Function(PermissionResultReceived value)
    permissionResultReceived,
    required TResult Function(MapBoundsChanged value) mapBoundsChanged,
    required TResult Function(RefreshRequested value) refreshRequested,
    required TResult Function(SearchChanged value) searchChanged,
    required TResult Function(FiltersChanged value) filtersChanged,
    required TResult Function(MarkerSelected value) markerSelected,
    required TResult Function(ViewportChanged value) viewportChanged,
    required TResult Function(MarkersRefreshed value) markersRefreshed,
  }) {
    return viewportChanged(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(InitializeRequested value)? initializeRequested,
    TResult? Function(PermissionResultReceived value)? permissionResultReceived,
    TResult? Function(MapBoundsChanged value)? mapBoundsChanged,
    TResult? Function(RefreshRequested value)? refreshRequested,
    TResult? Function(SearchChanged value)? searchChanged,
    TResult? Function(FiltersChanged value)? filtersChanged,
    TResult? Function(MarkerSelected value)? markerSelected,
    TResult? Function(ViewportChanged value)? viewportChanged,
    TResult? Function(MarkersRefreshed value)? markersRefreshed,
  }) {
    return viewportChanged?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(InitializeRequested value)? initializeRequested,
    TResult Function(PermissionResultReceived value)? permissionResultReceived,
    TResult Function(MapBoundsChanged value)? mapBoundsChanged,
    TResult Function(RefreshRequested value)? refreshRequested,
    TResult Function(SearchChanged value)? searchChanged,
    TResult Function(FiltersChanged value)? filtersChanged,
    TResult Function(MarkerSelected value)? markerSelected,
    TResult Function(ViewportChanged value)? viewportChanged,
    TResult Function(MarkersRefreshed value)? markersRefreshed,
    required TResult orElse(),
  }) {
    if (viewportChanged != null) {
      return viewportChanged(this);
    }
    return orElse();
  }
}

abstract class ViewportChanged implements ExploreEvent {
  const factory ViewportChanged({
    required final double minLat,
    required final double maxLat,
    required final double minLng,
    required final double maxLng,
    required final int zoom,
  }) = _$ViewportChangedImpl;

  double get minLat;
  double get maxLat;
  double get minLng;
  double get maxLng;
  int get zoom;

  /// Create a copy of ExploreEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ViewportChangedImplCopyWith<_$ViewportChangedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$MarkersRefreshedImplCopyWith<$Res> {
  factory _$$MarkersRefreshedImplCopyWith(
    _$MarkersRefreshedImpl value,
    $Res Function(_$MarkersRefreshedImpl) then,
  ) = __$$MarkersRefreshedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({int version});
}

/// @nodoc
class __$$MarkersRefreshedImplCopyWithImpl<$Res>
    extends _$ExploreEventCopyWithImpl<$Res, _$MarkersRefreshedImpl>
    implements _$$MarkersRefreshedImplCopyWith<$Res> {
  __$$MarkersRefreshedImplCopyWithImpl(
    _$MarkersRefreshedImpl _value,
    $Res Function(_$MarkersRefreshedImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ExploreEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? version = null}) {
    return _then(
      _$MarkersRefreshedImpl(
        version:
            null == version
                ? _value.version
                : version // ignore: cast_nullable_to_non_nullable
                    as int,
      ),
    );
  }
}

/// @nodoc

class _$MarkersRefreshedImpl implements MarkersRefreshed {
  const _$MarkersRefreshedImpl({required this.version});

  @override
  final int version;

  @override
  String toString() {
    return 'ExploreEvent.markersRefreshed(version: $version)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MarkersRefreshedImpl &&
            (identical(other.version, version) || other.version == version));
  }

  @override
  int get hashCode => Object.hash(runtimeType, version);

  /// Create a copy of ExploreEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MarkersRefreshedImplCopyWith<_$MarkersRefreshedImpl> get copyWith =>
      __$$MarkersRefreshedImplCopyWithImpl<_$MarkersRefreshedImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initializeRequested,
    required TResult Function(bool granted) permissionResultReceived,
    required TResult Function(MapParamsModel params) mapBoundsChanged,
    required TResult Function() refreshRequested,
    required TResult Function(String query) searchChanged,
    required TResult Function(RestaurantFilters filters) filtersChanged,
    required TResult Function(String? restaurantId) markerSelected,
    required TResult Function(
      double minLat,
      double maxLat,
      double minLng,
      double maxLng,
      int zoom,
    )
    viewportChanged,
    required TResult Function(int version) markersRefreshed,
  }) {
    return markersRefreshed(version);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initializeRequested,
    TResult? Function(bool granted)? permissionResultReceived,
    TResult? Function(MapParamsModel params)? mapBoundsChanged,
    TResult? Function()? refreshRequested,
    TResult? Function(String query)? searchChanged,
    TResult? Function(RestaurantFilters filters)? filtersChanged,
    TResult? Function(String? restaurantId)? markerSelected,
    TResult? Function(
      double minLat,
      double maxLat,
      double minLng,
      double maxLng,
      int zoom,
    )?
    viewportChanged,
    TResult? Function(int version)? markersRefreshed,
  }) {
    return markersRefreshed?.call(version);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initializeRequested,
    TResult Function(bool granted)? permissionResultReceived,
    TResult Function(MapParamsModel params)? mapBoundsChanged,
    TResult Function()? refreshRequested,
    TResult Function(String query)? searchChanged,
    TResult Function(RestaurantFilters filters)? filtersChanged,
    TResult Function(String? restaurantId)? markerSelected,
    TResult Function(
      double minLat,
      double maxLat,
      double minLng,
      double maxLng,
      int zoom,
    )?
    viewportChanged,
    TResult Function(int version)? markersRefreshed,
    required TResult orElse(),
  }) {
    if (markersRefreshed != null) {
      return markersRefreshed(version);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(InitializeRequested value) initializeRequested,
    required TResult Function(PermissionResultReceived value)
    permissionResultReceived,
    required TResult Function(MapBoundsChanged value) mapBoundsChanged,
    required TResult Function(RefreshRequested value) refreshRequested,
    required TResult Function(SearchChanged value) searchChanged,
    required TResult Function(FiltersChanged value) filtersChanged,
    required TResult Function(MarkerSelected value) markerSelected,
    required TResult Function(ViewportChanged value) viewportChanged,
    required TResult Function(MarkersRefreshed value) markersRefreshed,
  }) {
    return markersRefreshed(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(InitializeRequested value)? initializeRequested,
    TResult? Function(PermissionResultReceived value)? permissionResultReceived,
    TResult? Function(MapBoundsChanged value)? mapBoundsChanged,
    TResult? Function(RefreshRequested value)? refreshRequested,
    TResult? Function(SearchChanged value)? searchChanged,
    TResult? Function(FiltersChanged value)? filtersChanged,
    TResult? Function(MarkerSelected value)? markerSelected,
    TResult? Function(ViewportChanged value)? viewportChanged,
    TResult? Function(MarkersRefreshed value)? markersRefreshed,
  }) {
    return markersRefreshed?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(InitializeRequested value)? initializeRequested,
    TResult Function(PermissionResultReceived value)? permissionResultReceived,
    TResult Function(MapBoundsChanged value)? mapBoundsChanged,
    TResult Function(RefreshRequested value)? refreshRequested,
    TResult Function(SearchChanged value)? searchChanged,
    TResult Function(FiltersChanged value)? filtersChanged,
    TResult Function(MarkerSelected value)? markerSelected,
    TResult Function(ViewportChanged value)? viewportChanged,
    TResult Function(MarkersRefreshed value)? markersRefreshed,
    required TResult orElse(),
  }) {
    if (markersRefreshed != null) {
      return markersRefreshed(this);
    }
    return orElse();
  }
}

abstract class MarkersRefreshed implements ExploreEvent {
  const factory MarkersRefreshed({required final int version}) =
      _$MarkersRefreshedImpl;

  int get version;

  /// Create a copy of ExploreEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MarkersRefreshedImplCopyWith<_$MarkersRefreshedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
