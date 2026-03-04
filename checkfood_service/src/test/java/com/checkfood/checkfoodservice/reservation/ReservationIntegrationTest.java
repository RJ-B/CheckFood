package com.checkfood.checkfoodservice.reservation;

import com.checkfood.checkfoodservice.module.reservation.dto.request.CreateReservationRequest;
import com.checkfood.checkfoodservice.module.reservation.entity.Reservation;
import com.checkfood.checkfoodservice.module.reservation.entity.ReservationStatus;
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
import java.util.*;

import static org.assertj.core.api.Assertions.assertThat;
import static org.hamcrest.Matchers.*;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.get;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.post;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.*;

/**
 * End-to-end integration tests for the reservation module.
 *
 * Covers all 5 endpoints:
 * 1. GET  /api/v1/restaurants/{id}/reservation-scene
 * 2. GET  /api/v1/restaurants/{id}/tables/status?date=...
 * 3. GET  /api/v1/restaurants/{id}/tables/{tid}/available-slots?date=...
 * 4. POST /api/v1/reservations
 * 5. GET  /api/v1/reservations/me
 *
 * Uses H2 in-memory database (test profile) with deterministic seed data.
 */
class ReservationIntegrationTest extends BaseAuthIntegrationTest {

    // =========================================================================
    // Dependencies
    // =========================================================================

    @Autowired
    private RestaurantRepository restaurantRepository;

    @Autowired
    private RestaurantTableRepository tableRepository;

    @Autowired
    private ReservationRepository reservationRepository;

    // =========================================================================
    // Test data references (populated in setUp)
    // =========================================================================

    private UUID restaurantId;
    private UUID freeTableId;         // table with no reservations
    private UUID reservedTableId;     // table with a future reservation
    private UUID tableNoYawPitchId;   // table without panorama coords (should be excluded from scene)

    /** A date in the future (avoids LocalDate.now() code paths). */
    private LocalDate testDate;

    /** DayOfWeek corresponding to testDate (for opening hours). */
    private DayOfWeek testDayOfWeek;

    private String accessToken;

    // =========================================================================
    // Setup
    // =========================================================================

    @BeforeEach
    void setUpReservation() throws Exception {
        // Clean reservation-specific data (order matters)
        reservationRepository.deleteAll();
        tableRepository.deleteAll();
        // Delete restaurants, but opening hours are cascade-deleted via ElementCollection
        restaurantRepository.deleteAll();

        // Deterministic future date (7 days from now, always in the future)
        testDate = LocalDate.now().plusDays(7);
        testDayOfWeek = testDate.getDayOfWeek();

        // Seed restaurant with opening hours
        seedRestaurant();

        // Seed tables
        seedTables();

        // Seed one existing reservation on the reserved table
        seedExistingReservation();

        // Get JWT for the test user
        accessToken = getAccessToken(TEST_EMAIL, TEST_PASSWORD, TEST_DEVICE_ID);
    }

    // =========================================================================
    // 1. RESERVATION SCENE
    // =========================================================================

    @Nested
    @DisplayName("GET /api/v1/restaurants/{id}/reservation-scene")
    class ReservationSceneTests {

        @Test
        @DisplayName("200 — returns panoramaUrl and tables with yaw/pitch")
        void shouldReturnSceneWithTablesAndPanorama() throws Exception {
            mockMvc.perform(get("/api/v1/restaurants/{id}/reservation-scene", restaurantId)
                            .header("Authorization", "Bearer " + accessToken))
                    .andExpect(status().isOk())
                    .andExpect(jsonPath("$.restaurantId").value(restaurantId.toString()))
                    .andExpect(jsonPath("$.panoramaUrl").value("/panoramas/test.jpg"))
                    .andExpect(jsonPath("$.tables", hasSize(2))) // only tables WITH yaw/pitch
                    .andExpect(jsonPath("$.tables[*].tableId",
                            containsInAnyOrder(freeTableId.toString(), reservedTableId.toString())))
                    .andExpect(jsonPath("$.tables[0].yaw").isNumber())
                    .andExpect(jsonPath("$.tables[0].pitch").isNumber())
                    .andExpect(jsonPath("$.tables[0].label").isString())
                    .andExpect(jsonPath("$.tables[0].capacity").isNumber());
        }

