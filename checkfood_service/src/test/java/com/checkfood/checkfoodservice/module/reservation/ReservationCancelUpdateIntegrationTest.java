package com.checkfood.checkfoodservice.module.reservation;

import com.checkfood.checkfoodservice.module.reservation.dto.request.CreateReservationRequest;
import com.checkfood.checkfoodservice.module.reservation.dto.request.UpdateReservationRequest;
import com.checkfood.checkfoodservice.module.reservation.entity.Reservation;
import com.checkfood.checkfoodservice.module.reservation.entity.ReservationStatus;
import com.checkfood.checkfoodservice.module.reservation.repository.ReservationChangeRequestRepository;
import com.checkfood.checkfoodservice.module.reservation.repository.ReservationRepository;
import com.checkfood.checkfoodservice.module.restaurant.entity.common.Address;
import com.checkfood.checkfoodservice.module.restaurant.entity.restaurant.CuisineType;
import com.checkfood.checkfoodservice.module.restaurant.entity.restaurant.OpeningHours;
import com.checkfood.checkfoodservice.module.restaurant.entity.restaurant.Restaurant;
import com.checkfood.checkfoodservice.module.restaurant.entity.restaurant.RestaurantStatus;
import com.checkfood.checkfoodservice.module.restaurant.entity.restaurant.table.RestaurantTable;
import com.checkfood.checkfoodservice.module.restaurant.repository.RestaurantRepository;
import com.checkfood.checkfoodservice.module.restaurant.repository.table.RestaurantTableRepository;
import com.checkfood.checkfoodservice.security.BaseAuthIntegrationTest;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Nested;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;

import java.math.BigDecimal;
import java.time.DayOfWeek;
import java.time.LocalDate;
import java.time.LocalTime;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

import static org.assertj.core.api.Assertions.assertThat;
import static org.hamcrest.Matchers.is;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.*;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.*;

/**
 * Integration tests for reservation cancel, update, pending-changes, and history endpoints.
 * Extends the existing ReservationIntegrationTest scope (which covers creation + scene).
 */
@DisplayName("Reservation — cancel/update/history/change-request integration tests")
class ReservationCancelUpdateIntegrationTest extends BaseAuthIntegrationTest {

    @Autowired private RestaurantRepository restaurantRepository;
    @Autowired private RestaurantTableRepository tableRepository;
    @Autowired private ReservationRepository reservationRepository;
    @Autowired private ReservationChangeRequestRepository changeRequestRepository;

    private UUID restaurantId;
    private UUID tableId;
    private LocalDate futureDate;
    private String userToken;
    private String otherToken;

    @BeforeEach
    void setUp() throws Exception {
        changeRequestRepository.deleteAll();
        reservationRepository.deleteAll();
        tableRepository.deleteAll();
        restaurantRepository.deleteAll();

        futureDate = LocalDate.now().plusDays(14);
        // ensure day is not Sunday (closed)
        while (futureDate.getDayOfWeek() == DayOfWeek.SUNDAY) {
            futureDate = futureDate.plusDays(1);
        }

        var hours = new ArrayList<OpeningHours>();
        for (DayOfWeek day : DayOfWeek.values()) {
            hours.add(OpeningHours.builder()
                    .dayOfWeek(day)
                    .openAt(LocalTime.of(10, 0))
                    .closeAt(LocalTime.of(22, 0))
                    .closed(day == DayOfWeek.SUNDAY)
                    .build());
        }

        var restaurant = restaurantRepository.save(Restaurant.builder()
                .ownerId(UUID.randomUUID())
                .name("Integration Restaurant")
                .cuisineType(CuisineType.CZECH)
                .status(RestaurantStatus.ACTIVE)
                .active(true)
                .rating(BigDecimal.ZERO)
                .address(Address.builder().country("CZ").city("Prague").street("Test St").streetNumber("1").postalCode("11000").build())
                .openingHours(hours)
                .build());
        restaurantId = restaurant.getId();

        var table = tableRepository.save(RestaurantTable.builder()
                .restaurantId(restaurantId)
                .label("T1")
                .capacity(6)
                .active(true)
                .build());
        tableId = table.getId();

        userToken = getAccessToken(TEST_EMAIL, TEST_PASSWORD, TEST_DEVICE_ID);
        otherToken = getAccessToken("other2@checkfood.test", TEST_PASSWORD, "dev-002");
    }

