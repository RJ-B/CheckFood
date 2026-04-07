// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'orders_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$OrdersState {
  // Context
  bool get contextLoading => throw _privateConstructorUsedError;
  DiningContext? get diningContext => throw _privateConstructorUsedError;
  bool get noActiveContext => throw _privateConstructorUsedError;
  String? get contextError => throw _privateConstructorUsedError; // Menu
  bool get menuLoading => throw _privateConstructorUsedError;
  List<MenuCategory> get menuCategories => throw _privateConstructorUsedError;
  String? get menuError => throw _privateConstructorUsedError; // Cart
  List<CartItem> get cartItems =>
      throw _privateConstructorUsedError; // Order submission
  bool get submitting => throw _privateConstructorUsedError;
  bool get submitSuccess => throw _privateConstructorUsedError;
  String? get submitError =>
      throw _privateConstructorUsedError; // Current orders
  bool get ordersLoading => throw _privateConstructorUsedError;
  List<OrderSummary> get currentOrders =>
      throw _privateConstructorUsedError; // Payment
  bool get paymentInitiating => throw _privateConstructorUsedError;
  String? get paymentError => throw _privateConstructorUsedError;
  String? get paymentRedirectUrl =>
      throw _privateConstructorUsedError; // Map of orderId -> paymentStatus string
  Map<String, String> get paymentStatuses =>
      throw _privateConstructorUsedError; // Session
  DiningSession? get session => throw _privateConstructorUsedError;
  List<SessionOrderItem> get sessionItems => throw _privateConstructorUsedError;
  Set<String> get selectedItemIds => throw _privateConstructorUsedError;
  bool get sessionLoading => throw _privateConstructorUsedError;
  String? get sessionError =>
      throw _privateConstructorUsedError; // Payment summary totals (minor units)
  int get sessionTotalMinor => throw _privateConstructorUsedError;
  int get sessionPaidMinor => throw _privateConstructorUsedError;
  int get sessionRemainingMinor =>
      throw _privateConstructorUsedError; // QR invite code to display
  String? get sessionInviteCode => throw _privateConstructorUsedError;
  bool get sessionJoining => throw _privateConstructorUsedError;
  String? get sessionJoinError => throw _privateConstructorUsedError;

  /// Create a copy of OrdersState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $OrdersStateCopyWith<OrdersState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OrdersStateCopyWith<$Res> {
  factory $OrdersStateCopyWith(
    OrdersState value,
    $Res Function(OrdersState) then,
  ) = _$OrdersStateCopyWithImpl<$Res, OrdersState>;
  @useResult
  $Res call({
    bool contextLoading,
    DiningContext? diningContext,
    bool noActiveContext,
    String? contextError,
    bool menuLoading,
    List<MenuCategory> menuCategories,
    String? menuError,
    List<CartItem> cartItems,
    bool submitting,
    bool submitSuccess,
    String? submitError,
    bool ordersLoading,
    List<OrderSummary> currentOrders,
    bool paymentInitiating,
    String? paymentError,
    String? paymentRedirectUrl,
    Map<String, String> paymentStatuses,
    DiningSession? session,
    List<SessionOrderItem> sessionItems,
    Set<String> selectedItemIds,
    bool sessionLoading,
    String? sessionError,
    int sessionTotalMinor,
    int sessionPaidMinor,
    int sessionRemainingMinor,
    String? sessionInviteCode,
    bool sessionJoining,
    String? sessionJoinError,
  });

  $DiningContextCopyWith<$Res>? get diningContext;
  $DiningSessionCopyWith<$Res>? get session;
}

