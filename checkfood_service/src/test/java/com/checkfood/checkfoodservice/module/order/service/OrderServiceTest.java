package com.checkfood.checkfoodservice.module.order.service;

import com.checkfood.checkfoodservice.client.payment.MoonePaymentService;
import com.checkfood.checkfoodservice.module.order.dining.dto.response.DiningContextResponse;
import com.checkfood.checkfoodservice.module.order.dining.service.DiningContextService;
import com.checkfood.checkfoodservice.module.order.dto.request.CreateOrderRequest;
import com.checkfood.checkfoodservice.module.order.dto.request.OrderItemRequest;
import com.checkfood.checkfoodservice.module.order.dto.response.OrderPaymentStatusResponse;
import com.checkfood.checkfoodservice.module.order.dto.response.OrderResponse;
import com.checkfood.checkfoodservice.module.order.entity.Order;
import com.checkfood.checkfoodservice.module.order.entity.ItemPaymentStatus;
import com.checkfood.checkfoodservice.module.order.entity.OrderItem;
import com.checkfood.checkfoodservice.module.order.entity.OrderStatus;
import com.checkfood.checkfoodservice.module.order.entity.PaymentStatus;
import com.checkfood.checkfoodservice.module.order.exception.OrderException;
import com.checkfood.checkfoodservice.module.order.logging.OrderLogger;
import com.checkfood.checkfoodservice.module.order.repository.OrderRepository;
import com.checkfood.checkfoodservice.module.restaurant.menu.entity.MenuItem;
import com.checkfood.checkfoodservice.module.restaurant.menu.repository.MenuItemRepository;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Nested;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.ArgumentCaptor;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;
import org.springframework.http.HttpStatus;

import java.time.LocalDateTime;
import java.util.*;

import static org.assertj.core.api.Assertions.assertThat;
import static org.assertj.core.api.Assertions.assertThatThrownBy;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.BDDMockito.given;
import static org.mockito.Mockito.*;

@ExtendWith(MockitoExtension.class)
@DisplayName("OrderService unit tests")
class OrderServiceTest {

    @Mock private OrderRepository orderRepository;
    @Mock private MenuItemRepository menuItemRepository;
    @Mock private DiningContextService diningContextService;
    @Mock private OrderLogger orderLogger;
    @Mock private MoonePaymentService moonePaymentService;

    @InjectMocks
    private OrderServiceImpl orderService;

    private static final Long USER_ID = 42L;
    private static final UUID RESTAURANT_ID = UUID.randomUUID();
    private static final UUID TABLE_ID = UUID.randomUUID();
    private static final UUID RESERVATION_ID = UUID.randomUUID();
    private static final UUID SESSION_ID = UUID.randomUUID();
    private static final UUID MENU_ITEM_ID = UUID.randomUUID();
    private static final UUID ORDER_ID = UUID.randomUUID();

    private DiningContextResponse activeDiningContext;
    private MenuItem availableMenuItem;

    @BeforeEach
    void setUp() {
        activeDiningContext = DiningContextResponse.builder()
                .restaurantId(RESTAURANT_ID)
                .tableId(TABLE_ID)
                .reservationId(RESERVATION_ID)
                .sessionId(SESSION_ID)
                .contextType("SESSION")
                .restaurantName("Test Restaurant")
                .tableLabel("Table 1")
                .build();

        availableMenuItem = MenuItem.builder()
                .id(MENU_ITEM_ID)
                .restaurantId(RESTAURANT_ID)
                .name("Svickova")
                .priceMinor(25000)
                .available(true)
                .build();
    }

    // =========================================================================
    // createOrder
    // =========================================================================

    @Nested
    @DisplayName("createOrder")
    class CreateOrder {

