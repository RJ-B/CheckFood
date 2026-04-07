import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../domain/entities/cart_item.dart';
import '../../domain/entities/dining_session.dart';
import '../../domain/entities/session_order_item.dart';
import '../../domain/usecases/create_order_usecase.dart';
import '../../domain/usecases/get_current_orders_usecase.dart';
import '../../domain/usecases/get_dining_context_usecase.dart';
import '../../domain/usecases/get_menu_usecase.dart';
import '../../domain/usecases/initiate_payment_usecase.dart';
import '../../domain/usecases/get_payment_status_usecase.dart';
import '../../../../../../../core/di/injection_container.dart';
import '../../data/datasources/orders_remote_datasource.dart';
import 'orders_event.dart';
import 'orders_state.dart';

/// BLoC that manages the full ordering flow: dining context, menu, cart,
/// order submission, payment, and group session handling.
class OrdersBloc extends Bloc<OrdersEvent, OrdersState> {
  final GetDiningContextUseCase _getDiningContextUseCase;
  final GetMenuUseCase _getMenuUseCase;
  final CreateOrderUseCase _createOrderUseCase;
  final GetCurrentOrdersUseCase _getCurrentOrdersUseCase;
  final InitiatePaymentUseCase _initiatePaymentUseCase;
  final GetPaymentStatusUseCase _getPaymentStatusUseCase;
  late final OrdersRemoteDataSource _remoteDataSource;

  Timer? _pollingTimer;
  String? _pollingOrderId;
  int _pollCount = 0;
  static const int _maxPollCount = 10;

  OrdersBloc({
    required GetDiningContextUseCase getDiningContextUseCase,
    required GetMenuUseCase getMenuUseCase,
    required CreateOrderUseCase createOrderUseCase,
    required GetCurrentOrdersUseCase getCurrentOrdersUseCase,
    required InitiatePaymentUseCase initiatePaymentUseCase,
    required GetPaymentStatusUseCase getPaymentStatusUseCase,
  })  : _getDiningContextUseCase = getDiningContextUseCase,
        _getMenuUseCase = getMenuUseCase,
        _createOrderUseCase = createOrderUseCase,
        _getCurrentOrdersUseCase = getCurrentOrdersUseCase,
        _initiatePaymentUseCase = initiatePaymentUseCase,
        _getPaymentStatusUseCase = getPaymentStatusUseCase,
        super(const OrdersState()) {
    _remoteDataSource = sl<OrdersRemoteDataSource>();
    on<LoadContext>(_onLoadContext);
    on<LoadMenu>(_onLoadMenu);
    on<AddToCart>(_onAddToCart);
    on<RemoveFromCart>(_onRemoveFromCart);
    on<UpdateCartQuantity>(_onUpdateCartQuantity);
    on<ClearCart>(_onClearCart);
    on<SubmitOrder>(_onSubmitOrder);
    on<LoadCurrentOrders>(_onLoadCurrentOrders);
    on<RefreshOrders>(_onRefresh);
    on<PayOrder>(_onPayOrder);
    on<CheckPaymentStatus>(_onCheckPaymentStatus);
    on<LoadSession>(_onLoadSession);
    on<LoadSessionOrders>(_onLoadSessionOrders);
    on<ToggleItemSelection>(_onToggleItemSelection);
    on<SelectAllMyItems>(_onSelectAllMyItems);
    on<PaySelectedItems>(_onPaySelectedItems);
    on<JoinSession>(_onJoinSession);
    on<ShowSessionQr>(_onShowSessionQr);
  }

  @override
  Future<void> close() {
    _pollingTimer?.cancel();
    return super.close();
  }

  Future<void> _onLoadContext(
    LoadContext event,
    Emitter<OrdersState> emit,
  ) async {
    emit(state.copyWith(
      contextLoading: true,
      contextError: null,
      noActiveContext: false,
    ));

    try {
      final context = await _getDiningContextUseCase();
      emit(state.copyWith(
        contextLoading: false,
        diningContext: context,
      ));

      add(LoadMenu(restaurantId: context.restaurantId));
      add(const LoadCurrentOrders());

      if (context.sessionId != null) {
        add(const OrdersEvent.loadSession());
        add(const OrdersEvent.loadSessionOrders());
      }
    } on DioException catch (e) {
      if (e.response?.statusCode == 404) {
        emit(state.copyWith(
          contextLoading: false,
          noActiveContext: true,
        ));
      } else {
        emit(state.copyWith(
          contextLoading: false,
          contextError: 'Nepodařilo se načíst kontext.',
        ));
      }
    } catch (_) {
      emit(state.copyWith(
        contextLoading: false,
        contextError: 'Nepodařilo se načíst kontext.',
      ));
    }
  }

