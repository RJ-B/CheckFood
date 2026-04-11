package com.checkfood.checkfoodservice.module.reservation;

import com.checkfood.checkfoodservice.module.reservation.dto.request.ConfirmRecurringReservationRequest;
import com.checkfood.checkfoodservice.module.reservation.dto.request.ExtendReservationRequest;
import com.checkfood.checkfoodservice.module.reservation.dto.request.ProposeChangeRequest;
import com.checkfood.checkfoodservice.module.reservation.entity.RecurringReservation;
import com.checkfood.checkfoodservice.module.reservation.entity.RecurringReservationStatus;
import com.checkfood.checkfoodservice.module.reservation.entity.Reservation;
import com.checkfood.checkfoodservice.module.reservation.entity.ReservationStatus;
import com.checkfood.checkfoodservice.module.reservation.exception.ReservationErrorCode;
import com.checkfood.checkfoodservice.module.reservation.exception.ReservationException;
import com.checkfood.checkfoodservice.module.reservation.logging.ReservationLogger;
import com.checkfood.checkfoodservice.module.reservation.repository.RecurringReservationRepository;
import com.checkfood.checkfoodservice.module.reservation.repository.ReservationChangeRequestRepository;
import com.checkfood.checkfoodservice.module.reservation.repository.ReservationRepository;
import com.checkfood.checkfoodservice.module.reservation.service.RecurringReservationServiceImpl;
import com.checkfood.checkfoodservice.module.reservation.service.StaffReservationServiceImpl;
import com.checkfood.checkfoodservice.module.restaurant.entity.employee.EmployeePermission;
import com.checkfood.checkfoodservice.module.restaurant.entity.employee.MembershipStatus;
import com.checkfood.checkfoodservice.module.restaurant.entity.employee.RestaurantEmployee;
import com.checkfood.checkfoodservice.module.restaurant.entity.employee.RestaurantEmployeeRole;
import com.checkfood.checkfoodservice.module.restaurant.entity.restaurant.CuisineType;
import com.checkfood.checkfoodservice.module.restaurant.entity.restaurant.Restaurant;
import com.checkfood.checkfoodservice.module.restaurant.entity.restaurant.RestaurantStatus;
import com.checkfood.checkfoodservice.module.restaurant.entity.restaurant.table.RestaurantTable;
import com.checkfood.checkfoodservice.module.restaurant.exception.RestaurantException;
import com.checkfood.checkfoodservice.module.restaurant.repository.RestaurantEmployeeRepository;
import com.checkfood.checkfoodservice.module.restaurant.repository.RestaurantRepository;
import com.checkfood.checkfoodservice.module.restaurant.repository.table.RestaurantTableRepository;
import com.checkfood.checkfoodservice.security.module.user.entity.UserEntity;
import com.checkfood.checkfoodservice.security.module.user.service.UserService;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Nested;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;

import java.math.BigDecimal;
import java.time.Clock;
import java.time.DayOfWeek;
import java.time.LocalDate;
import java.time.LocalTime;
import java.time.ZoneId;
import java.util.EnumSet;
import java.util.List;
import java.util.Optional;
import java.util.UUID;

import static org.assertj.core.api.Assertions.assertThat;
import static org.assertj.core.api.Assertions.assertThatThrownBy;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.Mockito.when;

@ExtendWith(MockitoExtension.class)
@DisplayName("StaffReservationService unit tests")
class StaffReservationServiceTest {

    @Mock private ReservationRepository reservationRepository;
    @Mock private RecurringReservationRepository recurringRepository;
    @Mock private RestaurantRepository restaurantRepository;
    @Mock private RestaurantTableRepository tableRepository;
    @Mock private RestaurantEmployeeRepository employeeRepository;
    @Mock private ReservationChangeRequestRepository changeRequestRepository;
    @Mock private UserService userService;
    @Mock private ReservationLogger reservationLogger;
    @Mock private RecurringReservationServiceImpl recurringReservationService;

    @InjectMocks
    private StaffReservationServiceImpl service;

