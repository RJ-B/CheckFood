// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'orders_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$OrdersEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loadContext,
    required TResult Function(String restaurantId) loadMenu,
    required TResult Function(MenuItem menuItem) addToCart,
    required TResult Function(String menuItemId) removeFromCart,
    required TResult Function(String menuItemId, int quantity)
    updateCartQuantity,
    required TResult Function() clearCart,
    required TResult Function(String? note) submitOrder,
    required TResult Function() loadCurrentOrders,
    required TResult Function() refresh,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loadContext,
    TResult? Function(String restaurantId)? loadMenu,
    TResult? Function(MenuItem menuItem)? addToCart,
    TResult? Function(String menuItemId)? removeFromCart,
    TResult? Function(String menuItemId, int quantity)? updateCartQuantity,
    TResult? Function()? clearCart,
    TResult? Function(String? note)? submitOrder,
    TResult? Function()? loadCurrentOrders,
    TResult? Function()? refresh,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loadContext,
    TResult Function(String restaurantId)? loadMenu,
    TResult Function(MenuItem menuItem)? addToCart,
    TResult Function(String menuItemId)? removeFromCart,
    TResult Function(String menuItemId, int quantity)? updateCartQuantity,
    TResult Function()? clearCart,
    TResult Function(String? note)? submitOrder,
    TResult Function()? loadCurrentOrders,
    TResult Function()? refresh,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(LoadContext value) loadContext,
    required TResult Function(LoadMenu value) loadMenu,
    required TResult Function(AddToCart value) addToCart,
    required TResult Function(RemoveFromCart value) removeFromCart,
    required TResult Function(UpdateCartQuantity value) updateCartQuantity,
    required TResult Function(ClearCart value) clearCart,
    required TResult Function(SubmitOrder value) submitOrder,
    required TResult Function(LoadCurrentOrders value) loadCurrentOrders,
    required TResult Function(RefreshOrders value) refresh,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(LoadContext value)? loadContext,
    TResult? Function(LoadMenu value)? loadMenu,
    TResult? Function(AddToCart value)? addToCart,
    TResult? Function(RemoveFromCart value)? removeFromCart,
    TResult? Function(UpdateCartQuantity value)? updateCartQuantity,
    TResult? Function(ClearCart value)? clearCart,
    TResult? Function(SubmitOrder value)? submitOrder,
    TResult? Function(LoadCurrentOrders value)? loadCurrentOrders,
    TResult? Function(RefreshOrders value)? refresh,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LoadContext value)? loadContext,
    TResult Function(LoadMenu value)? loadMenu,
    TResult Function(AddToCart value)? addToCart,
    TResult Function(RemoveFromCart value)? removeFromCart,
    TResult Function(UpdateCartQuantity value)? updateCartQuantity,
    TResult Function(ClearCart value)? clearCart,
    TResult Function(SubmitOrder value)? submitOrder,
    TResult Function(LoadCurrentOrders value)? loadCurrentOrders,
    TResult Function(RefreshOrders value)? refresh,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OrdersEventCopyWith<$Res> {
  factory $OrdersEventCopyWith(
    OrdersEvent value,
    $Res Function(OrdersEvent) then,
  ) = _$OrdersEventCopyWithImpl<$Res, OrdersEvent>;
}

/// @nodoc
class _$OrdersEventCopyWithImpl<$Res, $Val extends OrdersEvent>
    implements $OrdersEventCopyWith<$Res> {
  _$OrdersEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of OrdersEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$LoadContextImplCopyWith<$Res> {
  factory _$$LoadContextImplCopyWith(
    _$LoadContextImpl value,
    $Res Function(_$LoadContextImpl) then,
  ) = __$$LoadContextImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$LoadContextImplCopyWithImpl<$Res>
    extends _$OrdersEventCopyWithImpl<$Res, _$LoadContextImpl>
    implements _$$LoadContextImplCopyWith<$Res> {
  __$$LoadContextImplCopyWithImpl(
    _$LoadContextImpl _value,
    $Res Function(_$LoadContextImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of OrdersEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$LoadContextImpl implements LoadContext {
  const _$LoadContextImpl();

  @override
  String toString() {
    return 'OrdersEvent.loadContext()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$LoadContextImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loadContext,
    required TResult Function(String restaurantId) loadMenu,
    required TResult Function(MenuItem menuItem) addToCart,
    required TResult Function(String menuItemId) removeFromCart,
    required TResult Function(String menuItemId, int quantity)
    updateCartQuantity,
    required TResult Function() clearCart,
    required TResult Function(String? note) submitOrder,
    required TResult Function() loadCurrentOrders,
    required TResult Function() refresh,
  }) {
    return loadContext();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loadContext,
    TResult? Function(String restaurantId)? loadMenu,
    TResult? Function(MenuItem menuItem)? addToCart,
    TResult? Function(String menuItemId)? removeFromCart,
    TResult? Function(String menuItemId, int quantity)? updateCartQuantity,
    TResult? Function()? clearCart,
    TResult? Function(String? note)? submitOrder,
    TResult? Function()? loadCurrentOrders,
    TResult? Function()? refresh,
  }) {
    return loadContext?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loadContext,
    TResult Function(String restaurantId)? loadMenu,
    TResult Function(MenuItem menuItem)? addToCart,
    TResult Function(String menuItemId)? removeFromCart,
    TResult Function(String menuItemId, int quantity)? updateCartQuantity,
    TResult Function()? clearCart,
    TResult Function(String? note)? submitOrder,
    TResult Function()? loadCurrentOrders,
    TResult Function()? refresh,
    required TResult orElse(),
  }) {
    if (loadContext != null) {
      return loadContext();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(LoadContext value) loadContext,
    required TResult Function(LoadMenu value) loadMenu,
    required TResult Function(AddToCart value) addToCart,
    required TResult Function(RemoveFromCart value) removeFromCart,
    required TResult Function(UpdateCartQuantity value) updateCartQuantity,
    required TResult Function(ClearCart value) clearCart,
    required TResult Function(SubmitOrder value) submitOrder,
    required TResult Function(LoadCurrentOrders value) loadCurrentOrders,
    required TResult Function(RefreshOrders value) refresh,
  }) {
    return loadContext(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(LoadContext value)? loadContext,
    TResult? Function(LoadMenu value)? loadMenu,
    TResult? Function(AddToCart value)? addToCart,
    TResult? Function(RemoveFromCart value)? removeFromCart,
    TResult? Function(UpdateCartQuantity value)? updateCartQuantity,
    TResult? Function(ClearCart value)? clearCart,
    TResult? Function(SubmitOrder value)? submitOrder,
    TResult? Function(LoadCurrentOrders value)? loadCurrentOrders,
    TResult? Function(RefreshOrders value)? refresh,
  }) {
    return loadContext?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LoadContext value)? loadContext,
    TResult Function(LoadMenu value)? loadMenu,
    TResult Function(AddToCart value)? addToCart,
    TResult Function(RemoveFromCart value)? removeFromCart,
    TResult Function(UpdateCartQuantity value)? updateCartQuantity,
    TResult Function(ClearCart value)? clearCart,
    TResult Function(SubmitOrder value)? submitOrder,
    TResult Function(LoadCurrentOrders value)? loadCurrentOrders,
    TResult Function(RefreshOrders value)? refresh,
    required TResult orElse(),
  }) {
    if (loadContext != null) {
      return loadContext(this);
    }
    return orElse();
  }
}

