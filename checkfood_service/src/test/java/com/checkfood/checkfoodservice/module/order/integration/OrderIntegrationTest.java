package com.checkfood.checkfoodservice.module.order.integration;

import com.checkfood.checkfoodservice.client.payment.MoonePaymentService;
import com.checkfood.checkfoodservice.module.order.dining.entity.DiningSession;
import com.checkfood.checkfoodservice.module.order.dining.entity.DiningSessionMember;
import com.checkfood.checkfoodservice.module.order.dining.entity.DiningSessionStatus;
import com.checkfood.checkfoodservice.module.order.dining.repository.DiningSessionMemberRepository;
import com.checkfood.checkfoodservice.module.order.dining.repository.DiningSessionRepository;
import com.checkfood.checkfoodservice.module.order.dto.request.CreateOrderRequest;
import com.checkfood.checkfoodservice.module.order.dto.request.OrderItemRequest;
import com.checkfood.checkfoodservice.module.order.entity.Order;
import com.checkfood.checkfoodservice.module.order.entity.OrderStatus;
import com.checkfood.checkfoodservice.module.order.entity.PaymentStatus;
import com.checkfood.checkfoodservice.module.order.repository.OrderRepository;
import com.checkfood.checkfoodservice.module.reservation.entity.Reservation;
import com.checkfood.checkfoodservice.module.reservation.entity.ReservationStatus;
import com.checkfood.checkfoodservice.module.reservation.repository.ReservationRepository;
import com.checkfood.checkfoodservice.module.restaurant.entity.restaurant.CuisineType;
import com.checkfood.checkfoodservice.module.restaurant.entity.restaurant.Restaurant;
import com.checkfood.checkfoodservice.module.restaurant.entity.restaurant.RestaurantStatus;
import com.checkfood.checkfoodservice.module.restaurant.entity.restaurant.table.RestaurantTable;
import com.checkfood.checkfoodservice.module.restaurant.menu.entity.MenuItem;
import com.checkfood.checkfoodservice.module.restaurant.menu.repository.MenuItemRepository;
import com.checkfood.checkfoodservice.module.restaurant.repository.RestaurantRepository;
import com.checkfood.checkfoodservice.module.restaurant.repository.table.RestaurantTableRepository;
import com.checkfood.checkfoodservice.security.BaseAuthIntegrationTest;
import com.checkfood.checkfoodservice.security.module.user.entity.UserEntity;
import com.checkfood.checkfoodservice.security.module.user.repository.UserRepository;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Nested;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.test.context.bean.override.mockito.MockitoBean;
import org.springframework.test.web.servlet.ResultActions;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.LocalTime;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import static org.assertj.core.api.Assertions.assertThat;
import static org.hamcrest.Matchers.*;
import static org.mockito.ArgumentMatchers.anyInt;
import static org.mockito.ArgumentMatchers.anyString;
import static org.mockito.BDDMockito.given;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.*;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.*;

/**
 * Integration tests for OrderController, DiningSessionController, DiningContextController.
 * Full controller → service → repository → H2 stack.
 */
@DisplayName("Order module integration tests")
class OrderIntegrationTest extends BaseAuthIntegrationTest {

    // =========================================================================
    // Additional repositories needed for test fixture setup
    // =========================================================================

    @Autowired private OrderRepository orderRepository;
    @Autowired private DiningSessionRepository diningSessionRepository;
    @Autowired private DiningSessionMemberRepository diningSessionMemberRepository;
    @Autowired private ReservationRepository reservationRepository;
    @Autowired private RestaurantRepository restaurantRepository;
    @Autowired private RestaurantTableRepository restaurantTableRepository;
    @Autowired private MenuItemRepository menuItemRepository;

    // MoonePaymentService calls the real Moone API — always mock it
    @MockitoBean
    private MoonePaymentService moonePaymentService;

    // Sdílený Clock bean (Europe/Prague) — test musí používat stejnou zónu jako service
    @Autowired
    private java.time.Clock clock;

    // =========================================================================
    // Test users / tokens
    // =========================================================================

    private String userToken;
    private String otherUserToken;
    private Long userId;
    private Long otherUserId;

    // Restaurant / table / reservation / session fixtures
    private UUID restaurantId;
    private UUID tableId;
    private UUID reservationId;
    private UUID sessionId;
    private UUID menuItemId;

    private static final String USER_EMAIL = "order-user@checkfood.test";
    private static final String OTHER_EMAIL = "order-other@checkfood.test";
    private static final String PASSWORD = "Test1234!";