        @Test
        @DisplayName("200 — excludes tables without yaw/pitch from scene")
        void shouldExcludeTablesWithoutYawPitch() throws Exception {
            mockMvc.perform(get("/api/v1/restaurants/{id}/reservation-scene", restaurantId)
                            .header("Authorization", "Bearer " + accessToken))
                    .andExpect(status().isOk())
                    .andExpect(jsonPath("$.tables[*].tableId",
                            not(hasItem(tableNoYawPitchId.toString()))));
        }

        @Test
        @DisplayName("404 — non-existent restaurant")
        void shouldReturn404ForNonExistentRestaurant() throws Exception {
            mockMvc.perform(get("/api/v1/restaurants/{id}/reservation-scene", UUID.randomUUID())
                            .header("Authorization", "Bearer " + accessToken))
                    .andExpect(status().isNotFound());
        }

        @Test
        @DisplayName("401 — without JWT token")
        void shouldReturn401WithoutToken() throws Exception {
            mockMvc.perform(get("/api/v1/restaurants/{id}/reservation-scene", restaurantId))
                    .andExpect(status().isUnauthorized());
        }
    }

    // =========================================================================
    // 2. TABLE STATUSES
    // =========================================================================

    @Nested
    @DisplayName("GET /api/v1/restaurants/{id}/tables/status")
    class TableStatusTests {

        @Test
        @DisplayName("200 — returns correct FREE/RESERVED statuses for future date")
        void shouldReturnCorrectStatuses() throws Exception {
            mockMvc.perform(get("/api/v1/restaurants/{id}/tables/status", restaurantId)
                            .param("date", testDate.toString())
                            .header("Authorization", "Bearer " + accessToken))
                    .andExpect(status().isOk())
                    .andExpect(jsonPath("$.date").value(testDate.toString()))
                    .andExpect(jsonPath("$.tables", hasSize(3))) // all active tables
                    .andExpect(jsonPath("$.tables[?(@.tableId == '%s')].status", freeTableId.toString())
                            .value("FREE"))
                    .andExpect(jsonPath("$.tables[?(@.tableId == '%s')].status", reservedTableId.toString())
                            .value("RESERVED"));
        }

        @Test
        @DisplayName("200 — all FREE when no reservations on date")
        void shouldReturnAllFreeForDateWithoutReservations() throws Exception {
            // Use a different date with no reservations
            LocalDate emptyDate = testDate.plusDays(30);

            mockMvc.perform(get("/api/v1/restaurants/{id}/tables/status", restaurantId)
                            .param("date", emptyDate.toString())
                            .header("Authorization", "Bearer " + accessToken))
                    .andExpect(status().isOk())
                    .andExpect(jsonPath("$.tables[*].status", everyItem(is("FREE"))));
        }

        @Test
        @DisplayName("401 — without JWT token")
        void shouldReturn401WithoutToken() throws Exception {
            mockMvc.perform(get("/api/v1/restaurants/{id}/tables/status", restaurantId)
                            .param("date", testDate.toString()))
                    .andExpect(status().isUnauthorized());
        }
    }

    // =========================================================================
    // 3. AVAILABLE SLOTS
    // =========================================================================

    @Nested
    @DisplayName("GET /api/v1/restaurants/{id}/tables/{tid}/available-slots")
    class AvailableSlotsTests {

        @Test
        @DisplayName("200 — returns available slots for free table")
        void shouldReturnSlotsForFreeTable() throws Exception {
            mockMvc.perform(get("/api/v1/restaurants/{id}/tables/{tid}/available-slots",
                            restaurantId, freeTableId)
                            .param("date", testDate.toString())
                            .header("Authorization", "Bearer " + accessToken))
                    .andExpect(status().isOk())
                    .andExpect(jsonPath("$.date").value(testDate.toString()))
                    .andExpect(jsonPath("$.tableId").value(freeTableId.toString()))
                    .andExpect(jsonPath("$.slotMinutes").value(30))
                    // Open-ended model: last slot = closeAt - 30min = 21:30
                    // Slots from 10:00 to 21:30 in 30-min increments = 24 slots
                    .andExpect(jsonPath("$.availableStartTimes", hasSize(24)))
                    .andExpect(jsonPath("$.availableStartTimes[0]").value("10:00:00"))
                    .andExpect(jsonPath("$.availableStartTimes[1]").value("10:30:00"));
        }

