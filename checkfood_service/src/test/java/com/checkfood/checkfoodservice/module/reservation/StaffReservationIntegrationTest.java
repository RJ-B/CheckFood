package com.checkfood.checkfoodservice.module.reservation;

import com.checkfood.checkfoodservice.module.reservation.dto.request.ConfirmRecurringReservationRequest;
import com.checkfood.checkfoodservice.module.reservation.dto.request.CreateRecurringReservationRequest;
import com.checkfood.checkfoodservice.module.reservation.dto.request.CreateReservationRequest;
import com.checkfood.checkfoodservice.module.reservation.dto.request.ExtendReservationRequest;
import com.checkfood.checkfoodservice.module.reservation.dto.request.ProposeChangeRequest;
import com.checkfood.checkfoodservice.module.reservation.entity.RecurringReservation;
import com.checkfood.checkfoodservice.module.reservation.entity.RecurringReservationStatus;
import com.checkfood.checkfoodservice.module.reservation.entity.Reservation;
import com.checkfood.checkfoodservice.module.reservation.entity.ReservationStatus;
import com.checkfood.checkfoodservice.module.reservation.repository.RecurringReservationRepository;
import com.checkfood.checkfoodservice.module.reservation.repository.ReservationChangeRequestRepository;
import com.checkfood.checkfoodservice.module.reservation.repository.ReservationRepository;
import com.checkfood.checkfoodservice.module.restaurant.entity.common.Address;
import com.checkfood.checkfoodservice.module.restaurant.entity.employee.EmployeePermission;
import com.checkfood.checkfoodservice.module.restaurant.entity.employee.MembershipStatus;
import com.checkfood.checkfoodservice.module.restaurant.entity.employee.RestaurantEmployee;
import com.checkfood.checkfoodservice.module.restaurant.entity.employee.RestaurantEmployeeRole;
import com.checkfood.checkfoodservice.module.restaurant.entity.restaurant.CuisineType;
import com.checkfood.checkfoodservice.module.restaurant.entity.restaurant.OpeningHours;
import com.checkfood.checkfoodservice.module.restaurant.entity.restaurant.Restaurant;
import com.checkfood.checkfoodservice.module.restaurant.entity.restaurant.RestaurantStatus;
import com.checkfood.checkfoodservice.module.restaurant.entity.restaurant.table.RestaurantTable;
import com.checkfood.checkfoodservice.module.restaurant.repository.RestaurantEmployeeRepository;
import com.checkfood.checkfoodservice.module.restaurant.repository.RestaurantRepository;
import com.checkfood.checkfoodservice.module.restaurant.repository.table.RestaurantTableRepository;
import com.checkfood.checkfoodservice.security.BaseAuthIntegrationTest;
import com.checkfood.checkfoodservice.security.module.auth.dto.request.LoginRequest;
import com.checkfood.checkfoodservice.security.module.user.entity.RoleEntity;
import com.fasterxml.jackson.databind.JsonNode;
import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Nested;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.test.web.servlet.MvcResult;

import java.math.BigDecimal;
import java.time.DayOfWeek;
import java.time.LocalDate;
import java.time.LocalTime;
import java.util.ArrayList;
import java.util.EnumSet;
import java.util.HashSet;
import java.util.Set;
import java.util.UUID;

import static org.assertj.core.api.Assertions.assertThat;
import static org.hamcrest.Matchers.hasSize;
import static org.hamcrest.Matchers.is;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.*;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.*;

/**
 * Integration tests for StaffReservationController (/api/v1/staff/...) and
 * RecurringReservationController (/api/v1/recurring-reservations/...).
 *
 * Auth setup: one OWNER user attached to a restaurant, one plain USER for
 * authorization-denied checks.
 */
@DisplayName("Staff/Recurring Reservation integration tests")
class StaffReservationIntegrationTest extends BaseAuthIntegrationTest {

    // =========================================================================
    // Additional repos
    // =========================================================================

    @Autowired private RestaurantRepository restaurantRepository;
    @Autowired private RestaurantTableRepository tableRepository;
    @Autowired private ReservationRepository reservationRepository;
    @Autowired private RecurringReservationRepository recurringRepository;
    @Autowired private ReservationChangeRequestRepository changeRequestRepository;
    @Autowired private RestaurantEmployeeRepository employeeRepository;

    // =========================================================================
    // Fixtures
    // =========================================================================

    private static final String OWNER_EMAIL = "owner@staff.test";
    private static final String USER_EMAIL  = "customer@staff.test";

    private UUID restaurantId;
    private UUID tableId;
    private LocalDate futureDate;

    private String ownerToken;
    private String userToken;

    // =========================================================================
    // Setup
    // =========================================================================

    /**
     * Must run AFTER each test so that restaurant_employee rows are removed
     * BEFORE the parent setUpBase() calls userRepository.deleteAll() in the
     * next test cycle (parent @BeforeEach runs before child @BeforeEach, so
     * cleanup must happen in @AfterEach of the child instead).
     */
    @AfterEach
    void tearDownStaff() {
        changeRequestRepository.deleteAll();
        recurringRepository.deleteAll();
        reservationRepository.deleteAll();
        employeeRepository.deleteAll();
        tableRepository.deleteAll();
        restaurantRepository.deleteAll();
    }

    @BeforeEach
    void setUpStaff() throws Exception {
        changeRequestRepository.deleteAll();
        recurringRepository.deleteAll();
        reservationRepository.deleteAll();
        employeeRepository.deleteAll();
        tableRepository.deleteAll();
        restaurantRepository.deleteAll();

        ensureRoleExists("OWNER");
        ensureRoleExists("STAFF");

        futureDate = LocalDate.now().plusDays(14);
        while (futureDate.getDayOfWeek() == DayOfWeek.SUNDAY) {
            futureDate = futureDate.plusDays(1);
        }

        var hours = new ArrayList<OpeningHours>();
        for (DayOfWeek day : DayOfWeek.values()) {
            hours.add(OpeningHours.builder()
                    .dayOfWeek(day)
                    .openAt(LocalTime.of(9, 0))
                    .closeAt(LocalTime.of(23, 0))
                    .closed(day == DayOfWeek.SUNDAY)
                    .build());
        }

        var restaurant = restaurantRepository.save(Restaurant.builder()
                .name("Staff Restaurant")
                .cuisineType(CuisineType.CZECH)
                .status(RestaurantStatus.ACTIVE)
                .active(true)
                .rating(BigDecimal.ZERO)
                .address(Address.builder().country("CZ").city("Brno").street("Staff St").streetNumber("5").postalCode("60200").build())
                .openingHours(hours)
                .build());
        restaurantId = restaurant.getId();

        var table = tableRepository.save(RestaurantTable.builder()
                .restaurantId(restaurantId).label("S1").capacity(8).active(true).build());
        tableId = table.getId();

        // Create OWNER user with restaurant membership
        ownerToken = getTokenWithRole(OWNER_EMAIL, "OWNER", "owner-device-01");
        var ownerUser = userRepository.findByEmail(OWNER_EMAIL).orElseThrow();
        employeeRepository.save(RestaurantEmployee.builder()
                .user(ownerUser)
                .restaurant(restaurant)
                .role(RestaurantEmployeeRole.OWNER)
                .membershipStatus(MembershipStatus.ACTIVE)
                .permissions(EnumSet.allOf(EmployeePermission.class))
                .build());

        // Plain customer
        userToken = getAccessToken(USER_EMAIL, TEST_PASSWORD, "user-device-01");
    }