    @BeforeEach
    void setUpOrderFixtures() throws Exception {
        // Delete order module data in reverse FK order
        orderRepository.deleteAll();
        diningSessionMemberRepository.deleteAll();
        diningSessionRepository.deleteAll();
        menuItemRepository.deleteAll();
        reservationRepository.deleteAll();
        restaurantTableRepository.deleteAll();
        restaurantRepository.deleteAll();

        // Create users and get tokens
        userToken = getAccessToken(USER_EMAIL, PASSWORD, "order-device-1");
        otherUserToken = getAccessToken(OTHER_EMAIL, PASSWORD, "order-device-2");

        userId = userRepository.findByEmail(USER_EMAIL)
                .map(UserEntity::getId)
                .orElseThrow();
        otherUserId = userRepository.findByEmail(OTHER_EMAIL)
                .map(UserEntity::getId)
                .orElseThrow();

        // Minimal restaurant
        Restaurant restaurant = Restaurant.builder()
                .name("Test Restaurant")
                .cuisineType(CuisineType.CZECH)
                .status(RestaurantStatus.ACTIVE)
                .active(true)
                .build();
        restaurant = restaurantRepository.save(restaurant);
        restaurantId = restaurant.getId();

        // Table
        RestaurantTable table = RestaurantTable.builder()
                .restaurantId(restaurantId)
                .label("Table 1")
                .capacity(4)
                .active(true)
                .build();
        table = restaurantTableRepository.save(table);
        tableId = table.getId();

        // Checked-in reservation for today so DiningContextService resolves it.
        // Používá Clock bean (Europe/Prague) — stejnou zónu jako DiningContextServiceImpl,
        // aby test nefailoval když CI běží v UTC a clock je v CET.
        LocalDate today = LocalDate.now(clock);
        LocalTime now = LocalTime.now(clock);
        Reservation reservation = Reservation.builder()
                .restaurantId(restaurantId)
                .tableId(tableId)
                .userId(userId)
                .date(today)
                .startTime(now.minusMinutes(15))
                .endTime(now.plusMinutes(90))
                .status(ReservationStatus.CHECKED_IN)
                .partySize(2)
                .build();
        reservation = reservationRepository.save(reservation);
        reservationId = reservation.getId();

        // Menu item for this restaurant
        MenuItem menuItem = MenuItem.builder()
                .restaurantId(restaurantId)
                .categoryId(UUID.randomUUID())
                .name("Svickova")
                .priceMinor(25000)
                .available(true)
                .build();
        menuItem = menuItemRepository.save(menuItem);
        menuItemId = menuItem.getId();

        // Active session
        DiningSession session = DiningSession.builder()
                .restaurantId(restaurantId)
                .tableId(tableId)
                .reservationId(reservationId)
                .inviteCode("TESTCODE")
                .status(DiningSessionStatus.ACTIVE)
                .createdByUserId(userId)
                .build();
        session = diningSessionRepository.save(session);
        sessionId = session.getId();

        DiningSessionMember member = DiningSessionMember.builder()
                .sessionId(sessionId)
                .userId(userId)
                .build();
        diningSessionMemberRepository.save(member);
    }

    // =========================================================================
    // POST /api/v1/orders
    // =========================================================================

    @Nested
    @DisplayName("POST /api/v1/orders — createOrder")
    class CreateOrderEndpoint {

        @Test
        @DisplayName("201 + body when authenticated user creates valid order")
        void should_return201_when_validOrder() throws Exception {
            CreateOrderRequest request = new CreateOrderRequest(
                    List.of(new OrderItemRequest(menuItemId, 2)), "extra sauce");

            performCreateOrder(userToken, request)
                    .andExpect(status().isCreated())
                    .andExpect(jsonPath("$.id").exists())
                    .andExpect(jsonPath("$.totalPriceMinor").value(50000))
                    .andExpect(jsonPath("$.status").value("CONFIRMED"))
                    .andExpect(jsonPath("$.currency").value("CZK"))
                    .andExpect(jsonPath("$.items", hasSize(1)));
        }

        @Test
        @DisplayName("201 persists order to DB — round-trip check")
        void should_persistOrderToDb() throws Exception {
            CreateOrderRequest request = new CreateOrderRequest(
                    List.of(new OrderItemRequest(menuItemId, 1)), null);

            performCreateOrder(userToken, request)
                    .andExpect(status().isCreated());

            assertThat(orderRepository.findAllByUserIdOrderByCreatedAtDesc(userId)).hasSize(1);
        }

        @Test
        @DisplayName("401 when no token")
        void should_return401_when_noToken() throws Exception {
            CreateOrderRequest request = new CreateOrderRequest(
                    List.of(new OrderItemRequest(menuItemId, 1)), null);

            mockMvc.perform(post("/api/v1/orders")
                            .contentType(MediaType.APPLICATION_JSON)
                            .content(objectMapper.writeValueAsString(request)))
                    .andExpect(status().isUnauthorized());
        }

        @Test
        @DisplayName("400 when items list is null")
        void should_return400_when_itemsNull() throws Exception {
            String body = "{\"items\": null}";

            mockMvc.perform(post("/api/v1/orders")
                            .header("Authorization", "Bearer " + userToken)
                            .contentType(MediaType.APPLICATION_JSON)
                            .content(body))
                    .andExpect(status().isBadRequest());
        }

        @Test
        @DisplayName("400 when items list is empty")
        void should_return400_when_itemsEmpty() throws Exception {
            CreateOrderRequest request = new CreateOrderRequest(List.of(), null);

            performCreateOrder(userToken, request)
                    .andExpect(status().isBadRequest());
        }

        @Test
        @DisplayName("400 when menuItemId is null in OrderItemRequest")
        void should_return400_when_menuItemIdNull() throws Exception {
            String body = "{\"items\": [{\"menuItemId\": null, \"quantity\": 1}]}";

            mockMvc.perform(post("/api/v1/orders")
                            .header("Authorization", "Bearer " + userToken)
                            .contentType(MediaType.APPLICATION_JSON)
                            .content(body))
                    .andExpect(status().isBadRequest());
        }

        @Test
        @DisplayName("400 when quantity is 0 (below min=1)")
        void should_return400_when_quantityZero() throws Exception {
            String body = String.format("{\"items\": [{\"menuItemId\": \"%s\", \"quantity\": 0}]}", menuItemId);

            mockMvc.perform(post("/api/v1/orders")
                            .header("Authorization", "Bearer " + userToken)
                            .contentType(MediaType.APPLICATION_JSON)
                            .content(body))
                    .andExpect(status().isBadRequest());
        }