        @Test
        @DisplayName("happy path — single item, correct total computed server-side")
        void should_createOrder_when_validRequest() {
            OrderItemRequest itemReq = new OrderItemRequest(MENU_ITEM_ID, 2);
            CreateOrderRequest request = new CreateOrderRequest(List.of(itemReq), "extra sauce");

            given(diningContextService.getActiveDiningContext(USER_ID)).willReturn(activeDiningContext);
            given(menuItemRepository.findAllByIdIn(any())).willReturn(List.of(availableMenuItem));

            Order savedOrder = buildOrder(50000, List.of(buildOrderItem(MENU_ITEM_ID, 25000, 2)));
            given(orderRepository.save(any())).willReturn(savedOrder);

            OrderResponse response = orderService.createOrder(request, USER_ID);

            assertThat(response).isNotNull();
            assertThat(response.getTotalPriceMinor()).isEqualTo(50000);
            assertThat(response.getItems()).hasSize(1);
        }

        @Test
        @DisplayName("total is sum of unitPrice * quantity for multiple items")
        void should_sumTotalCorrectly_forMultipleItems() {
            UUID id2 = UUID.randomUUID();
            MenuItem item2 = MenuItem.builder()
                    .id(id2).restaurantId(RESTAURANT_ID)
                    .name("Pivo").priceMinor(6000).available(true).build();

            OrderItemRequest req1 = new OrderItemRequest(MENU_ITEM_ID, 1);
            OrderItemRequest req2 = new OrderItemRequest(id2, 3);
            CreateOrderRequest request = new CreateOrderRequest(List.of(req1, req2), null);

            given(diningContextService.getActiveDiningContext(USER_ID)).willReturn(activeDiningContext);
            given(menuItemRepository.findAllByIdIn(any())).willReturn(List.of(availableMenuItem, item2));

            Order savedOrder = buildOrder(43000,
                    List.of(buildOrderItem(MENU_ITEM_ID, 25000, 1), buildOrderItem(id2, 6000, 3)));
            given(orderRepository.save(any())).willReturn(savedOrder);

            OrderResponse response = orderService.createOrder(request, USER_ID);

            // 25000 * 1 + 6000 * 3 = 43000
            assertThat(response.getTotalPriceMinor()).isEqualTo(43000);
        }

        @Test
        @DisplayName("throws 404 when menu item id not found in DB")
        void should_throw404_when_menuItemNotFound() {
            OrderItemRequest itemReq = new OrderItemRequest(MENU_ITEM_ID, 1);
            CreateOrderRequest request = new CreateOrderRequest(List.of(itemReq), null);

            given(diningContextService.getActiveDiningContext(USER_ID)).willReturn(activeDiningContext);
            given(menuItemRepository.findAllByIdIn(any())).willReturn(List.of()); // empty — item not found

            assertThatThrownBy(() -> orderService.createOrder(request, USER_ID))
                    .isInstanceOf(OrderException.class)
                    .satisfies(ex -> assertThat(((OrderException) ex).getStatus()).isEqualTo(HttpStatus.NOT_FOUND));
        }

        @Test
        @DisplayName("throws 409 when menu item is unavailable")
        void should_throw409_when_menuItemUnavailable() {
            MenuItem unavailable = MenuItem.builder()
                    .id(MENU_ITEM_ID).restaurantId(RESTAURANT_ID)
                    .name("Sold Out").priceMinor(10000).available(false).build();

            OrderItemRequest itemReq = new OrderItemRequest(MENU_ITEM_ID, 1);
            CreateOrderRequest request = new CreateOrderRequest(List.of(itemReq), null);

            given(diningContextService.getActiveDiningContext(USER_ID)).willReturn(activeDiningContext);
            given(menuItemRepository.findAllByIdIn(any())).willReturn(List.of(unavailable));

            assertThatThrownBy(() -> orderService.createOrder(request, USER_ID))
                    .isInstanceOf(OrderException.class)
                    .satisfies(ex -> assertThat(((OrderException) ex).getStatus()).isEqualTo(HttpStatus.CONFLICT));
        }