    // =========================================================================
    // PATCH /api/v1/reservations/{id}/cancel
    // =========================================================================

    @Nested
    @DisplayName("PATCH /api/v1/reservations/{id}/cancel")
    class CancelTests {

        @Test
        @DisplayName("200 — happy path: cancel own future reservation")
        void should_cancel_ownFutureReservation() throws Exception {
            var reservation = seedReservation(userToken, futureDate, LocalTime.of(14, 0));

            mockMvc.perform(patch("/api/v1/reservations/{id}/cancel", reservation.getId())
                            .header("Authorization", "Bearer " + userToken))
                    .andExpect(status().isOk())
                    .andExpect(jsonPath("$.status").value("CANCELLED"));

            var updated = reservationRepository.findById(reservation.getId()).orElseThrow();
            assertThat(updated.getStatus()).isEqualTo(ReservationStatus.CANCELLED);
        }

        @Test
        @DisplayName("401 — no token")
        void should_return401_without_token() throws Exception {
            var reservation = seedReservation(userToken, futureDate, LocalTime.of(14, 0));

            mockMvc.perform(patch("/api/v1/reservations/{id}/cancel", reservation.getId()))
                    .andExpect(status().isUnauthorized());
        }

        @Test
        @DisplayName("403 — user cannot cancel another user's reservation")
        void should_return403_when_cancellingOtherUsersReservation() throws Exception {
            var reservation = seedReservation(userToken, futureDate, LocalTime.of(14, 0));

            mockMvc.perform(patch("/api/v1/reservations/{id}/cancel", reservation.getId())
                            .header("Authorization", "Bearer " + otherToken))
                    .andExpect(status().isForbidden())
                    .andExpect(jsonPath("$.code").value("RESERVATION_ACCESS_DENIED"));
        }

        @Test
        @DisplayName("404 — non-existent reservation ID")
        void should_return404_for_nonExistentId() throws Exception {
            mockMvc.perform(patch("/api/v1/reservations/{id}/cancel", UUID.randomUUID())
                            .header("Authorization", "Bearer " + userToken))
                    .andExpect(status().isNotFound())
                    .andExpect(jsonPath("$.code").value("RESERVATION_NOT_FOUND"));
        }

        @Test
        @DisplayName("409 — cancel already-cancelled reservation returns 409")
        void should_return409_when_alreadyCancelled() throws Exception {
            var reservation = seedReservation(userToken, futureDate, LocalTime.of(14, 0));
            reservation.setStatus(ReservationStatus.CANCELLED);
            reservationRepository.save(reservation);

            mockMvc.perform(patch("/api/v1/reservations/{id}/cancel", reservation.getId())
                            .header("Authorization", "Bearer " + userToken))
                    .andExpect(status().isConflict())
                    .andExpect(jsonPath("$.code").value("RESERVATION_ALREADY_CANCELLED"));
        }

        @Test
        @DisplayName("409 — cancel completed reservation returns CANNOT_CANCEL")
        void should_return409_when_completedReservation() throws Exception {
            var reservation = reservationRepository.save(Reservation.builder()
                    .restaurantId(restaurantId).tableId(tableId)
                    .userId(extractUserId(userToken)).date(LocalDate.now().minusDays(1))
                    .startTime(LocalTime.of(12, 0)).endTime(LocalTime.of(13, 0))
                    .status(ReservationStatus.COMPLETED).partySize(2).build());

            mockMvc.perform(patch("/api/v1/reservations/{id}/cancel", reservation.getId())
                            .header("Authorization", "Bearer " + userToken))
                    .andExpect(status().isConflict())
                    .andExpect(jsonPath("$.code").value("RESERVATION_CANNOT_CANCEL"));
        }