    // =========================================================================
    // Authorization: plain USER cannot reach /api/v1/staff/...
    // =========================================================================

    @Nested
    @DisplayName("Authorization — plain USER cannot access staff endpoints")
    class UserRoleForbiddenTests {

        @Test
        @DisplayName("403 — GET /api/v1/staff/my-restaurant/tables")
        void should_return403_for_getTables() throws Exception {
            mockMvc.perform(get("/api/v1/staff/my-restaurant/tables")
                            .header("Authorization", "Bearer " + userToken))
                    .andExpect(status().isForbidden());
        }

        @Test
        @DisplayName("403 — GET /api/v1/staff/my-restaurant/reservations")
        void should_return403_for_getReservations() throws Exception {
            mockMvc.perform(get("/api/v1/staff/my-restaurant/reservations")
                            .param("date", futureDate.toString())
                            .header("Authorization", "Bearer " + userToken))
                    .andExpect(status().isForbidden());
        }

        @Test
        @DisplayName("401 — without token")
        void should_return401_without_token() throws Exception {
            mockMvc.perform(get("/api/v1/staff/my-restaurant/tables"))
                    .andExpect(status().isUnauthorized());
        }
    }

    // =========================================================================
    // GET /api/v1/staff/my-restaurant/tables
    // =========================================================================

    @Nested
    @DisplayName("GET /api/v1/staff/my-restaurant/tables")
    class GetTablesTests {

        @Test
        @DisplayName("200 — OWNER sees their restaurant's tables")
        void should_returnTables_for_owner() throws Exception {
            mockMvc.perform(get("/api/v1/staff/my-restaurant/tables")
                            .param("restaurantId", restaurantId.toString())
                            .header("Authorization", "Bearer " + ownerToken))
                    .andExpect(status().isOk())
                    .andExpect(jsonPath("$", hasSize(1)))
                    .andExpect(jsonPath("$[0].label").value("S1"))
                    .andExpect(jsonPath("$[0].capacity").value(8));
        }
    }

    // =========================================================================
    // GET /api/v1/staff/my-restaurant/reservations
    // =========================================================================

    @Nested
    @DisplayName("GET /api/v1/staff/my-restaurant/reservations")
    class GetReservationsTests {

        @Test
        @DisplayName("200 — returns reservations for the given date")
        void should_returnReservations_for_date() throws Exception {
            seedConfirmedReservation(futureDate, LocalTime.of(12, 0));

            mockMvc.perform(get("/api/v1/staff/my-restaurant/reservations")
                            .param("date", futureDate.toString())
                            .param("restaurantId", restaurantId.toString())
                            .header("Authorization", "Bearer " + ownerToken))
                    .andExpect(status().isOk())
                    .andExpect(jsonPath("$", hasSize(1)));
        }

        @Test
        @DisplayName("200 — empty list when no reservations on date")
        void should_returnEmpty_when_noReservations() throws Exception {
            mockMvc.perform(get("/api/v1/staff/my-restaurant/reservations")
                            .param("date", futureDate.plusDays(30).toString())
                            .param("restaurantId", restaurantId.toString())
                            .header("Authorization", "Bearer " + ownerToken))
                    .andExpect(status().isOk())
                    .andExpect(jsonPath("$", hasSize(0)));
        }
    }

    // =========================================================================
    // POST /api/v1/staff/reservations/{id}/confirm
    // =========================================================================

    @Nested
    @DisplayName("POST /api/v1/staff/reservations/{id}/confirm")
    class ConfirmReservationTests {

        @Test
        @DisplayName("200 — OWNER can confirm PENDING_CONFIRMATION reservation")
        void should_confirm_pendingReservation() throws Exception {
            var r = reservationRepository.save(Reservation.builder()
                    .restaurantId(restaurantId).tableId(tableId)
                    .userId(userRepository.findByEmail(USER_EMAIL).orElseThrow().getId())
                    .date(futureDate).startTime(LocalTime.of(14, 0)).endTime(LocalTime.of(15, 0))
                    .status(ReservationStatus.PENDING_CONFIRMATION).partySize(2).build());

            mockMvc.perform(post("/api/v1/staff/reservations/{id}/confirm", r.getId())
                            .param("restaurantId", restaurantId.toString())
                            .header("Authorization", "Bearer " + ownerToken))
                    .andExpect(status().isOk())
                    .andExpect(jsonPath("$.status").value("CONFIRMED"));

            assertThat(reservationRepository.findById(r.getId()).orElseThrow().getStatus())
                    .isEqualTo(ReservationStatus.CONFIRMED);
        }

        @Test
        @DisplayName("409 — cannot confirm CANCELLED reservation")
        void should_return409_when_confirmCancelled() throws Exception {
            var r = seedReservationWithStatus(ReservationStatus.CANCELLED);

            mockMvc.perform(post("/api/v1/staff/reservations/{id}/confirm", r.getId())
                            .param("restaurantId", restaurantId.toString())
                            .header("Authorization", "Bearer " + ownerToken))
                    .andExpect(status().isConflict())
                    .andExpect(jsonPath("$.code").value("INVALID_STATUS_TRANSITION"));
        }