        @Test
        @DisplayName("throws 409 when menu item belongs to different restaurant")
        void should_throw409_when_menuItemWrongRestaurant() {
            MenuItem wrongRestaurant = MenuItem.builder()
                    .id(MENU_ITEM_ID).restaurantId(UUID.randomUUID()) // different restaurant
                    .name("Foreign").priceMinor(10000).available(true).build();

            OrderItemRequest itemReq = new OrderItemRequest(MENU_ITEM_ID, 1);
            CreateOrderRequest request = new CreateOrderRequest(List.of(itemReq), null);

            given(diningContextService.getActiveDiningContext(USER_ID)).willReturn(activeDiningContext);
            given(menuItemRepository.findAllByIdIn(any())).willReturn(List.of(wrongRestaurant));

            assertThatThrownBy(() -> orderService.createOrder(request, USER_ID))
                    .isInstanceOf(OrderException.class)
                    .satisfies(ex -> assertThat(((OrderException) ex).getStatus()).isEqualTo(HttpStatus.CONFLICT));
        }

        @Test
        @DisplayName("throws when no active dining context")
        void should_throwException_when_noDiningContext() {
            CreateOrderRequest request = new CreateOrderRequest(
                    List.of(new OrderItemRequest(MENU_ITEM_ID, 1)), null);

            given(diningContextService.getActiveDiningContext(USER_ID))
                    .willThrow(OrderException.noDiningContext());

            assertThatThrownBy(() -> orderService.createOrder(request, USER_ID))
                    .isInstanceOf(OrderException.class);
        }

        @Test
        @DisplayName("order is persisted with status CONFIRMED, not PENDING")
        void should_persistOrderWithConfirmedStatus() {
            OrderItemRequest itemReq = new OrderItemRequest(MENU_ITEM_ID, 1);
            CreateOrderRequest request = new CreateOrderRequest(List.of(itemReq), null);

            given(diningContextService.getActiveDiningContext(USER_ID)).willReturn(activeDiningContext);
            given(menuItemRepository.findAllByIdIn(any())).willReturn(List.of(availableMenuItem));

            Order savedOrder = buildOrder(25000, List.of(buildOrderItem(MENU_ITEM_ID, 25000, 1)));
            given(orderRepository.save(any())).willReturn(savedOrder);

            orderService.createOrder(request, USER_ID);

            ArgumentCaptor<Order> captor = ArgumentCaptor.forClass(Order.class);
            verify(orderRepository).save(captor.capture());
            assertThat(captor.getValue().getStatus()).isEqualTo(OrderStatus.CONFIRMED);
        }

        @Test
        @DisplayName("currency is always CZK in created order")
        void should_setCurrencyCZK() {
            OrderItemRequest itemReq = new OrderItemRequest(MENU_ITEM_ID, 1);
            CreateOrderRequest request = new CreateOrderRequest(List.of(itemReq), null);

            given(diningContextService.getActiveDiningContext(USER_ID)).willReturn(activeDiningContext);
            given(menuItemRepository.findAllByIdIn(any())).willReturn(List.of(availableMenuItem));

            Order savedOrder = buildOrder(25000, List.of(buildOrderItem(MENU_ITEM_ID, 25000, 1)));
            given(orderRepository.save(any())).willReturn(savedOrder);

            OrderResponse response = orderService.createOrder(request, USER_ID);

            assertThat(response.getCurrency()).isEqualTo("CZK");
        }

        @Test
        @DisplayName("note is persisted on order when provided")
        void should_persistNote() {
            OrderItemRequest itemReq = new OrderItemRequest(MENU_ITEM_ID, 1);
            CreateOrderRequest request = new CreateOrderRequest(List.of(itemReq), "no onions please");

            given(diningContextService.getActiveDiningContext(USER_ID)).willReturn(activeDiningContext);
            given(menuItemRepository.findAllByIdIn(any())).willReturn(List.of(availableMenuItem));

            Order savedOrder = buildOrder(25000, List.of(buildOrderItem(MENU_ITEM_ID, 25000, 1)));
            savedOrder.setNote("no onions please");
            given(orderRepository.save(any())).willReturn(savedOrder);

            OrderResponse response = orderService.createOrder(request, USER_ID);

            assertThat(response.getNote()).isEqualTo("no onions please");
        }