    private static final String STAFF_EMAIL = "staff@restaurant.test";
    private static final UUID RESTAURANT_ID = UUID.randomUUID();
    private static final UUID TABLE_ID = UUID.randomUUID();

    private UserEntity staffUser;
    private Restaurant restaurant;
    private RestaurantEmployee ownerMembership;
    private RestaurantEmployee staffMembership;

    @BeforeEach
    void setUp() {
        var fixedInstant = java.time.LocalDateTime.of(2025, 1, 13, 12, 0)
                .toInstant(java.time.ZoneOffset.UTC);
        Clock clock = Clock.fixed(fixedInstant, ZoneId.of("UTC"));
        service = new StaffReservationServiceImpl(
                reservationRepository, recurringRepository, restaurantRepository,
                tableRepository, employeeRepository, changeRequestRepository,
                userService, reservationLogger, recurringReservationService, clock);

        staffUser = new UserEntity();
        staffUser.setId(42L);
        staffUser.setEmail(STAFF_EMAIL);

        restaurant = Restaurant.builder()
                .id(RESTAURANT_ID)
                .ownerId(UUID.randomUUID())
                .name("Test Restaurant")
                .cuisineType(CuisineType.CZECH)
                .status(RestaurantStatus.ACTIVE)
                .active(true)
                .rating(BigDecimal.ZERO)
                .build();

        ownerMembership = RestaurantEmployee.builder()
                .id(1L)
                .user(staffUser)
                .restaurant(restaurant)
                .role(RestaurantEmployeeRole.OWNER)
                .membershipStatus(MembershipStatus.ACTIVE)
                .permissions(EnumSet.allOf(EmployeePermission.class))
                .build();

        staffMembership = RestaurantEmployee.builder()
                .id(2L)
                .user(staffUser)
                .restaurant(restaurant)
                .role(RestaurantEmployeeRole.STAFF)
                .membershipStatus(MembershipStatus.ACTIVE)
                .permissions(EmployeePermission.defaultsForRole(RestaurantEmployeeRole.STAFF))
                .build();
    }

    // =========================================================================
    // Helpers
    // =========================================================================

    private void givenOwnerMembership() {
        when(userService.findByEmail(STAFF_EMAIL)).thenReturn(staffUser);
        when(employeeRepository.findByUserIdAndRestaurantId(staffUser.getId(), RESTAURANT_ID))
                .thenReturn(Optional.of(ownerMembership));
    }

    private void givenStaffMembership() {
        when(userService.findByEmail(STAFF_EMAIL)).thenReturn(staffUser);
        when(employeeRepository.findByUserIdAndRestaurantId(staffUser.getId(), RESTAURANT_ID))
                .thenReturn(Optional.of(staffMembership));
    }

    private Reservation confirmedReservation() {
        return Reservation.builder()
                .id(UUID.randomUUID())
                .restaurantId(RESTAURANT_ID)
                .tableId(TABLE_ID)
                .userId(99L)
                .date(LocalDate.of(2025, 2, 10))
                .startTime(LocalTime.of(12, 0))
                .endTime(LocalTime.of(13, 0))
                .status(ReservationStatus.CONFIRMED)
                .partySize(2)
                .build();
    }

    // =========================================================================
    // findActiveMembership guard
    // =========================================================================

    @Nested
    @DisplayName("membership guard")
    class MembershipGuardTests {

        @Test
        @DisplayName("throws 403 when staff has no membership")
        void should_throw403_when_noMembership() {
            when(userService.findByEmail(STAFF_EMAIL)).thenReturn(staffUser);
            when(employeeRepository.findByUserIdAndRestaurantId(staffUser.getId(), RESTAURANT_ID))
                    .thenReturn(Optional.empty());

            assertThatThrownBy(() -> service.confirmReservation(UUID.randomUUID(), STAFF_EMAIL, RESTAURANT_ID))
                    .isInstanceOf(ReservationException.class)
                    .satisfies(e -> assertThat(((ReservationException) e).getErrorCode())
                            .isEqualTo(ReservationErrorCode.NOT_RESTAURANT_STAFF));
        }

