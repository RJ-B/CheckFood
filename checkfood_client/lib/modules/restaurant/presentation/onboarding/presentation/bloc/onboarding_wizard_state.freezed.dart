// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'onboarding_wizard_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$OnboardingWizardState {
  int get currentStep => throw _privateConstructorUsedError;
  bool get loading => throw _privateConstructorUsedError;
  String? get error => throw _privateConstructorUsedError;
  OnboardingStatus? get status => throw _privateConstructorUsedError;
  OwnerRestaurantResponseModel? get restaurant =>
      throw _privateConstructorUsedError;
  List<OnboardingTable> get tables => throw _privateConstructorUsedError;
  List<OnboardingMenuCategory> get categories =>
      throw _privateConstructorUsedError;
  List<PanoramaSession> get sessions => throw _privateConstructorUsedError;
  PanoramaSession? get activeSession => throw _privateConstructorUsedError;
  bool get publishing => throw _privateConstructorUsedError;
  bool get published => throw _privateConstructorUsedError;

  /// Create a copy of OnboardingWizardState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $OnboardingWizardStateCopyWith<OnboardingWizardState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OnboardingWizardStateCopyWith<$Res> {
  factory $OnboardingWizardStateCopyWith(
    OnboardingWizardState value,
    $Res Function(OnboardingWizardState) then,
  ) = _$OnboardingWizardStateCopyWithImpl<$Res, OnboardingWizardState>;
  @useResult
  $Res call({
    int currentStep,
    bool loading,
    String? error,
    OnboardingStatus? status,
    OwnerRestaurantResponseModel? restaurant,
    List<OnboardingTable> tables,
    List<OnboardingMenuCategory> categories,
    List<PanoramaSession> sessions,
    PanoramaSession? activeSession,
    bool publishing,
    bool published,
  });

  $OnboardingStatusCopyWith<$Res>? get status;
  $OwnerRestaurantResponseModelCopyWith<$Res>? get restaurant;
  $PanoramaSessionCopyWith<$Res>? get activeSession;
}

/// @nodoc
class _$OnboardingWizardStateCopyWithImpl<
  $Res,
  $Val extends OnboardingWizardState