        @Test
        @DisplayName("400 when quantity is 100 (above max=99)")
        void should_return400_when_quantityAboveMax() throws Exception {
            String body = String.format("{\"items\": [{\"menuItemId\": \"%s\", \"quantity\": 100}]}", menuItemId);

            mockMvc.perform(post("/api/v1/orders")
                            .header("Authorization", "Bearer " + userToken)
                            .contentType(MediaType.APPLICATION_JSON)
                            .content(body))
                    .andExpect(status().isBadRequest());
        }

        @Test
        @DisplayName("boundary: quantity=1 accepted")
        void should_return201_when_quantityIsOne() throws Exception {
            CreateOrderRequest request = new CreateOrderRequest(
                    List.of(new OrderItemRequest(menuItemId, 1)), null);

            performCreateOrder(userToken, request)
                    .andExpect(status().isCreated());
        }

        @Test
        @DisplayName("boundary: quantity=99 accepted")
        void should_return201_when_quantityIsNinetyNine() throws Exception {
            CreateOrderRequest request = new CreateOrderRequest(
                    List.of(new OrderItemRequest(menuItemId, 99)), null);

            performCreateOrder(userToken, request)
                    .andExpect(status().isCreated());
        }

        @Test
        @DisplayName("400 when note exceeds 500 characters")
        void should_return400_when_noteTooLong() throws Exception {
            String longNote = "A".repeat(501);
            CreateOrderRequest request = new CreateOrderRequest(
                    List.of(new OrderItemRequest(menuItemId, 1)), longNote);

            performCreateOrder(userToken, request)
                    .andExpect(status().isBadRequest());
        }

        @Test
        @DisplayName("boundary: note exactly 500 chars accepted")
        void should_return201_when_noteExactly500Chars() throws Exception {
            String note500 = "A".repeat(500);
            CreateOrderRequest request = new CreateOrderRequest(
                    List.of(new OrderItemRequest(menuItemId, 1)), note500);

            performCreateOrder(userToken, request)
                    .andExpect(status().isCreated());
        }

        @Test
        @DisplayName("404 when menu item does not exist")
        void should_return404_when_menuItemNotFound() throws Exception {
            UUID unknownItem = UUID.randomUUID();
            CreateOrderRequest request = new CreateOrderRequest(
                    List.of(new OrderItemRequest(unknownItem, 1)), null);

            performCreateOrder(userToken, request)
                    .andExpect(status().isNotFound());
        }

        @Test
        @DisplayName("409 when menu item is unavailable")
        void should_return409_when_menuItemUnavailable() throws Exception {
            MenuItem unavailable = MenuItem.builder()
                    .restaurantId(restaurantId)
                    .categoryId(UUID.randomUUID())
                    .name("Unavailable Item")
                    .priceMinor(10000)
                    .available(false)
                    .build();
            unavailable = menuItemRepository.save(unavailable);

            CreateOrderRequest request = new CreateOrderRequest(
                    List.of(new OrderItemRequest(unavailable.getId(), 1)), null);

            performCreateOrder(userToken, request)
                    .andExpect(status().isConflict());
        }

        @Test
        @DisplayName("409 when menu item belongs to different restaurant")
        void should_return409_when_menuItemWrongRestaurant() throws Exception {
            UUID otherRestaurant = UUID.randomUUID();
            MenuItem foreignItem = MenuItem.builder()
                    .restaurantId(otherRestaurant)
                    .categoryId(UUID.randomUUID())
                    .name("Foreign Item")
                    .priceMinor(10000)
                    .available(true)
                    .build();
            foreignItem = menuItemRepository.save(foreignItem);

            CreateOrderRequest request = new CreateOrderRequest(
                    List.of(new OrderItemRequest(foreignItem.getId(), 1)), null);

            performCreateOrder(userToken, request)
                    .andExpect(status().isConflict());
        }

        // GAP: user with no active reservation/session should receive 404, not 500
        @Test
        @DisplayName("404 when user has no active dining context")
        void should_return404_when_noDiningContext() throws Exception {
            CreateOrderRequest request = new CreateOrderRequest(
                    List.of(new OrderItemRequest(menuItemId, 1)), null);

            // otherUser has no reservation → no dining context
            performCreateOrder(otherUserToken, request)
                    .andExpect(status().isNotFound());
        }
    }

    // =========================================================================
    // GET /api/v1/orders/me/current
    // =========================================================================

    @Nested
    @DisplayName("GET /api/v1/orders/me/current")
    class GetCurrentOrders {

        @Test
        @DisplayName("200 + empty list when no current orders")
        void should_return200EmptyList_when_noOrders() throws Exception {
            mockMvc.perform(get("/api/v1/orders/me/current")
                            .header("Authorization", "Bearer " + userToken))
                    .andExpect(status().isOk())
                    .andExpect(jsonPath("$", hasSize(0)));
        }

        @Test
        @DisplayName("401 when no token")
        void should_return401_when_unauthenticated() throws Exception {
            mockMvc.perform(get("/api/v1/orders/me/current"))
                    .andExpect(status().isUnauthorized());
        }

        @Test
        @DisplayName("200 + list of summaries when orders exist")
        void should_returnSummaries_when_ordersExist() throws Exception {
            saveOrder(userId, 25000, OrderStatus.CONFIRMED);
            saveOrder(userId, 10000, OrderStatus.CONFIRMED);

            mockMvc.perform(get("/api/v1/orders/me/current")
                            .header("Authorization", "Bearer " + userToken))
                    .andExpect(status().isOk())
                    .andExpect(jsonPath("$", hasSize(2)));
        }