abstract class LoadContext implements OrdersEvent {
  const factory LoadContext() = _$LoadContextImpl;
}

/// @nodoc
abstract class _$$LoadMenuImplCopyWith<$Res> {
  factory _$$LoadMenuImplCopyWith(
    _$LoadMenuImpl value,
    $Res Function(_$LoadMenuImpl) then,
  ) = __$$LoadMenuImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String restaurantId});
}

/// @nodoc
class __$$LoadMenuImplCopyWithImpl<$Res>
    extends _$OrdersEventCopyWithImpl<$Res, _$LoadMenuImpl>
    implements _$$LoadMenuImplCopyWith<$Res> {
  __$$LoadMenuImplCopyWithImpl(
    _$LoadMenuImpl _value,
    $Res Function(_$LoadMenuImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of OrdersEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? restaurantId = null}) {
    return _then(
      _$LoadMenuImpl(
        restaurantId:
            null == restaurantId
                ? _value.restaurantId
                : restaurantId // ignore: cast_nullable_to_non_nullable
                    as String,
      ),
    );
  }
}

/// @nodoc

class _$LoadMenuImpl implements LoadMenu {
  const _$LoadMenuImpl({required this.restaurantId});

  @override
  final String restaurantId;

  @override
  String toString() {
    return 'OrdersEvent.loadMenu(restaurantId: $restaurantId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoadMenuImpl &&
            (identical(other.restaurantId, restaurantId) ||
                other.restaurantId == restaurantId));
  }

  @override
  int get hashCode => Object.hash(runtimeType, restaurantId);

  /// Create a copy of OrdersEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LoadMenuImplCopyWith<_$LoadMenuImpl> get copyWith =>
      __$$LoadMenuImplCopyWithImpl<_$LoadMenuImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loadContext,
    required TResult Function(String restaurantId) loadMenu,
    required TResult Function(MenuItem menuItem) addToCart,
    required TResult Function(String menuItemId) removeFromCart,
    required TResult Function(String menuItemId, int quantity)
    updateCartQuantity,
    required TResult Function() clearCart,
    required TResult Function(String? note) submitOrder,
    required TResult Function() loadCurrentOrders,
    required TResult Function() refresh,
  }) {
    return loadMenu(restaurantId);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loadContext,
    TResult? Function(String restaurantId)? loadMenu,
    TResult? Function(MenuItem menuItem)? addToCart,
    TResult? Function(String menuItemId)? removeFromCart,
    TResult? Function(String menuItemId, int quantity)? updateCartQuantity,
    TResult? Function()? clearCart,
    TResult? Function(String? note)? submitOrder,
    TResult? Function()? loadCurrentOrders,
    TResult? Function()? refresh,
  }) {
    return loadMenu?.call(restaurantId);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loadContext,
    TResult Function(String restaurantId)? loadMenu,
    TResult Function(MenuItem menuItem)? addToCart,
    TResult Function(String menuItemId)? removeFromCart,
    TResult Function(String menuItemId, int quantity)? updateCartQuantity,
    TResult Function()? clearCart,
    TResult Function(String? note)? submitOrder,
    TResult Function()? loadCurrentOrders,
    TResult Function()? refresh,
    required TResult orElse(),
  }) {
    if (loadMenu != null) {
      return loadMenu(restaurantId);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(LoadContext value) loadContext,
    required TResult Function(LoadMenu value) loadMenu,
    required TResult Function(AddToCart value) addToCart,
    required TResult Function(RemoveFromCart value) removeFromCart,
    required TResult Function(UpdateCartQuantity value) updateCartQuantity,
    required TResult Function(ClearCart value) clearCart,
    required TResult Function(SubmitOrder value) submitOrder,
    required TResult Function(LoadCurrentOrders value) loadCurrentOrders,
    required TResult Function(RefreshOrders value) refresh,
  }) {
    return loadMenu(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(LoadContext value)? loadContext,
    TResult? Function(LoadMenu value)? loadMenu,
    TResult? Function(AddToCart value)? addToCart,
    TResult? Function(RemoveFromCart value)? removeFromCart,
    TResult? Function(UpdateCartQuantity value)? updateCartQuantity,
    TResult? Function(ClearCart value)? clearCart,
    TResult? Function(SubmitOrder value)? submitOrder,
    TResult? Function(LoadCurrentOrders value)? loadCurrentOrders,
    TResult? Function(RefreshOrders value)? refresh,
  }) {
    return loadMenu?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LoadContext value)? loadContext,
    TResult Function(LoadMenu value)? loadMenu,
    TResult Function(AddToCart value)? addToCart,
    TResult Function(RemoveFromCart value)? removeFromCart,
    TResult Function(UpdateCartQuantity value)? updateCartQuantity,
    TResult Function(ClearCart value)? clearCart,
    TResult Function(SubmitOrder value)? submitOrder,
    TResult Function(LoadCurrentOrders value)? loadCurrentOrders,
    TResult Function(RefreshOrders value)? refresh,
    required TResult orElse(),
  }) {
    if (loadMenu != null) {
      return loadMenu(this);
    }
    return orElse();
  }
}

