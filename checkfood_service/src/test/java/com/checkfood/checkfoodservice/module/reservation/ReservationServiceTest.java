package com.checkfood.checkfoodservice.module.reservation;

import com.checkfood.checkfoodservice.module.reservation.dto.request.CreateReservationRequest;
import com.checkfood.checkfoodservice.module.reservation.dto.request.UpdateReservationRequest;
import com.checkfood.checkfoodservice.module.reservation.entity.Reservation;
import com.checkfood.checkfoodservice.module.reservation.entity.ReservationStatus;
import com.checkfood.checkfoodservice.module.reservation.exception.ReservationErrorCode;
import com.checkfood.checkfoodservice.module.reservation.exception.ReservationException;
import com.checkfood.checkfoodservice.module.reservation.logging.ReservationLogger;
import com.checkfood.checkfoodservice.module.reservation.repository.ReservationChangeRequestRepository;
import com.checkfood.checkfoodservice.module.reservation.repository.ReservationRepository;
import com.checkfood.checkfoodservice.module.reservation.service.ReservationServiceImpl;
import com.checkfood.checkfoodservice.module.restaurant.entity.restaurant.CuisineType;
import com.checkfood.checkfoodservice.module.restaurant.entity.restaurant.OpeningHours;
import com.checkfood.checkfoodservice.module.restaurant.entity.restaurant.Restaurant;
import com.checkfood.checkfoodservice.module.restaurant.entity.restaurant.RestaurantStatus;
import com.checkfood.checkfoodservice.module.restaurant.entity.restaurant.table.RestaurantTable;
import com.checkfood.checkfoodservice.module.restaurant.exception.RestaurantErrorCode;
import com.checkfood.checkfoodservice.module.restaurant.exception.RestaurantException;
import com.checkfood.checkfoodservice.module.restaurant.repository.RestaurantRepository;
import com.checkfood.checkfoodservice.module.restaurant.repository.table.RestaurantTableRepository;
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
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;
import java.util.UUID;

import static org.assertj.core.api.Assertions.assertThat;
import static org.assertj.core.api.Assertions.assertThatThrownBy;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.ArgumentMatchers.anyList;
import static org.mockito.ArgumentMatchers.eq;
import static org.mockito.Mockito.when;

@ExtendWith(MockitoExtension.class)
@DisplayName("ReservationService unit tests")
class ReservationServiceTest {

    @Mock private ReservationRepository reservationRepository;
    @Mock private RestaurantRepository restaurantRepository;
    @Mock private RestaurantTableRepository tableRepository;
    @Mock private ReservationChangeRequestRepository changeRequestRepository;
    @Mock private ReservationLogger reservationLogger;

    @InjectMocks
    private ReservationServiceImpl service;

    private static final Long USER_ID = 1L;
    private static final UUID RESTAURANT_ID = UUID.randomUUID();
    private static final UUID TABLE_ID = UUID.randomUUID();

    private Restaurant restaurant;
    private RestaurantTable table;

    @BeforeEach
    void setUp() {
        // Fixed clock: 2025-01-13 (Monday) at 10:00
        var fixedInstant = java.time.LocalDateTime.of(2025, 1, 13, 10, 0)
                .toInstant(java.time.ZoneOffset.UTC);
        var clock = Clock.fixed(fixedInstant, ZoneId.of("UTC"));
        service = new ReservationServiceImpl(
                reservationRepository, restaurantRepository, tableRepository,
                changeRequestRepository, reservationLogger, clock);

        var hours = new ArrayList<OpeningHours>();
        for (DayOfWeek day : DayOfWeek.values()) {
            hours.add(OpeningHours.builder()
                    .dayOfWeek(day)
                    .openAt(LocalTime.of(10, 0))
                    .closeAt(LocalTime.of(22, 0))
                    .closed(day == DayOfWeek.SUNDAY)
                    .build());
        }

        restaurant = Restaurant.builder()
                .id(RESTAURANT_ID)
                .ownerId(UUID.randomUUID())
                .name("Test Restaurant")
                .cuisineType(CuisineType.CZECH)
                .status(RestaurantStatus.ACTIVE)
                .active(true)
                .rating(BigDecimal.ZERO)
                .openingHours(hours)
                .build();

        table = RestaurantTable.builder()
                .id(TABLE_ID)
                .restaurantId(RESTAURANT_ID)
                .label("A1")
                .capacity(4)
                .active(true)
                .build();
    }

