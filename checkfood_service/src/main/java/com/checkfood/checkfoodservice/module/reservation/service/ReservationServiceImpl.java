package com.checkfood.checkfoodservice.module.reservation.service;

import com.checkfood.checkfoodservice.module.reservation.dto.request.CreateReservationRequest;
import com.checkfood.checkfoodservice.module.reservation.dto.request.UpdateReservationRequest;
import com.checkfood.checkfoodservice.module.reservation.dto.response.*;
import com.checkfood.checkfoodservice.module.reservation.entity.Reservation;
import com.checkfood.checkfoodservice.module.reservation.entity.ReservationStatus;
import com.checkfood.checkfoodservice.module.reservation.exception.ReservationException;
import com.checkfood.checkfoodservice.module.reservation.logging.ReservationLogger;
import com.checkfood.checkfoodservice.module.reservation.repository.ReservationRepository;
import com.checkfood.checkfoodservice.module.restaurant.entity.restaurant.OpeningHours;
import com.checkfood.checkfoodservice.module.restaurant.entity.restaurant.Restaurant;
import com.checkfood.checkfoodservice.module.restaurant.entity.restaurant.table.RestaurantTable;
import com.checkfood.checkfoodservice.module.restaurant.exception.RestaurantException;
import com.checkfood.checkfoodservice.module.restaurant.repository.RestaurantRepository;
import com.checkfood.checkfoodservice.module.restaurant.repository.table.RestaurantTableRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.Clock;
import java.time.DayOfWeek;
import java.time.LocalDate;
import java.time.LocalTime;
import java.util.*;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
public class ReservationServiceImpl implements ReservationService {

    private static final int SLOT_INTERVAL_MINUTES = 30;
    private static final int DEFAULT_DURATION_MINUTES = 90;
    private static final int BOOKING_BUFFER_MINUTES = 30;
    private static final int EDIT_CUTOFF_MINUTES = 120;
    private static final int HISTORY_PREVIEW_LIMIT = 10;

    /** Statuses that count as "active" (upcoming, editable, blocking slots). */
    private static final Set<ReservationStatus> ACTIVE_STATUSES = Set.of(
            ReservationStatus.PENDING_CONFIRMATION,
            ReservationStatus.CONFIRMED,
            ReservationStatus.RESERVED,   // backward compat with existing DB rows
            ReservationStatus.CHECKED_IN
    );

    /** Statuses excluded from slot availability and table status queries. */
    private static final List<ReservationStatus> EXCLUDED_STATUSES = List.of(
            ReservationStatus.CANCELLED,
            ReservationStatus.REJECTED,
            ReservationStatus.COMPLETED
    );

    private final ReservationRepository reservationRepository;
    private final RestaurantRepository restaurantRepository;
    private final RestaurantTableRepository tableRepository;
    private final ReservationLogger reservationLogger;
    private final Clock clock;

    // ========================================================================
    // 1. RESERVATION SCENE (panorama + table positions)
    // ========================================================================

    @Override
    @Transactional(readOnly = true)
    public ReservationSceneResponse getReservationScene(UUID restaurantId) {
        var restaurant = findRestaurant(restaurantId);
        var tables = tableRepository.findAllByRestaurantIdAndActiveTrue(restaurantId);

        var sceneTables = tables.stream()
                .filter(t -> t.getYaw() != null && t.getPitch() != null)
                .map(t -> ReservationSceneResponse.SceneTable.builder()
                        .tableId(t.getId())
                        .label(t.getLabel())
                        .yaw(t.getYaw())
                        .pitch(t.getPitch())
                        .capacity(t.getCapacity())
                        .build())
                .toList();

        return ReservationSceneResponse.builder()
                .restaurantId(restaurantId)
                .panoramaUrl(restaurant.getPanoramaUrl())
                .tables(sceneTables)
                .build();
    }

    // ========================================================================
    // 2. TABLE STATUSES (for coloring markers)
    // ========================================================================