        @Test
        @DisplayName("quantity=99 (max boundary) is accepted")
        void should_acceptMaxQuantity() {
            OrderItemRequest itemReq = new OrderItemRequest(MENU_ITEM_ID, 99);
            CreateOrderRequest request = new CreateOrderRequest(List.of(itemReq), null);

            given(diningContextService.getActiveDiningContext(USER_ID)).willReturn(activeDiningContext);
            given(menuItemRepository.findAllByIdIn(any())).willReturn(List.of(availableMenuItem));

            int expectedTotal = 25000 * 99;
            Order savedOrder = buildOrder(expectedTotal, List.of(buildOrderItem(MENU_ITEM_ID, 25000, 99)));
            given(orderRepository.save(any())).willReturn(savedOrder);

            OrderResponse response = orderService.createOrder(request, USER_ID);

            assertThat(response.getTotalPriceMinor()).isEqualTo(expectedTotal);
        }
    }

    // =========================================================================
    // getOrderDetail
    // =========================================================================

    @Nested
    @DisplayName("getOrderDetail")
    class GetOrderDetail {

        @Test
        @DisplayName("returns order when caller is the owner")
        void should_returnOrder_when_ownerRequests() {
            Order order = buildOrder(25000, List.of());
            order.setUserId(USER_ID);
            given(orderRepository.findById(ORDER_ID)).willReturn(Optional.of(order));

            OrderResponse response = orderService.getOrderDetail(ORDER_ID, USER_ID);

            assertThat(response).isNotNull();
        }

        @Test
        @DisplayName("throws 404 when order does not exist")
        void should_throw404_when_orderNotFound() {
            given(orderRepository.findById(ORDER_ID)).willReturn(Optional.empty());

            assertThatThrownBy(() -> orderService.getOrderDetail(ORDER_ID, USER_ID))
                    .isInstanceOf(OrderException.class)
                    .satisfies(ex -> assertThat(((OrderException) ex).getStatus()).isEqualTo(HttpStatus.NOT_FOUND));
        }

        @Test
        @DisplayName("throws 403 when caller is not the owner")
        void should_throw403_when_callerIsNotOwner() {
            Order order = buildOrder(25000, List.of());
            order.setUserId(999L); // different user
            given(orderRepository.findById(ORDER_ID)).willReturn(Optional.of(order));

            assertThatThrownBy(() -> orderService.getOrderDetail(ORDER_ID, USER_ID))
                    .isInstanceOf(OrderException.class)
                    .satisfies(ex -> assertThat(((OrderException) ex).getStatus()).isEqualTo(HttpStatus.FORBIDDEN));
        }
    }

    // =========================================================================
    // getCurrentOrders
    // =========================================================================

    @Nested
    @DisplayName("getCurrentOrders")
    class GetCurrentOrders {

        @Test
        @DisplayName("returns empty list when no active dining context")
        void should_returnEmptyList_when_noDiningContext() {
            given(diningContextService.findActiveDiningContext(USER_ID)).willReturn(Optional.empty());

            List<?> result = orderService.getCurrentOrders(USER_ID);

            assertThat(result).isEmpty();
        }

        @Test
        @DisplayName("queries by reservationId when context has a reservation")
        void should_queryByReservationId_when_contextHasReservation() {
            given(diningContextService.findActiveDiningContext(USER_ID))
                    .willReturn(Optional.of(activeDiningContext));
            given(orderRepository.findAllByUserIdAndReservationIdAndStatusNotOrderByCreatedAtDesc(
                    USER_ID, RESERVATION_ID, OrderStatus.CANCELLED))
                    .willReturn(List.of(buildOrder(10000, List.of())));

            List<?> result = orderService.getCurrentOrders(USER_ID);

            assertThat(result).hasSize(1);
            verify(orderRepository).findAllByUserIdAndReservationIdAndStatusNotOrderByCreatedAtDesc(
                    USER_ID, RESERVATION_ID, OrderStatus.CANCELLED);
        }