    @Nested
    @DisplayName("createReservation")
    class CreateReservationTests {

        @Test
        @DisplayName("throws 404 when restaurant not found")
        void should_throw404_when_restaurantNotFound() {
            when(restaurantRepository.findById(RESTAURANT_ID)).thenReturn(Optional.empty());

            var req = CreateReservationRequest.builder()
                    .restaurantId(RESTAURANT_ID).tableId(TABLE_ID)
                    .date(LocalDate.of(2025, 1, 20)).startTime(LocalTime.of(12, 0)).partySize(2).build();

            assertThatThrownBy(() -> service.createReservation(req, USER_ID))
                    .isInstanceOf(RestaurantException.class)
                    .satisfies(e -> assertThat(((RestaurantException) e).getErrorCode())
                            .isEqualTo(RestaurantErrorCode.RESTAURANT_NOT_FOUND));
        }

        @Test
        @DisplayName("throws 400 when table not in restaurant")
        void should_throw400_when_tableNotInRestaurant() {
            when(restaurantRepository.findById(RESTAURANT_ID)).thenReturn(Optional.of(restaurant));
            when(tableRepository.findByIdAndRestaurantId(TABLE_ID, RESTAURANT_ID)).thenReturn(Optional.empty());

            var req = CreateReservationRequest.builder()
                    .restaurantId(RESTAURANT_ID).tableId(TABLE_ID)
                    .date(LocalDate.of(2025, 1, 20)).startTime(LocalTime.of(12, 0)).partySize(2).build();

            assertThatThrownBy(() -> service.createReservation(req, USER_ID))
                    .isInstanceOf(ReservationException.class)
                    .satisfies(e -> assertThat(((ReservationException) e).getErrorCode())
                            .isEqualTo(ReservationErrorCode.TABLE_NOT_IN_RESTAURANT));
        }

        @Test
        @DisplayName("throws 400 when party size exceeds capacity")
        void should_throw400_when_partySizeExceedsCapacity() {
            when(restaurantRepository.findById(RESTAURANT_ID)).thenReturn(Optional.of(restaurant));
            when(tableRepository.findByIdAndRestaurantId(TABLE_ID, RESTAURANT_ID)).thenReturn(Optional.of(table));

            var req = CreateReservationRequest.builder()
                    .restaurantId(RESTAURANT_ID).tableId(TABLE_ID)
                    .date(LocalDate.of(2025, 1, 20)).startTime(LocalTime.of(12, 0)).partySize(10).build();

            assertThatThrownBy(() -> service.createReservation(req, USER_ID))
                    .isInstanceOf(ReservationException.class)
                    .satisfies(e -> assertThat(((ReservationException) e).getErrorCode())
                            .isEqualTo(ReservationErrorCode.PARTY_SIZE_EXCEEDS_CAPACITY));
        }

        @Test
        @DisplayName("throws 409 when slot is already taken")
        void should_throw409_when_slotConflict() {
            when(restaurantRepository.findById(RESTAURANT_ID)).thenReturn(Optional.of(restaurant));
            when(tableRepository.findByIdAndRestaurantId(TABLE_ID, RESTAURANT_ID)).thenReturn(Optional.of(table));
            when(reservationRepository.findAllByRestaurantIdAndDateAndStatusNotIn(any(), any(), anyList()))
                    .thenReturn(List.of());
            when(reservationRepository.findAllByUserIdOrderByDateDescStartTimeDesc(USER_ID))
                    .thenReturn(List.of());
            when(reservationRepository.existsOverlappingReservation(any(), any(), any(), any())).thenReturn(true);

            var req = CreateReservationRequest.builder()
                    .restaurantId(RESTAURANT_ID).tableId(TABLE_ID)
                    .date(LocalDate.of(2025, 1, 20)).startTime(LocalTime.of(12, 0)).partySize(2).build();

            assertThatThrownBy(() -> service.createReservation(req, USER_ID))
                    .isInstanceOf(ReservationException.class)
                    .satisfies(e -> assertThat(((ReservationException) e).getErrorCode())
                            .isEqualTo(ReservationErrorCode.SLOT_CONFLICT));
        }