  Future<void> _onLoadMenu(
    LoadMenu event,
    Emitter<OrdersState> emit,
  ) async {
    emit(state.copyWith(menuLoading: true, menuError: null));

    try {
      final categories = await _getMenuUseCase(event.restaurantId);
      emit(state.copyWith(
        menuLoading: false,
        menuCategories: categories,
      ));
    } catch (_) {
      emit(state.copyWith(
        menuLoading: false,
        menuError: 'Nepodařilo se načíst menu.',
      ));
    }
  }

  void _onAddToCart(AddToCart event, Emitter<OrdersState> emit) {
    final existing = state.cartItems.indexWhere(
      (item) => item.menuItemId == event.menuItem.id,
    );

    final updatedCart = List<CartItem>.from(state.cartItems);

    if (existing >= 0) {
      final old = updatedCart[existing];
      updatedCart[existing] = old.copyWith(quantity: old.quantity + 1);
    } else {
      updatedCart.add(CartItem(
        menuItemId: event.menuItem.id,
        itemName: event.menuItem.name,
        unitPriceMinor: event.menuItem.priceMinor,
        quantity: 1,
        currency: event.menuItem.currency,
      ));
    }

    emit(state.copyWith(cartItems: updatedCart, submitSuccess: false));
  }

  void _onRemoveFromCart(RemoveFromCart event, Emitter<OrdersState> emit) {
    final existing = state.cartItems.indexWhere(
      (item) => item.menuItemId == event.menuItemId,
    );

    if (existing < 0) return;

    final updatedCart = List<CartItem>.from(state.cartItems);
    final old = updatedCart[existing];

    if (old.quantity > 1) {
      updatedCart[existing] = old.copyWith(quantity: old.quantity - 1);
    } else {
      updatedCart.removeAt(existing);
    }

    emit(state.copyWith(cartItems: updatedCart));
  }

  void _onUpdateCartQuantity(
      UpdateCartQuantity event, Emitter<OrdersState> emit) {
    final existing = state.cartItems.indexWhere(
      (item) => item.menuItemId == event.menuItemId,
    );

    if (existing < 0) return;

    final updatedCart = List<CartItem>.from(state.cartItems);

    if (event.quantity <= 0) {
      updatedCart.removeAt(existing);
    } else {
      updatedCart[existing] =
          updatedCart[existing].copyWith(quantity: event.quantity);
    }

    emit(state.copyWith(cartItems: updatedCart));
  }

  void _onClearCart(ClearCart event, Emitter<OrdersState> emit) {
    emit(state.copyWith(cartItems: []));
  }

  Future<void> _onSubmitOrder(
    SubmitOrder event,
    Emitter<OrdersState> emit,
  ) async {
    if (!state.canSubmit) return;

    emit(state.copyWith(submitting: true, submitError: null, submitSuccess: false));

    try {
      final items = state.cartItems
          .map((item) => (menuItemId: item.menuItemId, quantity: item.quantity))
          .toList();

      await _createOrderUseCase(items: items, note: event.note);

      emit(state.copyWith(
        submitting: false,
        submitSuccess: true,
        cartItems: [],
      ));

      add(const LoadCurrentOrders());
    } on DioException catch (e) {
      final message = switch (e.response?.statusCode) {
        404 => 'Položka nebyla nalezena.',
        409 => 'Kontext objednávky se změnil.',
        422 => 'Neplatná objednávka.',
        _ => 'Nepodařilo se odeslat objednávku.',
      };
      emit(state.copyWith(submitting: false, submitError: message));
    } catch (_) {
      emit(state.copyWith(
        submitting: false,
        submitError: 'Nepodařilo se odeslat objednávku.',
      ));
    }
  }

  Future<void> _onLoadCurrentOrders(
    LoadCurrentOrders event,
    Emitter<OrdersState> emit,
  ) async {
    emit(state.copyWith(ordersLoading: true));

    try {
      final orders = await _getCurrentOrdersUseCase();
      emit(state.copyWith(ordersLoading: false, currentOrders: orders));
    } catch (_) {
      emit(state.copyWith(ordersLoading: false));
    }
  }

  Future<void> _onRefresh(
    RefreshOrders event,
    Emitter<OrdersState> emit,
  ) async {
    add(const LoadContext());
  }