abstract class LoadMenu implements OrdersEvent {
  const factory LoadMenu({required final String restaurantId}) = _$LoadMenuImpl;

  String get restaurantId;

  /// Create a copy of OrdersEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LoadMenuImplCopyWith<_$LoadMenuImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$AddToCartImplCopyWith<$Res> {
  factory _$$AddToCartImplCopyWith(
    _$AddToCartImpl value,
    $Res Function(_$AddToCartImpl) then,
  ) = __$$AddToCartImplCopyWithImpl<$Res>;
  @useResult
  $Res call({MenuItem menuItem});

  $MenuItemCopyWith<$Res> get menuItem;
}

/// @nodoc
class __$$AddToCartImplCopyWithImpl<$Res>
    extends _$OrdersEventCopyWithImpl<$Res, _$AddToCartImpl>
    implements _$$AddToCartImplCopyWith<$Res> {
  __$$AddToCartImplCopyWithImpl(
    _$AddToCartImpl _value,
    $Res Function(_$AddToCartImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of OrdersEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? menuItem = null}) {
    return _then(
      _$AddToCartImpl(
        menuItem:
            null == menuItem
                ? _value.menuItem
                : menuItem // ignore: cast_nullable_to_non_nullable
                    as MenuItem,
      ),
    );
  }

  /// Create a copy of OrdersEvent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $MenuItemCopyWith<$Res> get menuItem {
    return $MenuItemCopyWith<$Res>(_value.menuItem, (value) {
      return _then(_value.copyWith(menuItem: value));
    });
  }
}

/// @nodoc

class _$AddToCartImpl implements AddToCart {
  const _$AddToCartImpl({required this.menuItem});

  @override
  final MenuItem menuItem;

  @override
  String toString() {
    return 'OrdersEvent.addToCart(menuItem: $menuItem)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AddToCartImpl &&
            (identical(other.menuItem, menuItem) ||
                other.menuItem == menuItem));
  }

  @override
  int get hashCode => Object.hash(runtimeType, menuItem);

  /// Create a copy of OrdersEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AddToCartImplCopyWith<_$AddToCartImpl> get copyWith =>
      __$$AddToCartImplCopyWithImpl<_$AddToCartImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loadContext,
    required TResult Function(String restaurantId) loadMenu,
    required TResult Function(MenuItem menuItem) addToCart,
    required TResult Function(String menuItemId) removeFromCart,
    required TResult Function(String menuItemId, int quantity)
    updateCartQuantity,
    required TResult Function() clearCart,
    required TResult Function(String? note) submitOrder,
    required TResult Function() loadCurrentOrders,
    required TResult Function() refresh,
  }) {
    return addToCart(menuItem);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loadContext,
    TResult? Function(String restaurantId)? loadMenu,
    TResult? Function(MenuItem menuItem)? addToCart,
    TResult? Function(String menuItemId)? removeFromCart,
    TResult? Function(String menuItemId, int quantity)? updateCartQuantity,
    TResult? Function()? clearCart,
    TResult? Function(String? note)? submitOrder,
    TResult? Function()? loadCurrentOrders,
    TResult? Function()? refresh,
  }) {
    return addToCart?.call(menuItem);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loadContext,
    TResult Function(String restaurantId)? loadMenu,
    TResult Function(MenuItem menuItem)? addToCart,
    TResult Function(String menuItemId)? removeFromCart,
    TResult Function(String menuItemId, int quantity)? updateCartQuantity,
    TResult Function()? clearCart,
    TResult Function(String? note)? submitOrder,
    TResult Function()? loadCurrentOrders,
    TResult Function()? refresh,
    required TResult orElse(),
  }) {
    if (addToCart != null) {
      return addToCart(menuItem);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(LoadContext value) loadContext,
    required TResult Function(LoadMenu value) loadMenu,
    required TResult Function(AddToCart value) addToCart,
    required TResult Function(RemoveFromCart value) removeFromCart,
    required TResult Function(UpdateCartQuantity value) updateCartQuantity,
    required TResult Function(ClearCart value) clearCart,
    required TResult Function(SubmitOrder value) submitOrder,
    required TResult Function(LoadCurrentOrders value) loadCurrentOrders,
    required TResult Function(RefreshOrders value) refresh,
  }) {
    return addToCart(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(LoadContext value)? loadContext,
    TResult? Function(LoadMenu value)? loadMenu,
    TResult? Function(AddToCart value)? addToCart,
    TResult? Function(RemoveFromCart value)? removeFromCart,
    TResult? Function(UpdateCartQuantity value)? updateCartQuantity,
    TResult? Function(ClearCart value)? clearCart,
    TResult? Function(SubmitOrder value)? submitOrder,
    TResult? Function(LoadCurrentOrders value)? loadCurrentOrders,
    TResult? Function(RefreshOrders value)? refresh,
  }) {
    return addToCart?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LoadContext value)? loadContext,
    TResult Function(LoadMenu value)? loadMenu,
    TResult Function(AddToCart value)? addToCart,
    TResult Function(RemoveFromCart value)? removeFromCart,
    TResult Function(UpdateCartQuantity value)? updateCartQuantity,
    TResult Function(ClearCart value)? clearCart,
    TResult Function(SubmitOrder value)? submitOrder,
    TResult Function(LoadCurrentOrders value)? loadCurrentOrders,
    TResult Function(RefreshOrders value)? refresh,
    required TResult orElse(),
  }) {
    if (addToCart != null) {
      return addToCart(this);
    }
    return orElse();
  }
}

