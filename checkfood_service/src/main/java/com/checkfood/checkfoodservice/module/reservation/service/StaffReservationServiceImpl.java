package com.checkfood.checkfoodservice.module.reservation.service;

import com.checkfood.checkfoodservice.module.reservation.dto.response.ReservationResponse;
import com.checkfood.checkfoodservice.module.reservation.dto.response.StaffReservationResponse;
import com.checkfood.checkfoodservice.module.reservation.entity.Reservation;
import com.checkfood.checkfoodservice.module.reservation.entity.ReservationStatus;
import com.checkfood.checkfoodservice.module.reservation.exception.ReservationException;
import com.checkfood.checkfoodservice.module.reservation.logging.ReservationLogger;
import com.checkfood.checkfoodservice.module.reservation.repository.ReservationRepository;
import com.checkfood.checkfoodservice.module.restaurant.entity.employee.MembershipStatus;
import com.checkfood.checkfoodservice.module.restaurant.entity.employee.RestaurantEmployee;
import com.checkfood.checkfoodservice.module.restaurant.entity.restaurant.Restaurant;
import com.checkfood.checkfoodservice.module.restaurant.entity.restaurant.table.RestaurantTable;
import com.checkfood.checkfoodservice.module.restaurant.repository.RestaurantEmployeeRepository;
import com.checkfood.checkfoodservice.module.restaurant.repository.RestaurantRepository;
import com.checkfood.checkfoodservice.module.restaurant.repository.table.RestaurantTableRepository;
import com.checkfood.checkfoodservice.security.module.user.service.UserService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.Clock;
import java.time.LocalDate;
import java.time.LocalTime;
import java.util.List;
import java.util.Map;
import java.util.UUID;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
public class StaffReservationServiceImpl implements StaffReservationService {

    private static final int CHECKIN_BEFORE_MINUTES = 30;
    private static final int CHECKIN_AFTER_MINUTES = 60;

    private final ReservationRepository reservationRepository;
    private final RestaurantRepository restaurantRepository;
    private final RestaurantTableRepository tableRepository;
    private final RestaurantEmployeeRepository employeeRepository;
    private final UserService userService;
    private final ReservationLogger reservationLogger;
    private final Clock clock;

    // ========================================================================
    // LIST RESERVATIONS FOR MY RESTAURANT
    // ========================================================================

    @Override
    @Transactional(readOnly = true)
    public List<StaffReservationResponse> getReservationsForMyRestaurant(String userEmail, LocalDate date) {
        var membership = findActiveMembership(userEmail);
        var restaurantId = membership.getRestaurant().getId();

        var reservations = reservationRepository
                .findAllByRestaurantIdAndDateOrderByStartTimeAsc(restaurantId, date);

        // Batch-load table labels
        var tableIds = reservations.stream()
                .map(Reservation::getTableId)
                .collect(Collectors.toSet());
        var tableLabels = tableRepository.findAllById(tableIds).stream()
                .collect(Collectors.toMap(RestaurantTable::getId, RestaurantTable::getLabel));

        var now = LocalTime.now(clock);
        var today = LocalDate.now(clock);

        return reservations.stream()
                .map(r -> toStaffResponse(r, tableLabels.get(r.getTableId()), date, today, now))
                .toList();
    }

    // ========================================================================
    // CONFIRM
    // ========================================================================

    @Override
    @Transactional
    public ReservationResponse confirmReservation(UUID reservationId, String userEmail) {
        var membership = findActiveMembership(userEmail);
        var reservation = findAndVerifyAccess(reservationId, membership);

        if (reservation.getStatus() != ReservationStatus.PENDING_CONFIRMATION
                && reservation.getStatus() != ReservationStatus.RESERVED) {
            throw ReservationException.invalidStatusTransition(
                    reservation.getStatus().name(), ReservationStatus.CONFIRMED.name());
        }

        reservation.setStatus(ReservationStatus.CONFIRMED);
        var saved = reservationRepository.save(reservation);
        reservationLogger.logReservationConfirmed(saved.getId(), saved.getDate());

        return toReservationResponse(saved);
    }

    // ========================================================================
    // REJECT
    // ========================================================================

    @Override
    @Transactional
    public ReservationResponse rejectReservation(UUID reservationId, String userEmail) {
        var membership = findActiveMembership(userEmail);
        var reservation = findAndVerifyAccess(reservationId, membership);

        if (reservation.getStatus() != ReservationStatus.PENDING_CONFIRMATION
                && reservation.getStatus() != ReservationStatus.RESERVED) {
            throw ReservationException.invalidStatusTransition(
                    reservation.getStatus().name(), ReservationStatus.REJECTED.name());
        }

        reservation.setStatus(ReservationStatus.REJECTED);
        var saved = reservationRepository.save(reservation);
        reservationLogger.logReservationRejected(saved.getId(), saved.getDate());

        return toReservationResponse(saved);
    }

    // ========================================================================
    // CHECK-IN
    // ========================================================================