        @Test
        @DisplayName("idempotency — cancel twice returns same 409 on second call")
        void should_return409_on_secondCancel() throws Exception {
            var reservation = seedReservation(userToken, futureDate, LocalTime.of(14, 0));

            mockMvc.perform(patch("/api/v1/reservations/{id}/cancel", reservation.getId())
                            .header("Authorization", "Bearer " + userToken))
                    .andExpect(status().isOk());

            mockMvc.perform(patch("/api/v1/reservations/{id}/cancel", reservation.getId())
                            .header("Authorization", "Bearer " + userToken))
                    .andExpect(status().isConflict());
        }
    }

    // =========================================================================
    // PUT /api/v1/reservations/{id}
    // =========================================================================

    @Nested
    @DisplayName("PUT /api/v1/reservations/{id}")
    class UpdateReservationTests {

        @Test
        @DisplayName("200 — happy path: update own confirmed reservation")
        void should_update_ownReservation() throws Exception {
            var reservation = seedReservation(userToken, futureDate, LocalTime.of(14, 0));
            // Force to CONFIRMED so it is editable (PENDING_CONFIRMATION also editable if far future)
            reservation.setStatus(ReservationStatus.CONFIRMED);
            reservationRepository.save(reservation);

            var req = new UpdateReservationRequest(tableId, futureDate, LocalTime.of(16, 0), 3);

            mockMvc.perform(put("/api/v1/reservations/{id}", reservation.getId())
                            .header("Authorization", "Bearer " + userToken)
                            .contentType(MediaType.APPLICATION_JSON)
                            .content(objectMapper.writeValueAsString(req)))
                    .andExpect(status().isOk())
                    .andExpect(jsonPath("$.startTime").value("16:00:00"))
                    .andExpect(jsonPath("$.partySize").value(3));
        }

        @Test
        @DisplayName("401 — no token")
        void should_return401_without_token() throws Exception {
            var reservation = seedReservation(userToken, futureDate, LocalTime.of(14, 0));
            var req = new UpdateReservationRequest(tableId, futureDate, LocalTime.of(16, 0), 3);

            mockMvc.perform(put("/api/v1/reservations/{id}", reservation.getId())
                            .contentType(MediaType.APPLICATION_JSON)
                            .content(objectMapper.writeValueAsString(req)))
                    .andExpect(status().isUnauthorized());
        }

        @Test
        @DisplayName("403 — cannot update another user's reservation")
        void should_return403_for_otherUsersReservation() throws Exception {
            var reservation = seedReservation(userToken, futureDate, LocalTime.of(14, 0));
            reservation.setStatus(ReservationStatus.CONFIRMED);
            reservationRepository.save(reservation);

            var req = new UpdateReservationRequest(tableId, futureDate, LocalTime.of(16, 0), 3);
            mockMvc.perform(put("/api/v1/reservations/{id}", reservation.getId())
                            .header("Authorization", "Bearer " + otherToken)
                            .contentType(MediaType.APPLICATION_JSON)
                            .content(objectMapper.writeValueAsString(req)))
                    .andExpect(status().isForbidden());
        }

        @Test
        @DisplayName("400 — validation: partySize < 1")
        void should_return400_when_partySizeZero() throws Exception {
            var reservation = seedReservation(userToken, futureDate, LocalTime.of(14, 0));
            var req = new UpdateReservationRequest(tableId, futureDate, LocalTime.of(16, 0), 0);

            mockMvc.perform(put("/api/v1/reservations/{id}", reservation.getId())
                            .header("Authorization", "Bearer " + userToken)
                            .contentType(MediaType.APPLICATION_JSON)
                            .content(objectMapper.writeValueAsString(req)))
                    .andExpect(status().isBadRequest());
        }