abstract class AddToCart implements OrdersEvent {
  const factory AddToCart({required final MenuItem menuItem}) = _$AddToCartImpl;

  MenuItem get menuItem;

  /// Create a copy of OrdersEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AddToCartImplCopyWith<_$AddToCartImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$RemoveFromCartImplCopyWith<$Res> {
  factory _$$RemoveFromCartImplCopyWith(
    _$RemoveFromCartImpl value,
    $Res Function(_$RemoveFromCartImpl) then,
  ) = __$$RemoveFromCartImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String menuItemId});
}

/// @nodoc
class __$$RemoveFromCartImplCopyWithImpl<$Res>
    extends _$OrdersEventCopyWithImpl<$Res, _$RemoveFromCartImpl>
    implements _$$RemoveFromCartImplCopyWith<$Res> {
  __$$RemoveFromCartImplCopyWithImpl(
    _$RemoveFromCartImpl _value,
    $Res Function(_$RemoveFromCartImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of OrdersEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? menuItemId = null}) {
    return _then(
      _$RemoveFromCartImpl(
        menuItemId:
            null == menuItemId
                ? _value.menuItemId
                : menuItemId // ignore: cast_nullable_to_non_nullable
                    as String,
      ),
    );
  }
}

/// @nodoc

class _$RemoveFromCartImpl implements RemoveFromCart {
  const _$RemoveFromCartImpl({required this.menuItemId});

  @override
  final String menuItemId;

  @override
  String toString() {
    return 'OrdersEvent.removeFromCart(menuItemId: $menuItemId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RemoveFromCartImpl &&
            (identical(other.menuItemId, menuItemId) ||
                other.menuItemId == menuItemId));
  }

  @override
  int get hashCode => Object.hash(runtimeType, menuItemId);

  /// Create a copy of OrdersEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$RemoveFromCartImplCopyWith<_$RemoveFromCartImpl> get copyWith =>
      __$$RemoveFromCartImplCopyWithImpl<_$RemoveFromCartImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loadContext,
    required TResult Function(String restaurantId) loadMenu,
    required TResult Function(MenuItem menuItem) addToCart,
    required TResult Function(String menuItemId) removeFromCart,
    required TResult Function(String menuItemId, int quantity)
    updateCartQuantity,
    required TResult Function() clearCart,
    required TResult Function(String? note) submitOrder,
    required TResult Function() loadCurrentOrders,
    required TResult Function() refresh,
  }) {
    return removeFromCart(menuItemId);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loadContext,
    TResult? Function(String restaurantId)? loadMenu,
    TResult? Function(MenuItem menuItem)? addToCart,
    TResult? Function(String menuItemId)? removeFromCart,
    TResult? Function(String menuItemId, int quantity)? updateCartQuantity,
    TResult? Function()? clearCart,
    TResult? Function(String? note)? submitOrder,
    TResult? Function()? loadCurrentOrders,
    TResult? Function()? refresh,
  }) {
    return removeFromCart?.call(menuItemId);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loadContext,
    TResult Function(String restaurantId)? loadMenu,
    TResult Function(MenuItem menuItem)? addToCart,
    TResult Function(String menuItemId)? removeFromCart,
    TResult Function(String menuItemId, int quantity)? updateCartQuantity,
    TResult Function()? clearCart,
    TResult Function(String? note)? submitOrder,
    TResult Function()? loadCurrentOrders,
    TResult Function()? refresh,
    required TResult orElse(),
  }) {
    if (removeFromCart != null) {
      return removeFromCart(menuItemId);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(LoadContext value) loadContext,
    required TResult Function(LoadMenu value) loadMenu,
    required TResult Function(AddToCart value) addToCart,
    required TResult Function(RemoveFromCart value) removeFromCart,
    required TResult Function(UpdateCartQuantity value) updateCartQuantity,
    required TResult Function(ClearCart value) clearCart,
    required TResult Function(SubmitOrder value) submitOrder,
    required TResult Function(LoadCurrentOrders value) loadCurrentOrders,
    required TResult Function(RefreshOrders value) refresh,
  }) {
    return removeFromCart(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(LoadContext value)? loadContext,
    TResult? Function(LoadMenu value)? loadMenu,
    TResult? Function(AddToCart value)? addToCart,
    TResult? Function(RemoveFromCart value)? removeFromCart,
    TResult? Function(UpdateCartQuantity value)? updateCartQuantity,
    TResult? Function(ClearCart value)? clearCart,
    TResult? Function(SubmitOrder value)? submitOrder,
    TResult? Function(LoadCurrentOrders value)? loadCurrentOrders,
    TResult? Function(RefreshOrders value)? refresh,
  }) {
    return removeFromCart?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LoadContext value)? loadContext,
    TResult Function(LoadMenu value)? loadMenu,
    TResult Function(AddToCart value)? addToCart,
    TResult Function(RemoveFromCart value)? removeFromCart,
    TResult Function(UpdateCartQuantity value)? updateCartQuantity,
    TResult Function(ClearCart value)? clearCart,
    TResult Function(SubmitOrder value)? submitOrder,
    TResult Function(LoadCurrentOrders value)? loadCurrentOrders,
    TResult Function(RefreshOrders value)? refresh,
    required TResult orElse(),
  }) {
    if (removeFromCart != null) {
      return removeFromCart(this);
    }
    return orElse();
  }
}

abstract class RemoveFromCart implements OrdersEvent {
  const factory RemoveFromCart({required final String menuItemId}) =
      _$RemoveFromCartImpl;

  String get menuItemId;

  /// Create a copy of OrdersEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RemoveFromCartImplCopyWith<_$RemoveFromCartImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$UpdateCartQuantityImplCopyWith<$Res> {
  factory _$$UpdateCartQuantityImplCopyWith(
    _$UpdateCartQuantityImpl value,
    $Res Function(_$UpdateCartQuantityImpl) then,
  ) = __$$UpdateCartQuantityImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String menuItemId, int quantity});
}