        @Test
        @DisplayName("200 — excludes slots blocked by active open-ended reservation")
        void shouldExcludeOverlappingSlots() throws Exception {
            // The reserved table has an active reservation starting at 12:00 (open-ended).
            // Open-ended model: slot is blocked if any active reservation has startTime <= candidate.
            // So all slots from 12:00 onward are blocked.
            // Available: 10:00, 10:30, 11:00, 11:30 = 4 slots

            var result = mockMvc.perform(get("/api/v1/restaurants/{id}/tables/{tid}/available-slots",
                            restaurantId, reservedTableId)
                            .param("date", testDate.toString())
                            .header("Authorization", "Bearer " + accessToken))
                    .andExpect(status().isOk())
                    .andExpect(jsonPath("$.availableStartTimes", hasSize(4)))
                    .andReturn();

            String body = result.getResponse().getContentAsString();
            // 12:00 and later should NOT be available
            assertThat(body).doesNotContain("\"12:00:00\"");
            assertThat(body).doesNotContain("\"13:00:00\"");
            assertThat(body).doesNotContain("\"13:30:00\"");
            // Slots before 12:00 should be available
            assertThat(body).contains("\"10:00:00\"");
            assertThat(body).contains("\"10:30:00\"");
            assertThat(body).contains("\"11:00:00\"");
            assertThat(body).contains("\"11:30:00\"");
        }

        @Test
        @DisplayName("200 — returns empty list when restaurant is closed")
        void shouldReturnEmptyWhenClosed() throws Exception {
            // Find a day that's closed — we set Sunday as closed in seed
            // Find the next Sunday from testDate
            LocalDate sunday = testDate;
            while (sunday.getDayOfWeek() != DayOfWeek.SUNDAY) {
                sunday = sunday.plusDays(1);
            }

            mockMvc.perform(get("/api/v1/restaurants/{id}/tables/{tid}/available-slots",
                            restaurantId, freeTableId)
                            .param("date", sunday.toString())
                            .header("Authorization", "Bearer " + accessToken))
                    .andExpect(status().isOk())
                    .andExpect(jsonPath("$.availableStartTimes", hasSize(0)));
        }

        @Test
        @DisplayName("400 — table not belonging to restaurant")
        void shouldReturn400ForTableNotInRestaurant() throws Exception {
            // Create a table in a different restaurant
            var otherRestaurant = restaurantRepository.save(Restaurant.builder()
                    .ownerId(UUID.randomUUID())
                    .name("Other Restaurant")
                    .cuisineType(CuisineType.ITALIAN)
                    .status(RestaurantStatus.ACTIVE)
                    .active(true)
                    .rating(BigDecimal.ZERO)
                    .build());
            var otherTable = tableRepository.save(RestaurantTable.builder()
                    .restaurantId(otherRestaurant.getId())
                    .label("Other Table")
                    .capacity(4)
                    .active(true)
                    .build());

            mockMvc.perform(get("/api/v1/restaurants/{id}/tables/{tid}/available-slots",
                            restaurantId, otherTable.getId())
                            .param("date", testDate.toString())
                            .header("Authorization", "Bearer " + accessToken))
                    .andExpect(status().isBadRequest());
        }

        @Test
        @DisplayName("401 — without JWT token")
        void shouldReturn401WithoutToken() throws Exception {
            mockMvc.perform(get("/api/v1/restaurants/{id}/tables/{tid}/available-slots",
                            restaurantId, freeTableId)
                            .param("date", testDate.toString()))
                    .andExpect(status().isUnauthorized());
        }
    }

    // =========================================================================
    // 4. CREATE RESERVATION
    // =========================================================================

    @Nested
    @DisplayName("POST /api/v1/reservations")
    class CreateReservationTests {