        @Test
        @DisplayName("throws 403 when membership is PENDING (not ACTIVE)")
        void should_throw403_when_pendingMembership() {
            var pendingMembership = RestaurantEmployee.builder()
                    .id(3L).user(staffUser).restaurant(restaurant)
                    .role(RestaurantEmployeeRole.STAFF)
                    .membershipStatus(MembershipStatus.PENDING)
                    .build();

            when(userService.findByEmail(STAFF_EMAIL)).thenReturn(staffUser);
            when(employeeRepository.findByUserIdAndRestaurantId(staffUser.getId(), RESTAURANT_ID))
                    .thenReturn(Optional.of(pendingMembership));

            assertThatThrownBy(() -> service.confirmReservation(UUID.randomUUID(), STAFF_EMAIL, RESTAURANT_ID))
                    .isInstanceOf(ReservationException.class)
                    .satisfies(e -> assertThat(((ReservationException) e).getErrorCode())
                            .isEqualTo(ReservationErrorCode.NOT_RESTAURANT_STAFF));
        }
    }

    // =========================================================================
    // State transitions — confirmReservation
    // =========================================================================

    @Nested
    @DisplayName("confirmReservation — state transitions")
    class ConfirmReservationTests {

        @Test
        @DisplayName("409 — cannot confirm CHECKED_IN reservation")
        void should_throw409_when_confirmCheckedIn() {
            givenOwnerMembership();
            var r = confirmedReservation();
            r.setStatus(ReservationStatus.CHECKED_IN);
            when(reservationRepository.findById(r.getId())).thenReturn(Optional.of(r));

            assertThatThrownBy(() -> service.confirmReservation(r.getId(), STAFF_EMAIL, RESTAURANT_ID))
                    .isInstanceOf(ReservationException.class)
                    .satisfies(e -> assertThat(((ReservationException) e).getErrorCode())
                            .isEqualTo(ReservationErrorCode.INVALID_STATUS_TRANSITION));
        }

        @Test
        @DisplayName("409 — cannot confirm CANCELLED reservation")
        void should_throw409_when_confirmCancelled() {
            givenOwnerMembership();
            var r = confirmedReservation();
            r.setStatus(ReservationStatus.CANCELLED);
            when(reservationRepository.findById(r.getId())).thenReturn(Optional.of(r));

            assertThatThrownBy(() -> service.confirmReservation(r.getId(), STAFF_EMAIL, RESTAURANT_ID))
                    .isInstanceOf(ReservationException.class)
                    .satisfies(e -> assertThat(((ReservationException) e).getErrorCode())
                            .isEqualTo(ReservationErrorCode.INVALID_STATUS_TRANSITION));
        }

        @Test
        @DisplayName("409 — cannot confirm COMPLETED reservation")
        void should_throw409_when_confirmCompleted() {
            givenOwnerMembership();
            var r = confirmedReservation();
            r.setStatus(ReservationStatus.COMPLETED);
            when(reservationRepository.findById(r.getId())).thenReturn(Optional.of(r));

            assertThatThrownBy(() -> service.confirmReservation(r.getId(), STAFF_EMAIL, RESTAURANT_ID))
                    .isInstanceOf(ReservationException.class)
                    .satisfies(e -> assertThat(((ReservationException) e).getErrorCode())
                            .isEqualTo(ReservationErrorCode.INVALID_STATUS_TRANSITION));
        }

        @Test
        @DisplayName("403 — STAFF role lacks CONFIRM_RESERVATION permission")
        void should_throw403_when_staffLacksConfirmPermission() {
            // Strip CONFIRM from the staff member
            staffMembership.setPermissions(EnumSet.of(
                    EmployeePermission.CHECK_IN_RESERVATION, EmployeePermission.COMPLETE_RESERVATION));
            givenStaffMembership();

            assertThatThrownBy(() -> service.confirmReservation(UUID.randomUUID(), STAFF_EMAIL, RESTAURANT_ID))
                    .isInstanceOf(RestaurantException.class);
        }