/// @nodoc
class __$$UpdateCartQuantityImplCopyWithImpl<$Res>
    extends _$OrdersEventCopyWithImpl<$Res, _$UpdateCartQuantityImpl>
    implements _$$UpdateCartQuantityImplCopyWith<$Res> {
  __$$UpdateCartQuantityImplCopyWithImpl(
    _$UpdateCartQuantityImpl _value,
    $Res Function(_$UpdateCartQuantityImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of OrdersEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? menuItemId = null, Object? quantity = null}) {
    return _then(
      _$UpdateCartQuantityImpl(
        menuItemId:
            null == menuItemId
                ? _value.menuItemId
                : menuItemId // ignore: cast_nullable_to_non_nullable
                    as String,
        quantity:
            null == quantity
                ? _value.quantity
                : quantity // ignore: cast_nullable_to_non_nullable
                    as int,
      ),
    );
  }
}

/// @nodoc

class _$UpdateCartQuantityImpl implements UpdateCartQuantity {
  const _$UpdateCartQuantityImpl({
    required this.menuItemId,
    required this.quantity,
  });

  @override
  final String menuItemId;
  @override
  final int quantity;

  @override
  String toString() {
    return 'OrdersEvent.updateCartQuantity(menuItemId: $menuItemId, quantity: $quantity)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UpdateCartQuantityImpl &&
            (identical(other.menuItemId, menuItemId) ||
                other.menuItemId == menuItemId) &&
            (identical(other.quantity, quantity) ||
                other.quantity == quantity));
  }

  @override
  int get hashCode => Object.hash(runtimeType, menuItemId, quantity);

  /// Create a copy of OrdersEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UpdateCartQuantityImplCopyWith<_$UpdateCartQuantityImpl> get copyWith =>
      __$$UpdateCartQuantityImplCopyWithImpl<_$UpdateCartQuantityImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loadContext,
    required TResult Function(String restaurantId) loadMenu,
    required TResult Function(MenuItem menuItem) addToCart,
    required TResult Function(String menuItemId) removeFromCart,
    required TResult Function(String menuItemId, int quantity)
    updateCartQuantity,
    required TResult Function() clearCart,
    required TResult Function(String? note) submitOrder,
    required TResult Function() loadCurrentOrders,
    required TResult Function() refresh,
  }) {
    return updateCartQuantity(menuItemId, quantity);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loadContext,
    TResult? Function(String restaurantId)? loadMenu,
    TResult? Function(MenuItem menuItem)? addToCart,
    TResult? Function(String menuItemId)? removeFromCart,
    TResult? Function(String menuItemId, int quantity)? updateCartQuantity,
    TResult? Function()? clearCart,
    TResult? Function(String? note)? submitOrder,
    TResult? Function()? loadCurrentOrders,
    TResult? Function()? refresh,
  }) {
    return updateCartQuantity?.call(menuItemId, quantity);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loadContext,
    TResult Function(String restaurantId)? loadMenu,
    TResult Function(MenuItem menuItem)? addToCart,
    TResult Function(String menuItemId)? removeFromCart,
    TResult Function(String menuItemId, int quantity)? updateCartQuantity,
    TResult Function()? clearCart,
    TResult Function(String? note)? submitOrder,
    TResult Function()? loadCurrentOrders,
    TResult Function()? refresh,
    required TResult orElse(),
  }) {
    if (updateCartQuantity != null) {
      return updateCartQuantity(menuItemId, quantity);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(LoadContext value) loadContext,
    required TResult Function(LoadMenu value) loadMenu,
    required TResult Function(AddToCart value) addToCart,
    required TResult Function(RemoveFromCart value) removeFromCart,
    required TResult Function(UpdateCartQuantity value) updateCartQuantity,
    required TResult Function(ClearCart value) clearCart,
    required TResult Function(SubmitOrder value) submitOrder,
    required TResult Function(LoadCurrentOrders value) loadCurrentOrders,
    required TResult Function(RefreshOrders value) refresh,
  }) {
    return updateCartQuantity(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(LoadContext value)? loadContext,
    TResult? Function(LoadMenu value)? loadMenu,
    TResult? Function(AddToCart value)? addToCart,
    TResult? Function(RemoveFromCart value)? removeFromCart,
    TResult? Function(UpdateCartQuantity value)? updateCartQuantity,
    TResult? Function(ClearCart value)? clearCart,
    TResult? Function(SubmitOrder value)? submitOrder,
    TResult? Function(LoadCurrentOrders value)? loadCurrentOrders,
    TResult? Function(RefreshOrders value)? refresh,
  }) {
    return updateCartQuantity?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LoadContext value)? loadContext,
    TResult Function(LoadMenu value)? loadMenu,
    TResult Function(AddToCart value)? addToCart,
    TResult Function(RemoveFromCart value)? removeFromCart,
    TResult Function(UpdateCartQuantity value)? updateCartQuantity,
    TResult Function(ClearCart value)? clearCart,
    TResult Function(SubmitOrder value)? submitOrder,
    TResult Function(LoadCurrentOrders value)? loadCurrentOrders,
    TResult Function(RefreshOrders value)? refresh,
    required TResult orElse(),
  }) {
    if (updateCartQuantity != null) {
      return updateCartQuantity(this);
    }
    return orElse();
  }
}

abstract class UpdateCartQuantity implements OrdersEvent {
  const factory UpdateCartQuantity({
    required final String menuItemId,
    required final int quantity,
  }) = _$UpdateCartQuantityImpl;

  String get menuItemId;
  int get quantity;