    @Override
    @Transactional(readOnly = true)
    public TableStatusResponse getTableStatuses(UUID restaurantId, LocalDate date) {
        var tables = tableRepository.findAllByRestaurantIdAndActiveTrue(restaurantId);
        var reservations = reservationRepository.findAllByRestaurantIdAndDateAndStatusNotIn(
                restaurantId, date, EXCLUDED_STATUSES
        );

        var now = LocalTime.now(clock);
        var today = LocalDate.now(clock);

        var statusList = tables.stream().map(table -> {
            var tableReservations = reservations.stream()
                    .filter(r -> r.getTableId().equals(table.getId()))
                    .toList();

            String status;
            if (tableReservations.isEmpty()) {
                status = "FREE";
            } else if (tableReservations.stream()
                    .anyMatch(r -> r.getStatus() == ReservationStatus.CHECKED_IN)) {
                status = "OCCUPIED";
            } else {
                status = "RESERVED";
            }

            return TableStatusResponse.TableStatus.builder()
                    .tableId(table.getId())
                    .status(status)
                    .build();
        }).toList();

        return TableStatusResponse.builder()
                .date(date)
                .tables(statusList)
                .build();
    }

    // ========================================================================
    // 3. AVAILABLE SLOTS (algorithm)
    // ========================================================================

    @Override
    @Transactional(readOnly = true)
    public AvailableSlotsResponse getAvailableSlots(UUID restaurantId, UUID tableId, LocalDate date, UUID excludeReservationId) {
        var restaurant = findRestaurant(restaurantId);
        validateTableBelongsToRestaurant(tableId, restaurantId);

        // 1) Get opening hours for this day
        DayOfWeek dayOfWeek = date.getDayOfWeek();
        OpeningHours hours = restaurant.getOpeningHours().stream()
                .filter(h -> h.getDayOfWeek() == dayOfWeek)
                .findFirst()
                .orElse(null);

        if (hours == null || hours.isClosed() || hours.getOpenAt() == null || hours.getCloseAt() == null) {
            return AvailableSlotsResponse.builder()
                    .date(date)
                    .tableId(tableId)
                    .slotMinutes(SLOT_INTERVAL_MINUTES)
                    .durationMinutes(DEFAULT_DURATION_MINUTES)
                    .availableStartTimes(List.of())
                    .build();
        }

        // 2) Get existing reservations for this table+date (excluding cancelled/rejected)
        var existingReservations = reservationRepository.findAllByTableIdAndDateAndStatusNotIn(
                tableId, date, EXCLUDED_STATUSES
        );

        // Exclude the reservation being edited (so the user's own slot appears available)
        if (excludeReservationId != null) {
            existingReservations = existingReservations.stream()
                    .filter(r -> !r.getId().equals(excludeReservationId))
                    .toList();
        }

        // 3) Generate candidate start times
        LocalTime openAt = hours.getOpenAt();
        LocalTime closeAt = hours.getCloseAt();
        LocalTime lastPossibleStart = closeAt.minusMinutes(DEFAULT_DURATION_MINUTES);

        // If today, skip past slots (with BOOKING_BUFFER_MINUTES ahead)
        LocalTime earliestStart = openAt;
        if (date.equals(LocalDate.now(clock))) {
            var nowPlusBuffer = LocalTime.now(clock).plusMinutes(BOOKING_BUFFER_MINUTES);
            if (nowPlusBuffer.isAfter(earliestStart)) {
                // Round up to next slot boundary
                int minutesSinceOpen = (int) java.time.Duration.between(openAt, nowPlusBuffer).toMinutes();
                int slotsToSkip = (minutesSinceOpen + SLOT_INTERVAL_MINUTES - 1) / SLOT_INTERVAL_MINUTES;
                earliestStart = openAt.plusMinutes((long) slotsToSkip * SLOT_INTERVAL_MINUTES);
            }
        }

        List<LocalTime> availableSlots = new ArrayList<>();
        LocalTime candidate = earliestStart;

        while (!candidate.isAfter(lastPossibleStart)) {
            LocalTime candidateEnd = candidate.plusMinutes(DEFAULT_DURATION_MINUTES);

            // 4) Check overlap with existing reservations
            final LocalTime start = candidate;
            final LocalTime end = candidateEnd;
            boolean hasConflict = existingReservations.stream()
                    .anyMatch(r -> r.getStartTime().isBefore(end) && r.getEndTime().isAfter(start));

            if (!hasConflict) {
                availableSlots.add(candidate);
            }

            candidate = candidate.plusMinutes(SLOT_INTERVAL_MINUTES);
        }

        return AvailableSlotsResponse.builder()
                .date(date)
                .tableId(tableId)
                .slotMinutes(SLOT_INTERVAL_MINUTES)
                .durationMinutes(DEFAULT_DURATION_MINUTES)
                .availableStartTimes(availableSlots)
                .build();
    }