        @Test
        @DisplayName("403 — staff cannot operate on another restaurant's reservation")
        void should_throw403_when_reservationBelongsToDifferentRestaurant() {
            givenOwnerMembership();
            var r = confirmedReservation();
            r.setRestaurantId(UUID.randomUUID()); // different restaurant
            r.setStatus(ReservationStatus.PENDING_CONFIRMATION);
            when(reservationRepository.findById(r.getId())).thenReturn(Optional.of(r));

            assertThatThrownBy(() -> service.confirmReservation(r.getId(), STAFF_EMAIL, RESTAURANT_ID))
                    .isInstanceOf(ReservationException.class)
                    .satisfies(e -> assertThat(((ReservationException) e).getErrorCode())
                            .isEqualTo(ReservationErrorCode.NOT_RESTAURANT_STAFF));
        }
    }

    // =========================================================================
    // State transitions — checkInReservation
    // =========================================================================

    @Nested
    @DisplayName("checkInReservation — state transitions")
    class CheckInReservationTests {

        @Test
        @DisplayName("409 — cannot check in CANCELLED reservation")
        void should_throw409_when_checkInCancelled() {
            givenOwnerMembership();
            var r = confirmedReservation();
            r.setStatus(ReservationStatus.CANCELLED);
            when(reservationRepository.findById(r.getId())).thenReturn(Optional.of(r));

            assertThatThrownBy(() -> service.checkInReservation(r.getId(), STAFF_EMAIL, RESTAURANT_ID))
                    .isInstanceOf(ReservationException.class)
                    .satisfies(e -> assertThat(((ReservationException) e).getErrorCode())
                            .isEqualTo(ReservationErrorCode.INVALID_STATUS_TRANSITION));
        }

        @Test
        @DisplayName("409 — cannot check in PENDING_CONFIRMATION reservation")
        void should_throw409_when_checkInPendingConfirmation() {
            givenOwnerMembership();
            var r = confirmedReservation();
            r.setStatus(ReservationStatus.PENDING_CONFIRMATION);
            when(reservationRepository.findById(r.getId())).thenReturn(Optional.of(r));

            assertThatThrownBy(() -> service.checkInReservation(r.getId(), STAFF_EMAIL, RESTAURANT_ID))
                    .isInstanceOf(ReservationException.class)
                    .satisfies(e -> assertThat(((ReservationException) e).getErrorCode())
                            .isEqualTo(ReservationErrorCode.INVALID_STATUS_TRANSITION));
        }

        @Test
        @DisplayName("409 — cannot check in COMPLETED reservation")
        void should_throw409_when_checkInCompleted() {
            givenOwnerMembership();
            var r = confirmedReservation();
            r.setStatus(ReservationStatus.COMPLETED);
            when(reservationRepository.findById(r.getId())).thenReturn(Optional.of(r));

            assertThatThrownBy(() -> service.checkInReservation(r.getId(), STAFF_EMAIL, RESTAURANT_ID))
                    .isInstanceOf(ReservationException.class)
                    .satisfies(e -> assertThat(((ReservationException) e).getErrorCode())
                            .isEqualTo(ReservationErrorCode.INVALID_STATUS_TRANSITION));
        }
    }

    // =========================================================================
    // State transitions — completeReservation
    // =========================================================================

    @Nested
    @DisplayName("completeReservation — state transitions")
    class CompleteReservationTests {

        @Test
        @DisplayName("409 — cannot complete CONFIRMED (must be CHECKED_IN)")
        void should_throw409_when_completeConfirmed() {
            givenOwnerMembership();
            var r = confirmedReservation();
            r.setStatus(ReservationStatus.CONFIRMED);
            when(reservationRepository.findById(r.getId())).thenReturn(Optional.of(r));

            assertThatThrownBy(() -> service.completeReservation(r.getId(), STAFF_EMAIL, RESTAURANT_ID))
                    .isInstanceOf(ReservationException.class)
                    .satisfies(e -> assertThat(((ReservationException) e).getErrorCode())
                            .isEqualTo(ReservationErrorCode.INVALID_STATUS_TRANSITION));
        }