    @Override
    @Transactional
    public ReservationResponse checkInReservation(UUID reservationId, String userEmail) {
        var membership = findActiveMembership(userEmail);
        var reservation = findAndVerifyAccess(reservationId, membership);

        if (reservation.getStatus() != ReservationStatus.CONFIRMED
                && reservation.getStatus() != ReservationStatus.RESERVED) {
            throw ReservationException.invalidStatusTransition(
                    reservation.getStatus().name(), ReservationStatus.CHECKED_IN.name());
        }

        // Validate check-in time window: startTime - 30min to startTime + 60min
        var now = LocalTime.now(clock);
        var today = LocalDate.now(clock);
        if (!reservation.getDate().isEqual(today)) {
            throw ReservationException.checkInOutsideWindow();
        }
        var windowStart = reservation.getStartTime().minusMinutes(CHECKIN_BEFORE_MINUTES);
        var windowEnd = reservation.getStartTime().plusMinutes(CHECKIN_AFTER_MINUTES);
        if (now.isBefore(windowStart) || now.isAfter(windowEnd)) {
            throw ReservationException.checkInOutsideWindow();
        }

        reservation.setStatus(ReservationStatus.CHECKED_IN);
        var saved = reservationRepository.save(reservation);
        reservationLogger.logReservationCheckedIn(saved.getId(), saved.getDate());

        return toReservationResponse(saved);
    }

    // ========================================================================
    // COMPLETE
    // ========================================================================

    @Override
    @Transactional
    public ReservationResponse completeReservation(UUID reservationId, String userEmail) {
        var membership = findActiveMembership(userEmail);
        var reservation = findAndVerifyAccess(reservationId, membership);

        if (reservation.getStatus() != ReservationStatus.CHECKED_IN) {
            throw ReservationException.invalidStatusTransition(
                    reservation.getStatus().name(), ReservationStatus.COMPLETED.name());
        }

        reservation.setStatus(ReservationStatus.COMPLETED);
        var saved = reservationRepository.save(reservation);
        reservationLogger.logReservationCompleted(saved.getId(), saved.getDate());

        return toReservationResponse(saved);
    }

    // ========================================================================
    // HELPERS
    // ========================================================================

    private RestaurantEmployee findActiveMembership(String userEmail) {
        var user = userService.findByEmail(userEmail);
        var membership = employeeRepository.findByUserId(user.getId())
                .orElseThrow(ReservationException::notRestaurantStaff);
        if (membership.getMembershipStatus() != MembershipStatus.ACTIVE) {
            throw ReservationException.notRestaurantStaff();
        }
        return membership;
    }

    private Reservation findAndVerifyAccess(UUID reservationId, RestaurantEmployee membership) {
        var reservation = reservationRepository.findById(reservationId)
                .orElseThrow(() -> ReservationException.notFound(reservationId));
        if (!reservation.getRestaurantId().equals(membership.getRestaurant().getId())) {
            throw ReservationException.notRestaurantStaff();
        }
        return reservation;
    }

    private StaffReservationResponse toStaffResponse(
            Reservation r, String tableLabel,
            LocalDate queryDate, LocalDate today, LocalTime now) {

        boolean isToday = queryDate.isEqual(today);
        var status = r.getStatus();

        boolean canConfirm = status == ReservationStatus.PENDING_CONFIRMATION
                || status == ReservationStatus.RESERVED;

        boolean canReject = status == ReservationStatus.PENDING_CONFIRMATION
                || status == ReservationStatus.RESERVED;

        boolean canCheckIn = (status == ReservationStatus.CONFIRMED || status == ReservationStatus.RESERVED)
                && isToday
                && !now.isBefore(r.getStartTime().minusMinutes(CHECKIN_BEFORE_MINUTES))
                && !now.isAfter(r.getStartTime().plusMinutes(CHECKIN_AFTER_MINUTES));

        boolean canComplete = status == ReservationStatus.CHECKED_IN;

        return StaffReservationResponse.builder()
                .id(r.getId())
                .tableId(r.getTableId())
                .tableLabel(tableLabel)
                .userId(r.getUserId())
                .date(r.getDate())
                .startTime(r.getStartTime())
                .endTime(r.getEndTime())
                .partySize(r.getPartySize())
                .status(r.getStatus())
                .createdAt(r.getCreatedAt())
                .canConfirm(canConfirm)
                .canReject(canReject)
                .canCheckIn(canCheckIn)
                .canComplete(canComplete)
                .build();
    }

    private ReservationResponse toReservationResponse(Reservation r) {
        var restaurantName = restaurantRepository.findById(r.getRestaurantId())
                .map(Restaurant::getName).orElse(null);
        var tableLabel = tableRepository.findById(r.getTableId())
                .map(RestaurantTable::getLabel).orElse(null);

        return ReservationResponse.builder()
                .id(r.getId())
                .restaurantId(r.getRestaurantId())
                .tableId(r.getTableId())
                .restaurantName(restaurantName)
                .tableLabel(tableLabel)
                .date(r.getDate())
                .startTime(r.getStartTime())
                .endTime(r.getEndTime())
                .status(r.getStatus())
                .partySize(r.getPartySize())
                .canEdit(false)
                .canCancel(false)
                .build();
    }
}