  /// Create a copy of OrdersEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UpdateCartQuantityImplCopyWith<_$UpdateCartQuantityImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ClearCartImplCopyWith<$Res> {
  factory _$$ClearCartImplCopyWith(
    _$ClearCartImpl value,
    $Res Function(_$ClearCartImpl) then,
  ) = __$$ClearCartImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$ClearCartImplCopyWithImpl<$Res>
    extends _$OrdersEventCopyWithImpl<$Res, _$ClearCartImpl>
    implements _$$ClearCartImplCopyWith<$Res> {
  __$$ClearCartImplCopyWithImpl(
    _$ClearCartImpl _value,
    $Res Function(_$ClearCartImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of OrdersEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$ClearCartImpl implements ClearCart {
  const _$ClearCartImpl();

  @override
  String toString() {
    return 'OrdersEvent.clearCart()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$ClearCartImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loadContext,
    required TResult Function(String restaurantId) loadMenu,
    required TResult Function(MenuItem menuItem) addToCart,
    required TResult Function(String menuItemId) removeFromCart,
    required TResult Function(String menuItemId, int quantity)
    updateCartQuantity,
    required TResult Function() clearCart,
    required TResult Function(String? note) submitOrder,
    required TResult Function() loadCurrentOrders,
    required TResult Function() refresh,
  }) {
    return clearCart();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loadContext,
    TResult? Function(String restaurantId)? loadMenu,
    TResult? Function(MenuItem menuItem)? addToCart,
    TResult? Function(String menuItemId)? removeFromCart,
    TResult? Function(String menuItemId, int quantity)? updateCartQuantity,
    TResult? Function()? clearCart,
    TResult? Function(String? note)? submitOrder,
    TResult? Function()? loadCurrentOrders,
    TResult? Function()? refresh,
  }) {
    return clearCart?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loadContext,
    TResult Function(String restaurantId)? loadMenu,
    TResult Function(MenuItem menuItem)? addToCart,
    TResult Function(String menuItemId)? removeFromCart,
    TResult Function(String menuItemId, int quantity)? updateCartQuantity,
    TResult Function()? clearCart,
    TResult Function(String? note)? submitOrder,
    TResult Function()? loadCurrentOrders,
    TResult Function()? refresh,
    required TResult orElse(),
  }) {
    if (clearCart != null) {
      return clearCart();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(LoadContext value) loadContext,
    required TResult Function(LoadMenu value) loadMenu,
    required TResult Function(AddToCart value) addToCart,
    required TResult Function(RemoveFromCart value) removeFromCart,
    required TResult Function(UpdateCartQuantity value) updateCartQuantity,
    required TResult Function(ClearCart value) clearCart,
    required TResult Function(SubmitOrder value) submitOrder,
    required TResult Function(LoadCurrentOrders value) loadCurrentOrders,
    required TResult Function(RefreshOrders value) refresh,
  }) {
    return clearCart(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(LoadContext value)? loadContext,
    TResult? Function(LoadMenu value)? loadMenu,
    TResult? Function(AddToCart value)? addToCart,
    TResult? Function(RemoveFromCart value)? removeFromCart,
    TResult? Function(UpdateCartQuantity value)? updateCartQuantity,
    TResult? Function(ClearCart value)? clearCart,
    TResult? Function(SubmitOrder value)? submitOrder,
    TResult? Function(LoadCurrentOrders value)? loadCurrentOrders,
    TResult? Function(RefreshOrders value)? refresh,
  }) {
    return clearCart?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LoadContext value)? loadContext,
    TResult Function(LoadMenu value)? loadMenu,
    TResult Function(AddToCart value)? addToCart,
    TResult Function(RemoveFromCart value)? removeFromCart,
    TResult Function(UpdateCartQuantity value)? updateCartQuantity,
    TResult Function(ClearCart value)? clearCart,
    TResult Function(SubmitOrder value)? submitOrder,
    TResult Function(LoadCurrentOrders value)? loadCurrentOrders,
    TResult Function(RefreshOrders value)? refresh,
    required TResult orElse(),
  }) {
    if (clearCart != null) {
      return clearCart(this);
    }
    return orElse();
  }
}

abstract class ClearCart implements OrdersEvent {
  const factory ClearCart() = _$ClearCartImpl;
}

/// @nodoc
abstract class _$$SubmitOrderImplCopyWith<$Res> {
  factory _$$SubmitOrderImplCopyWith(
    _$SubmitOrderImpl value,
    $Res Function(_$SubmitOrderImpl) then,
  ) = __$$SubmitOrderImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String? note});
}

/// @nodoc
class __$$SubmitOrderImplCopyWithImpl<$Res>
    extends _$OrdersEventCopyWithImpl<$Res, _$SubmitOrderImpl>
    implements _$$SubmitOrderImplCopyWith<$Res> {
  __$$SubmitOrderImplCopyWithImpl(
    _$SubmitOrderImpl _value,
    $Res Function(_$SubmitOrderImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of OrdersEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? note = freezed}) {
    return _then(
      _$SubmitOrderImpl(
        note:
            freezed == note
                ? _value.note
                : note // ignore: cast_nullable_to_non_nullable
                    as String?,
      ),
    );
  }
}

/// @nodoc

class _$SubmitOrderImpl implements SubmitOrder {
  const _$SubmitOrderImpl({this.note});

  @override
  final String? note;