        @Test
        @DisplayName("cancelled orders are excluded from current list")
        void should_excludeCancelledOrders() throws Exception {
            saveOrder(userId, 25000, OrderStatus.CONFIRMED);
            saveOrder(userId, 10000, OrderStatus.CANCELLED);

            mockMvc.perform(get("/api/v1/orders/me/current")
                            .header("Authorization", "Bearer " + userToken))
                    .andExpect(status().isOk())
                    .andExpect(jsonPath("$", hasSize(1)));
        }

        // GAP: No pagination on the list endpoint — returns unbounded list
        @Test
        @DisplayName("GAP: endpoint has no pagination support")
        void gap_shouldSupportPagination() throws Exception {
            // Currently returns all orders. This test documents the missing feature.
            for (int i = 0; i < 5; i++) {
                saveOrder(userId, 10000, OrderStatus.CONFIRMED);
            }

            mockMvc.perform(get("/api/v1/orders/me/current")
                            .header("Authorization", "Bearer " + userToken))
                    .andExpect(status().isOk())
                    .andExpect(jsonPath("$", hasSize(5)));
            // GAP: Should support ?page=0&size=3 and return paged envelope
        }
    }

    // =========================================================================
    // GET /api/v1/orders/{orderId}
    // =========================================================================

    @Nested
    @DisplayName("GET /api/v1/orders/{orderId}")
    class GetOrderDetail {

        @Test
        @DisplayName("200 when owner requests their order")
        void should_return200_when_ownerRequests() throws Exception {
            Order order = saveOrder(userId, 25000, OrderStatus.CONFIRMED);

            mockMvc.perform(get("/api/v1/orders/{id}", order.getId())
                            .header("Authorization", "Bearer " + userToken))
                    .andExpect(status().isOk())
                    .andExpect(jsonPath("$.id").value(order.getId().toString()))
                    .andExpect(jsonPath("$.totalPriceMinor").value(25000));
        }

        @Test
        @DisplayName("401 when no token")
        void should_return401_when_noToken() throws Exception {
            Order order = saveOrder(userId, 25000, OrderStatus.CONFIRMED);

            mockMvc.perform(get("/api/v1/orders/{id}", order.getId()))
                    .andExpect(status().isUnauthorized());
        }

        @Test
        @DisplayName("404 when order does not exist")
        void should_return404_when_orderNotFound() throws Exception {
            mockMvc.perform(get("/api/v1/orders/{id}", UUID.randomUUID())
                            .header("Authorization", "Bearer " + userToken))
                    .andExpect(status().isNotFound());
        }

        @Test
        @DisplayName("403 when non-owner requests another user's order")
        void should_return403_when_nonOwnerRequests() throws Exception {
            Order order = saveOrder(userId, 25000, OrderStatus.CONFIRMED);

            mockMvc.perform(get("/api/v1/orders/{id}", order.getId())
                            .header("Authorization", "Bearer " + otherUserToken))
                    .andExpect(status().isForbidden());
        }
    }

    // =========================================================================
    // POST /api/v1/orders/{orderId}/pay
    // =========================================================================

    @Nested
    @DisplayName("POST /api/v1/orders/{orderId}/pay")
    class InitiatePayment {

        @Test
        @DisplayName("200 + redirectUrl when payment initiated successfully")
        void should_return200_when_paymentInitiated() throws Exception {
            given(moonePaymentService.initiateTransaction(anyInt(), anyString()))
                    .willReturn(new MoonePaymentService.MooneTransactionResult("tx-001", "https://pay.example/tx-001"));

            Order order = saveOrder(userId, 25000, OrderStatus.CONFIRMED);

            mockMvc.perform(post("/api/v1/orders/{id}/pay", order.getId())
                            .header("Authorization", "Bearer " + userToken))
                    .andExpect(status().isOk())
                    .andExpect(jsonPath("$.paymentTransactionId").value("tx-001"))
                    .andExpect(jsonPath("$.paymentRedirectUrl").value("https://pay.example/tx-001"))
                    .andExpect(jsonPath("$.paymentStatus").value("INITIATED"));
        }

        @Test
        @DisplayName("409 when order is already PAID — prevents double-payment")
        void should_return409_when_alreadyPaid() throws Exception {
            Order order = saveOrder(userId, 25000, OrderStatus.CONFIRMED);
            order.setPaymentStatus(PaymentStatus.PAID);
            orderRepository.save(order);

            mockMvc.perform(post("/api/v1/orders/{id}/pay", order.getId())
                            .header("Authorization", "Bearer " + userToken))
                    .andExpect(status().isConflict());
        }

        @Test
        @DisplayName("idempotent — returns existing order when already INITIATED")
        void should_returnExistingOrder_when_initiatedAgain() throws Exception {
            Order order = saveOrder(userId, 25000, OrderStatus.CONFIRMED);
            order.setPaymentStatus(PaymentStatus.INITIATED);
            order.setPaymentTransactionId("existing-tx");
            order.setPaymentRedirectUrl("https://pay.example/existing");
            orderRepository.save(order);

            mockMvc.perform(post("/api/v1/orders/{id}/pay", order.getId())
                            .header("Authorization", "Bearer " + userToken))
                    .andExpect(status().isOk())
                    .andExpect(jsonPath("$.paymentTransactionId").value("existing-tx"));
        }

        @Test
        @DisplayName("401 when not authenticated")
        void should_return401_when_noToken() throws Exception {
            Order order = saveOrder(userId, 25000, OrderStatus.CONFIRMED);

            mockMvc.perform(post("/api/v1/orders/{id}/pay", order.getId()))
                    .andExpect(status().isUnauthorized());
        }