        @Test
        @DisplayName("queries by restaurantId when context has no reservation")
        void should_queryByRestaurantId_when_noReservation() {
            DiningContextResponse noReservationContext = DiningContextResponse.builder()
                    .restaurantId(RESTAURANT_ID)
                    .tableId(TABLE_ID)
                    .reservationId(null) // no reservation
                    .build();

            given(diningContextService.findActiveDiningContext(USER_ID))
                    .willReturn(Optional.of(noReservationContext));
            given(orderRepository.findAllByUserIdAndRestaurantIdAndStatusNotOrderByCreatedAtDesc(
                    USER_ID, RESTAURANT_ID, OrderStatus.CANCELLED))
                    .willReturn(List.of());

            orderService.getCurrentOrders(USER_ID);

            verify(orderRepository).findAllByUserIdAndRestaurantIdAndStatusNotOrderByCreatedAtDesc(
                    USER_ID, RESTAURANT_ID, OrderStatus.CANCELLED);
        }
    }

    // =========================================================================
    // initiatePayment
    // =========================================================================

    @Nested
    @DisplayName("initiatePayment")
    class InitiatePayment {

        @Test
        @DisplayName("happy path — stores transactionId and redirectUrl")
        void should_storeTransactionIdAndRedirectUrl() {
            Order order = buildOrder(25000, List.of());
            order.setUserId(USER_ID);
            order.setPaymentStatus(PaymentStatus.NONE);
            given(orderRepository.findById(ORDER_ID)).willReturn(Optional.of(order));
            given(moonePaymentService.initiateTransaction(25000, "CZK"))
                    .willReturn(new MoonePaymentService.MooneTransactionResult("tx-123", "https://pay.example/tx-123"));
            given(orderRepository.save(any())).willAnswer(inv -> inv.getArgument(0));

            OrderResponse response = orderService.initiatePayment(ORDER_ID, USER_ID);

            assertThat(response.getPaymentTransactionId()).isEqualTo("tx-123");
            assertThat(response.getPaymentRedirectUrl()).isEqualTo("https://pay.example/tx-123");
            assertThat(response.getPaymentStatus()).isEqualTo(PaymentStatus.INITIATED);
        }

        @Test
        @DisplayName("throws 409 when order is already PAID — double-payment prevented")
        void should_throw409_when_alreadyPaid() {
            Order order = buildOrder(25000, List.of());
            order.setUserId(USER_ID);
            order.setPaymentStatus(PaymentStatus.PAID);
            given(orderRepository.findById(ORDER_ID)).willReturn(Optional.of(order));

            assertThatThrownBy(() -> orderService.initiatePayment(ORDER_ID, USER_ID))
                    .isInstanceOf(OrderException.class)
                    .satisfies(ex -> assertThat(((OrderException) ex).getStatus()).isEqualTo(HttpStatus.CONFLICT));
        }

        @Test
        @DisplayName("idempotent — returns existing order when payment INITIATED")
        void should_returnExistingOrder_when_paymentAlreadyInitiated() {
            Order order = buildOrder(25000, List.of());
            order.setUserId(USER_ID);
            order.setPaymentStatus(PaymentStatus.INITIATED);
            order.setPaymentTransactionId("existing-tx");
            given(orderRepository.findById(ORDER_ID)).willReturn(Optional.of(order));

            OrderResponse response = orderService.initiatePayment(ORDER_ID, USER_ID);

            assertThat(response.getPaymentTransactionId()).isEqualTo("existing-tx");
            verify(moonePaymentService, never()).initiateTransaction(anyInt(), anyString());
        }

        @Test
        @DisplayName("idempotent — returns existing order when payment PROCESSING")
        void should_returnExistingOrder_when_paymentProcessing() {
            Order order = buildOrder(25000, List.of());
            order.setUserId(USER_ID);
            order.setPaymentStatus(PaymentStatus.PROCESSING);
            given(orderRepository.findById(ORDER_ID)).willReturn(Optional.of(order));

            orderService.initiatePayment(ORDER_ID, USER_ID);

            verify(moonePaymentService, never()).initiateTransaction(anyInt(), anyString());
        }