  @override
  String toString() {
    return 'OrdersEvent.submitOrder(note: $note)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SubmitOrderImpl &&
            (identical(other.note, note) || other.note == note));
  }

  @override
  int get hashCode => Object.hash(runtimeType, note);

  /// Create a copy of OrdersEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SubmitOrderImplCopyWith<_$SubmitOrderImpl> get copyWith =>
      __$$SubmitOrderImplCopyWithImpl<_$SubmitOrderImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loadContext,
    required TResult Function(String restaurantId) loadMenu,
    required TResult Function(MenuItem menuItem) addToCart,
    required TResult Function(String menuItemId) removeFromCart,
    required TResult Function(String menuItemId, int quantity)
    updateCartQuantity,
    required TResult Function() clearCart,
    required TResult Function(String? note) submitOrder,
    required TResult Function() loadCurrentOrders,
    required TResult Function() refresh,
  }) {
    return submitOrder(note);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loadContext,
    TResult? Function(String restaurantId)? loadMenu,
    TResult? Function(MenuItem menuItem)? addToCart,
    TResult? Function(String menuItemId)? removeFromCart,
    TResult? Function(String menuItemId, int quantity)? updateCartQuantity,
    TResult? Function()? clearCart,
    TResult? Function(String? note)? submitOrder,
    TResult? Function()? loadCurrentOrders,
    TResult? Function()? refresh,
  }) {
    return submitOrder?.call(note);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loadContext,
    TResult Function(String restaurantId)? loadMenu,
    TResult Function(MenuItem menuItem)? addToCart,
    TResult Function(String menuItemId)? removeFromCart,
    TResult Function(String menuItemId, int quantity)? updateCartQuantity,
    TResult Function()? clearCart,
    TResult Function(String? note)? submitOrder,
    TResult Function()? loadCurrentOrders,
    TResult Function()? refresh,
    required TResult orElse(),
  }) {
    if (submitOrder != null) {
      return submitOrder(note);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(LoadContext value) loadContext,
    required TResult Function(LoadMenu value) loadMenu,
    required TResult Function(AddToCart value) addToCart,
    required TResult Function(RemoveFromCart value) removeFromCart,
    required TResult Function(UpdateCartQuantity value) updateCartQuantity,
    required TResult Function(ClearCart value) clearCart,
    required TResult Function(SubmitOrder value) submitOrder,
    required TResult Function(LoadCurrentOrders value) loadCurrentOrders,
    required TResult Function(RefreshOrders value) refresh,
  }) {
    return submitOrder(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(LoadContext value)? loadContext,
    TResult? Function(LoadMenu value)? loadMenu,
    TResult? Function(AddToCart value)? addToCart,
    TResult? Function(RemoveFromCart value)? removeFromCart,
    TResult? Function(UpdateCartQuantity value)? updateCartQuantity,
    TResult? Function(ClearCart value)? clearCart,
    TResult? Function(SubmitOrder value)? submitOrder,
    TResult? Function(LoadCurrentOrders value)? loadCurrentOrders,
    TResult? Function(RefreshOrders value)? refresh,
  }) {
    return submitOrder?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LoadContext value)? loadContext,
    TResult Function(LoadMenu value)? loadMenu,
    TResult Function(AddToCart value)? addToCart,
    TResult Function(RemoveFromCart value)? removeFromCart,
    TResult Function(UpdateCartQuantity value)? updateCartQuantity,
    TResult Function(ClearCart value)? clearCart,
    TResult Function(SubmitOrder value)? submitOrder,
    TResult Function(LoadCurrentOrders value)? loadCurrentOrders,
    TResult Function(RefreshOrders value)? refresh,
    required TResult orElse(),
  }) {
    if (submitOrder != null) {
      return submitOrder(this);
    }
    return orElse();
  }
}

abstract class SubmitOrder implements OrdersEvent {
  const factory SubmitOrder({final String? note}) = _$SubmitOrderImpl;

  String? get note;

  /// Create a copy of OrdersEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SubmitOrderImplCopyWith<_$SubmitOrderImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$LoadCurrentOrdersImplCopyWith<$Res> {
  factory _$$LoadCurrentOrdersImplCopyWith(
    _$LoadCurrentOrdersImpl value,
    $Res Function(_$LoadCurrentOrdersImpl) then,
  ) = __$$LoadCurrentOrdersImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$LoadCurrentOrdersImplCopyWithImpl<$Res>
    extends _$OrdersEventCopyWithImpl<$Res, _$LoadCurrentOrdersImpl>
    implements _$$LoadCurrentOrdersImplCopyWith<$Res> {
  __$$LoadCurrentOrdersImplCopyWithImpl(
    _$LoadCurrentOrdersImpl _value,
    $Res Function(_$LoadCurrentOrdersImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of OrdersEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$LoadCurrentOrdersImpl implements LoadCurrentOrders {
  const _$LoadCurrentOrdersImpl();

  @override
  String toString() {
    return 'OrdersEvent.loadCurrentOrders()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$LoadCurrentOrdersImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loadContext,
    required TResult Function(String restaurantId) loadMenu,
    required TResult Function(MenuItem menuItem) addToCart,
    required TResult Function(String menuItemId) removeFromCart,
    required TResult Function(String menuItemId, int quantity)
    updateCartQuantity,
    required TResult Function() clearCart,
    required TResult Function(String? note) submitOrder,
    required TResult Function() loadCurrentOrders,
    required TResult Function() refresh,
  }) {
    return loadCurrentOrders();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loadContext,
    TResult? Function(String restaurantId)? loadMenu,
    TResult? Function(MenuItem menuItem)? addToCart,
    TResult? Function(String menuItemId)? removeFromCart,
    TResult? Function(String menuItemId, int quantity)? updateCartQuantity,
    TResult? Function()? clearCart,
    TResult? Function(String? note)? submitOrder,
    TResult? Function()? loadCurrentOrders,
    TResult? Function()? refresh,
  }) {
    return loadCurrentOrders?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loadContext,
    TResult Function(String restaurantId)? loadMenu,
    TResult Function(MenuItem menuItem)? addToCart,
    TResult Function(String menuItemId)? removeFromCart,
    TResult Function(String menuItemId, int quantity)? updateCartQuantity,
    TResult Function()? clearCart,
    TResult Function(String? note)? submitOrder,
    TResult Function()? loadCurrentOrders,
    TResult Function()? refresh,
    required TResult orElse(),
  }) {
    if (loadCurrentOrders != null) {
      return loadCurrentOrders();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(LoadContext value) loadContext,
    required TResult Function(LoadMenu value) loadMenu,
    required TResult Function(AddToCart value) addToCart,
    required TResult Function(RemoveFromCart value) removeFromCart,
    required TResult Function(UpdateCartQuantity value) updateCartQuantity,
    required TResult Function(ClearCart value) clearCart,
    required TResult Function(SubmitOrder value) submitOrder,
    required TResult Function(LoadCurrentOrders value) loadCurrentOrders,
    required TResult Function(RefreshOrders value) refresh,
  }) {
    return loadCurrentOrders(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(LoadContext value)? loadContext,
    TResult? Function(LoadMenu value)? loadMenu,
    TResult? Function(AddToCart value)? addToCart,
    TResult? Function(RemoveFromCart value)? removeFromCart,
    TResult? Function(UpdateCartQuantity value)? updateCartQuantity,
    TResult? Function(ClearCart value)? clearCart,
    TResult? Function(SubmitOrder value)? submitOrder,
    TResult? Function(LoadCurrentOrders value)? loadCurrentOrders,
    TResult? Function(RefreshOrders value)? refresh,
  }) {
    return loadCurrentOrders?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LoadContext value)? loadContext,
    TResult Function(LoadMenu value)? loadMenu,
    TResult Function(AddToCart value)? addToCart,
    TResult Function(RemoveFromCart value)? removeFromCart,
    TResult Function(UpdateCartQuantity value)? updateCartQuantity,
    TResult Function(ClearCart value)? clearCart,
    TResult Function(SubmitOrder value)? submitOrder,
    TResult Function(LoadCurrentOrders value)? loadCurrentOrders,
    TResult Function(RefreshOrders value)? refresh,
    required TResult orElse(),
  }) {
    if (loadCurrentOrders != null) {
      return loadCurrentOrders(this);
    }
    return orElse();
  }
}