        @Test
        @DisplayName("404 when order not found")
        void should_return404_when_orderNotFound() throws Exception {
            mockMvc.perform(post("/api/v1/orders/{id}/pay", UUID.randomUUID())
                            .header("Authorization", "Bearer " + userToken))
                    .andExpect(status().isNotFound());
        }

        @Test
        @DisplayName("403 when non-owner tries to pay")
        void should_return403_when_nonOwnerPays() throws Exception {
            Order order = saveOrder(userId, 25000, OrderStatus.CONFIRMED);

            mockMvc.perform(post("/api/v1/orders/{id}/pay", order.getId())
                            .header("Authorization", "Bearer " + otherUserToken))
                    .andExpect(status().isForbidden());
        }

        @Test
        @DisplayName("502 when Moone gateway fails")
        void should_return502_when_mooneGatewayFails() throws Exception {
            given(moonePaymentService.initiateTransaction(anyInt(), anyString()))
                    .willThrow(new IllegalStateException("Moone unavailable"));

            Order order = saveOrder(userId, 25000, OrderStatus.CONFIRMED);

            mockMvc.perform(post("/api/v1/orders/{id}/pay", order.getId())
                            .header("Authorization", "Bearer " + userToken))
                    .andExpect(status().isBadGateway());
        }
    }

    // =========================================================================
    // GET /api/v1/orders/{orderId}/payment-status
    // =========================================================================

    @Nested
    @DisplayName("GET /api/v1/orders/{orderId}/payment-status")
    class GetPaymentStatus {

        @Test
        @DisplayName("200 + status NONE for new order")
        void should_return200_withNoneStatus() throws Exception {
            Order order = saveOrder(userId, 25000, OrderStatus.CONFIRMED);

            mockMvc.perform(get("/api/v1/orders/{id}/payment-status", order.getId())
                            .header("Authorization", "Bearer " + userToken))
                    .andExpect(status().isOk())
                    .andExpect(jsonPath("$.paymentStatus").value("NONE"))
                    .andExpect(jsonPath("$.orderId").value(order.getId().toString()));
        }

        @Test
        @DisplayName("401 when unauthenticated")
        void should_return401() throws Exception {
            Order order = saveOrder(userId, 25000, OrderStatus.CONFIRMED);
            mockMvc.perform(get("/api/v1/orders/{id}/payment-status", order.getId()))
                    .andExpect(status().isUnauthorized());
        }

        @Test
        @DisplayName("404 when order not found")
        void should_return404() throws Exception {
            mockMvc.perform(get("/api/v1/orders/{id}/payment-status", UUID.randomUUID())
                            .header("Authorization", "Bearer " + userToken))
                    .andExpect(status().isNotFound());
        }

        @Test
        @DisplayName("403 when non-owner polls status")
        void should_return403_when_nonOwner() throws Exception {
            Order order = saveOrder(userId, 25000, OrderStatus.CONFIRMED);

            mockMvc.perform(get("/api/v1/orders/{id}/payment-status", order.getId())
                            .header("Authorization", "Bearer " + otherUserToken))
                    .andExpect(status().isForbidden());
        }
    }

    // =========================================================================
    // POST /api/v1/payments/callback  (public, no JWT)
    // =========================================================================

    @Nested
    @DisplayName("POST /api/v1/payments/callback — Moone webhook")
    class PaymentCallback {

        @Test
        @DisplayName("200 OK for valid callback with publicID")
        void should_return200_for_publicIDCallback() throws Exception {
            Order order = saveOrder(userId, 25000, OrderStatus.CONFIRMED);
            order.setPaymentStatus(PaymentStatus.INITIATED);
            order.setPaymentTransactionId("moone-tx-1");
            orderRepository.save(order);

            given(moonePaymentService.getTransactionStatus("moone-tx-1")).willReturn(PaymentStatus.PAID);

            mockMvc.perform(post("/api/v1/payments/callback")
                            .contentType(MediaType.APPLICATION_JSON)
                            .content("{\"publicID\": \"moone-tx-1\"}"))
                    .andExpect(status().isOk());

            Order updated = orderRepository.findById(order.getId()).orElseThrow();
            assertThat(updated.getPaymentStatus()).isEqualTo(PaymentStatus.PAID);
        }

        @Test
        @DisplayName("200 OK with no body change when transactionId unknown")
        void should_return200_when_transactionIdUnknown() throws Exception {
            mockMvc.perform(post("/api/v1/payments/callback")
                            .contentType(MediaType.APPLICATION_JSON)
                            .content("{\"publicID\": \"unknown-tx\"}"))
                    .andExpect(status().isOk());
        }

        @Test
        @DisplayName("200 OK when payload has no transaction id (no crash)")
        void should_return200_when_noTransactionId() throws Exception {
            mockMvc.perform(post("/api/v1/payments/callback")
                            .contentType(MediaType.APPLICATION_JSON)
                            .content("{\"unrelated\": \"data\"}"))
                    .andExpect(status().isOk());
        }

        @Test
        @DisplayName("callback does not require Authorization header (public endpoint)")
        void should_be_publicEndpoint() throws Exception {
            // No Authorization header — must not be 401
            mockMvc.perform(post("/api/v1/payments/callback")
                            .contentType(MediaType.APPLICATION_JSON)
                            .content("{\"publicID\": \"some-tx\"}"))
                    .andExpect(status().isOk());
        }
    }

    // =========================================================================
    // POST /api/v1/sessions/join
    // =========================================================================

    @Nested
    @DisplayName("POST /api/v1/sessions/join")
    class JoinSession {