        @Test
        @DisplayName("409 — cannot complete CANCELLED reservation")
        void should_throw409_when_completeCancelled() {
            givenOwnerMembership();
            var r = confirmedReservation();
            r.setStatus(ReservationStatus.CANCELLED);
            when(reservationRepository.findById(r.getId())).thenReturn(Optional.of(r));

            assertThatThrownBy(() -> service.completeReservation(r.getId(), STAFF_EMAIL, RESTAURANT_ID))
                    .isInstanceOf(ReservationException.class)
                    .satisfies(e -> assertThat(((ReservationException) e).getErrorCode())
                            .isEqualTo(ReservationErrorCode.INVALID_STATUS_TRANSITION));
        }

        @Test
        @DisplayName("200 — complete CHECKED_IN reservation transitions to COMPLETED")
        void should_complete_checkedIn_reservation() {
            givenOwnerMembership();
            var r = confirmedReservation();
            r.setStatus(ReservationStatus.CHECKED_IN);
            when(reservationRepository.findById(r.getId())).thenReturn(Optional.of(r));
            when(reservationRepository.save(any())).thenAnswer(inv -> inv.getArgument(0));
            when(restaurantRepository.findById(any())).thenReturn(Optional.of(restaurant));
            when(tableRepository.findById(any())).thenReturn(Optional.of(
                    RestaurantTable.builder().id(TABLE_ID).label("A1").capacity(4).active(true)
                            .restaurantId(RESTAURANT_ID).build()));

            var result = service.completeReservation(r.getId(), STAFF_EMAIL, RESTAURANT_ID);

            assertThat(result.getStatus()).isEqualTo(ReservationStatus.COMPLETED);
        }
    }

    // =========================================================================
    // extendReservation
    // =========================================================================

    @Nested
    @DisplayName("extendReservation")
    class ExtendReservationTests {

        @Test
        @DisplayName("409 — cannot extend CANCELLED reservation")
        void should_throw409_when_extendCancelled() {
            givenOwnerMembership();
            var r = confirmedReservation();
            r.setStatus(ReservationStatus.CANCELLED);
            when(reservationRepository.findById(r.getId())).thenReturn(Optional.of(r));

            var req = new ExtendReservationRequest(LocalTime.of(14, 0));
            assertThatThrownBy(() -> service.extendReservation(r.getId(), req, STAFF_EMAIL, RESTAURANT_ID))
                    .isInstanceOf(ReservationException.class)
                    .satisfies(e -> assertThat(((ReservationException) e).getErrorCode())
                            .isEqualTo(ReservationErrorCode.INVALID_STATUS_TRANSITION));
        }

        @Test
        @DisplayName("400 — endTime in the past is rejected")
        void should_throw400_when_endTimeInPast() {
            givenOwnerMembership();
            var r = confirmedReservation();
            r.setStatus(ReservationStatus.CHECKED_IN);
            when(reservationRepository.findById(r.getId())).thenReturn(Optional.of(r));

            // Clock is fixed at 12:00, so 11:00 is in the past
            var req = new ExtendReservationRequest(LocalTime.of(11, 0));
            assertThatThrownBy(() -> service.extendReservation(r.getId(), req, STAFF_EMAIL, RESTAURANT_ID))
                    .isInstanceOf(ReservationException.class)
                    .satisfies(e -> assertThat(((ReservationException) e).getErrorCode())
                            .isEqualTo(ReservationErrorCode.INVALID_RESERVATION_TIME));
        }

        @Test
        @DisplayName("409 — cannot extend when slot conflict exists")
        void should_throw409_when_slotConflictOnExtend() {
            givenOwnerMembership();
            var r = confirmedReservation();
            r.setStatus(ReservationStatus.CHECKED_IN);
            when(reservationRepository.findById(r.getId())).thenReturn(Optional.of(r));
            when(reservationRepository.existsOverlappingReservationExcluding(any(), any(), any(), any(), any()))
                    .thenReturn(true);

            var req = new ExtendReservationRequest(LocalTime.of(15, 0));
            assertThatThrownBy(() -> service.extendReservation(r.getId(), req, STAFF_EMAIL, RESTAURANT_ID))
                    .isInstanceOf(ReservationException.class)
                    .satisfies(e -> assertThat(((ReservationException) e).getErrorCode())
                            .isEqualTo(ReservationErrorCode.SLOT_CONFLICT));
        }
    }