        @Test
        @DisplayName("throws 404 when order not found")
        void should_throw404_when_orderNotFound() {
            given(orderRepository.findById(ORDER_ID)).willReturn(Optional.empty());

            assertThatThrownBy(() -> orderService.initiatePayment(ORDER_ID, USER_ID))
                    .isInstanceOf(OrderException.class)
                    .satisfies(ex -> assertThat(((OrderException) ex).getStatus()).isEqualTo(HttpStatus.NOT_FOUND));
        }

        @Test
        @DisplayName("throws 403 when caller is not owner")
        void should_throw403_when_callerNotOwner() {
            Order order = buildOrder(25000, List.of());
            order.setUserId(999L);
            given(orderRepository.findById(ORDER_ID)).willReturn(Optional.of(order));

            assertThatThrownBy(() -> orderService.initiatePayment(ORDER_ID, USER_ID))
                    .isInstanceOf(OrderException.class)
                    .satisfies(ex -> assertThat(((OrderException) ex).getStatus()).isEqualTo(HttpStatus.FORBIDDEN));
        }

        @Test
        @DisplayName("throws 502 when Moone throws exception")
        void should_throw502_when_mooneThrows() {
            Order order = buildOrder(25000, List.of());
            order.setUserId(USER_ID);
            order.setPaymentStatus(PaymentStatus.NONE);
            given(orderRepository.findById(ORDER_ID)).willReturn(Optional.of(order));
            given(moonePaymentService.initiateTransaction(anyInt(), anyString()))
                    .willThrow(new IllegalStateException("Moone down"));

            assertThatThrownBy(() -> orderService.initiatePayment(ORDER_ID, USER_ID))
                    .isInstanceOf(OrderException.class)
                    .satisfies(ex -> assertThat(((OrderException) ex).getStatus()).isEqualTo(HttpStatus.BAD_GATEWAY));
        }

        @Test
        @DisplayName("FAILED payment can be re-initiated (not blocked like PAID)")
        void should_allowReinitiatePayment_when_previousPaymentFailed() {
            Order order = buildOrder(25000, List.of());
            order.setUserId(USER_ID);
            order.setPaymentStatus(PaymentStatus.FAILED);
            given(orderRepository.findById(ORDER_ID)).willReturn(Optional.of(order));
            given(moonePaymentService.initiateTransaction(25000, "CZK"))
                    .willReturn(new MoonePaymentService.MooneTransactionResult("new-tx", "https://pay.example/new"));
            given(orderRepository.save(any())).willAnswer(inv -> inv.getArgument(0));

            OrderResponse response = orderService.initiatePayment(ORDER_ID, USER_ID);

            assertThat(response.getPaymentTransactionId()).isEqualTo("new-tx");
        }
    }

    // =========================================================================
    // getPaymentStatus
    // =========================================================================

    @Nested
    @DisplayName("getPaymentStatus")
    class GetPaymentStatus {

        @Test
        @DisplayName("returns status and transactionId for owner")
        void should_returnStatus_when_ownerRequests() {
            Order order = buildOrder(25000, List.of());
            order.setUserId(USER_ID);
            order.setPaymentStatus(PaymentStatus.INITIATED);
            order.setPaymentTransactionId("tx-999");
            given(orderRepository.findById(ORDER_ID)).willReturn(Optional.of(order));

            OrderPaymentStatusResponse response = orderService.getPaymentStatus(ORDER_ID, USER_ID);

            assertThat(response.getPaymentStatus()).isEqualTo(PaymentStatus.INITIATED);
            assertThat(response.getPaymentTransactionId()).isEqualTo("tx-999");
        }

        @Test
        @DisplayName("throws 403 when non-owner polls payment status")
        void should_throw403_when_nonOwnerPolls() {
            Order order = buildOrder(25000, List.of());
            order.setUserId(999L);
            given(orderRepository.findById(ORDER_ID)).willReturn(Optional.of(order));

            assertThatThrownBy(() -> orderService.getPaymentStatus(ORDER_ID, USER_ID))
                    .isInstanceOf(OrderException.class)
                    .satisfies(ex -> assertThat(((OrderException) ex).getStatus()).isEqualTo(HttpStatus.FORBIDDEN));
        }
    }