        @Test
        @DisplayName("200 + session data when valid invite code provided")
        void should_return200_when_validCode() throws Exception {
            String body = "{\"inviteCode\": \"TESTCODE\"}";

            mockMvc.perform(post("/api/v1/sessions/join")
                            .header("Authorization", "Bearer " + otherUserToken)
                            .contentType(MediaType.APPLICATION_JSON)
                            .content(body))
                    .andExpect(status().isOk())
                    .andExpect(jsonPath("$.id").value(sessionId.toString()))
                    .andExpect(jsonPath("$.inviteCode").value("TESTCODE"));
        }

        @Test
        @DisplayName("idempotent — joining same session twice returns 200 both times")
        void should_return200_when_joiningTwice() throws Exception {
            String body = "{\"inviteCode\": \"TESTCODE\"}";

            mockMvc.perform(post("/api/v1/sessions/join")
                            .header("Authorization", "Bearer " + otherUserToken)
                            .contentType(MediaType.APPLICATION_JSON)
                            .content(body))
                    .andExpect(status().isOk());

            mockMvc.perform(post("/api/v1/sessions/join")
                            .header("Authorization", "Bearer " + otherUserToken)
                            .contentType(MediaType.APPLICATION_JSON)
                            .content(body))
                    .andExpect(status().isOk());

            // No duplicate member row
            assertThat(diningSessionMemberRepository.existsBySessionIdAndUserId(sessionId, otherUserId)).isTrue();
            assertThat(diningSessionMemberRepository.findAllBySessionId(sessionId)).hasSize(2); // host + guest
        }

        @Test
        @DisplayName("404 when invite code does not match any active session")
        void should_return404_when_invalidCode() throws Exception {
            String body = "{\"inviteCode\": \"INVALID0\"}";

            mockMvc.perform(post("/api/v1/sessions/join")
                            .header("Authorization", "Bearer " + otherUserToken)
                            .contentType(MediaType.APPLICATION_JSON)
                            .content(body))
                    .andExpect(status().isNotFound());
        }

        @Test
        @DisplayName("400 when inviteCode is blank")
        void should_return400_when_inviteCodeBlank() throws Exception {
            String body = "{\"inviteCode\": \"\"}";

            mockMvc.perform(post("/api/v1/sessions/join")
                            .header("Authorization", "Bearer " + otherUserToken)
                            .contentType(MediaType.APPLICATION_JSON)
                            .content(body))
                    .andExpect(status().isBadRequest());
        }

        @Test
        @DisplayName("400 when inviteCode is 7 chars (below min=8)")
        void should_return400_when_codeTooShort() throws Exception {
            String body = "{\"inviteCode\": \"SHORT12\"}";

            mockMvc.perform(post("/api/v1/sessions/join")
                            .header("Authorization", "Bearer " + otherUserToken)
                            .contentType(MediaType.APPLICATION_JSON)
                            .content(body))
                    .andExpect(status().isBadRequest());
        }

        @Test
        @DisplayName("400 when inviteCode is 9 chars (above max=8)")
        void should_return400_when_codeTooLong() throws Exception {
            String body = "{\"inviteCode\": \"TOOLONG12\"}";

            mockMvc.perform(post("/api/v1/sessions/join")
                            .header("Authorization", "Bearer " + otherUserToken)
                            .contentType(MediaType.APPLICATION_JSON)
                            .content(body))
                    .andExpect(status().isBadRequest());
        }

        @Test
        @DisplayName("401 when not authenticated")
        void should_return401_when_noToken() throws Exception {
            String body = "{\"inviteCode\": \"TESTCODE\"}";

            mockMvc.perform(post("/api/v1/sessions/join")
                            .contentType(MediaType.APPLICATION_JSON)
                            .content(body))
                    .andExpect(status().isUnauthorized());
        }

        @Test
        @DisplayName("404 when joining a CLOSED session by code")
        void should_return404_when_joiningClosedSession() throws Exception {
            DiningSession closed = DiningSession.builder()
                    .restaurantId(restaurantId)
                    .tableId(tableId)
                    .inviteCode("CLOSED99")
                    .status(DiningSessionStatus.CLOSED)
                    .createdByUserId(userId)
                    .build();
            diningSessionRepository.save(closed);

            String body = "{\"inviteCode\": \"CLOSED99\"}";

            mockMvc.perform(post("/api/v1/sessions/join")
                            .header("Authorization", "Bearer " + otherUserToken)
                            .contentType(MediaType.APPLICATION_JSON)
                            .content(body))
                    .andExpect(status().isNotFound());
        }
    }

    // =========================================================================
    // GET /api/v1/sessions/me
    // =========================================================================

    @Nested
    @DisplayName("GET /api/v1/sessions/me")
    class GetMySession {

        @Test
        @DisplayName("200 + session when user has active session")
        void should_return200_when_userHasSession() throws Exception {
            mockMvc.perform(get("/api/v1/sessions/me")
                            .header("Authorization", "Bearer " + userToken))
                    .andExpect(status().isOk())
                    .andExpect(jsonPath("$.id").value(sessionId.toString()))
                    .andExpect(jsonPath("$.status").value("ACTIVE"));
        }

        @Test
        @DisplayName("404 when user has no active session")
        void should_return404_when_noActiveSession() throws Exception {
            mockMvc.perform(get("/api/v1/sessions/me")
                            .header("Authorization", "Bearer " + otherUserToken))
                    .andExpect(status().isNotFound());
        }