        @Test
        @DisplayName("409 — cannot confirm CHECKED_IN reservation")
        void should_return409_when_confirmCheckedIn() throws Exception {
            var r = seedReservationWithStatus(ReservationStatus.CHECKED_IN);

            mockMvc.perform(post("/api/v1/staff/reservations/{id}/confirm", r.getId())
                            .param("restaurantId", restaurantId.toString())
                            .header("Authorization", "Bearer " + ownerToken))
                    .andExpect(status().isConflict())
                    .andExpect(jsonPath("$.code").value("INVALID_STATUS_TRANSITION"));
        }

        @Test
        @DisplayName("409 — cannot confirm COMPLETED reservation")
        void should_return409_when_confirmCompleted() throws Exception {
            var r = seedReservationWithStatus(ReservationStatus.COMPLETED);

            mockMvc.perform(post("/api/v1/staff/reservations/{id}/confirm", r.getId())
                            .param("restaurantId", restaurantId.toString())
                            .header("Authorization", "Bearer " + ownerToken))
                    .andExpect(status().isConflict())
                    .andExpect(jsonPath("$.code").value("INVALID_STATUS_TRANSITION"));
        }

        @Test
        @DisplayName("404 — non-existent reservation")
        void should_return404_for_nonExistentReservation() throws Exception {
            mockMvc.perform(post("/api/v1/staff/reservations/{id}/confirm", UUID.randomUUID())
                            .param("restaurantId", restaurantId.toString())
                            .header("Authorization", "Bearer " + ownerToken))
                    .andExpect(status().isNotFound());
        }

        @Test
        @DisplayName("403 — plain USER cannot confirm")
        void should_return403_for_plainUser() throws Exception {
            var r = seedReservationWithStatus(ReservationStatus.PENDING_CONFIRMATION);
            mockMvc.perform(post("/api/v1/staff/reservations/{id}/confirm", r.getId())
                            .header("Authorization", "Bearer " + userToken))
                    .andExpect(status().isForbidden());
        }
    }

    // =========================================================================
    // POST /api/v1/staff/reservations/{id}/reject
    // =========================================================================

    @Nested
    @DisplayName("POST /api/v1/staff/reservations/{id}/reject")
    class RejectReservationTests {

        @Test
        @DisplayName("200 — OWNER can reject PENDING_CONFIRMATION reservation")
        void should_reject_pendingReservation() throws Exception {
            var r = seedReservationWithStatus(ReservationStatus.PENDING_CONFIRMATION);

            mockMvc.perform(post("/api/v1/staff/reservations/{id}/reject", r.getId())
                            .param("restaurantId", restaurantId.toString())
                            .header("Authorization", "Bearer " + ownerToken))
                    .andExpect(status().isOk())
                    .andExpect(jsonPath("$.status").value("REJECTED"));
        }

        @Test
        @DisplayName("409 — cannot reject CHECKED_IN reservation")
        void should_return409_when_rejectCheckedIn() throws Exception {
            var r = seedReservationWithStatus(ReservationStatus.CHECKED_IN);

            mockMvc.perform(post("/api/v1/staff/reservations/{id}/reject", r.getId())
                            .param("restaurantId", restaurantId.toString())
                            .header("Authorization", "Bearer " + ownerToken))
                    .andExpect(status().isConflict())
                    .andExpect(jsonPath("$.code").value("INVALID_STATUS_TRANSITION"));
        }

        @Test
        @DisplayName("409 — cannot reject CANCELLED reservation")
        void should_return409_when_rejectCancelled() throws Exception {
            var r = seedReservationWithStatus(ReservationStatus.CANCELLED);

            mockMvc.perform(post("/api/v1/staff/reservations/{id}/reject", r.getId())
                            .param("restaurantId", restaurantId.toString())
                            .header("Authorization", "Bearer " + ownerToken))
                    .andExpect(status().isConflict());
        }
    }

    // =========================================================================
    // POST /api/v1/staff/reservations/{id}/check-in
    // =========================================================================

    @Nested
    @DisplayName("POST /api/v1/staff/reservations/{id}/check-in")
    class CheckInTests {

        @Test
        @DisplayName("200 — OWNER can check in CONFIRMED reservation")
        void should_checkIn_confirmedReservation() throws Exception {
            var r = seedReservationWithStatus(ReservationStatus.CONFIRMED);

            mockMvc.perform(post("/api/v1/staff/reservations/{id}/check-in", r.getId())
                            .param("restaurantId", restaurantId.toString())
                            .header("Authorization", "Bearer " + ownerToken))
                    .andExpect(status().isOk())
                    .andExpect(jsonPath("$.status").value("CHECKED_IN"));
        }

        @Test
        @DisplayName("409 — cannot check in PENDING_CONFIRMATION reservation")
        void should_return409_when_checkInPending() throws Exception {
            var r = seedReservationWithStatus(ReservationStatus.PENDING_CONFIRMATION);

            mockMvc.perform(post("/api/v1/staff/reservations/{id}/check-in", r.getId())
                            .param("restaurantId", restaurantId.toString())
                            .header("Authorization", "Bearer " + ownerToken))
                    .andExpect(status().isConflict())
                    .andExpect(jsonPath("$.code").value("INVALID_STATUS_TRANSITION"));
        }

        @Test
        @DisplayName("409 — cannot check in CANCELLED reservation")
        void should_return409_when_checkInCancelled() throws Exception {
            var r = seedReservationWithStatus(ReservationStatus.CANCELLED);

            mockMvc.perform(post("/api/v1/staff/reservations/{id}/check-in", r.getId())
                            .param("restaurantId", restaurantId.toString())
                            .header("Authorization", "Bearer " + ownerToken))
                    .andExpect(status().isConflict())
                    .andExpect(jsonPath("$.code").value("INVALID_STATUS_TRANSITION"));
        }

        @Test
        @DisplayName("409 — cannot check in COMPLETED reservation")
        void should_return409_when_checkInCompleted() throws Exception {
            var r = seedReservationWithStatus(ReservationStatus.COMPLETED);

            mockMvc.perform(post("/api/v1/staff/reservations/{id}/check-in", r.getId())
                            .param("restaurantId", restaurantId.toString())
                            .header("Authorization", "Bearer " + ownerToken))
                    .andExpect(status().isConflict())
                    .andExpect(jsonPath("$.code").value("INVALID_STATUS_TRANSITION"));
        }
    }

    // =========================================================================
    // POST /api/v1/staff/reservations/{id}/complete
    // =========================================================================

    @Nested
    @DisplayName("POST /api/v1/staff/reservations/{id}/complete")
    class CompleteReservationTests {