        @Test
        @DisplayName("throws 429 when per-restaurant-per-day limit reached (3)")
        void should_throw429_when_perDayLimitReached() {
            when(restaurantRepository.findById(RESTAURANT_ID)).thenReturn(Optional.of(restaurant));
            when(tableRepository.findByIdAndRestaurantId(TABLE_ID, RESTAURANT_ID)).thenReturn(Optional.of(table));

            // 3 existing reservations by same user at same restaurant on same day
            var date = LocalDate.of(2025, 1, 20);
            var existing = List.of(
                    reservationWith(USER_ID, date, ReservationStatus.PENDING_CONFIRMATION),
                    reservationWith(USER_ID, date, ReservationStatus.CONFIRMED),
                    reservationWith(USER_ID, date, ReservationStatus.CONFIRMED));
            when(reservationRepository.findAllByRestaurantIdAndDateAndStatusNotIn(any(), eq(date), anyList()))
                    .thenReturn(existing);

            var req = CreateReservationRequest.builder()
                    .restaurantId(RESTAURANT_ID).tableId(TABLE_ID)
                    .date(date).startTime(LocalTime.of(18, 0)).partySize(2).build();

            assertThatThrownBy(() -> service.createReservation(req, USER_ID))
                    .isInstanceOf(ReservationException.class)
                    .satisfies(e -> assertThat(((ReservationException) e).getErrorCode())
                            .isEqualTo(ReservationErrorCode.RESERVATION_LIMIT));
        }

        @Test
        @DisplayName("throws 429 when total active reservations limit reached (10)")
        void should_throw429_when_totalActiveLimitReached() {
            when(restaurantRepository.findById(RESTAURANT_ID)).thenReturn(Optional.of(restaurant));
            when(tableRepository.findByIdAndRestaurantId(TABLE_ID, RESTAURANT_ID)).thenReturn(Optional.of(table));
            when(reservationRepository.findAllByRestaurantIdAndDateAndStatusNotIn(any(), any(), anyList()))
                    .thenReturn(List.of());

            // 10 future active reservations
            var futureDate = LocalDate.of(2025, 2, 1);
            var active = new ArrayList<Reservation>();
            for (int i = 0; i < 10; i++) {
                active.add(reservationWith(USER_ID, futureDate, ReservationStatus.CONFIRMED));
            }
            when(reservationRepository.findAllByUserIdOrderByDateDescStartTimeDesc(USER_ID))
                    .thenReturn(active);

            var req = CreateReservationRequest.builder()
                    .restaurantId(RESTAURANT_ID).tableId(TABLE_ID)
                    .date(LocalDate.of(2025, 1, 20)).startTime(LocalTime.of(12, 0)).partySize(2).build();

            assertThatThrownBy(() -> service.createReservation(req, USER_ID))
                    .isInstanceOf(ReservationException.class)
                    .satisfies(e -> assertThat(((ReservationException) e).getErrorCode())
                            .isEqualTo(ReservationErrorCode.RESERVATION_LIMIT));
        }

        @Test
        @DisplayName("throws 400 when duration out of restaurant bounds")
        void should_throw400_when_durationOutOfBounds() {
            when(restaurantRepository.findById(RESTAURANT_ID)).thenReturn(Optional.of(restaurant));
            when(tableRepository.findByIdAndRestaurantId(TABLE_ID, RESTAURANT_ID)).thenReturn(Optional.of(table));
            when(reservationRepository.findAllByRestaurantIdAndDateAndStatusNotIn(any(), any(), anyList()))
                    .thenReturn(List.of());
            when(reservationRepository.findAllByUserIdOrderByDateDescStartTimeDesc(USER_ID))
                    .thenReturn(List.of());

            // restaurant default: min=30 max=180. Request duration=200 (above max)
            var req = CreateReservationRequest.builder()
                    .restaurantId(RESTAURANT_ID).tableId(TABLE_ID)
                    .date(LocalDate.of(2025, 1, 20)).startTime(LocalTime.of(12, 0))
                    .partySize(2).durationMinutes(200).build();

            assertThatThrownBy(() -> service.createReservation(req, USER_ID))
                    .isInstanceOf(ReservationException.class)
                    .satisfies(e -> assertThat(((ReservationException) e).getErrorCode())
                            .isEqualTo(ReservationErrorCode.INVALID_RESERVATION_TIME));
        }