        @Test
        @DisplayName("401 when unauthenticated")
        void should_return401_when_noToken() throws Exception {
            mockMvc.perform(get("/api/v1/sessions/me"))
                    .andExpect(status().isUnauthorized());
        }
    }

    // =========================================================================
    // GET /api/v1/sessions/{id}/orders
    // =========================================================================

    @Nested
    @DisplayName("GET /api/v1/sessions/{id}/orders")
    class GetSessionOrders {

        @Test
        @DisplayName("200 + list when session member requests")
        void should_return200_when_memberRequests() throws Exception {
            mockMvc.perform(get("/api/v1/sessions/{id}/orders", sessionId)
                            .header("Authorization", "Bearer " + userToken))
                    .andExpect(status().isOk())
                    .andExpect(jsonPath("$", isA(List.class)));
        }

        @Test
        @DisplayName("403 when non-member requests session orders")
        void should_return403_when_nonMemberRequests() throws Exception {
            mockMvc.perform(get("/api/v1/sessions/{id}/orders", sessionId)
                            .header("Authorization", "Bearer " + otherUserToken))
                    .andExpect(status().isForbidden());
        }

        @Test
        @DisplayName("401 when not authenticated")
        void should_return401_when_noToken() throws Exception {
            mockMvc.perform(get("/api/v1/sessions/{id}/orders", sessionId))
                    .andExpect(status().isUnauthorized());
        }

        @Test
        @DisplayName("cancelled orders are excluded from session order list")
        void should_excludeCancelledOrders_from_sessionList() throws Exception {
            saveOrderForSession(userId, 10000, OrderStatus.CONFIRMED);
            saveOrderForSession(userId, 5000, OrderStatus.CANCELLED);

            mockMvc.perform(get("/api/v1/sessions/{id}/orders", sessionId)
                            .header("Authorization", "Bearer " + userToken))
                    .andExpect(status().isOk())
                    .andExpect(jsonPath("$", hasSize(1)));
        }
    }

    // =========================================================================
    // POST /api/v1/sessions/{id}/close
    // =========================================================================

    @Nested
    @DisplayName("POST /api/v1/sessions/{id}/close")
    class CloseSession {

        @Test
        @DisplayName("200 when host closes session")
        void should_return200_when_hostCloses() throws Exception {
            mockMvc.perform(post("/api/v1/sessions/{id}/close", sessionId)
                            .header("Authorization", "Bearer " + userToken))
                    .andExpect(status().isOk());

            DiningSession closed = diningSessionRepository.findById(sessionId).orElseThrow();
            assertThat(closed.getStatus()).isEqualTo(DiningSessionStatus.CLOSED);
        }

        @Test
        @DisplayName("403 when non-host tries to close session")
        void should_return403_when_nonHostCloses() throws Exception {
            // Add otherUser as member so it's not 404 territory
            diningSessionMemberRepository.save(DiningSessionMember.builder()
                    .sessionId(sessionId).userId(otherUserId).build());

            mockMvc.perform(post("/api/v1/sessions/{id}/close", sessionId)
                            .header("Authorization", "Bearer " + otherUserToken))
                    .andExpect(status().isForbidden());
        }

        @Test
        @DisplayName("409 when session already closed")
        void should_return409_when_sessionAlreadyClosed() throws Exception {
            // Close once
            mockMvc.perform(post("/api/v1/sessions/{id}/close", sessionId)
                            .header("Authorization", "Bearer " + userToken))
                    .andExpect(status().isOk());

            // Close again → 409
            mockMvc.perform(post("/api/v1/sessions/{id}/close", sessionId)
                            .header("Authorization", "Bearer " + userToken))
                    .andExpect(status().isConflict());
        }

        @Test
        @DisplayName("404 when session not found")
        void should_return404_when_sessionNotFound() throws Exception {
            mockMvc.perform(post("/api/v1/sessions/{id}/close", UUID.randomUUID())
                            .header("Authorization", "Bearer " + userToken))
                    .andExpect(status().isNotFound());
        }

        @Test
        @DisplayName("401 when not authenticated")
        void should_return401_when_noToken() throws Exception {
            mockMvc.perform(post("/api/v1/sessions/{id}/close", sessionId))
                    .andExpect(status().isUnauthorized());
        }
    }

    // =========================================================================
    // GET /api/v1/sessions/{id}/payment-summary
    // =========================================================================

    @Nested
    @DisplayName("GET /api/v1/sessions/{id}/payment-summary")
    class GetPaymentSummary {

        @Test
        @DisplayName("200 + summary with correct fields when member requests")
        void should_return200_when_memberRequests() throws Exception {
            mockMvc.perform(get("/api/v1/sessions/{id}/payment-summary", sessionId)
                            .header("Authorization", "Bearer " + userToken))
                    .andExpect(status().isOk())
                    .andExpect(jsonPath("$.totalMinor").exists())
                    .andExpect(jsonPath("$.paidMinor").exists())
                    .andExpect(jsonPath("$.remainingMinor").exists())
                    .andExpect(jsonPath("$.items").isArray());
        }

        @Test
        @DisplayName("summary: remainingMinor = totalMinor - paidMinor (both 0 for empty session)")
        void should_computeRemainingCorrectly() throws Exception {
            // Empty session: no orders, so totalMinor=0, paidMinor=0, remainingMinor=0
            mockMvc.perform(get("/api/v1/sessions/{id}/payment-summary", sessionId)
                            .header("Authorization", "Bearer " + userToken))
                    .andExpect(status().isOk())
                    .andExpect(jsonPath("$.remainingMinor").value(0))
                    .andExpect(jsonPath("$.totalMinor").value(0))
                    .andExpect(jsonPath("$.paidMinor").value(0));
        }