  Future<void> _onPayOrder(
    PayOrder event,
    Emitter<OrdersState> emit,
  ) async {
    emit(state.copyWith(
      paymentInitiating: true,
      paymentError: null,
      paymentRedirectUrl: null,
    ));

    try {
      final redirectUrl = await _initiatePaymentUseCase(event.orderId);
      emit(state.copyWith(
        paymentInitiating: false,
        paymentRedirectUrl: redirectUrl,
        paymentStatuses: Map.from(state.paymentStatuses)
          ..[event.orderId] = 'INITIATED',
      ));

      final uri = Uri.parse(redirectUrl);
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } catch (_) {
      emit(state.copyWith(
        paymentInitiating: false,
        paymentError: 'Nepodařilo se spustit platbu.',
      ));
    }
  }

  Future<void> _onCheckPaymentStatus(
    CheckPaymentStatus event,
    Emitter<OrdersState> emit,
  ) async {
    _stopPolling();
    _pollingOrderId = event.orderId;
    _pollCount = 0;

    _pollingTimer = Timer.periodic(const Duration(seconds: 3), (_) async {
      if (_pollCount >= _maxPollCount) {
        _stopPolling();
        return;
      }
      _pollCount++;
      add(OrdersEvent.checkPaymentStatus(orderId: event.orderId));
    });

    try {
      final status = await _getPaymentStatusUseCase(event.orderId);
      final updated = Map<String, String>.from(state.paymentStatuses)
        ..[event.orderId] = status;
      emit(state.copyWith(paymentStatuses: updated));

      if (status == 'PAID' || status == 'FAILED' || status == 'CANCELLED') {
        _stopPolling();
        add(const LoadCurrentOrders());
      }
    } catch (_) {}

  }

  void _stopPolling() {
    _pollingTimer?.cancel();
    _pollingTimer = null;
    _pollCount = 0;
    _pollingOrderId = null;
  }

  Future<void> _onLoadSession(
    LoadSession event,
    Emitter<OrdersState> emit,
  ) async {
    emit(state.copyWith(sessionLoading: true, sessionError: null));
    try {
      final data = await _remoteDataSource.getMySession();
      final session = _parseSession(data);
      emit(state.copyWith(sessionLoading: false, session: session));
    } on DioException catch (e) {
      if (e.response?.statusCode == 404) {
        emit(state.copyWith(sessionLoading: false, session: null));
      } else {
        emit(state.copyWith(
          sessionLoading: false,
          sessionError: 'Nepodařilo se načíst sezení.',
        ));
      }
    } catch (_) {
      emit(state.copyWith(
        sessionLoading: false,
        sessionError: 'Nepodařilo se načíst sezení.',
      ));
    }
  }

  Future<void> _onLoadSessionOrders(
    LoadSessionOrders event,
    Emitter<OrdersState> emit,
  ) async {
    final sessionId = state.session?.id ?? state.diningContext?.sessionId;
    if (sessionId == null) return;

    emit(state.copyWith(sessionLoading: true, sessionError: null));
    try {
      final ordersList = await _remoteDataSource.getSessionOrders(sessionId);
      final items = <SessionOrderItem>[];
      for (final order in ordersList) {
        final orderItems = (order['items'] as List?) ?? [];
        for (final item in orderItems) {
          items.add(_parseSessionOrderItem(item as Map<String, dynamic>,
              orderId: order['id'] as String? ?? ''));
        }
      }

      Map<String, dynamic>? summary;
      try {
        summary = await _remoteDataSource.getPaymentSummary(sessionId);
      } catch (_) {}

      emit(state.copyWith(
        sessionLoading: false,
        sessionItems: items,
        sessionTotalMinor: summary?['totalMinor'] as int? ?? 0,
        sessionPaidMinor: summary?['paidMinor'] as int? ?? 0,
        sessionRemainingMinor: summary?['remainingMinor'] as int? ?? 0,
      ));
    } catch (_) {
      emit(state.copyWith(
        sessionLoading: false,
        sessionError: 'Nepodařilo se načíst položky sezení.',
      ));
    }
  }

  void _onToggleItemSelection(
    ToggleItemSelection event,
    Emitter<OrdersState> emit,
  ) {
    final item = state.sessionItems.firstWhere(
      (i) => i.id == event.itemId,
      orElse: () => throw StateError('Item not found'),
    );
    if (item.isPaid || item.isPaying) return;

    final updated = Set<String>.from(state.selectedItemIds);
    if (updated.contains(event.itemId)) {
      updated.remove(event.itemId);
    } else {
      updated.add(event.itemId);
    }
    emit(state.copyWith(selectedItemIds: updated));
  }