        @Test
        @DisplayName("201 — creates reservation successfully")
        void shouldCreateReservation() throws Exception {
            var request = CreateReservationRequest.builder()
                    .restaurantId(restaurantId)
                    .tableId(freeTableId)
                    .date(testDate)
                    .startTime(LocalTime.of(18, 0))
                    .partySize(3)
                    .build();

            mockMvc.perform(post("/api/v1/reservations")
                            .header("Authorization", "Bearer " + accessToken)
                            .contentType(MediaType.APPLICATION_JSON)
                            .content(objectMapper.writeValueAsString(request)))
                    .andExpect(status().isCreated())
                    .andExpect(jsonPath("$.id").isNotEmpty())
                    .andExpect(jsonPath("$.restaurantId").value(restaurantId.toString()))
                    .andExpect(jsonPath("$.tableId").value(freeTableId.toString()))
                    .andExpect(jsonPath("$.date").value(testDate.toString()))
                    .andExpect(jsonPath("$.startTime").value("18:00:00"))
                    .andExpect(jsonPath("$.endTime").value(nullValue())) // open-ended: no endTime
                    .andExpect(jsonPath("$.status").value("PENDING_CONFIRMATION"))
                    .andExpect(jsonPath("$.partySize").value(3));

            // Verify in DB
            List<Reservation> all = reservationRepository.findAllByTableIdAndDateAndStatusNotIn(
                    freeTableId, testDate, List.of(ReservationStatus.CANCELLED, ReservationStatus.REJECTED));
            assertThat(all).hasSize(1);
            assertThat(all.get(0).getStartTime()).isEqualTo(LocalTime.of(18, 0));
            assertThat(all.get(0).getEndTime()).isNull(); // open-ended: endTime is null
        }

        @Test
        @DisplayName("409 — conflict when slot already taken")
        void shouldReturn409OnConflict() throws Exception {
            // Try to book the same slot as the existing reservation (12:00 on reservedTable)
            var request = CreateReservationRequest.builder()
                    .restaurantId(restaurantId)
                    .tableId(reservedTableId)
                    .date(testDate)
                    .startTime(LocalTime.of(12, 0))
                    .partySize(2)
                    .build();

            mockMvc.perform(post("/api/v1/reservations")
                            .header("Authorization", "Bearer " + accessToken)
                            .contentType(MediaType.APPLICATION_JSON)
                            .content(objectMapper.writeValueAsString(request)))
                    .andExpect(status().isConflict())
                    .andExpect(jsonPath("$.code").value("SLOT_CONFLICT"));
        }

        @Test
        @DisplayName("409 — conflict when booking after active open-ended reservation")
        void shouldReturn409WhenBookingAfterActiveReservation() throws Exception {
            // Existing active reservation starts at 12:00 (open-ended).
            // New: 14:00 → existing.startTime (12:00) <= 14:00 → CONFLICT
            var request = CreateReservationRequest.builder()
                    .restaurantId(restaurantId)
                    .tableId(reservedTableId)
                    .date(testDate)
                    .startTime(LocalTime.of(14, 0))
                    .partySize(2)
                    .build();

            mockMvc.perform(post("/api/v1/reservations")
                            .header("Authorization", "Bearer " + accessToken)
                            .contentType(MediaType.APPLICATION_JSON)
                            .content(objectMapper.writeValueAsString(request)))
                    .andExpect(status().isConflict());
        }

        @Test
        @DisplayName("201 — booking before active reservation succeeds")
        void shouldSucceedForSlotBeforeActiveReservation() throws Exception {
            // Existing active reservation starts at 12:00 (open-ended).
            // New: 10:00 → existing.startTime (12:00) <= 10:00 is FALSE → no conflict
            var request = CreateReservationRequest.builder()
                    .restaurantId(restaurantId)
                    .tableId(reservedTableId)
                    .date(testDate)
                    .startTime(LocalTime.of(10, 0))
                    .partySize(2)
                    .build();

            mockMvc.perform(post("/api/v1/reservations")
                            .header("Authorization", "Bearer " + accessToken)
                            .contentType(MediaType.APPLICATION_JSON)
                            .content(objectMapper.writeValueAsString(request)))
                    .andExpect(status().isCreated())
                    .andExpect(jsonPath("$.startTime").value("10:00:00"))
                    .andExpect(jsonPath("$.endTime").value(nullValue()));
        }