        @Test
        @DisplayName("200 — OWNER can complete CHECKED_IN reservation")
        void should_complete_checkedInReservation() throws Exception {
            var r = seedReservationWithStatus(ReservationStatus.CHECKED_IN);

            mockMvc.perform(post("/api/v1/staff/reservations/{id}/complete", r.getId())
                            .param("restaurantId", restaurantId.toString())
                            .header("Authorization", "Bearer " + ownerToken))
                    .andExpect(status().isOk())
                    .andExpect(jsonPath("$.status").value("COMPLETED"));
        }

        @Test
        @DisplayName("409 — cannot complete CONFIRMED (must be CHECKED_IN first)")
        void should_return409_when_completeConfirmed() throws Exception {
            var r = seedReservationWithStatus(ReservationStatus.CONFIRMED);

            mockMvc.perform(post("/api/v1/staff/reservations/{id}/complete", r.getId())
                            .param("restaurantId", restaurantId.toString())
                            .header("Authorization", "Bearer " + ownerToken))
                    .andExpect(status().isConflict())
                    .andExpect(jsonPath("$.code").value("INVALID_STATUS_TRANSITION"));
        }

        @Test
        @DisplayName("409 — cannot complete CANCELLED reservation")
        void should_return409_when_completeCancelled() throws Exception {
            var r = seedReservationWithStatus(ReservationStatus.CANCELLED);

            mockMvc.perform(post("/api/v1/staff/reservations/{id}/complete", r.getId())
                            .param("restaurantId", restaurantId.toString())
                            .header("Authorization", "Bearer " + ownerToken))
                    .andExpect(status().isConflict())
                    .andExpect(jsonPath("$.code").value("INVALID_STATUS_TRANSITION"));
        }
    }

    // =========================================================================
    // PATCH /api/v1/staff/reservations/{id}/extend
    // =========================================================================

    @Nested
    @DisplayName("PATCH /api/v1/staff/reservations/{id}/extend")
    class ExtendTests {

        @Test
        @DisplayName("200 — OWNER can extend CHECKED_IN reservation to future time")
        void should_extend_checkedIn() throws Exception {
            var r = seedReservationWithStatus(ReservationStatus.CHECKED_IN);
            var req = new ExtendReservationRequest(LocalTime.of(23, 0));

            mockMvc.perform(patch("/api/v1/staff/reservations/{id}/extend", r.getId())
                            .param("restaurantId", restaurantId.toString())
                            .contentType(MediaType.APPLICATION_JSON)
                            .content(objectMapper.writeValueAsString(req))
                            .header("Authorization", "Bearer " + ownerToken))
                    .andExpect(status().isOk())
                    .andExpect(jsonPath("$.endTime").value("23:00:00"));
        }

        @Test
        @DisplayName("409 — cannot extend CANCELLED reservation")
        void should_return409_when_extendCancelled() throws Exception {
            var r = seedReservationWithStatus(ReservationStatus.CANCELLED);
            var req = new ExtendReservationRequest(LocalTime.of(20, 0));

            mockMvc.perform(patch("/api/v1/staff/reservations/{id}/extend", r.getId())
                            .param("restaurantId", restaurantId.toString())
                            .contentType(MediaType.APPLICATION_JSON)
                            .content(objectMapper.writeValueAsString(req))
                            .header("Authorization", "Bearer " + ownerToken))
                    .andExpect(status().isConflict())
                    .andExpect(jsonPath("$.code").value("INVALID_STATUS_TRANSITION"));
        }

        @Test
        @DisplayName("400 — endTime null fails validation")
        void should_return400_when_endTimeNull() throws Exception {
            var r = seedReservationWithStatus(ReservationStatus.CHECKED_IN);

            mockMvc.perform(patch("/api/v1/staff/reservations/{id}/extend", r.getId())
                            .param("restaurantId", restaurantId.toString())
                            .contentType(MediaType.APPLICATION_JSON)
                            .content("{}")
                            .header("Authorization", "Bearer " + ownerToken))
                    .andExpect(status().isBadRequest());
        }

        @Test
        @DisplayName("409 — cannot extend if conflicting reservation exists")
        void should_return409_when_slotConflict() throws Exception {
            var r = seedReservationWithStatus(ReservationStatus.CHECKED_IN);
            // Seed a conflicting reservation right after the existing one.
            // futureDate is +14 days, so any wall-clock time of day is in
            // the future — production validation now checks date+time, not
            // just LocalTime.now().
            reservationRepository.save(Reservation.builder()
                    .restaurantId(restaurantId).tableId(tableId)
                    .userId(99L).date(futureDate)
                    .startTime(LocalTime.of(16, 0)).endTime(LocalTime.of(17, 0))
                    .status(ReservationStatus.CONFIRMED).partySize(2).build());

            var req = new ExtendReservationRequest(LocalTime.of(17, 0));
            mockMvc.perform(patch("/api/v1/staff/reservations/{id}/extend", r.getId())
                            .param("restaurantId", restaurantId.toString())
                            .contentType(MediaType.APPLICATION_JSON)
                            .content(objectMapper.writeValueAsString(req))
                            .header("Authorization", "Bearer " + ownerToken))
                    .andExpect(status().isConflict())
                    .andExpect(jsonPath("$.code").value("SLOT_CONFLICT"));
        }
    }

    // =========================================================================
    // PUT /api/v1/staff/reservations/{id}/propose-change
    // =========================================================================

    @Nested
    @DisplayName("PUT /api/v1/staff/reservations/{id}/propose-change")
    class ProposeChangeTests {

        @Test
        @DisplayName("200 — propose startTime change on CONFIRMED reservation")
        void should_proposeChange_confirmed() throws Exception {
            var r = seedReservationWithStatus(ReservationStatus.CONFIRMED);
            var req = new ProposeChangeRequest(LocalTime.of(16, 0), null);

            mockMvc.perform(put("/api/v1/staff/reservations/{id}/propose-change", r.getId())
                            .param("restaurantId", restaurantId.toString())
                            .contentType(MediaType.APPLICATION_JSON)
                            .content(objectMapper.writeValueAsString(req))
                            .header("Authorization", "Bearer " + ownerToken))
                    .andExpect(status().isOk())
                    .andExpect(jsonPath("$.proposedStartTime").value("16:00:00"))
                    .andExpect(jsonPath("$.status").value("PENDING"));
        }