  void _onSelectAllMyItems(
    SelectAllMyItems event,
    Emitter<OrdersState> emit,
  ) {
    final myUnpaidIds = state.sessionItems
        .where((item) => item.isUnpaid)
        .map((item) => item.id)
        .toSet();
    emit(state.copyWith(selectedItemIds: myUnpaidIds));
  }

  Future<void> _onPaySelectedItems(
    PaySelectedItems event,
    Emitter<OrdersState> emit,
  ) async {
    if (state.selectedItemIds.isEmpty) return;

    emit(state.copyWith(paymentInitiating: true, paymentError: null));
    try {
      final result =
          await _remoteDataSource.payItems(state.selectedItemIds.toList());
      final redirectUrl = result['redirectUrl'] as String?;

      emit(state.copyWith(
        paymentInitiating: false,
        selectedItemIds: {},
      ));

      if (redirectUrl != null && redirectUrl.isNotEmpty) {
        final uri = Uri.parse(redirectUrl);
        await launchUrl(uri, mode: LaunchMode.externalApplication);
      }

      add(const OrdersEvent.loadSessionOrders());
    } catch (_) {
      emit(state.copyWith(
        paymentInitiating: false,
        paymentError: 'Nepodařilo se spustit platbu.',
      ));
    }
  }

  Future<void> _onJoinSession(
    JoinSession event,
    Emitter<OrdersState> emit,
  ) async {
    emit(state.copyWith(sessionJoining: true, sessionJoinError: null));
    try {
      final data = await _remoteDataSource.joinSession(event.inviteCode);
      final session = _parseSession(data);
      emit(state.copyWith(sessionJoining: false, session: session));
      add(const OrdersEvent.loadContext());
    } on DioException catch (e) {
      final message = switch (e.response?.statusCode) {
        404 => 'Sezení nebylo nalezeno.',
        409 => 'Ke stolu již patříte.',
        _ => 'Nepodařilo se připojit ke stolu.',
      };
      emit(state.copyWith(sessionJoining: false, sessionJoinError: message));
    } catch (_) {
      emit(state.copyWith(
        sessionJoining: false,
        sessionJoinError: 'Nepodařilo se připojit ke stolu.',
      ));
    }
  }

  Future<void> _onShowSessionQr(
    ShowSessionQr event,
    Emitter<OrdersState> emit,
  ) async {
    final sessionId = state.session?.id ?? state.diningContext?.sessionId;
    if (sessionId == null) return;
    try {
      final data = await _remoteDataSource.getSessionQr(sessionId);
      final inviteCode = data['inviteCode'] as String?;
      emit(state.copyWith(sessionInviteCode: inviteCode));
    } catch (_) {}
  }

  DiningSession _parseSession(Map<String, dynamic> data) {
    final membersRaw = (data['members'] as List?) ?? [];
    final members = membersRaw.map((m) {
      final map = m as Map<String, dynamic>;
      return SessionMember(
        userId: map['userId'] as int? ?? 0,
        firstName: map['firstName'] as String?,
        lastName: map['lastName'] as String?,
        joinedAt: DateTime.tryParse(map['joinedAt'] as String? ?? '') ??
            DateTime.now(),
      );
    }).toList();

    return DiningSession(
      id: data['id'] as String? ?? '',
      restaurantId: data['restaurantId'] as String? ?? '',
      tableId: data['tableId'] as String? ?? '',
      inviteCode: data['inviteCode'] as String? ?? '',
      status: data['status'] as String? ?? 'ACTIVE',
      members: members,
    );
  }

  SessionOrderItem _parseSessionOrderItem(
    Map<String, dynamic> data, {
    required String orderId,
  }) {
    return SessionOrderItem(
      id: data['id'] as String? ?? '',
      orderId: orderId,
      name: data['name'] as String? ?? '',
      unitPriceMinor: data['unitPriceMinor'] as int? ?? 0,
      quantity: data['quantity'] as int? ?? 1,
      orderedByUserId: data['orderedByUserId'] as int?,
      orderedByName: data['orderedByName'] as String?,
      paidByUserId: data['paidByUserId'] as int?,
      paidByName: data['paidByName'] as String?,
      paymentStatus: data['itemPaymentStatus'] as String? ?? 'UNPAID',
    );
  }
}