    // ========================================================================
    // 4. CREATE RESERVATION (transaction-safe against race conditions)
    // ========================================================================

    @Override
    @Transactional
    public ReservationResponse createReservation(CreateReservationRequest request, Long userId) {
        findRestaurant(request.getRestaurantId());
        var table = findTableInRestaurant(request.getTableId(), request.getRestaurantId());

        // Validate: cannot create reservation in the past
        validateNotInPast(request.getDate(), request.getStartTime());

        // Validate party size against table capacity
        if (request.getPartySize() > table.getCapacity()) {
            throw ReservationException.partySizeExceedsCapacity(request.getPartySize(), table.getCapacity());
        }

        LocalTime endTime = request.getStartTime().plusMinutes(DEFAULT_DURATION_MINUTES);

        // Race-safe overlap check inside transaction
        boolean conflict = reservationRepository.existsOverlappingReservation(
                request.getTableId(),
                request.getDate(),
                request.getStartTime(),
                endTime
        );

        if (conflict) {
            reservationLogger.logSlotConflict(request.getTableId(), request.getDate());
            throw ReservationException.slotConflict();
        }

        var reservation = Reservation.builder()
                .restaurantId(request.getRestaurantId())
                .tableId(request.getTableId())
                .userId(userId)
                .date(request.getDate())
                .startTime(request.getStartTime())
                .endTime(endTime)
                .status(ReservationStatus.PENDING_CONFIRMATION)
                .partySize(request.getPartySize())
                .build();

        var saved = reservationRepository.save(reservation);

        reservationLogger.logReservationCreated(
                saved.getId(), saved.getRestaurantId(), saved.getTableId(), saved.getDate()
        );

        return toResponse(saved, null, null, false);
    }

    // ========================================================================
    // 5. MY RESERVATIONS OVERVIEW (upcoming + history)
    // ========================================================================

    @Override
    @Transactional(readOnly = true)
    public MyReservationsOverviewResponse getMyReservationsOverview(Long userId) {
        var reservations = reservationRepository.findAllByUserIdOrderByDateDescStartTimeDesc(userId);

        // Batch-load restaurant names and table labels
        var namesMaps = batchLoadNames(reservations);

        // Split into upcoming and history
        var upcoming = reservations.stream()
                .filter(this::isUpcoming)
                .sorted(Comparator.comparing(Reservation::getDate).thenComparing(Reservation::getStartTime))
                .map(r -> toResponse(r, namesMaps.restaurantNames.get(r.getRestaurantId()),
                        namesMaps.tableLabels.get(r.getTableId()), computeCanEdit(r)))
                .toList();

        var allHistory = reservations.stream()
                .filter(r -> !isUpcoming(r))
                .toList();

        var history = allHistory.stream()
                .limit(HISTORY_PREVIEW_LIMIT)
                .map(r -> toResponse(r, namesMaps.restaurantNames.get(r.getRestaurantId()),
                        namesMaps.tableLabels.get(r.getTableId()), false))
                .toList();

        return MyReservationsOverviewResponse.builder()
                .upcoming(upcoming)
                .history(history)
                .totalHistoryCount(allHistory.size())
                .build();
    }