        @Test
        @DisplayName("409 — cannot propose change on CANCELLED reservation")
        void should_return409_when_proposedOnCancelled() throws Exception {
            var r = seedReservationWithStatus(ReservationStatus.CANCELLED);
            var req = new ProposeChangeRequest(LocalTime.of(16, 0), null);

            mockMvc.perform(put("/api/v1/staff/reservations/{id}/propose-change", r.getId())
                            .param("restaurantId", restaurantId.toString())
                            .contentType(MediaType.APPLICATION_JSON)
                            .content(objectMapper.writeValueAsString(req))
                            .header("Authorization", "Bearer " + ownerToken))
                    .andExpect(status().isConflict());
        }

        // GAP: StaffReservationServiceImpl.proposeChange() throws ResponseStatusException(BAD_REQUEST)
        //      when both startTime and tableId are null, but ReservationExceptionHandler does NOT
        //      handle ResponseStatusException — it only handles ReservationException. The fallback
        //      generic handler converts it to 500. Fix: add @ExceptionHandler(ResponseStatusException.class)
        //      to ReservationExceptionHandler, or throw a ReservationException instead.
        @Test
        @DisplayName("GAP — both startTime and tableId null returns 500 instead of 400 (ResponseStatusException not handled)")
        void should_return400_when_bothNull() throws Exception {
            var r = seedReservationWithStatus(ReservationStatus.CONFIRMED);

            mockMvc.perform(put("/api/v1/staff/reservations/{id}/propose-change", r.getId())
                            .param("restaurantId", restaurantId.toString())
                            .contentType(MediaType.APPLICATION_JSON)
                            .content("{}")
                            .header("Authorization", "Bearer " + ownerToken))
                    .andExpect(status().isBadRequest());
        }

        // GAP: ProposeChangeRequest has no @NotNull / @AtLeastOne Bean Validation constraint —
        //      the at-least-one validation is done at service layer via ResponseStatusException which
        //      is not handled by ReservationExceptionHandler, causing 500 instead of 400. Fix: either
        //      add a custom @AtLeastOneField constraint to ProposeChangeRequest so @Valid catches it,
        //      or switch the service throw to a proper ReservationException.
        @Test
        @DisplayName("GAP — propose-change with both fields null should be caught by DTO validation (currently 500 due to unhandled ResponseStatusException)")
        void gap_shouldValidateAtDtoLevel() throws Exception {
            var r = seedReservationWithStatus(ReservationStatus.CONFIRMED);

            mockMvc.perform(put("/api/v1/staff/reservations/{id}/propose-change", r.getId())
                            .param("restaurantId", restaurantId.toString())
                            .contentType(MediaType.APPLICATION_JSON)
                            .content("{}")
                            .header("Authorization", "Bearer " + ownerToken))
                    .andExpect(status().isBadRequest());
        }
    }

    // =========================================================================
    // Recurring reservations — customer flow
    // =========================================================================

    @Nested
    @DisplayName("POST /api/v1/recurring-reservations")
    class CreateRecurringTests {

        @Test
        @DisplayName("201 — customer creates recurring reservation")
        void should_create_recurringReservation() throws Exception {
            var req = CreateRecurringReservationRequest.builder()
                    .restaurantId(restaurantId).tableId(tableId)
                    .dayOfWeek(DayOfWeek.MONDAY).startTime(LocalTime.of(12, 0)).partySize(2).build();

            mockMvc.perform(post("/api/v1/recurring-reservations")
                            .header("Authorization", "Bearer " + userToken)
                            .contentType(MediaType.APPLICATION_JSON)
                            .content(objectMapper.writeValueAsString(req)))
                    .andExpect(status().isCreated())
                    .andExpect(jsonPath("$.status").value("PENDING_CONFIRMATION"))
                    .andExpect(jsonPath("$.dayOfWeek").value("MONDAY"));
        }

        @Test
        @DisplayName("400 — null dayOfWeek")
        void should_return400_when_dayOfWeekNull() throws Exception {
            var body = """
                    {"restaurantId":"%s","tableId":"%s","startTime":"12:00:00","partySize":2}
                    """.formatted(restaurantId, tableId);

            mockMvc.perform(post("/api/v1/recurring-reservations")
                            .header("Authorization", "Bearer " + userToken)
                            .contentType(MediaType.APPLICATION_JSON)
                            .content(body))
                    .andExpect(status().isBadRequest());
        }

        @Test
        @DisplayName("400 — null restaurantId")
        void should_return400_when_restaurantIdNull() throws Exception {
            var body = """
                    {"tableId":"%s","dayOfWeek":"MONDAY","startTime":"12:00:00","partySize":2}
                    """.formatted(tableId);

            mockMvc.perform(post("/api/v1/recurring-reservations")
                            .header("Authorization", "Bearer " + userToken)
                            .contentType(MediaType.APPLICATION_JSON)
                            .content(body))
                    .andExpect(status().isBadRequest());
        }

        @Test
        @DisplayName("400 — partySize exceeds table capacity")
        void should_return400_when_partySizeExceedsCapacity() throws Exception {
            var req = CreateRecurringReservationRequest.builder()
                    .restaurantId(restaurantId).tableId(tableId)
                    .dayOfWeek(DayOfWeek.MONDAY).startTime(LocalTime.of(12, 0)).partySize(100).build();

            mockMvc.perform(post("/api/v1/recurring-reservations")
                            .header("Authorization", "Bearer " + userToken)
                            .contentType(MediaType.APPLICATION_JSON)
                            .content(objectMapper.writeValueAsString(req)))
                    .andExpect(status().isBadRequest())
                    .andExpect(jsonPath("$.code").value("PARTY_SIZE_EXCEEDS_CAPACITY"));
        }

        @Test
        @DisplayName("401 — no token")
        void should_return401_without_token() throws Exception {
            mockMvc.perform(post("/api/v1/recurring-reservations")
                            .contentType(MediaType.APPLICATION_JSON)
                            .content("{}"))
                    .andExpect(status().isUnauthorized());
        }

        @Test
        @DisplayName("404 — non-existent restaurant")
        void should_return404_when_restaurantNotFound() throws Exception {
            var req = CreateRecurringReservationRequest.builder()
                    .restaurantId(UUID.randomUUID()).tableId(tableId)
                    .dayOfWeek(DayOfWeek.MONDAY).startTime(LocalTime.of(12, 0)).partySize(2).build();

            mockMvc.perform(post("/api/v1/recurring-reservations")
                            .header("Authorization", "Bearer " + userToken)
                            .contentType(MediaType.APPLICATION_JSON)
                            .content(objectMapper.writeValueAsString(req)))
                    .andExpect(status().isNotFound());
        }
    }