abstract class LoadCurrentOrders implements OrdersEvent {
  const factory LoadCurrentOrders() = _$LoadCurrentOrdersImpl;
}

/// @nodoc
abstract class _$$RefreshOrdersImplCopyWith<$Res> {
  factory _$$RefreshOrdersImplCopyWith(
    _$RefreshOrdersImpl value,
    $Res Function(_$RefreshOrdersImpl) then,
  ) = __$$RefreshOrdersImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$RefreshOrdersImplCopyWithImpl<$Res>
    extends _$OrdersEventCopyWithImpl<$Res, _$RefreshOrdersImpl>
    implements _$$RefreshOrdersImplCopyWith<$Res> {
  __$$RefreshOrdersImplCopyWithImpl(
    _$RefreshOrdersImpl _value,
    $Res Function(_$RefreshOrdersImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of OrdersEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$RefreshOrdersImpl implements RefreshOrders {
  const _$RefreshOrdersImpl();

  @override
  String toString() {
    return 'OrdersEvent.refresh()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$RefreshOrdersImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loadContext,
    required TResult Function(String restaurantId) loadMenu,
    required TResult Function(MenuItem menuItem) addToCart,
    required TResult Function(String menuItemId) removeFromCart,
    required TResult Function(String menuItemId, int quantity)
    updateCartQuantity,
    required TResult Function() clearCart,
    required TResult Function(String? note) submitOrder,
    required TResult Function() loadCurrentOrders,
    required TResult Function() refresh,
  }) {
    return refresh();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loadContext,
    TResult? Function(String restaurantId)? loadMenu,
    TResult? Function(MenuItem menuItem)? addToCart,
    TResult? Function(String menuItemId)? removeFromCart,
    TResult? Function(String menuItemId, int quantity)? updateCartQuantity,
    TResult? Function()? clearCart,
    TResult? Function(String? note)? submitOrder,
    TResult? Function()? loadCurrentOrders,
    TResult? Function()? refresh,
  }) {
    return refresh?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loadContext,
    TResult Function(String restaurantId)? loadMenu,
    TResult Function(MenuItem menuItem)? addToCart,
    TResult Function(String menuItemId)? removeFromCart,
    TResult Function(String menuItemId, int quantity)? updateCartQuantity,
    TResult Function()? clearCart,
    TResult Function(String? note)? submitOrder,
    TResult Function()? loadCurrentOrders,
    TResult Function()? refresh,
    required TResult orElse(),
  }) {
    if (refresh != null) {
      return refresh();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(LoadContext value) loadContext,
    required TResult Function(LoadMenu value) loadMenu,
    required TResult Function(AddToCart value) addToCart,
    required TResult Function(RemoveFromCart value) removeFromCart,
    required TResult Function(UpdateCartQuantity value) updateCartQuantity,
    required TResult Function(ClearCart value) clearCart,
    required TResult Function(SubmitOrder value) submitOrder,
    required TResult Function(LoadCurrentOrders value) loadCurrentOrders,
    required TResult Function(RefreshOrders value) refresh,
  }) {
    return refresh(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(LoadContext value)? loadContext,
    TResult? Function(LoadMenu value)? loadMenu,
    TResult? Function(AddToCart value)? addToCart,
    TResult? Function(RemoveFromCart value)? removeFromCart,
    TResult? Function(UpdateCartQuantity value)? updateCartQuantity,
    TResult? Function(ClearCart value)? clearCart,
    TResult? Function(SubmitOrder value)? submitOrder,
    TResult? Function(LoadCurrentOrders value)? loadCurrentOrders,
    TResult? Function(RefreshOrders value)? refresh,
  }) {
    return refresh?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LoadContext value)? loadContext,
    TResult Function(LoadMenu value)? loadMenu,
    TResult Function(AddToCart value)? addToCart,
    TResult Function(RemoveFromCart value)? removeFromCart,
    TResult Function(UpdateCartQuantity value)? updateCartQuantity,
    TResult Function(ClearCart value)? clearCart,
    TResult Function(SubmitOrder value)? submitOrder,
    TResult Function(LoadCurrentOrders value)? loadCurrentOrders,
    TResult Function(RefreshOrders value)? refresh,
    required TResult orElse(),
  }) {
    if (refresh != null) {
      return refresh(this);
    }
    return orElse();
  }
}

abstract class RefreshOrders implements OrdersEvent {
  const factory RefreshOrders() = _$RefreshOrdersImpl;
}