        @Test
        @DisplayName("401 — without JWT token")
        void shouldReturn401WithoutToken() throws Exception {
            var request = CreateReservationRequest.builder()
                    .restaurantId(restaurantId)
                    .tableId(freeTableId)
                    .date(testDate)
                    .startTime(LocalTime.of(18, 0))
                    .partySize(2)
                    .build();

            mockMvc.perform(post("/api/v1/reservations")
                            .contentType(MediaType.APPLICATION_JSON)
                            .content(objectMapper.writeValueAsString(request)))
                    .andExpect(status().isUnauthorized());
        }

        @Test
        @DisplayName("400 — validation error: missing required fields")
        void shouldReturn400ForMissingFields() throws Exception {
            // Empty body
            mockMvc.perform(post("/api/v1/reservations")
                            .header("Authorization", "Bearer " + accessToken)
                            .contentType(MediaType.APPLICATION_JSON)
                            .content("{}"))
                    .andExpect(status().isBadRequest());
        }

        @Test
        @DisplayName("404 — non-existent restaurant")
        void shouldReturn404ForNonExistentRestaurant() throws Exception {
            var request = CreateReservationRequest.builder()
                    .restaurantId(UUID.randomUUID())
                    .tableId(freeTableId)
                    .date(testDate)
                    .startTime(LocalTime.of(18, 0))
                    .partySize(2)
                    .build();

            mockMvc.perform(post("/api/v1/reservations")
                            .header("Authorization", "Bearer " + accessToken)
                            .contentType(MediaType.APPLICATION_JSON)
                            .content(objectMapper.writeValueAsString(request)))
                    .andExpect(status().isNotFound());
        }
    }

    // =========================================================================
    // 5. MY RESERVATIONS
    // =========================================================================

    @Nested
    @DisplayName("GET /api/v1/reservations/me")
    class MyReservationsTests {

        @Test
        @DisplayName("200 — returns empty upcoming/history for user without reservations")
        void shouldReturnEmptyListForNewUser() throws Exception {
            mockMvc.perform(get("/api/v1/reservations/me")
                            .header("Authorization", "Bearer " + accessToken))
                    .andExpect(status().isOk())
                    .andExpect(jsonPath("$.upcoming", hasSize(0)))
                    .andExpect(jsonPath("$.history", hasSize(0)))
                    .andExpect(jsonPath("$.totalHistoryCount").value(0));
        }

        @Test
        @DisplayName("200 — returns newly created reservation with restaurant name and table label")
        void shouldReturnReservationAfterCreation() throws Exception {
            // First, create a reservation
            var request = CreateReservationRequest.builder()
                    .restaurantId(restaurantId)
                    .tableId(freeTableId)
                    .date(testDate)
                    .startTime(LocalTime.of(14, 0))
                    .partySize(4)
                    .build();

            mockMvc.perform(post("/api/v1/reservations")
                            .header("Authorization", "Bearer " + accessToken)
                            .contentType(MediaType.APPLICATION_JSON)
                            .content(objectMapper.writeValueAsString(request)))
                    .andExpect(status().isCreated());

            // Now check "my reservations" — response is {upcoming: [...], history: [...], totalHistoryCount: N}
            mockMvc.perform(get("/api/v1/reservations/me")
                            .header("Authorization", "Bearer " + accessToken))
                    .andExpect(status().isOk())
                    .andExpect(jsonPath("$.upcoming", hasSize(1)))
                    .andExpect(jsonPath("$.upcoming[0].restaurantName").value("Test Restaurant"))
                    .andExpect(jsonPath("$.upcoming[0].tableLabel").value("Stůl A"))
                    .andExpect(jsonPath("$.upcoming[0].date").value(testDate.toString()))
                    .andExpect(jsonPath("$.upcoming[0].startTime").value("14:00:00"))
                    .andExpect(jsonPath("$.upcoming[0].partySize").value(4));
        }