        @Test
        @DisplayName("creates reservation with custom duration within bounds")
        void should_createReservation_with_customDuration() {
            when(restaurantRepository.findById(RESTAURANT_ID)).thenReturn(Optional.of(restaurant));
            when(tableRepository.findByIdAndRestaurantId(TABLE_ID, RESTAURANT_ID)).thenReturn(Optional.of(table));
            when(reservationRepository.findAllByRestaurantIdAndDateAndStatusNotIn(any(), any(), anyList()))
                    .thenReturn(List.of());
            when(reservationRepository.findAllByUserIdOrderByDateDescStartTimeDesc(USER_ID))
                    .thenReturn(List.of());
            when(reservationRepository.existsOverlappingReservation(any(), any(), any(), any())).thenReturn(false);

            var saved = reservationWith(USER_ID, LocalDate.of(2025, 1, 20), ReservationStatus.CONFIRMED);
            saved.setStartTime(LocalTime.of(12, 0));
            saved.setEndTime(LocalTime.of(13, 0));
            when(reservationRepository.save(any())).thenReturn(saved);
            when(changeRequestRepository.findByReservationIdAndStatus(any(), any())).thenReturn(Optional.empty());

            var req = CreateReservationRequest.builder()
                    .restaurantId(RESTAURANT_ID).tableId(TABLE_ID)
                    .date(LocalDate.of(2025, 1, 20)).startTime(LocalTime.of(12, 0))
                    .partySize(2).durationMinutes(60).build();

            var result = service.createReservation(req, USER_ID);

            assertThat(result).isNotNull();
        }
    }

    @Nested
    @DisplayName("cancelReservation")
    class CancelReservationTests {

        @Test
        @DisplayName("throws 403 when user does not own the reservation")
        void should_throw403_when_wrongOwner() {
            var reservation = reservationWith(999L, LocalDate.of(2025, 1, 20), ReservationStatus.CONFIRMED);
            when(reservationRepository.findById(reservation.getId())).thenReturn(Optional.of(reservation));

            assertThatThrownBy(() -> service.cancelReservation(reservation.getId(), USER_ID))
                    .isInstanceOf(ReservationException.class)
                    .satisfies(e -> assertThat(((ReservationException) e).getErrorCode())
                            .isEqualTo(ReservationErrorCode.RESERVATION_ACCESS_DENIED));
        }

        @Test
        @DisplayName("throws 409 when reservation is already cancelled")
        void should_throw409_when_alreadyCancelled() {
            var reservation = reservationWith(USER_ID, LocalDate.of(2025, 1, 20), ReservationStatus.CANCELLED);
            when(reservationRepository.findById(reservation.getId())).thenReturn(Optional.of(reservation));

            assertThatThrownBy(() -> service.cancelReservation(reservation.getId(), USER_ID))
                    .isInstanceOf(ReservationException.class)
                    .satisfies(e -> assertThat(((ReservationException) e).getErrorCode())
                            .isEqualTo(ReservationErrorCode.RESERVATION_ALREADY_CANCELLED));
        }

        @Test
        @DisplayName("throws 409 when cancelling a past COMPLETED reservation")
        void should_throw409_when_pastCompletedReservation() {
            // Date in the past, status COMPLETED — isUpcoming() will return false -> cannotCancel()
            var reservation = reservationWith(USER_ID, LocalDate.of(2024, 12, 1), ReservationStatus.COMPLETED);
            when(reservationRepository.findById(reservation.getId())).thenReturn(Optional.of(reservation));

            assertThatThrownBy(() -> service.cancelReservation(reservation.getId(), USER_ID))
                    .isInstanceOf(ReservationException.class)
                    .satisfies(e -> assertThat(((ReservationException) e).getErrorCode())
                            .isEqualTo(ReservationErrorCode.RESERVATION_CANNOT_CANCEL));
        }