        @Test
        @DisplayName("400 — validation: null tableId")
        void should_return400_when_tableIdNull() throws Exception {
            var reservation = seedReservation(userToken, futureDate, LocalTime.of(14, 0));
            var req = new UpdateReservationRequest(null, futureDate, LocalTime.of(16, 0), 2);

            mockMvc.perform(put("/api/v1/reservations/{id}", reservation.getId())
                            .header("Authorization", "Bearer " + userToken)
                            .contentType(MediaType.APPLICATION_JSON)
                            .content(objectMapper.writeValueAsString(req)))
                    .andExpect(status().isBadRequest());
        }

        @Test
        @DisplayName("409 — slot conflict on update")
        void should_return409_when_slotConflict() throws Exception {
            // Create a conflicting reservation on the same slot
            var conflict = reservationRepository.save(Reservation.builder()
                    .restaurantId(restaurantId).tableId(tableId)
                    .userId(extractUserId(otherToken)).date(futureDate)
                    .startTime(LocalTime.of(16, 0)).endTime(LocalTime.of(17, 0))
                    .status(ReservationStatus.CONFIRMED).partySize(2).build());

            var reservation = seedReservation(userToken, futureDate, LocalTime.of(14, 0));
            reservation.setStatus(ReservationStatus.CONFIRMED);
            reservationRepository.save(reservation);

            var req = new UpdateReservationRequest(tableId, futureDate, LocalTime.of(16, 0), 2);
            mockMvc.perform(put("/api/v1/reservations/{id}", reservation.getId())
                            .header("Authorization", "Bearer " + userToken)
                            .contentType(MediaType.APPLICATION_JSON)
                            .content(objectMapper.writeValueAsString(req)))
                    .andExpect(status().isConflict())
                    .andExpect(jsonPath("$.code").value("SLOT_CONFLICT"));
        }

        @Test
        @DisplayName("404 — update non-existent reservation")
        void should_return404_for_nonExistentId() throws Exception {
            var req = new UpdateReservationRequest(tableId, futureDate, LocalTime.of(16, 0), 2);
            mockMvc.perform(put("/api/v1/reservations/{id}", UUID.randomUUID())
                            .header("Authorization", "Bearer " + userToken)
                            .contentType(MediaType.APPLICATION_JSON)
                            .content(objectMapper.writeValueAsString(req)))
                    .andExpect(status().isNotFound());
        }
    }

    // =========================================================================
    // GET /api/v1/reservations/me/history
    // =========================================================================

    @Nested
    @DisplayName("GET /api/v1/reservations/me/history")
    class HistoryTests {

        @Test
        @DisplayName("200 — returns only past/terminal reservations")
        void should_returnPastReservations() throws Exception {
            // past completed reservation
            reservationRepository.save(Reservation.builder()
                    .restaurantId(restaurantId).tableId(tableId)
                    .userId(extractUserId(userToken)).date(LocalDate.now().minusDays(3))
                    .startTime(LocalTime.of(12, 0)).endTime(LocalTime.of(13, 0))
                    .status(ReservationStatus.COMPLETED).partySize(2).build());

            mockMvc.perform(get("/api/v1/reservations/me/history")
                            .header("Authorization", "Bearer " + userToken))
                    .andExpect(status().isOk())
                    .andExpect(jsonPath("$.length()").value(1));
        }

        @Test
        @DisplayName("200 — empty for new user")
        void should_returnEmpty_for_newUser() throws Exception {
            mockMvc.perform(get("/api/v1/reservations/me/history")
                            .header("Authorization", "Bearer " + otherToken))
                    .andExpect(status().isOk())
                    .andExpect(jsonPath("$.length()").value(0));
        }

        @Test
        @DisplayName("401 — no token")
        void should_return401_without_token() throws Exception {
            mockMvc.perform(get("/api/v1/reservations/me/history"))
                    .andExpect(status().isUnauthorized());
        }

        @Test
        @DisplayName("200 — future CONFIRMED reservation NOT in history")
        void should_not_include_futureReservations_inHistory() throws Exception {
            seedReservation(userToken, futureDate, LocalTime.of(14, 0));

            mockMvc.perform(get("/api/v1/reservations/me/history")
                            .header("Authorization", "Bearer " + userToken))
                    .andExpect(status().isOk())
                    .andExpect(jsonPath("$.length()").value(0));
        }
    }

