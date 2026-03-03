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
  List<OrderSummary> get currentOrders => throw _privateConstructorUsedError;

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
  });

  $DiningContextCopyWith<$Res>? get diningContext;
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
  });

  @override
  $DiningContextCopyWith<$Res>? get diningContext;
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
  }) : _menuCategories = menuCategories,
       _cartItems = cartItems,
       _currentOrders = currentOrders,
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

  @override
  String toString() {
    return 'OrdersState(contextLoading: $contextLoading, diningContext: $diningContext, noActiveContext: $noActiveContext, contextError: $contextError, menuLoading: $menuLoading, menuCategories: $menuCategories, menuError: $menuError, cartItems: $cartItems, submitting: $submitting, submitSuccess: $submitSuccess, submitError: $submitError, ordersLoading: $ordersLoading, currentOrders: $currentOrders)';
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
            ));
  }

  @override
  int get hashCode => Object.hash(
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
  );

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
  List<OrderSummary> get currentOrders;

  /// Create a copy of OrdersState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$OrdersStateImplCopyWith<_$OrdersStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