    // =========================================================================
    // proposeChange
    // =========================================================================

    @Nested
    @DisplayName("proposeChange")
    class ProposeChangeTests {

        @Test
        @DisplayName("409 — cannot propose change on CANCELLED reservation")
        void should_throw409_when_proposeCancelled() {
            givenOwnerMembership();
            var r = confirmedReservation();
            r.setStatus(ReservationStatus.CANCELLED);
            when(reservationRepository.findById(r.getId())).thenReturn(Optional.of(r));

            var req = new ProposeChangeRequest(LocalTime.of(14, 0), null);
            assertThatThrownBy(() -> service.proposeChange(r.getId(), req, STAFF_EMAIL, RESTAURANT_ID))
                    .isInstanceOf(ReservationException.class)
                    .satisfies(e -> assertThat(((ReservationException) e).getErrorCode())
                            .isEqualTo(ReservationErrorCode.INVALID_STATUS_TRANSITION));
        }

        @Test
        @DisplayName("400 — both startTime and tableId null in ProposeChangeRequest")
        void should_throw400_when_bothFieldsNull() {
            givenOwnerMembership();
            var r = confirmedReservation();
            r.setStatus(ReservationStatus.CONFIRMED);
            when(reservationRepository.findById(r.getId())).thenReturn(Optional.of(r));

            var req = new ProposeChangeRequest(null, null);
            assertThatThrownBy(() -> service.proposeChange(r.getId(), req, STAFF_EMAIL, RESTAURANT_ID))
                    .isInstanceOf(org.springframework.web.server.ResponseStatusException.class);
        }

        @Test
        @DisplayName("403 — STAFF without EDIT_RESERVATION permission cannot propose change")
        void should_throw403_when_staffLacksEditPermission() {
            staffMembership.setPermissions(EnumSet.of(EmployeePermission.CONFIRM_RESERVATION));
            givenStaffMembership();

            var req = new ProposeChangeRequest(LocalTime.of(14, 0), null);
            assertThatThrownBy(() -> service.proposeChange(UUID.randomUUID(), req, STAFF_EMAIL, RESTAURANT_ID))
                    .isInstanceOf(RestaurantException.class);
        }
    }

    // =========================================================================
    // Recurring reservation — state transitions
    // =========================================================================

    @Nested
    @DisplayName("confirmRecurringReservation — state transitions")
    class ConfirmRecurringTests {

        @Test
        @DisplayName("409 — cannot confirm ACTIVE recurring reservation")
        void should_throw409_when_alreadyActive() {
            givenOwnerMembership();
            var recurring = RecurringReservation.builder()
                    .id(UUID.randomUUID()).restaurantId(RESTAURANT_ID).tableId(TABLE_ID)
                    .userId(99L).dayOfWeek(DayOfWeek.MONDAY).startTime(LocalTime.of(12, 0))
                    .status(RecurringReservationStatus.ACTIVE).build();
            when(recurringRepository.findById(recurring.getId())).thenReturn(Optional.of(recurring));

            var req = ConfirmRecurringReservationRequest.builder()
                    .repeatUntil(LocalDate.of(2025, 12, 31)).build();
            assertThatThrownBy(() -> service.confirmRecurringReservation(recurring.getId(), req, STAFF_EMAIL, RESTAURANT_ID))
                    .isInstanceOf(ReservationException.class)
                    .satisfies(e -> assertThat(((ReservationException) e).getErrorCode())
                            .isEqualTo(ReservationErrorCode.RECURRING_RESERVATION_ALREADY_ACTIVE));
        }