    // =========================================================================
    // POST /api/v1/reservations — validation boundary tests
    // =========================================================================

    @Nested
    @DisplayName("POST /api/v1/reservations — validation")
    class CreateValidationTests {

        @Test
        @DisplayName("400 — null restaurantId")
        void should_return400_when_restaurantIdNull() throws Exception {
            var body = """
                    {"tableId":"%s","date":"%s","startTime":"12:00:00","partySize":2}
                    """.formatted(tableId, futureDate);

            mockMvc.perform(post("/api/v1/reservations")
                            .header("Authorization", "Bearer " + userToken)
                            .contentType(MediaType.APPLICATION_JSON)
                            .content(body))
                    .andExpect(status().isBadRequest());
        }

        @Test
        @DisplayName("400 — null tableId")
        void should_return400_when_tableIdNull() throws Exception {
            var body = """
                    {"restaurantId":"%s","date":"%s","startTime":"12:00:00","partySize":2}
                    """.formatted(restaurantId, futureDate);

            mockMvc.perform(post("/api/v1/reservations")
                            .header("Authorization", "Bearer " + userToken)
                            .contentType(MediaType.APPLICATION_JSON)
                            .content(body))
                    .andExpect(status().isBadRequest());
        }

        @Test
        @DisplayName("400 — null date")
        void should_return400_when_dateNull() throws Exception {
            var body = """
                    {"restaurantId":"%s","tableId":"%s","startTime":"12:00:00","partySize":2}
                    """.formatted(restaurantId, tableId);

            mockMvc.perform(post("/api/v1/reservations")
                            .header("Authorization", "Bearer " + userToken)
                            .contentType(MediaType.APPLICATION_JSON)
                            .content(body))
                    .andExpect(status().isBadRequest());
        }

        @Test
        @DisplayName("400 — date in the past")
        void should_return400_when_dateInPast() throws Exception {
            var body = """
                    {"restaurantId":"%s","tableId":"%s","date":"%s","startTime":"12:00:00","partySize":2}
                    """.formatted(restaurantId, tableId, LocalDate.now().minusDays(1));

            mockMvc.perform(post("/api/v1/reservations")
                            .header("Authorization", "Bearer " + userToken)
                            .contentType(MediaType.APPLICATION_JSON)
                            .content(body))
                    .andExpect(status().isBadRequest());
        }

        @Test
        @DisplayName("400 — partySize = 0 (below @Min(1))")
        void should_return400_when_partySizeZero() throws Exception {
            var req = CreateReservationRequest.builder()
                    .restaurantId(restaurantId).tableId(tableId)
                    .date(futureDate).startTime(LocalTime.of(12, 0)).partySize(0).build();

            mockMvc.perform(post("/api/v1/reservations")
                            .header("Authorization", "Bearer " + userToken)
                            .contentType(MediaType.APPLICATION_JSON)
                            .content(objectMapper.writeValueAsString(req)))
                    .andExpect(status().isBadRequest());
        }

        @Test
        @DisplayName("400 — durationMinutes = 14 (below @Min(15))")
        void should_return400_when_durationBelowMin() throws Exception {
            var req = CreateReservationRequest.builder()
                    .restaurantId(restaurantId).tableId(tableId)
                    .date(futureDate).startTime(LocalTime.of(12, 0)).partySize(2)
                    .durationMinutes(14).build();

            mockMvc.perform(post("/api/v1/reservations")
                            .header("Authorization", "Bearer " + userToken)
                            .contentType(MediaType.APPLICATION_JSON)
                            .content(objectMapper.writeValueAsString(req)))
                    .andExpect(status().isBadRequest());
        }