>
    implements $OnboardingWizardStateCopyWith<$Res> {
  _$OnboardingWizardStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of OnboardingWizardState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? currentStep = null,
    Object? loading = null,
    Object? error = freezed,
    Object? status = freezed,
    Object? restaurant = freezed,
    Object? tables = null,
    Object? categories = null,
    Object? sessions = null,
    Object? activeSession = freezed,
    Object? publishing = null,
    Object? published = null,
  }) {
    return _then(
      _value.copyWith(
            currentStep:
                null == currentStep
                    ? _value.currentStep
                    : currentStep // ignore: cast_nullable_to_non_nullable
                        as int,
            loading:
                null == loading
                    ? _value.loading
                    : loading // ignore: cast_nullable_to_non_nullable
                        as bool,
            error:
                freezed == error
                    ? _value.error
                    : error // ignore: cast_nullable_to_non_nullable
                        as String?,
            status:
                freezed == status
                    ? _value.status
                    : status // ignore: cast_nullable_to_non_nullable
                        as OnboardingStatus?,
            restaurant:
                freezed == restaurant
                    ? _value.restaurant
                    : restaurant // ignore: cast_nullable_to_non_nullable
                        as OwnerRestaurantResponseModel?,
            tables:
                null == tables
                    ? _value.tables
                    : tables // ignore: cast_nullable_to_non_nullable
                        as List<OnboardingTable>,
            categories:
                null == categories
                    ? _value.categories
                    : categories // ignore: cast_nullable_to_non_nullable
                        as List<OnboardingMenuCategory>,
            sessions:
                null == sessions
                    ? _value.sessions
                    : sessions // ignore: cast_nullable_to_non_nullable
                        as List<PanoramaSession>,
            activeSession:
                freezed == activeSession
                    ? _value.activeSession
                    : activeSession // ignore: cast_nullable_to_non_nullable
                        as PanoramaSession?,
            publishing:
                null == publishing
                    ? _value.publishing
                    : publishing // ignore: cast_nullable_to_non_nullable
                        as bool,
            published:
                null == published
                    ? _value.published
                    : published // ignore: cast_nullable_to_non_nullable
                        as bool,
          )
          as $Val,
    );
  }

  /// Create a copy of OnboardingWizardState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $OnboardingStatusCopyWith<$Res>? get status {
    if (_value.status == null) {
      return null;
    }

    return $OnboardingStatusCopyWith<$Res>(_value.status!, (value) {
      return _then(_value.copyWith(status: value) as $Val);
    });
  }

  /// Create a copy of OnboardingWizardState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $OwnerRestaurantResponseModelCopyWith<$Res>? get restaurant {
    if (_value.restaurant == null) {
      return null;
    }

    return $OwnerRestaurantResponseModelCopyWith<$Res>(_value.restaurant!, (
      value,
    ) {
      return _then(_value.copyWith(restaurant: value) as $Val);
    });
  }

  /// Create a copy of OnboardingWizardState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $PanoramaSessionCopyWith<$Res>? get activeSession {
    if (_value.activeSession == null) {
      return null;
    }

    return $PanoramaSessionCopyWith<$Res>(_value.activeSession!, (value) {
      return _then(_value.copyWith(activeSession: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$OnboardingWizardStateImplCopyWith<$Res>
    implements $OnboardingWizardStateCopyWith<$Res> {
  factory _$$OnboardingWizardStateImplCopyWith(
    _$OnboardingWizardStateImpl value,
    $Res Function(_$OnboardingWizardStateImpl) then,
  ) = __$$OnboardingWizardStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int currentStep,
    bool loading,
    String? error,
    OnboardingStatus? status,
    OwnerRestaurantResponseModel? restaurant,
    List<OnboardingTable> tables,
    List<OnboardingMenuCategory> categories,
    List<PanoramaSession> sessions,
    PanoramaSession? activeSession,
    bool publishing,
    bool published,
  });

  @override
  $OnboardingStatusCopyWith<$Res>? get status;
  @override
  $OwnerRestaurantResponseModelCopyWith<$Res>? get restaurant;
  @override
  $PanoramaSessionCopyWith<$Res>? get activeSession;
}

/// @nodoc
class __$$OnboardingWizardStateImplCopyWithImpl<$Res>
    extends
        _$OnboardingWizardStateCopyWithImpl<$Res, _$OnboardingWizardStateImpl>
    implements _$$OnboardingWizardStateImplCopyWith<$Res> {
  __$$OnboardingWizardStateImplCopyWithImpl(
    _$OnboardingWizardStateImpl _value,
    $Res Function(_$OnboardingWizardStateImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of OnboardingWizardState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? currentStep = null,
    Object? loading = null,
    Object? error = freezed,
    Object? status = freezed,
    Object? restaurant = freezed,
    Object? tables = null,
    Object? categories = null,
    Object? sessions = null,
    Object? activeSession = freezed,
    Object? publishing = null,
    Object? published = null,
  }) {
    return _then(
      _$OnboardingWizardStateImpl(
        currentStep:
            null == currentStep
                ? _value.currentStep
                : currentStep // ignore: cast_nullable_to_non_nullable
                    as int,
        loading:
            null == loading
                ? _value.loading
                : loading // ignore: cast_nullable_to_non_nullable
                    as bool,
        error:
            freezed == error
                ? _value.error
                : error // ignore: cast_nullable_to_non_nullable
                    as String?,
        status:
            freezed == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                    as OnboardingStatus?,
        restaurant:
            freezed == restaurant
                ? _value.restaurant
                : restaurant // ignore: cast_nullable_to_non_nullable
                    as OwnerRestaurantResponseModel?,
        tables:
            null == tables
                ? _value._tables
                : tables // ignore: cast_nullable_to_non_nullable
                    as List<OnboardingTable>,
        categories:
            null == categories
                ? _value._categories
                : categories // ignore: cast_nullable_to_non_nullable
                    as List<OnboardingMenuCategory>,
        sessions:
            null == sessions
                ? _value._sessions
                : sessions // ignore: cast_nullable_to_non_nullable
                    as List<PanoramaSession>,
        activeSession:
            freezed == activeSession
                ? _value.activeSession
                : activeSession // ignore: cast_nullable_to_non_nullable
                    as PanoramaSession?,
        publishing:
            null == publishing
                ? _value.publishing
                : publishing // ignore: cast_nullable_to_non_nullable
                    as bool,
        published:
            null == published
                ? _value.published
                : published // ignore: cast_nullable_to_non_nullable
                    as bool,
      ),
    );
  }
}

/// @nodoc

class _$OnboardingWizardStateImpl implements _OnboardingWizardState {
  const _$OnboardingWizardStateImpl({
    this.currentStep = 0,
    this.loading = false,
    this.error,
    this.status,
    this.restaurant,
    final List<OnboardingTable> tables = const [],
    final List<OnboardingMenuCategory> categories = const [],
    final List<PanoramaSession> sessions = const [],
    this.activeSession,
    this.publishing = false,
    this.published = false,
  }) : _tables = tables,
       _categories = categories,
       _sessions = sessions;

  @override
  @JsonKey()
  final int currentStep;
  @override
  @JsonKey()
  final bool loading;
  @override
  final String? error;
  @override
  final OnboardingStatus? status;
  @override
  final OwnerRestaurantResponseModel? restaurant;
  final List<OnboardingTable> _tables;
  @override
  @JsonKey()
  List<OnboardingTable> get tables {
    if (_tables is EqualUnmodifiableListView) return _tables;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_tables);
  }

  final List<OnboardingMenuCategory> _categories;
  @override
  @JsonKey()
  List<OnboardingMenuCategory> get categories {
    if (_categories is EqualUnmodifiableListView) return _categories;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_categories);
  }

  final List<PanoramaSession> _sessions;
  @override
  @JsonKey()
  List<PanoramaSession> get sessions {
    if (_sessions is EqualUnmodifiableListView) return _sessions;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_sessions);
  }

  @override
  final PanoramaSession? activeSession;
  @override
  @JsonKey()
  final bool publishing;
  @override
  @JsonKey()
  final bool published;

  @override
  String toString() {
    return 'OnboardingWizardState(currentStep: $currentStep, loading: $loading, error: $error, status: $status, restaurant: $restaurant, tables: $tables, categories: $categories, sessions: $sessions, activeSession: $activeSession, publishing: $publishing, published: $published)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OnboardingWizardStateImpl &&
            (identical(other.currentStep, currentStep) ||
                other.currentStep == currentStep) &&
            (identical(other.loading, loading) || other.loading == loading) &&
            (identical(other.error, error) || other.error == error) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.restaurant, restaurant) ||
                other.restaurant == restaurant) &&
            const DeepCollectionEquality().equals(other._tables, _tables) &&
            const DeepCollectionEquality().equals(
              other._categories,
              _categories,
            ) &&
            const DeepCollectionEquality().equals(other._sessions, _sessions) &&
            (identical(other.activeSession, activeSession) ||
                other.activeSession == activeSession) &&
            (identical(other.publishing, publishing) ||
                other.publishing == publishing) &&
            (identical(other.published, published) ||
                other.published == published));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    currentStep,
    loading,
    error,
    status,
    restaurant,
    const DeepCollectionEquality().hash(_tables),
    const DeepCollectionEquality().hash(_categories),
    const DeepCollectionEquality().hash(_sessions),
    activeSession,
    publishing,
    published,
  );

  /// Create a copy of OnboardingWizardState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$OnboardingWizardStateImplCopyWith<_$OnboardingWizardStateImpl>
  get copyWith =>
      __$$OnboardingWizardStateImplCopyWithImpl<_$OnboardingWizardStateImpl>(
        this,
        _$identity,
      );
}

abstract class _OnboardingWizardState implements OnboardingWizardState {
  const factory _OnboardingWizardState({
    final int currentStep,
    final bool loading,
    final String? error,
    final OnboardingStatus? status,
    final OwnerRestaurantResponseModel? restaurant,
    final List<OnboardingTable> tables,
    final List<OnboardingMenuCategory> categories,
    final List<PanoramaSession> sessions,
    final PanoramaSession? activeSession,
    final bool publishing,
    final bool published,
  }) = _$OnboardingWizardStateImpl;

  @override
  int get currentStep;
  @override
  bool get loading;
  @override
  String? get error;
  @override
  OnboardingStatus? get status;
  @override
  OwnerRestaurantResponseModel? get restaurant;
  @override
  List<OnboardingTable> get tables;
  @override
  List<OnboardingMenuCategory> get categories;
  @override
  List<PanoramaSession> get sessions;
  @override
  PanoramaSession? get activeSession;
  @override
  bool get publishing;
  @override
  bool get published;

  /// Create a copy of OnboardingWizardState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$OnboardingWizardStateImplCopyWith<_$OnboardingWizardStateImpl>
  get copyWith => throw _privateConstructorUsedError;
}