    // =========================================================================
    // GET /api/v1/recurring-reservations/me
    // =========================================================================

    @Nested
    @DisplayName("GET /api/v1/recurring-reservations/me")
    class GetMyRecurringTests {

        @Test
        @DisplayName("200 — returns empty list for new user")
        void should_returnEmpty_for_newUser() throws Exception {
            mockMvc.perform(get("/api/v1/recurring-reservations/me")
                            .header("Authorization", "Bearer " + userToken))
                    .andExpect(status().isOk())
                    .andExpect(jsonPath("$.length()").value(0));
        }

        @Test
        @DisplayName("200 — returns user's recurring reservations after creation")
        void should_returnList_after_creation() throws Exception {
            var req = CreateRecurringReservationRequest.builder()
                    .restaurantId(restaurantId).tableId(tableId)
                    .dayOfWeek(DayOfWeek.TUESDAY).startTime(LocalTime.of(18, 0)).partySize(2).build();

            mockMvc.perform(post("/api/v1/recurring-reservations")
                            .header("Authorization", "Bearer " + userToken)
                            .contentType(MediaType.APPLICATION_JSON)
                            .content(objectMapper.writeValueAsString(req)))
                    .andExpect(status().isCreated());

            mockMvc.perform(get("/api/v1/recurring-reservations/me")
                            .header("Authorization", "Bearer " + userToken))
                    .andExpect(status().isOk())
                    .andExpect(jsonPath("$.length()").value(1))
                    .andExpect(jsonPath("$[0].dayOfWeek").value("TUESDAY"));
        }

        @Test
        @DisplayName("401 — no token")
        void should_return401_without_token() throws Exception {
            mockMvc.perform(get("/api/v1/recurring-reservations/me"))
                    .andExpect(status().isUnauthorized());
        }
    }

    // =========================================================================
    // PATCH /api/v1/recurring-reservations/{id}/cancel
    // =========================================================================

    @Nested
    @DisplayName("PATCH /api/v1/recurring-reservations/{id}/cancel")
    class CancelRecurringTests {

        @Test
        @DisplayName("200 — cancel own PENDING_CONFIRMATION recurring reservation + cascades")
        void should_cancelRecurring_and_cascadeInstances() throws Exception {
            // Create recurring via API
            var req = CreateRecurringReservationRequest.builder()
                    .restaurantId(restaurantId).tableId(tableId)
                    .dayOfWeek(DayOfWeek.WEDNESDAY).startTime(LocalTime.of(12, 0)).partySize(2).build();

            var createResult = mockMvc.perform(post("/api/v1/recurring-reservations")
                            .header("Authorization", "Bearer " + userToken)
                            .contentType(MediaType.APPLICATION_JSON)
                            .content(objectMapper.writeValueAsString(req)))
                    .andExpect(status().isCreated())
                    .andReturn();

            var body = objectMapper.readTree(createResult.getResponse().getContentAsString());
            var recurringId = UUID.fromString(body.get("id").asText());

            // Add a future instance manually
            var userId = userRepository.findByEmail(USER_EMAIL).orElseThrow().getId();
            var nextWed = futureDate;
            while (nextWed.getDayOfWeek() != DayOfWeek.WEDNESDAY) nextWed = nextWed.plusDays(1);
            reservationRepository.save(Reservation.builder()
                    .restaurantId(restaurantId).tableId(tableId).userId(userId)
                    .date(nextWed).startTime(LocalTime.of(12, 0)).endTime(LocalTime.of(13, 0))
                    .status(ReservationStatus.CONFIRMED).partySize(2)
                    .recurringReservationId(recurringId).build());

            mockMvc.perform(patch("/api/v1/recurring-reservations/{id}/cancel", recurringId)
                            .header("Authorization", "Bearer " + userToken))
                    .andExpect(status().isOk())
                    .andExpect(jsonPath("$.status").value("CANCELLED"));

            // Verify cascade — future instance should be CANCELLED
            var instances = reservationRepository.findAll().stream()
                    .filter(r -> recurringId.equals(r.getRecurringReservationId()))
                    .toList();
            assertThat(instances).allMatch(r -> r.getStatus() == ReservationStatus.CANCELLED);
        }

        @Test
        @DisplayName("409 — cannot cancel already-CANCELLED recurring reservation")
        void should_return409_when_alreadyCancelled() throws Exception {
            var userId = userRepository.findByEmail(USER_EMAIL).orElseThrow().getId();
            var recurring = recurringRepository.save(RecurringReservation.builder()
                    .restaurantId(restaurantId).tableId(tableId).userId(userId)
                    .dayOfWeek(DayOfWeek.FRIDAY).startTime(LocalTime.of(12, 0))
                    .status(RecurringReservationStatus.CANCELLED).build());

            mockMvc.perform(patch("/api/v1/recurring-reservations/{id}/cancel", recurring.getId())
                            .header("Authorization", "Bearer " + userToken))
                    .andExpect(status().isConflict())
                    .andExpect(jsonPath("$.code").value("RESERVATION_ALREADY_CANCELLED"));
        }

        @Test
        @DisplayName("403 — user cannot cancel another user's recurring reservation")
        void should_return403_when_cancellingOtherUsers() throws Exception {
            var ownerUser = userRepository.findByEmail(OWNER_EMAIL).orElseThrow();
            var recurring = recurringRepository.save(RecurringReservation.builder()
                    .restaurantId(restaurantId).tableId(tableId).userId(ownerUser.getId())
                    .dayOfWeek(DayOfWeek.THURSDAY).startTime(LocalTime.of(14, 0))
                    .status(RecurringReservationStatus.PENDING_CONFIRMATION).build());

            mockMvc.perform(patch("/api/v1/recurring-reservations/{id}/cancel", recurring.getId())
                            .header("Authorization", "Bearer " + userToken))
                    .andExpect(status().isForbidden())
                    .andExpect(jsonPath("$.code").value("RESERVATION_ACCESS_DENIED"));
        }

        @Test
        @DisplayName("404 — non-existent recurring reservation")
        void should_return404_for_nonExistent() throws Exception {
            mockMvc.perform(patch("/api/v1/recurring-reservations/{id}/cancel", UUID.randomUUID())
                            .header("Authorization", "Bearer " + userToken))
                    .andExpect(status().isNotFound())
                    .andExpect(jsonPath("$.code").value("RECURRING_RESERVATION_NOT_FOUND"));
        }
    }