        @Test
        @DisplayName("400 — durationMinutes = 481 (above @Max(480))")
        void should_return400_when_durationAboveMax() throws Exception {
            var req = CreateReservationRequest.builder()
                    .restaurantId(restaurantId).tableId(tableId)
                    .date(futureDate).startTime(LocalTime.of(12, 0)).partySize(2)
                    .durationMinutes(481).build();

            mockMvc.perform(post("/api/v1/reservations")
                            .header("Authorization", "Bearer " + userToken)
                            .contentType(MediaType.APPLICATION_JSON)
                            .content(objectMapper.writeValueAsString(req)))
                    .andExpect(status().isBadRequest());
        }

        @Test
        @DisplayName("400 — party size exceeds table capacity")
        void should_return400_when_partySizeExceedsCapacity() throws Exception {
            var req = CreateReservationRequest.builder()
                    .restaurantId(restaurantId).tableId(tableId)
                    .date(futureDate).startTime(LocalTime.of(12, 0)).partySize(100).build();

            mockMvc.perform(post("/api/v1/reservations")
                            .header("Authorization", "Bearer " + userToken)
                            .contentType(MediaType.APPLICATION_JSON)
                            .content(objectMapper.writeValueAsString(req)))
                    .andExpect(status().isBadRequest())
                    .andExpect(jsonPath("$.code").value("PARTY_SIZE_EXCEEDS_CAPACITY"));
        }

        // GAP: createReservation does not validate opening hours — booking on a closed day (Sunday)
        //      succeeds with 201 instead of rejecting with 400 RESTAURANT_CLOSED.
        //      ReservationServiceImpl.createReservation() must call validateRestaurantOpen() like
        //      getAvailableSlots() already does.
        @Test
        @DisplayName("400 — restaurant closed on Sunday")
        void should_return400_when_restaurantClosed() throws Exception {
            LocalDate sunday = futureDate;
            while (sunday.getDayOfWeek() != DayOfWeek.SUNDAY) {
                sunday = sunday.plusDays(1);
            }

            var req = CreateReservationRequest.builder()
                    .restaurantId(restaurantId).tableId(tableId)
                    .date(sunday).startTime(LocalTime.of(12, 0)).partySize(2).build();

            mockMvc.perform(post("/api/v1/reservations")
                            .header("Authorization", "Bearer " + userToken)
                            .contentType(MediaType.APPLICATION_JSON)
                            .content(objectMapper.writeValueAsString(req)))
                    .andExpect(status().isBadRequest())
                    .andExpect(jsonPath("$.code").value("RESTAURANT_CLOSED"));
        }
    }

    // =========================================================================
    // GET /api/v1/reservations/me/pending-changes
    // =========================================================================

    @Nested
    @DisplayName("GET /api/v1/reservations/me/pending-changes")
    class PendingChangesTests {

        @Test
        @DisplayName("200 — empty list when no pending changes")
        void should_return_emptyList() throws Exception {
            mockMvc.perform(get("/api/v1/reservations/me/pending-changes")
                            .header("Authorization", "Bearer " + userToken))
                    .andExpect(status().isOk())
                    .andExpect(jsonPath("$.length()").value(0));
        }

        @Test
        @DisplayName("401 — no token")
        void should_return401_without_token() throws Exception {
            mockMvc.perform(get("/api/v1/reservations/me/pending-changes"))
                    .andExpect(status().isUnauthorized());
        }
    }

    // =========================================================================
    // POST /api/v1/reservations/change-requests/{id}/accept and /decline
    // =========================================================================

    @Nested
    @DisplayName("change-request accept/decline")
    class ChangeRequestActionTests {

        @Test
        @DisplayName("404 — accept non-existent change request")
        void should_return404_accept_nonExistent() throws Exception {
            mockMvc.perform(post("/api/v1/reservations/change-requests/{id}/accept", UUID.randomUUID())
                            .header("Authorization", "Bearer " + userToken))
                    .andExpect(status().isNotFound())
                    .andExpect(jsonPath("$.code").value("CHANGE_REQUEST_NOT_FOUND"));
        }