/// @nodoc
class _$OrdersStateCopyWithImpl<$Res, $Val extends OrdersState>
    implements $OrdersStateCopyWith<$Res> {
  _$OrdersStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of OrdersState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? contextLoading = null,
    Object? diningContext = freezed,
    Object? noActiveContext = null,
    Object? contextError = freezed,
    Object? menuLoading = null,
    Object? menuCategories = null,
    Object? menuError = freezed,
    Object? cartItems = null,
    Object? submitting = null,
    Object? submitSuccess = null,
    Object? submitError = freezed,
    Object? ordersLoading = null,
    Object? currentOrders = null,
    Object? paymentInitiating = null,
    Object? paymentError = freezed,
    Object? paymentRedirectUrl = freezed,
    Object? paymentStatuses = null,
    Object? session = freezed,
    Object? sessionItems = null,
    Object? selectedItemIds = null,
    Object? sessionLoading = null,
    Object? sessionError = freezed,
    Object? sessionTotalMinor = null,
    Object? sessionPaidMinor = null,
    Object? sessionRemainingMinor = null,
    Object? sessionInviteCode = freezed,
    Object? sessionJoining = null,
    Object? sessionJoinError = freezed,
  }) {
    return _then(
      _value.copyWith(
            contextLoading:
                null == contextLoading
                    ? _value.contextLoading
                    : contextLoading // ignore: cast_nullable_to_non_nullable
                        as bool,
            diningContext:
                freezed == diningContext
                    ? _value.diningContext
                    : diningContext // ignore: cast_nullable_to_non_nullable
                        as DiningContext?,
            noActiveContext:
                null == noActiveContext
                    ? _value.noActiveContext
                    : noActiveContext // ignore: cast_nullable_to_non_nullable
                        as bool,
            contextError:
                freezed == contextError
                    ? _value.contextError
                    : contextError // ignore: cast_nullable_to_non_nullable
                        as String?,
            menuLoading:
                null == menuLoading
                    ? _value.menuLoading
                    : menuLoading // ignore: cast_nullable_to_non_nullable
                        as bool,
            menuCategories:
                null == menuCategories
                    ? _value.menuCategories
                    : menuCategories // ignore: cast_nullable_to_non_nullable
                        as List<MenuCategory>,
            menuError:
                freezed == menuError
                    ? _value.menuError
                    : menuError // ignore: cast_nullable_to_non_nullable
                        as String?,
            cartItems:
                null == cartItems
                    ? _value.cartItems
                    : cartItems // ignore: cast_nullable_to_non_nullable
                        as List<CartItem>,
            submitting:
                null == submitting
                    ? _value.submitting
                    : submitting // ignore: cast_nullable_to_non_nullable
                        as bool,
            submitSuccess:
                null == submitSuccess
                    ? _value.submitSuccess
                    : submitSuccess // ignore: cast_nullable_to_non_nullable
                        as bool,
            submitError:
                freezed == submitError
                    ? _value.submitError
                    : submitError // ignore: cast_nullable_to_non_nullable
                        as String?,
            ordersLoading:
                null == ordersLoading
                    ? _value.ordersLoading
                    : ordersLoading // ignore: cast_nullable_to_non_nullable
                        as bool,
            currentOrders:
                null == currentOrders
                    ? _value.currentOrders
                    : currentOrders // ignore: cast_nullable_to_non_nullable
                        as List<OrderSummary>,
            paymentInitiating:
                null == paymentInitiating
                    ? _value.paymentInitiating
                    : paymentInitiating // ignore: cast_nullable_to_non_nullable
                        as bool,
            paymentError:
                freezed == paymentError
                    ? _value.paymentError
                    : paymentError // ignore: cast_nullable_to_non_nullable
                        as String?,
            paymentRedirectUrl:
                freezed == paymentRedirectUrl
                    ? _value.paymentRedirectUrl
                    : paymentRedirectUrl // ignore: cast_nullable_to_non_nullable
                        as String?,
            paymentStatuses:
                null == paymentStatuses
                    ? _value.paymentStatuses
                    : paymentStatuses // ignore: cast_nullable_to_non_nullable
                        as Map<String, String>,
            session:
                freezed == session
                    ? _value.session
                    : session // ignore: cast_nullable_to_non_nullable
                        as DiningSession?,
            sessionItems:
                null == sessionItems
                    ? _value.sessionItems
                    : sessionItems // ignore: cast_nullable_to_non_nullable
                        as List<SessionOrderItem>,
            selectedItemIds:
                null == selectedItemIds
                    ? _value.selectedItemIds
                    : selectedItemIds // ignore: cast_nullable_to_non_nullable
                        as Set<String>,
            sessionLoading:
                null == sessionLoading
                    ? _value.sessionLoading
                    : sessionLoading // ignore: cast_nullable_to_non_nullable
                        as bool,
            sessionError:
                freezed == sessionError
                    ? _value.sessionError
                    : sessionError // ignore: cast_nullable_to_non_nullable
                        as String?,
            sessionTotalMinor:
                null == sessionTotalMinor
                    ? _value.sessionTotalMinor
                    : sessionTotalMinor // ignore: cast_nullable_to_non_nullable
                        as int,
            sessionPaidMinor:
                null == sessionPaidMinor
                    ? _value.sessionPaidMinor
                    : sessionPaidMinor // ignore: cast_nullable_to_non_nullable
                        as int,
            sessionRemainingMinor:
                null == sessionRemainingMinor
                    ? _value.sessionRemainingMinor
                    : sessionRemainingMinor // ignore: cast_nullable_to_non_nullable
                        as int,
            sessionInviteCode:
                freezed == sessionInviteCode
                    ? _value.sessionInviteCode
                    : sessionInviteCode // ignore: cast_nullable_to_non_nullable
                        as String?,
            sessionJoining:
                null == sessionJoining
                    ? _value.sessionJoining
                    : sessionJoining // ignore: cast_nullable_to_non_nullable
                        as bool,
            sessionJoinError:
                freezed == sessionJoinError
                    ? _value.sessionJoinError
                    : sessionJoinError // ignore: cast_nullable_to_non_nullable
                        as String?,
          )
          as $Val,
    );
  }

  /// Create a copy of OrdersState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $DiningContextCopyWith<$Res>? get diningContext {
    if (_value.diningContext == null) {
      return null;
    }

    return $DiningContextCopyWith<$Res>(_value.diningContext!, (value) {
      return _then(_value.copyWith(diningContext: value) as $Val);
    });
  }

  /// Create a copy of OrdersState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $DiningSessionCopyWith<$Res>? get session {
    if (_value.session == null) {
      return null;
    }

    return $DiningSessionCopyWith<$Res>(_value.session!, (value) {
      return _then(_value.copyWith(session: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$OrdersStateImplCopyWith<$Res>
    implements $OrdersStateCopyWith<$Res> {
  factory _$$OrdersStateImplCopyWith(
    _$OrdersStateImpl value,
    $Res Function(_$OrdersStateImpl) then,
  ) = __$$OrdersStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    bool contextLoading,
    DiningContext? diningContext,
    bool noActiveContext,
    String? contextError,
    bool menuLoading,
    List<MenuCategory> menuCategories,
    String? menuError,
    List<CartItem> cartItems,
    bool submitting,
    bool submitSuccess,
    String? submitError,
    bool ordersLoading,
    List<OrderSummary> currentOrders,
    bool paymentInitiating,
    String? paymentError,
    String? paymentRedirectUrl,
    Map<String, String> paymentStatuses,
    DiningSession? session,
    List<SessionOrderItem> sessionItems,
    Set<String> selectedItemIds,
    bool sessionLoading,
    String? sessionError,
    int sessionTotalMinor,
    int sessionPaidMinor,
    int sessionRemainingMinor,
    String? sessionInviteCode,
    bool sessionJoining,
    String? sessionJoinError,
  });

  @override
  $DiningContextCopyWith<$Res>? get diningContext;
  @override
  $DiningSessionCopyWith<$Res>? get session;
}

/// @nodoc
class __$$OrdersStateImplCopyWithImpl<$Res>
    extends _$OrdersStateCopyWithImpl<$Res, _$OrdersStateImpl>
    implements _$$OrdersStateImplCopyWith<$Res> {
  __$$OrdersStateImplCopyWithImpl(
    _$OrdersStateImpl _value,
    $Res Function(_$OrdersStateImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of OrdersState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? contextLoading = null,
    Object? diningContext = freezed,
    Object? noActiveContext = null,
    Object? contextError = freezed,
    Object? menuLoading = null,
    Object? menuCategories = null,
    Object? menuError = freezed,
    Object? cartItems = null,
    Object? submitting = null,
    Object? submitSuccess = null,
    Object? submitError = freezed,
    Object? ordersLoading = null,
    Object? currentOrders = null,
    Object? paymentInitiating = null,
    Object? paymentError = freezed,
    Object? paymentRedirectUrl = freezed,
    Object? paymentStatuses = null,
    Object? session = freezed,
    Object? sessionItems = null,
    Object? selectedItemIds = null,
    Object? sessionLoading = null,
    Object? sessionError = freezed,
    Object? sessionTotalMinor = null,
    Object? sessionPaidMinor = null,
    Object? sessionRemainingMinor = null,
    Object? sessionInviteCode = freezed,
    Object? sessionJoining = null,
    Object? sessionJoinError = freezed,
  }) {
    return _then(
      _$OrdersStateImpl(
        contextLoading:
            null == contextLoading
                ? _value.contextLoading
                : contextLoading // ignore: cast_nullable_to_non_nullable
                    as bool,
        diningContext:
            freezed == diningContext
                ? _value.diningContext
                : diningContext // ignore: cast_nullable_to_non_nullable
                    as DiningContext?,
        noActiveContext:
            null == noActiveContext
                ? _value.noActiveContext
                : noActiveContext // ignore: cast_nullable_to_non_nullable
                    as bool,
        contextError:
            freezed == contextError
                ? _value.contextError
                : contextError // ignore: cast_nullable_to_non_nullable
                    as String?,
        menuLoading:
            null == menuLoading
                ? _value.menuLoading
                : menuLoading // ignore: cast_nullable_to_non_nullable
                    as bool,
        menuCategories:
            null == menuCategories
                ? _value._menuCategories
                : menuCategories // ignore: cast_nullable_to_non_nullable
                    as List<MenuCategory>,
        menuError:
            freezed == menuError
                ? _value.menuError
                : menuError // ignore: cast_nullable_to_non_nullable
                    as String?,
        cartItems:
            null == cartItems
                ? _value._cartItems
                : cartItems // ignore: cast_nullable_to_non_nullable
                    as List<CartItem>,
        submitting:
            null == submitting
                ? _value.submitting
                : submitting // ignore: cast_nullable_to_non_nullable
                    as bool,
        submitSuccess:
            null == submitSuccess
                ? _value.submitSuccess
                : submitSuccess // ignore: cast_nullable_to_non_nullable
                    as bool,
        submitError:
            freezed == submitError
                ? _value.submitError
                : submitError // ignore: cast_nullable_to_non_nullable
                    as String?,
        ordersLoading:
            null == ordersLoading
                ? _value.ordersLoading
                : ordersLoading // ignore: cast_nullable_to_non_nullable
                    as bool,
        currentOrders:
            null == currentOrders
                ? _value._currentOrders
                : currentOrders // ignore: cast_nullable_to_non_nullable
                    as List<OrderSummary>,
        paymentInitiating:
            null == paymentInitiating
                ? _value.paymentInitiating
                : paymentInitiating // ignore: cast_nullable_to_non_nullable
                    as bool,
        paymentError:
            freezed == paymentError
                ? _value.paymentError
                : paymentError // ignore: cast_nullable_to_non_nullable
                    as String?,
        paymentRedirectUrl:
            freezed == paymentRedirectUrl
                ? _value.paymentRedirectUrl
                : paymentRedirectUrl // ignore: cast_nullable_to_non_nullable
                    as String?,
        paymentStatuses:
            null == paymentStatuses
                ? _value._paymentStatuses
                : paymentStatuses // ignore: cast_nullable_to_non_nullable
                    as Map<String, String>,
        session:
            freezed == session
                ? _value.session
                : session // ignore: cast_nullable_to_non_nullable
                    as DiningSession?,
        sessionItems:
            null == sessionItems
                ? _value._sessionItems
                : sessionItems // ignore: cast_nullable_to_non_nullable
                    as List<SessionOrderItem>,
        selectedItemIds:
            null == selectedItemIds
                ? _value._selectedItemIds
                : selectedItemIds // ignore: cast_nullable_to_non_nullable
                    as Set<String>,
        sessionLoading:
            null == sessionLoading
                ? _value.sessionLoading
                : sessionLoading // ignore: cast_nullable_to_non_nullable
                    as bool,
        sessionError:
            freezed == sessionError
                ? _value.sessionError
                : sessionError // ignore: cast_nullable_to_non_nullable
                    as String?,
        sessionTotalMinor:
            null == sessionTotalMinor
                ? _value.sessionTotalMinor
                : sessionTotalMinor // ignore: cast_nullable_to_non_nullable
                    as int,
        sessionPaidMinor:
            null == sessionPaidMinor
                ? _value.sessionPaidMinor
                : sessionPaidMinor // ignore: cast_nullable_to_non_nullable
                    as int,
        sessionRemainingMinor:
            null == sessionRemainingMinor
                ? _value.sessionRemainingMinor
                : sessionRemainingMinor // ignore: cast_nullable_to_non_nullable
                    as int,
        sessionInviteCode:
            freezed == sessionInviteCode
                ? _value.sessionInviteCode
                : sessionInviteCode // ignore: cast_nullable_to_non_nullable
                    as String?,
        sessionJoining:
            null == sessionJoining
                ? _value.sessionJoining
                : sessionJoining // ignore: cast_nullable_to_non_nullable
                    as bool,
        sessionJoinError:
            freezed == sessionJoinError
                ? _value.sessionJoinError
                : sessionJoinError // ignore: cast_nullable_to_non_nullable
                    as String?,
      ),
    );
  }
}

/// @nodoc

class _$OrdersStateImpl extends _OrdersState {
  const _$OrdersStateImpl({
    this.contextLoading = true,
    this.diningContext,
    this.noActiveContext = false,
    this.contextError,
    this.menuLoading = false,
    final List<MenuCategory> menuCategories = const [],
    this.menuError,
    final List<CartItem> cartItems = const [],
    this.submitting = false,
    this.submitSuccess = false,
    this.submitError,
    this.ordersLoading = false,
    final List<OrderSummary> currentOrders = const [],
    this.paymentInitiating = false,
    this.paymentError,
    this.paymentRedirectUrl,
    final Map<String, String> paymentStatuses = const {},
    this.session,
    final List<SessionOrderItem> sessionItems = const [],
    final Set<String> selectedItemIds = const {},
    this.sessionLoading = false,
    this.sessionError,
    this.sessionTotalMinor = 0,
    this.sessionPaidMinor = 0,
    this.sessionRemainingMinor = 0,
    this.sessionInviteCode,
    this.sessionJoining = false,
    this.sessionJoinError,
  }) : _menuCategories = menuCategories,
       _cartItems = cartItems,
       _currentOrders = currentOrders,
       _paymentStatuses = paymentStatuses,
       _sessionItems = sessionItems,
       _selectedItemIds = selectedItemIds,
       super._();

  // Context
  @override
  @JsonKey()
  final bool contextLoading;
  @override
  final DiningContext? diningContext;
  @override
  @JsonKey()
  final bool noActiveContext;
  @override
  final String? contextError;
  // Menu
  @override
  @JsonKey()
  final bool menuLoading;
  final List<MenuCategory> _menuCategories;
  @override
  @JsonKey()
  List<MenuCategory> get menuCategories {
    if (_menuCategories is EqualUnmodifiableListView) return _menuCategories;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_menuCategories);
  }

  @override
  final String? menuError;
  // Cart
  final List<CartItem> _cartItems;
  // Cart
  @override
  @JsonKey()
  List<CartItem> get cartItems {
    if (_cartItems is EqualUnmodifiableListView) return _cartItems;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_cartItems);
  }

  // Order submission
  @override
  @JsonKey()
  final bool submitting;
  @override
  @JsonKey()
  final bool submitSuccess;
  @override
  final String? submitError;
  // Current orders
  @override
  @JsonKey()
  final bool ordersLoading;
  final List<OrderSummary> _currentOrders;
  @override
  @JsonKey()
  List<OrderSummary> get currentOrders {
    if (_currentOrders is EqualUnmodifiableListView) return _currentOrders;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_currentOrders);
  }

  // Payment
  @override
  @JsonKey()
  final bool paymentInitiating;
  @override
  final String? paymentError;
  @override
  final String? paymentRedirectUrl;
  // Map of orderId -> paymentStatus string
  final Map<String, String> _paymentStatuses;
  // Map of orderId -> paymentStatus string
  @override
  @JsonKey()
  Map<String, String> get paymentStatuses {
    if (_paymentStatuses is EqualUnmodifiableMapView) return _paymentStatuses;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_paymentStatuses);
  }

  // Session
  @override
  final DiningSession? session;
  final List<SessionOrderItem> _sessionItems;
  @override
  @JsonKey()
  List<SessionOrderItem> get sessionItems {
    if (_sessionItems is EqualUnmodifiableListView) return _sessionItems;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_sessionItems);
  }

  final Set<String> _selectedItemIds;
  @override
  @JsonKey()
  Set<String> get selectedItemIds {
    if (_selectedItemIds is EqualUnmodifiableSetView) return _selectedItemIds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableSetView(_selectedItemIds);
  }

  @override
  @JsonKey()
  final bool sessionLoading;
  @override
  final String? sessionError;
  // Payment summary totals (minor units)
  @override
  @JsonKey()
  final int sessionTotalMinor;
  @override
  @JsonKey()
  final int sessionPaidMinor;
  @override
  @JsonKey()
  final int sessionRemainingMinor;
  // QR invite code to display
  @override
  final String? sessionInviteCode;
  @override
  @JsonKey()
  final bool sessionJoining;
  @override
  final String? sessionJoinError;

  @override
  String toString() {
    return 'OrdersState(contextLoading: $contextLoading, diningContext: $diningContext, noActiveContext: $noActiveContext, contextError: $contextError, menuLoading: $menuLoading, menuCategories: $menuCategories, menuError: $menuError, cartItems: $cartItems, submitting: $submitting, submitSuccess: $submitSuccess, submitError: $submitError, ordersLoading: $ordersLoading, currentOrders: $currentOrders, paymentInitiating: $paymentInitiating, paymentError: $paymentError, paymentRedirectUrl: $paymentRedirectUrl, paymentStatuses: $paymentStatuses, session: $session, sessionItems: $sessionItems, selectedItemIds: $selectedItemIds, sessionLoading: $sessionLoading, sessionError: $sessionError, sessionTotalMinor: $sessionTotalMinor, sessionPaidMinor: $sessionPaidMinor, sessionRemainingMinor: $sessionRemainingMinor, sessionInviteCode: $sessionInviteCode, sessionJoining: $sessionJoining, sessionJoinError: $sessionJoinError)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OrdersStateImpl &&
            (identical(other.contextLoading, contextLoading) ||
                other.contextLoading == contextLoading) &&
            (identical(other.diningContext, diningContext) ||
                other.diningContext == diningContext) &&
            (identical(other.noActiveContext, noActiveContext) ||
                other.noActiveContext == noActiveContext) &&
            (identical(other.contextError, contextError) ||
                other.contextError == contextError) &&
            (identical(other.menuLoading, menuLoading) ||
                other.menuLoading == menuLoading) &&
            const DeepCollectionEquality().equals(
              other._menuCategories,
              _menuCategories,
            ) &&
            (identical(other.menuError, menuError) ||
                other.menuError == menuError) &&
            const DeepCollectionEquality().equals(
              other._cartItems,
              _cartItems,
            ) &&
            (identical(other.submitting, submitting) ||
                other.submitting == submitting) &&
            (identical(other.submitSuccess, submitSuccess) ||
                other.submitSuccess == submitSuccess) &&
            (identical(other.submitError, submitError) ||
                other.submitError == submitError) &&
            (identical(other.ordersLoading, ordersLoading) ||
                other.ordersLoading == ordersLoading) &&
            const DeepCollectionEquality().equals(
              other._currentOrders,
              _currentOrders,
            ) &&
            (identical(other.paymentInitiating, paymentInitiating) ||
                other.paymentInitiating == paymentInitiating) &&
            (identical(other.paymentError, paymentError) ||
                other.paymentError == paymentError) &&
            (identical(other.paymentRedirectUrl, paymentRedirectUrl) ||
                other.paymentRedirectUrl == paymentRedirectUrl) &&
            const DeepCollectionEquality().equals(
              other._paymentStatuses,
              _paymentStatuses,
            ) &&
            (identical(other.session, session) || other.session == session) &&
            const DeepCollectionEquality().equals(
              other._sessionItems,
              _sessionItems,
            ) &&
            const DeepCollectionEquality().equals(
              other._selectedItemIds,
              _selectedItemIds,
            ) &&
            (identical(other.sessionLoading, sessionLoading) ||
                other.sessionLoading == sessionLoading) &&
            (identical(other.sessionError, sessionError) ||
                other.sessionError == sessionError) &&
            (identical(other.sessionTotalMinor, sessionTotalMinor) ||
                other.sessionTotalMinor == sessionTotalMinor) &&
            (identical(other.sessionPaidMinor, sessionPaidMinor) ||
                other.sessionPaidMinor == sessionPaidMinor) &&
            (identical(other.sessionRemainingMinor, sessionRemainingMinor) ||
                other.sessionRemainingMinor == sessionRemainingMinor) &&
            (identical(other.sessionInviteCode, sessionInviteCode) ||
                other.sessionInviteCode == sessionInviteCode) &&
            (identical(other.sessionJoining, sessionJoining) ||
                other.sessionJoining == sessionJoining) &&
            (identical(other.sessionJoinError, sessionJoinError) ||
                other.sessionJoinError == sessionJoinError));
  }

  @override
  int get hashCode => Object.hashAll([
    runtimeType,
    contextLoading,
    diningContext,
    noActiveContext,
    contextError,
    menuLoading,
    const DeepCollectionEquality().hash(_menuCategories),
    menuError,
    const DeepCollectionEquality().hash(_cartItems),
    submitting,
    submitSuccess,
    submitError,
    ordersLoading,
    const DeepCollectionEquality().hash(_currentOrders),
    paymentInitiating,
    paymentError,
    paymentRedirectUrl,
    const DeepCollectionEquality().hash(_paymentStatuses),
    session,
    const DeepCollectionEquality().hash(_sessionItems),
    const DeepCollectionEquality().hash(_selectedItemIds),
    sessionLoading,
    sessionError,
    sessionTotalMinor,
    sessionPaidMinor,
    sessionRemainingMinor,
    sessionInviteCode,
    sessionJoining,
    sessionJoinError,
  ]);

  /// Create a copy of OrdersState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$OrdersStateImplCopyWith<_$OrdersStateImpl> get copyWith =>
      __$$OrdersStateImplCopyWithImpl<_$OrdersStateImpl>(this, _$identity);
}