    // ========================================================================
    // 6. MY RESERVATIONS HISTORY (all, for "show all" button)
    // ========================================================================

    @Override
    @Transactional(readOnly = true)
    public List<ReservationResponse> getMyReservationsHistory(Long userId) {
        var reservations = reservationRepository.findAllByUserIdOrderByDateDescStartTimeDesc(userId);

        var namesMaps = batchLoadNames(reservations);

        return reservations.stream()
                .filter(r -> !isUpcoming(r))
                .map(r -> toResponse(r, namesMaps.restaurantNames.get(r.getRestaurantId()),
                        namesMaps.tableLabels.get(r.getTableId()), false))
                .toList();
    }

    // ========================================================================
    // 7. UPDATE RESERVATION
    // ========================================================================

    @Override
    @Transactional
    public ReservationResponse updateReservation(UUID id, UpdateReservationRequest request, Long userId) {
        var reservation = reservationRepository.findById(id)
                .orElseThrow(() -> ReservationException.notFound(id));

        // Security: verify ownership
        if (!reservation.getUserId().equals(userId)) {
            throw ReservationException.accessDenied();
        }

        // Business: verify editable
        if (!computeCanEdit(reservation)) {
            throw ReservationException.cannotEdit();
        }

        // Validate: new time cannot be in the past
        validateNotInPast(request.getDate(), request.getStartTime());

        // Validate table belongs to the original restaurant + capacity
        var table = findTableInRestaurant(request.getTableId(), reservation.getRestaurantId());
        if (request.getPartySize() > table.getCapacity()) {
            throw ReservationException.partySizeExceedsCapacity(request.getPartySize(), table.getCapacity());
        }

        LocalTime endTime = request.getStartTime().plusMinutes(DEFAULT_DURATION_MINUTES);

        // Race-safe overlap check excluding self
        boolean conflict = reservationRepository.existsOverlappingReservationExcluding(
                request.getTableId(),
                request.getDate(),
                request.getStartTime(),
                endTime,
                id
        );

        if (conflict) {
            reservationLogger.logSlotConflict(request.getTableId(), request.getDate());
            throw ReservationException.slotConflict();
        }

        // Update fields — editing resets status to PENDING_CONFIRMATION
        reservation.setTableId(request.getTableId());
        reservation.setDate(request.getDate());
        reservation.setStartTime(request.getStartTime());
        reservation.setEndTime(endTime);
        reservation.setPartySize(request.getPartySize());
        reservation.setStatus(ReservationStatus.PENDING_CONFIRMATION);

        var saved = reservationRepository.save(reservation);

        reservationLogger.logReservationUpdated(
                saved.getId(), saved.getTableId(), saved.getDate()
        );

        // Load names for response
        var restaurantName = restaurantRepository.findById(saved.getRestaurantId())
                .map(Restaurant::getName).orElse(null);
        var tableLabel = tableRepository.findById(saved.getTableId())
                .map(RestaurantTable::getLabel).orElse(null);

        return toResponse(saved, restaurantName, tableLabel, computeCanEdit(saved));
    }

    // ========================================================================
    // 8. CANCEL RESERVATION
    // ========================================================================

    @Override
    @Transactional
    public ReservationResponse cancelReservation(UUID id, Long userId) {
        var reservation = reservationRepository.findById(id)
                .orElseThrow(() -> ReservationException.notFound(id));

        // Security: verify ownership
        if (!reservation.getUserId().equals(userId)) {
            throw ReservationException.accessDenied();
        }

        // Business: verify not already cancelled
        if (reservation.getStatus() == ReservationStatus.CANCELLED) {
            throw ReservationException.alreadyCancelled();
        }

        // Business: cannot cancel a reservation that already started
        if (!isUpcoming(reservation)) {
            throw ReservationException.cannotCancel();
        }

        reservation.setStatus(ReservationStatus.CANCELLED);
        var saved = reservationRepository.save(reservation);

        reservationLogger.logReservationCancelled(saved.getId(), saved.getDate());

        var restaurantName = restaurantRepository.findById(saved.getRestaurantId())
                .map(Restaurant::getName).orElse(null);
        var tableLabel = tableRepository.findById(saved.getTableId())
                .map(RestaurantTable::getLabel).orElse(null);

        return toResponse(saved, restaurantName, tableLabel, false);
    }