        @Test
        @DisplayName("404 — decline non-existent change request")
        void should_return404_decline_nonExistent() throws Exception {
            mockMvc.perform(post("/api/v1/reservations/change-requests/{id}/decline", UUID.randomUUID())
                            .header("Authorization", "Bearer " + userToken))
                    .andExpect(status().isNotFound())
                    .andExpect(jsonPath("$.code").value("CHANGE_REQUEST_NOT_FOUND"));
        }

        @Test
        @DisplayName("401 — accept without token")
        void should_return401_accept_noToken() throws Exception {
            mockMvc.perform(post("/api/v1/reservations/change-requests/{id}/accept", UUID.randomUUID()))
                    .andExpect(status().isUnauthorized());
        }
    }

    // =========================================================================
    // GET /api/v1/restaurants/{id}/tables/status — availability matrix
    // =========================================================================

    @Nested
    @DisplayName("GET /api/v1/restaurants/{id}/tables/status — OCCUPIED status")
    class TableStatusOccupiedTests {

        @Test
        @DisplayName("200 — CHECKED_IN reservation marks table OCCUPIED")
        void should_return_occupied_when_checkedIn() throws Exception {
            reservationRepository.save(Reservation.builder()
                    .restaurantId(restaurantId).tableId(tableId)
                    .userId(extractUserId(userToken)).date(futureDate)
                    .startTime(LocalTime.of(12, 0)).endTime(LocalTime.of(13, 0))
                    .status(ReservationStatus.CHECKED_IN).partySize(2).build());

            mockMvc.perform(get("/api/v1/restaurants/{id}/tables/status", restaurantId)
                            .param("date", futureDate.toString())
                            .header("Authorization", "Bearer " + userToken))
                    .andExpect(status().isOk())
                    .andExpect(jsonPath("$.tables[?(@.tableId == '" + tableId + "')].status")
                            .value("OCCUPIED"));
        }

        @Test
        @DisplayName("200 — CANCELLED reservation does not affect table status")
        void should_return_free_when_cancelled() throws Exception {
            reservationRepository.save(Reservation.builder()
                    .restaurantId(restaurantId).tableId(tableId)
                    .userId(extractUserId(userToken)).date(futureDate)
                    .startTime(LocalTime.of(12, 0)).endTime(LocalTime.of(13, 0))
                    .status(ReservationStatus.CANCELLED).partySize(2).build());

            mockMvc.perform(get("/api/v1/restaurants/{id}/tables/status", restaurantId)
                            .param("date", futureDate.toString())
                            .header("Authorization", "Bearer " + userToken))
                    .andExpect(status().isOk())
                    .andExpect(jsonPath("$.tables[?(@.tableId == '" + tableId + "')].status")
                            .value("FREE"));
        }
    }

    // =========================================================================
    // Helper methods
    // =========================================================================

    /** Creates a reservation via the API and returns the saved entity. */
    private Reservation seedReservation(String token, LocalDate date, LocalTime startTime) throws Exception {
        var req = CreateReservationRequest.builder()
                .restaurantId(restaurantId).tableId(tableId)
                .date(date).startTime(startTime).partySize(2).build();

        mockMvc.perform(post("/api/v1/reservations")
                        .header("Authorization", "Bearer " + token)
                        .contentType(MediaType.APPLICATION_JSON)
                        .content(objectMapper.writeValueAsString(req)))
                .andExpect(status().isCreated());

        return reservationRepository.findAll().stream()
                .filter(r -> r.getDate().equals(date) && r.getStartTime().equals(startTime))
                .findFirst()
                .orElseThrow();
    }

    /**
     * Extract userId by creating the user and reading from the DB.
     * We look up the user by parsing the token indirectly through the user repo.
     */
    private Long extractUserId(String token) {
        // Pull the user email from the db — both users were already created via getAccessToken
        if (token.equals(userToken)) {
            return userRepository.findByEmail(TEST_EMAIL).orElseThrow().getId();
        }
        return userRepository.findByEmail("other2@checkfood.test").orElseThrow().getId();
    }
}