abstract class _OrdersState extends OrdersState {
  const factory _OrdersState({
    final bool contextLoading,
    final DiningContext? diningContext,
    final bool noActiveContext,
    final String? contextError,
    final bool menuLoading,
    final List<MenuCategory> menuCategories,
    final String? menuError,
    final List<CartItem> cartItems,
    final bool submitting,
    final bool submitSuccess,
    final String? submitError,
    final bool ordersLoading,
    final List<OrderSummary> currentOrders,
    final bool paymentInitiating,
    final String? paymentError,
    final String? paymentRedirectUrl,
    final Map<String, String> paymentStatuses,
    final DiningSession? session,
    final List<SessionOrderItem> sessionItems,
    final Set<String> selectedItemIds,
    final bool sessionLoading,
    final String? sessionError,
    final int sessionTotalMinor,
    final int sessionPaidMinor,
    final int sessionRemainingMinor,
    final String? sessionInviteCode,
    final bool sessionJoining,
    final String? sessionJoinError,
  }) = _$OrdersStateImpl;
  const _OrdersState._() : super._();

  // Context
  @override
  bool get contextLoading;
  @override
  DiningContext? get diningContext;
  @override
  bool get noActiveContext;
  @override
  String? get contextError; // Menu
  @override
  bool get menuLoading;
  @override
  List<MenuCategory> get menuCategories;
  @override
  String? get menuError; // Cart
  @override
  List<CartItem> get cartItems; // Order submission
  @override
  bool get submitting;
  @override
  bool get submitSuccess;
  @override
  String? get submitError; // Current orders
  @override
  bool get ordersLoading;
  @override
  List<OrderSummary> get currentOrders; // Payment
  @override
  bool get paymentInitiating;
  @override
  String? get paymentError;
  @override
  String? get paymentRedirectUrl; // Map of orderId -> paymentStatus string
  @override
  Map<String, String> get paymentStatuses; // Session
  @override
  DiningSession? get session;
  @override
  List<SessionOrderItem> get sessionItems;
  @override
  Set<String> get selectedItemIds;
  @override
  bool get sessionLoading;
  @override
  String? get sessionError; // Payment summary totals (minor units)
  @override
  int get sessionTotalMinor;
  @override
  int get sessionPaidMinor;
  @override
  int get sessionRemainingMinor; // QR invite code to display
  @override
  String? get sessionInviteCode;
  @override
  bool get sessionJoining;
  @override
  String? get sessionJoinError;

  /// Create a copy of OrdersState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$OrdersStateImplCopyWith<_$OrdersStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