        @Test
        @DisplayName("409 — cannot confirm REJECTED recurring reservation")
        void should_throw409_when_rejected() {
            givenOwnerMembership();
            var recurring = RecurringReservation.builder()
                    .id(UUID.randomUUID()).restaurantId(RESTAURANT_ID).tableId(TABLE_ID)
                    .userId(99L).dayOfWeek(DayOfWeek.MONDAY).startTime(LocalTime.of(12, 0))
                    .status(RecurringReservationStatus.REJECTED).build();
            when(recurringRepository.findById(recurring.getId())).thenReturn(Optional.of(recurring));

            var req = ConfirmRecurringReservationRequest.builder()
                    .repeatUntil(LocalDate.of(2025, 12, 31)).build();
            assertThatThrownBy(() -> service.confirmRecurringReservation(recurring.getId(), req, STAFF_EMAIL, RESTAURANT_ID))
                    .isInstanceOf(ReservationException.class)
                    .satisfies(e -> assertThat(((ReservationException) e).getErrorCode())
                            .isEqualTo(ReservationErrorCode.RECURRING_RESERVATION_ALREADY_ACTIVE));
        }

        @Test
        @DisplayName("403 — staff cannot confirm recurring reservation of another restaurant")
        void should_throw403_when_differentRestaurant() {
            givenOwnerMembership();
            var recurring = RecurringReservation.builder()
                    .id(UUID.randomUUID()).restaurantId(UUID.randomUUID()) // different restaurant
                    .tableId(TABLE_ID).userId(99L).dayOfWeek(DayOfWeek.MONDAY)
                    .startTime(LocalTime.of(12, 0))
                    .status(RecurringReservationStatus.PENDING_CONFIRMATION).build();
            when(recurringRepository.findById(recurring.getId())).thenReturn(Optional.of(recurring));

            var req = ConfirmRecurringReservationRequest.builder()
                    .repeatUntil(LocalDate.of(2025, 12, 31)).build();
            assertThatThrownBy(() -> service.confirmRecurringReservation(recurring.getId(), req, STAFF_EMAIL, RESTAURANT_ID))
                    .isInstanceOf(ReservationException.class)
                    .satisfies(e -> assertThat(((ReservationException) e).getErrorCode())
                            .isEqualTo(ReservationErrorCode.NOT_RESTAURANT_STAFF));
        }
    }

    // =========================================================================
    // cancelRecurringReservation (staff)
    // =========================================================================

    @Nested
    @DisplayName("cancelRecurringReservation (staff) — state transitions")
    class StaffCancelRecurringTests {

        @Test
        @DisplayName("409 — cannot cancel already CANCELLED recurring reservation")
        void should_throw409_when_alreadyCancelled() {
            givenOwnerMembership();
            var recurring = RecurringReservation.builder()
                    .id(UUID.randomUUID()).restaurantId(RESTAURANT_ID).tableId(TABLE_ID)
                    .userId(99L).dayOfWeek(DayOfWeek.MONDAY).startTime(LocalTime.of(12, 0))
                    .status(RecurringReservationStatus.CANCELLED).build();
            when(recurringRepository.findById(recurring.getId())).thenReturn(Optional.of(recurring));

            assertThatThrownBy(() -> service.cancelRecurringReservation(recurring.getId(), STAFF_EMAIL, RESTAURANT_ID))
                    .isInstanceOf(ReservationException.class)
                    .satisfies(e -> assertThat(((ReservationException) e).getErrorCode())
                            .isEqualTo(ReservationErrorCode.RESERVATION_ALREADY_CANCELLED));
        }

        @Test
        @DisplayName("403 — STAFF without CANCEL_RESERVATION permission cannot cancel")
        void should_throw403_when_staffLacksCancelPermission() {
            staffMembership.setPermissions(EnumSet.of(EmployeePermission.CONFIRM_RESERVATION));
            givenStaffMembership();

            assertThatThrownBy(() -> service.cancelRecurringReservation(UUID.randomUUID(), STAFF_EMAIL, RESTAURANT_ID))
                    .isInstanceOf(RestaurantException.class);
        }
    }
}