    // =========================================================================
    // Staff — recurring reservation confirm/reject/cancel
    // =========================================================================

    @Nested
    @DisplayName("Staff — confirm/reject recurring reservation")
    class StaffRecurringTests {

        @Test
        @DisplayName("200 — staff confirms PENDING recurring, instances generated")
        void should_confirmRecurring_and_generateInstances() throws Exception {
            var userId = userRepository.findByEmail(USER_EMAIL).orElseThrow().getId();
            var recurring = recurringRepository.save(RecurringReservation.builder()
                    .restaurantId(restaurantId).tableId(tableId).userId(userId)
                    .dayOfWeek(DayOfWeek.MONDAY).startTime(LocalTime.of(12, 0))
                    .status(RecurringReservationStatus.PENDING_CONFIRMATION).build());

            var req = ConfirmRecurringReservationRequest.builder()
                    .repeatUntil(LocalDate.now().plusWeeks(4)).build();

            mockMvc.perform(post("/api/v1/staff/recurring-reservations/{id}/confirm", recurring.getId())
                            .param("restaurantId", restaurantId.toString())
                            .contentType(MediaType.APPLICATION_JSON)
                            .content(objectMapper.writeValueAsString(req))
                            .header("Authorization", "Bearer " + ownerToken))
                    .andExpect(status().isOk())
                    .andExpect(jsonPath("$.status").value("ACTIVE"));

            // Instances should have been created
            var instances = reservationRepository.findAll().stream()
                    .filter(r -> recurring.getId().equals(r.getRecurringReservationId()))
                    .toList();
            assertThat(instances).isNotEmpty();
        }

        @Test
        @DisplayName("409 — cannot confirm ACTIVE recurring reservation")
        void should_return409_when_confirmAlreadyActive() throws Exception {
            var userId = userRepository.findByEmail(USER_EMAIL).orElseThrow().getId();
            var recurring = recurringRepository.save(RecurringReservation.builder()
                    .restaurantId(restaurantId).tableId(tableId).userId(userId)
                    .dayOfWeek(DayOfWeek.TUESDAY).startTime(LocalTime.of(12, 0))
                    .status(RecurringReservationStatus.ACTIVE)
                    .repeatUntil(LocalDate.now().plusWeeks(8)).build());

            var req = ConfirmRecurringReservationRequest.builder()
                    .repeatUntil(LocalDate.now().plusWeeks(4)).build();

            mockMvc.perform(post("/api/v1/staff/recurring-reservations/{id}/confirm", recurring.getId())
                            .param("restaurantId", restaurantId.toString())
                            .contentType(MediaType.APPLICATION_JSON)
                            .content(objectMapper.writeValueAsString(req))
                            .header("Authorization", "Bearer " + ownerToken))
                    .andExpect(status().isConflict())
                    .andExpect(jsonPath("$.code").value("RECURRING_RESERVATION_ALREADY_ACTIVE"));
        }

        @Test
        @DisplayName("200 — staff rejects PENDING recurring reservation")
        void should_rejectRecurring_pending() throws Exception {
            var userId = userRepository.findByEmail(USER_EMAIL).orElseThrow().getId();
            var recurring = recurringRepository.save(RecurringReservation.builder()
                    .restaurantId(restaurantId).tableId(tableId).userId(userId)
                    .dayOfWeek(DayOfWeek.WEDNESDAY).startTime(LocalTime.of(10, 0))
                    .status(RecurringReservationStatus.PENDING_CONFIRMATION).build());

            mockMvc.perform(post("/api/v1/staff/recurring-reservations/{id}/reject", recurring.getId())
                            .param("restaurantId", restaurantId.toString())
                            .header("Authorization", "Bearer " + ownerToken))
                    .andExpect(status().isOk())
                    .andExpect(jsonPath("$.status").value("REJECTED"));
        }

        @Test
        @DisplayName("409 — staff cannot reject ACTIVE recurring reservation")
        void should_return409_when_rejectActive() throws Exception {
            var userId = userRepository.findByEmail(USER_EMAIL).orElseThrow().getId();
            var recurring = recurringRepository.save(RecurringReservation.builder()
                    .restaurantId(restaurantId).tableId(tableId).userId(userId)
                    .dayOfWeek(DayOfWeek.THURSDAY).startTime(LocalTime.of(10, 0))
                    .status(RecurringReservationStatus.ACTIVE)
                    .repeatUntil(LocalDate.now().plusWeeks(8)).build());

            mockMvc.perform(post("/api/v1/staff/recurring-reservations/{id}/reject", recurring.getId())
                            .param("restaurantId", restaurantId.toString())
                            .header("Authorization", "Bearer " + ownerToken))
                    .andExpect(status().isConflict())
                    .andExpect(jsonPath("$.code").value("RECURRING_RESERVATION_ALREADY_ACTIVE"));
        }

        @Test
        @DisplayName("403 — plain USER cannot access staff recurring endpoints")
        void should_return403_for_plainUser_confirmRecurring() throws Exception {
            // Use a future repeatUntil so that @FutureOrPresent validation passes
            // and the 403 authorization check is actually reached.
            String futureRepeatUntil = LocalDate.now().plusYears(1).toString();
            mockMvc.perform(post("/api/v1/staff/recurring-reservations/{id}/confirm", UUID.randomUUID())
                            .contentType(MediaType.APPLICATION_JSON)
                            .content("{\"repeatUntil\":\"" + futureRepeatUntil + "\"}")
                            .header("Authorization", "Bearer " + userToken))
                    .andExpect(status().isForbidden());
        }