        @Test
        @DisplayName("200 — different user does not see other's reservations")
        void shouldNotReturnOtherUsersReservations() throws Exception {
            // Create reservation as main user
            var request = CreateReservationRequest.builder()
                    .restaurantId(restaurantId)
                    .tableId(freeTableId)
                    .date(testDate)
                    .startTime(LocalTime.of(16, 0))
                    .partySize(2)
                    .build();

            mockMvc.perform(post("/api/v1/reservations")
                            .header("Authorization", "Bearer " + accessToken)
                            .contentType(MediaType.APPLICATION_JSON)
                            .content(objectMapper.writeValueAsString(request)))
                    .andExpect(status().isCreated());

            // Register a second user and get their token
            String otherToken = getAccessToken(
                    "other@checkfood.test", TEST_PASSWORD, "test-device-002");

            // Second user should see empty upcoming list
            mockMvc.perform(get("/api/v1/reservations/me")
                            .header("Authorization", "Bearer " + otherToken))
                    .andExpect(status().isOk())
                    .andExpect(jsonPath("$.upcoming", hasSize(0)));
        }

        @Test
        @DisplayName("401 — without JWT token")
        void shouldReturn401WithoutToken() throws Exception {
            mockMvc.perform(get("/api/v1/reservations/me"))
                    .andExpect(status().isUnauthorized());
        }
    }

    // =========================================================================
    // 6. SLOT ALGORITHM EDGE CASES
    // =========================================================================

    @Nested
    @DisplayName("Slot algorithm — edge cases")
    class SlotAlgorithmEdgeCases {

        @Test
        @DisplayName("Cancelled reservation does not block slots")
        void cancelledReservationShouldNotBlockSlots() throws Exception {
            // Seed a CANCELLED reservation on the free table
            reservationRepository.save(Reservation.builder()
                    .restaurantId(restaurantId)
                    .tableId(freeTableId)
                    .userId(1L)
                    .date(testDate)
                    .startTime(LocalTime.of(14, 0))
                    .endTime(LocalTime.of(15, 30))
                    .status(ReservationStatus.CANCELLED)
                    .build());

            // All 24 slots should still be available (cancelled doesn't block)
            mockMvc.perform(get("/api/v1/restaurants/{id}/tables/{tid}/available-slots",
                            restaurantId, freeTableId)
                            .param("date", testDate.toString())
                            .header("Authorization", "Bearer " + accessToken))
                    .andExpect(status().isOk())
                    .andExpect(jsonPath("$.availableStartTimes", hasSize(24)));
        }

        @Test
        @DisplayName("Completed reservation does not block, active reservation blocks from startTime onward")
        void completedDoesNotBlockActiveBlocksFromStart() throws Exception {
            // COMPLETED reservation at 10:00 (with endTime set) — should NOT block
            reservationRepository.save(Reservation.builder()
                    .restaurantId(restaurantId)
                    .tableId(freeTableId)
                    .userId(1L)
                    .date(testDate)
                    .startTime(LocalTime.of(10, 0))
                    .endTime(LocalTime.of(11, 30))
                    .status(ReservationStatus.COMPLETED)
                    .build());
            // Active reservation at 18:00 (open-ended) — blocks 18:00 onward
            reservationRepository.save(Reservation.builder()
                    .restaurantId(restaurantId)
                    .tableId(freeTableId)
                    .userId(1L)
                    .date(testDate)
                    .startTime(LocalTime.of(18, 0))
                    .status(ReservationStatus.RESERVED)
                    .build());

            var result = mockMvc.perform(get("/api/v1/restaurants/{id}/tables/{tid}/available-slots",
                            restaurantId, freeTableId)
                            .param("date", testDate.toString())
                            .header("Authorization", "Bearer " + accessToken))
                    .andExpect(status().isOk())
                    .andReturn();

            String body = result.getResponse().getContentAsString();
            // 10:00 should be available (COMPLETED doesn't block)
            assertThat(body).contains("\"10:00:00\"");
            // 18:00 and later should NOT be available (active blocks)
            assertThat(body).doesNotContain("\"18:00:00\"");
            assertThat(body).doesNotContain("\"18:30:00\"");
            // 17:30 should be available (before active reservation)
            assertThat(body).contains("\"17:30:00\"");
        }