    // ========================================================================
    // HELPERS
    // ========================================================================

    private Restaurant findRestaurant(UUID restaurantId) {
        return restaurantRepository.findById(restaurantId)
                .orElseThrow(() -> RestaurantException.notFound(restaurantId));
    }

    private void validateTableBelongsToRestaurant(UUID tableId, UUID restaurantId) {
        tableRepository.findByIdAndRestaurantId(tableId, restaurantId)
                .orElseThrow(ReservationException::tableNotInRestaurant);
    }

    private RestaurantTable findTableInRestaurant(UUID tableId, UUID restaurantId) {
        return tableRepository.findByIdAndRestaurantId(tableId, restaurantId)
                .orElseThrow(ReservationException::tableNotInRestaurant);
    }

    private boolean isUpcoming(Reservation r) {
        if (!ACTIVE_STATUSES.contains(r.getStatus())) return false;
        LocalDate today = LocalDate.now(clock);
        if (r.getDate().isAfter(today)) return true;
        if (r.getDate().isEqual(today)) return r.getStartTime().isAfter(LocalTime.now(clock));
        return false;
    }

    private void validateNotInPast(LocalDate date, LocalTime startTime) {
        LocalDate today = LocalDate.now(clock);
        if (date.isBefore(today)) {
            throw ReservationException.invalidTime("Nelze vytvořit rezervaci v minulosti.");
        }
        if (date.isEqual(today) && !startTime.isAfter(LocalTime.now(clock).plusMinutes(BOOKING_BUFFER_MINUTES))) {
            throw ReservationException.invalidTime("Čas rezervace musí být alespoň " + BOOKING_BUFFER_MINUTES + " minut od teď.");
        }
    }

    private boolean computeCanEdit(Reservation r) {
        if (!isUpcoming(r)) return false;
        // Only PENDING_CONFIRMATION reservations can be edited by the customer
        if (r.getStatus() != ReservationStatus.PENDING_CONFIRMATION
                && r.getStatus() != ReservationStatus.RESERVED) {
            return false;
        }
        LocalDate today = LocalDate.now(clock);
        if (r.getDate().isAfter(today)) return true;
        // Same day: must be at least EDIT_CUTOFF_MINUTES before start
        return r.getStartTime().isAfter(LocalTime.now(clock).plusMinutes(EDIT_CUTOFF_MINUTES));
    }

    private boolean computeCanCancel(Reservation r) {
        return isUpcoming(r);
    }

    private ReservationResponse toResponse(Reservation r, String restaurantName, String tableLabel, boolean canEdit) {
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
                .canEdit(canEdit)
                .canCancel(computeCanCancel(r))
                .build();
    }

    private record NamesMaps(Map<UUID, String> restaurantNames, Map<UUID, String> tableLabels) {}

    private NamesMaps batchLoadNames(List<Reservation> reservations) {
        var restaurantIds = reservations.stream().map(Reservation::getRestaurantId).collect(Collectors.toSet());
        var tableIds = reservations.stream().map(Reservation::getTableId).collect(Collectors.toSet());

        var restaurantNames = restaurantRepository.findAllById(restaurantIds).stream()
                .collect(Collectors.toMap(Restaurant::getId, Restaurant::getName));
        var tableLabels = tableRepository.findAllById(tableIds).stream()
                .collect(Collectors.toMap(RestaurantTable::getId, RestaurantTable::getLabel));

        return new NamesMaps(restaurantNames, tableLabels);
    }
}