        @Test
        @DisplayName("throws 404 when reservation not found")
        void should_throw404_when_notFound() {
            var id = UUID.randomUUID();
            when(reservationRepository.findById(id)).thenReturn(Optional.empty());

            assertThatThrownBy(() -> service.cancelReservation(id, USER_ID))
                    .isInstanceOf(ReservationException.class)
                    .satisfies(e -> assertThat(((ReservationException) e).getErrorCode())
                            .isEqualTo(ReservationErrorCode.RESERVATION_NOT_FOUND));
        }
    }

    @Nested
    @DisplayName("updateReservation")
    class UpdateReservationTests {

        @Test
        @DisplayName("throws 403 when user does not own the reservation")
        void should_throw403_when_wrongOwner() {
            var reservation = reservationWith(999L, LocalDate.of(2025, 1, 20), ReservationStatus.CONFIRMED);
            when(reservationRepository.findById(reservation.getId())).thenReturn(Optional.of(reservation));

            var req = new UpdateReservationRequest(TABLE_ID, LocalDate.of(2025, 1, 21), LocalTime.of(14, 0), 2);
            assertThatThrownBy(() -> service.updateReservation(reservation.getId(), req, USER_ID))
                    .isInstanceOf(ReservationException.class)
                    .satisfies(e -> assertThat(((ReservationException) e).getErrorCode())
                            .isEqualTo(ReservationErrorCode.RESERVATION_ACCESS_DENIED));
        }

        @Test
        @DisplayName("throws 404 when reservation not found")
        void should_throw404_when_notFound() {
            var id = UUID.randomUUID();
            when(reservationRepository.findById(id)).thenReturn(Optional.empty());

            var req = new UpdateReservationRequest(TABLE_ID, LocalDate.of(2025, 1, 21), LocalTime.of(14, 0), 2);
            assertThatThrownBy(() -> service.updateReservation(id, req, USER_ID))
                    .isInstanceOf(ReservationException.class)
                    .satisfies(e -> assertThat(((ReservationException) e).getErrorCode())
                            .isEqualTo(ReservationErrorCode.RESERVATION_NOT_FOUND));
        }

        @Test
        @DisplayName("throws 409 when slot conflicts on update")
        void should_throw409_when_slotConflictOnUpdate() {
            var futureDate = LocalDate.of(2025, 3, 3);
            var reservation = reservationWith(USER_ID, futureDate, ReservationStatus.CONFIRMED);
            reservation.setStartTime(LocalTime.of(14, 0));
            reservation.setEndTime(LocalTime.of(15, 0));
            reservation.setRestaurantId(RESTAURANT_ID);
            reservation.setTableId(TABLE_ID);

            when(reservationRepository.findById(reservation.getId())).thenReturn(Optional.of(reservation));
            when(restaurantRepository.findById(RESTAURANT_ID)).thenReturn(Optional.of(restaurant));
            when(tableRepository.findByIdAndRestaurantId(TABLE_ID, RESTAURANT_ID)).thenReturn(Optional.of(table));
            when(reservationRepository.existsOverlappingReservationExcluding(any(), any(), any(), any(), any()))
                    .thenReturn(true);

            var req = new UpdateReservationRequest(TABLE_ID, futureDate, LocalTime.of(16, 0), 2);
            assertThatThrownBy(() -> service.updateReservation(reservation.getId(), req, USER_ID))
                    .isInstanceOf(ReservationException.class)
                    .satisfies(e -> assertThat(((ReservationException) e).getErrorCode())
                            .isEqualTo(ReservationErrorCode.SLOT_CONFLICT));
        }
    }

    // =========================================================================
    // Helpers
    // =========================================================================

    private Reservation reservationWith(Long userId, LocalDate date, ReservationStatus status) {
        return Reservation.builder()
                .id(UUID.randomUUID())
                .restaurantId(RESTAURANT_ID)
                .tableId(TABLE_ID)
                .userId(userId)
                .date(date)
                .startTime(LocalTime.of(12, 0))
                .endTime(LocalTime.of(13, 0))
                .status(status)
                .partySize(2)
                .build();
    }
}