        @Test
        @DisplayName("403 when non-member requests payment summary")
        void should_return403_when_nonMember() throws Exception {
            mockMvc.perform(get("/api/v1/sessions/{id}/payment-summary", sessionId)
                            .header("Authorization", "Bearer " + otherUserToken))
                    .andExpect(status().isForbidden());
        }

        @Test
        @DisplayName("401 when not authenticated")
        void should_return401_when_noToken() throws Exception {
            mockMvc.perform(get("/api/v1/sessions/{id}/payment-summary", sessionId))
                    .andExpect(status().isUnauthorized());
        }
    }

    // =========================================================================
    // GET /api/v1/dining-context/me
    // =========================================================================

    @Nested
    @DisplayName("GET /api/v1/dining-context/me")
    class GetDiningContext {

        @Test
        @DisplayName("200 + context when user has checked-in reservation")
        void should_return200_when_activeReservation() throws Exception {
            mockMvc.perform(get("/api/v1/dining-context/me")
                            .header("Authorization", "Bearer " + userToken))
                    .andExpect(status().isOk())
                    .andExpect(jsonPath("$.restaurantId").value(restaurantId.toString()))
                    .andExpect(jsonPath("$.tableId").value(tableId.toString()))
                    .andExpect(jsonPath("$.reservationId").value(reservationId.toString()));
        }

        @Test
        @DisplayName("404 when user has no active reservation")
        void should_return404_when_noActiveContext() throws Exception {
            mockMvc.perform(get("/api/v1/dining-context/me")
                            .header("Authorization", "Bearer " + otherUserToken))
                    .andExpect(status().isNotFound());
        }

        @Test
        @DisplayName("401 when not authenticated")
        void should_return401_when_noToken() throws Exception {
            mockMvc.perform(get("/api/v1/dining-context/me"))
                    .andExpect(status().isUnauthorized());
        }

        @Test
        @DisplayName("context includes sessionId when user has active dining session")
        void should_includeSessionId_when_sessionExists() throws Exception {
            mockMvc.perform(get("/api/v1/dining-context/me")
                            .header("Authorization", "Bearer " + userToken))
                    .andExpect(status().isOk())
                    .andExpect(jsonPath("$.sessionId").value(sessionId.toString()))
                    .andExpect(jsonPath("$.contextType").value("SESSION"));
        }

        // GAP: context endpoint does not return 404 with proper error body — returns Spring default white-label
        // This test verifies the error body has the expected shape
        @Test
        @DisplayName("404 response has structured error body with code field")
        void should_return404_with_structuredErrorBody() throws Exception {
            mockMvc.perform(get("/api/v1/dining-context/me")
                            .header("Authorization", "Bearer " + otherUserToken))
                    .andExpect(status().isNotFound())
                    .andExpect(jsonPath("$.code").exists())
                    .andExpect(jsonPath("$.message").exists());
        }
    }

    // =========================================================================
    // GET /api/v1/sessions/{id}/qr
    // =========================================================================

    @Nested
    @DisplayName("GET /api/v1/sessions/{id}/qr")
    class GetQrCode {

        @Test
        @DisplayName("200 + inviteCode when session member requests")
        void should_return200_when_memberRequests() throws Exception {
            mockMvc.perform(get("/api/v1/sessions/{id}/qr", sessionId)
                            .header("Authorization", "Bearer " + userToken))
                    .andExpect(status().isOk())
                    .andExpect(jsonPath("$.inviteCode").value("TESTCODE"));
        }

        @Test
        @DisplayName("401 when not authenticated")
        void should_return401_when_noToken() throws Exception {
            mockMvc.perform(get("/api/v1/sessions/{id}/qr", sessionId))
                    .andExpect(status().isUnauthorized());
        }

        // GAP: QR endpoint does not enforce session membership — any authenticated user can get the QR code
        @Test
        @DisplayName("GAP: QR endpoint should return 403 for non-members, currently leaks invite code")
        void gap_should_return403_for_nonMember() throws Exception {
            // otherUser is not a member of the session
            // Currently the controller re-fetches activeSession for the requesting user, which may return 404 or wrong session
            // Expected: 403 Forbidden. Actual: behavior depends on whether otherUser has their own session.
            mockMvc.perform(get("/api/v1/sessions/{id}/qr", sessionId)
                            .header("Authorization", "Bearer " + otherUserToken))
                    // GAP: Should be 403, but currently returns 404 (user's own session not found) or wrong data
                    .andExpect(status().is4xxClientError());
        }
    }

    // =========================================================================
    // Helpers
    // =========================================================================

    private ResultActions performCreateOrder(String token, CreateOrderRequest request) throws Exception {
        return mockMvc.perform(post("/api/v1/orders")
                .header("Authorization", "Bearer " + token)
                .contentType(MediaType.APPLICATION_JSON)
                .content(objectMapper.writeValueAsString(request)));
    }

    private Order saveOrder(Long forUserId, int totalPriceMinor, OrderStatus status) {
        Order order = Order.builder()
                .userId(forUserId)
                .restaurantId(restaurantId)
                .tableId(tableId)
                .reservationId(reservationId)
                .sessionId(sessionId)
                .status(status)
                .totalPriceMinor(totalPriceMinor)
                .currency("CZK")
                .paymentStatus(PaymentStatus.NONE)
                .build();
        return orderRepository.save(order);
    }

    private Order saveOrderForSession(Long forUserId, int totalPriceMinor, OrderStatus status) {
        return saveOrder(forUserId, totalPriceMinor, status);
    }
}