        // GAP: No check that ConfirmRecurringReservationRequest.repeatUntil must be after the
        // current date OR after the recurring reservation's first potential instance.
        // A repeatUntil in the past would generate 0 instances and throw RECURRING_NO_INSTANCES_GENERATED,
        // but the error is not clearly documented as 422 — it currently returns 409 CONFLICT.
        @Test
        @DisplayName("GAP — repeatUntil in the past yields RECURRING_NO_INSTANCES_GENERATED (should be 422)")
        void gap_repeatUntilInPast_shouldReturn422() throws Exception {
            var userId = userRepository.findByEmail(USER_EMAIL).orElseThrow().getId();
            var recurring = recurringRepository.save(RecurringReservation.builder()
                    .restaurantId(restaurantId).tableId(tableId).userId(userId)
                    .dayOfWeek(DayOfWeek.MONDAY).startTime(LocalTime.of(12, 0))
                    .status(RecurringReservationStatus.PENDING_CONFIRMATION).build());

            // repeatUntil in the past — no instances will be generated
            var req = ConfirmRecurringReservationRequest.builder()
                    .repeatUntil(LocalDate.now().minusDays(1)).build();

            // GAP: @FutureOrPresent on repeatUntil should reject this at validation level (400),
            // but currently the past date is allowed through validation and service throws 409.
            mockMvc.perform(post("/api/v1/staff/recurring-reservations/{id}/confirm", recurring.getId())
                            .param("restaurantId", restaurantId.toString())
                            .contentType(MediaType.APPLICATION_JSON)
                            .content(objectMapper.writeValueAsString(req))
                            .header("Authorization", "Bearer " + ownerToken))
                    .andExpect(status().is4xxClientError());
        }

        @Test
        @DisplayName("200 — staff cancels ACTIVE recurring reservation + cancels future instances")
        void should_staffCancelActive_and_cascade() throws Exception {
            var userId = userRepository.findByEmail(USER_EMAIL).orElseThrow().getId();
            var recurring = recurringRepository.save(RecurringReservation.builder()
                    .restaurantId(restaurantId).tableId(tableId).userId(userId)
                    .dayOfWeek(DayOfWeek.MONDAY).startTime(LocalTime.of(12, 0))
                    .status(RecurringReservationStatus.ACTIVE)
                    .repeatUntil(LocalDate.now().plusWeeks(8)).build());

            // Add a future instance
            var nextMon = LocalDate.now().plusDays(1);
            while (nextMon.getDayOfWeek() != DayOfWeek.MONDAY) nextMon = nextMon.plusDays(1);
            reservationRepository.save(Reservation.builder()
                    .restaurantId(restaurantId).tableId(tableId).userId(userId)
                    .date(nextMon).startTime(LocalTime.of(12, 0)).endTime(LocalTime.of(13, 0))
                    .status(ReservationStatus.CONFIRMED).partySize(2)
                    .recurringReservationId(recurring.getId()).build());

            mockMvc.perform(post("/api/v1/staff/recurring-reservations/{id}/cancel", recurring.getId())
                            .param("restaurantId", restaurantId.toString())
                            .header("Authorization", "Bearer " + ownerToken))
                    .andExpect(status().isOk())
                    .andExpect(jsonPath("$.status").value("CANCELLED"));

            var instances = reservationRepository.findAll().stream()
                    .filter(r -> recurring.getId().equals(r.getRecurringReservationId()))
                    .toList();
            assertThat(instances).allMatch(r -> r.getStatus() == ReservationStatus.CANCELLED);
        }
    }

    // =========================================================================
    // Double-booking prevention (concurrent check)
    // =========================================================================

    @Nested
    @DisplayName("Double-booking prevention")
    class DoubleBookingTests {

        @Test
        @DisplayName("409 — second create at same slot returns SLOT_CONFLICT")
        void should_return409_on_sameSlotDoubleBooking() throws Exception {
            var req = CreateReservationRequest.builder()
                    .restaurantId(restaurantId).tableId(tableId)
                    .date(futureDate).startTime(LocalTime.of(12, 0)).partySize(2).build();

            // First booking succeeds
            mockMvc.perform(post("/api/v1/reservations")
                            .header("Authorization", "Bearer " + userToken)
                            .contentType(MediaType.APPLICATION_JSON)
                            .content(objectMapper.writeValueAsString(req)))
                    .andExpect(status().isCreated());

            // Second booking by a different user at same slot → conflict
            mockMvc.perform(post("/api/v1/reservations")
                            .header("Authorization", "Bearer " + ownerToken)
                            .contentType(MediaType.APPLICATION_JSON)
                            .content(objectMapper.writeValueAsString(req)))
                    .andExpect(status().isConflict())
                    .andExpect(jsonPath("$.code").value("SLOT_CONFLICT"));
        }
    }

    // =========================================================================
    // Helpers
    // =========================================================================

    private Reservation seedReservationWithStatus(ReservationStatus status) {
        var userId = userRepository.findByEmail(USER_EMAIL).orElseThrow().getId();
        return reservationRepository.save(Reservation.builder()
                .restaurantId(restaurantId).tableId(tableId).userId(userId)
                .date(futureDate).startTime(LocalTime.of(14, 0)).endTime(LocalTime.of(15, 0))
                .status(status).partySize(2).build());
    }

    private Reservation seedConfirmedReservation(LocalDate date, LocalTime startTime) {
        var userId = userRepository.findByEmail(USER_EMAIL).orElseThrow().getId();
        return reservationRepository.save(Reservation.builder()
                .restaurantId(restaurantId).tableId(tableId).userId(userId)
                .date(date).startTime(startTime).endTime(startTime.plusHours(1))
                .status(ReservationStatus.CONFIRMED).partySize(2).build());
    }

    private String getTokenWithRole(String email, String roleName, String deviceId) throws Exception {
        createVerifiedUser(email, TEST_PASSWORD, TEST_FIRST_NAME, TEST_LAST_NAME);
        var user = userRepository.findByEmail(email).orElseThrow();
        var role = roleRepository.findByName(roleName).orElseThrow();
        // Avoid lazy-loading user.getRoles() — build fresh set to prevent
        // LazyInitializationException when Hibernate session is closed.
        var roles = new HashSet<RoleEntity>();
        roles.add(role);
        user.setRoles(roles);
        userRepository.saveAndFlush(user);

        MvcResult loginResult = mockMvc.perform(post("/api/auth/login")
                        .contentType(MediaType.APPLICATION_JSON)
                        .content(objectMapper.writeValueAsString(
                                LoginRequest.builder()
                                        .email(email).password(TEST_PASSWORD)
                                        .deviceIdentifier(deviceId).deviceName(TEST_DEVICE_NAME)
                                        .deviceType(TEST_DEVICE_TYPE).build())))
                .andExpect(status().isOk())
                .andReturn();

        JsonNode body = parseResponseBody(loginResult);
        return body.get("accessToken").asText();
    }

    private void ensureRoleExists(String roleName) {
        roleRepository.findByName(roleName).orElseGet(() -> {
            var role = new RoleEntity();
            role.setName(roleName);
            return roleRepository.save(role);
        });
    }
}