        @Test
        @DisplayName("Double-booking same slot returns 409")
        void shouldPreventDoubleBooking() throws Exception {
            var request = CreateReservationRequest.builder()
                    .restaurantId(restaurantId)
                    .tableId(freeTableId)
                    .date(testDate)
                    .startTime(LocalTime.of(15, 0))
                    .partySize(2)
                    .build();

            // First booking succeeds
            mockMvc.perform(post("/api/v1/reservations")
                            .header("Authorization", "Bearer " + accessToken)
                            .contentType(MediaType.APPLICATION_JSON)
                            .content(objectMapper.writeValueAsString(request)))
                    .andExpect(status().isCreated());

            // Second booking for exact same slot → conflict
            mockMvc.perform(post("/api/v1/reservations")
                            .header("Authorization", "Bearer " + accessToken)
                            .contentType(MediaType.APPLICATION_JSON)
                            .content(objectMapper.writeValueAsString(request)))
                    .andExpect(status().isConflict())
                    .andExpect(jsonPath("$.code").value("SLOT_CONFLICT"));
        }
    }

    // =========================================================================
    // Seed helpers
    // =========================================================================

    private void seedRestaurant() {
        Address address = Address.builder()
                .street("Test Street")
                .streetNumber("1")
                .city("Test City")
                .postalCode("12345")
                .country("CZ")
                .build();

        // Opening hours: Mon-Sat 10:00–22:00, Sunday CLOSED
        List<OpeningHours> hours = new ArrayList<>();
        for (int i = 1; i <= 6; i++) { // Mon–Sat
            hours.add(OpeningHours.builder()
                    .dayOfWeek(DayOfWeek.of(i))
                    .openAt(LocalTime.of(10, 0))
                    .closeAt(LocalTime.of(22, 0))
                    .closed(false)
                    .build());
        }
        hours.add(OpeningHours.builder()
                .dayOfWeek(DayOfWeek.SUNDAY)
                .openAt(null)
                .closeAt(null)
                .closed(true)
                .build());

        Restaurant restaurant = Restaurant.builder()
                .ownerId(UUID.randomUUID())
                .name("Test Restaurant")
                .description("Integration test restaurant")
                .cuisineType(CuisineType.CZECH)
                .panoramaUrl("/panoramas/test.jpg")
                .status(RestaurantStatus.ACTIVE)
                .active(true)
                .rating(new BigDecimal("4.0"))
                .address(address)
                .openingHours(hours)
                .tags(new HashSet<>(List.of("test")))
                .build();

        restaurant = restaurantRepository.save(restaurant);
        restaurantId = restaurant.getId();
    }

    private void seedTables() {
        // Table A: fully free, has yaw/pitch
        RestaurantTable freeTable = tableRepository.save(RestaurantTable.builder()
                .restaurantId(restaurantId)
                .label("Stůl A")
                .capacity(4)
                .active(true)
                .yaw(45.0)
                .pitch(-5.0)
                .build());
        freeTableId = freeTable.getId();

        // Table B: will have a reservation, has yaw/pitch
        RestaurantTable reservedTable = tableRepository.save(RestaurantTable.builder()
                .restaurantId(restaurantId)
                .label("Stůl B")
                .capacity(6)
                .active(true)
                .yaw(180.0)
                .pitch(-8.0)
                .build());
        reservedTableId = reservedTable.getId();

        // Table C: no yaw/pitch (should be excluded from scene)
        RestaurantTable noCoordTable = tableRepository.save(RestaurantTable.builder()
                .restaurantId(restaurantId)
                .label("Stůl C")
                .capacity(2)
                .active(true)
                .yaw(null)
                .pitch(null)
                .build());
        tableNoYawPitchId = noCoordTable.getId();
    }

    private void seedExistingReservation() {
        // Active reservation on reservedTable: starts at 12:00, open-ended (no endTime)
        reservationRepository.save(Reservation.builder()
                .restaurantId(restaurantId)
                .tableId(reservedTableId)
                .userId(999L) // system/other user
                .date(testDate)
                .startTime(LocalTime.of(12, 0))
                .status(ReservationStatus.RESERVED)
                .partySize(4)
                .build());
    }
}