    // =========================================================================
    // handlePaymentCallback
    // =========================================================================

    @Nested
    @DisplayName("handlePaymentCallback")
    class HandlePaymentCallback {

        @Test
        @DisplayName("updates order status from Moone callback with publicID key")
        void should_updateStatus_when_callbackContainsPublicID() {
            Order order = buildOrder(25000, List.of());
            order.setPaymentStatus(PaymentStatus.INITIATED);
            given(orderRepository.findByPaymentTransactionId("tx-abc")).willReturn(Optional.of(order));
            given(moonePaymentService.getTransactionStatus("tx-abc")).willReturn(PaymentStatus.PAID);
            given(orderRepository.save(any())).willAnswer(inv -> inv.getArgument(0));

            orderService.handlePaymentCallback(Map.of("publicID", "tx-abc"));

            ArgumentCaptor<Order> captor = ArgumentCaptor.forClass(Order.class);
            verify(orderRepository).save(captor.capture());
            assertThat(captor.getValue().getPaymentStatus()).isEqualTo(PaymentStatus.PAID);
        }

        @Test
        @DisplayName("accepts transactionId key as fallback")
        void should_acceptTransactionIdKey() {
            Order order = buildOrder(25000, List.of());
            given(orderRepository.findByPaymentTransactionId("tx-xyz")).willReturn(Optional.of(order));
            given(moonePaymentService.getTransactionStatus("tx-xyz")).willReturn(PaymentStatus.PAID);
            given(orderRepository.save(any())).willAnswer(inv -> inv.getArgument(0));

            orderService.handlePaymentCallback(Map.of("transactionId", "tx-xyz"));

            verify(orderRepository).save(any());
        }

        @Test
        @DisplayName("accepts id key as fallback")
        void should_acceptIdKey() {
            Order order = buildOrder(25000, List.of());
            given(orderRepository.findByPaymentTransactionId("tx-id")).willReturn(Optional.of(order));
            given(moonePaymentService.getTransactionStatus("tx-id")).willReturn(PaymentStatus.PAID);
            given(orderRepository.save(any())).willAnswer(inv -> inv.getArgument(0));

            orderService.handlePaymentCallback(Map.of("id", "tx-id"));

            verify(orderRepository).save(any());
        }

        @Test
        @DisplayName("does nothing silently when payload has no transactionId")
        void should_doNothing_when_noTransactionIdInPayload() {
            orderService.handlePaymentCallback(Map.of("unrelated", "data"));

            verify(orderRepository, never()).findByPaymentTransactionId(any());
        }

        @Test
        @DisplayName("does nothing when transactionId not found in DB (no crash)")
        void should_handleMissingOrder_gracefully() {
            given(orderRepository.findByPaymentTransactionId("unknown")).willReturn(Optional.empty());

            orderService.handlePaymentCallback(Map.of("publicID", "unknown"));

            verify(orderRepository, never()).save(any());
        }
    }

    // =========================================================================
    // getSessionPaymentSummary — split bill math
    // =========================================================================

    @Nested
    @DisplayName("getSessionPaymentSummary — split bill math")
    class SessionPaymentSummary {

        @Test
        @DisplayName("sum of items equals reported total")
        void should_sumItemsEqualTotal() {
            Order order = buildOrder(0, List.of(
                    buildOrderItem(UUID.randomUUID(), 10000, 2),
                    buildOrderItem(UUID.randomUUID(), 5000, 1)
            ));
            order.setSessionId(SESSION_ID);
            given(orderRepository.findAllBySessionIdAndStatusNot(SESSION_ID, OrderStatus.CANCELLED))
                    .willReturn(List.of(order));

            Map<String, Object> summary = orderService.getSessionPaymentSummary(SESSION_ID);

            assertThat(summary.get("totalMinor")).isEqualTo(25000); // 10000*2 + 5000*1
        }

        @Test
        @DisplayName("paidMinor counts only PAID items")
        void should_countOnlyPaidItems() {
            ItemPaymentStatus paid = ItemPaymentStatus.PAID;

            OrderItem paidItem = buildOrderItem(UUID.randomUUID(), 10000, 1);
            paidItem.setItemPaymentStatus(paid);
            OrderItem unpaidItem = buildOrderItem(UUID.randomUUID(), 5000, 1);

            Order order = buildOrder(0, List.of(paidItem, unpaidItem));
            given(orderRepository.findAllBySessionIdAndStatusNot(SESSION_ID, OrderStatus.CANCELLED))
                    .willReturn(List.of(order));

            Map<String, Object> summary = orderService.getSessionPaymentSummary(SESSION_ID);

            assertThat(summary.get("paidMinor")).isEqualTo(10000);
            assertThat(summary.get("remainingMinor")).isEqualTo(5000);
        }

        @Test
        @DisplayName("remainingMinor = totalMinor - paidMinor, never negative for valid state")
        void should_computeRemainingCorrectly() {
            Order order = buildOrder(0, List.of(buildOrderItem(UUID.randomUUID(), 10000, 3)));
            given(orderRepository.findAllBySessionIdAndStatusNot(SESSION_ID, OrderStatus.CANCELLED))
                    .willReturn(List.of(order));

            Map<String, Object> summary = orderService.getSessionPaymentSummary(SESSION_ID);

            int total = (int) summary.get("totalMinor");
            int paid = (int) summary.get("paidMinor");
            int remaining = (int) summary.get("remainingMinor");

            assertThat(remaining).isEqualTo(total - paid);
            assertThat(remaining).isGreaterThanOrEqualTo(0);
        }

        @Test
        @DisplayName("empty session returns all zeros")
        void should_returnZeros_when_sessionEmpty() {
            given(orderRepository.findAllBySessionIdAndStatusNot(SESSION_ID, OrderStatus.CANCELLED))
                    .willReturn(List.of());

            Map<String, Object> summary = orderService.getSessionPaymentSummary(SESSION_ID);

            assertThat(summary.get("totalMinor")).isEqualTo(0);
            assertThat(summary.get("paidMinor")).isEqualTo(0);
            assertThat(summary.get("remainingMinor")).isEqualTo(0);
        }

        @Test
        @DisplayName("items list in summary contains one entry per order item")
        void should_listAllItems_inSummaryResponse() {
            Order order = buildOrder(0, List.of(
                    buildOrderItem(UUID.randomUUID(), 10000, 1),
                    buildOrderItem(UUID.randomUUID(), 5000, 2)
            ));
            given(orderRepository.findAllBySessionIdAndStatusNot(SESSION_ID, OrderStatus.CANCELLED))
                    .willReturn(List.of(order));

            Map<String, Object> summary = orderService.getSessionPaymentSummary(SESSION_ID);

            @SuppressWarnings("unchecked")
            var items = (List<Map<String, Object>>) summary.get("items");
            assertThat(items).hasSize(2);
        }
    }

    // =========================================================================
    // Helpers
    // =========================================================================

    private Order buildOrder(int totalPriceMinor, List<OrderItem> items) {
        Order order = Order.builder()
                .id(ORDER_ID)
                .userId(USER_ID)
                .restaurantId(RESTAURANT_ID)
                .tableId(TABLE_ID)
                .reservationId(RESERVATION_ID)
                .sessionId(SESSION_ID)
                .status(OrderStatus.CONFIRMED)
                .totalPriceMinor(totalPriceMinor)
                .currency("CZK")
                .paymentStatus(PaymentStatus.NONE)
                .createdAt(LocalDateTime.now())
                .build();
        for (OrderItem item : items) {
            order.addItem(item);
        }
        return order;
    }

    private OrderItem buildOrderItem(UUID menuItemId, int unitPrice, int qty) {
        OrderItem item = OrderItem.builder()
                .id(UUID.randomUUID())
                .menuItemId(menuItemId)
                .itemName("Item " + menuItemId)
                .unitPriceMinor(unitPrice)
                .quantity(qty)
                .itemPaymentStatus(ItemPaymentStatus.UNPAID)
                .build();
        return item;
    }
}
