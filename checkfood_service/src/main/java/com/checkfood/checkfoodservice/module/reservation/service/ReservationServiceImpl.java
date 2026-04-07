package com.checkfood.checkfoodservice.module.reservation.service;

import lombok.extern.slf4j.Slf4j;
import com.checkfood.checkfoodservice.module.reservation.dto.request.CreateReservationRequest;
import com.checkfood.checkfoodservice.module.reservation.dto.request.UpdateReservationRequest;
import com.checkfood.checkfoodservice.module.reservation.dto.response.*;
import com.checkfood.checkfoodservice.module.reservation.entity.ChangeRequestStatus;
import com.checkfood.checkfoodservice.module.reservation.entity.Reservation;
import com.checkfood.checkfoodservice.module.reservation.entity.ReservationStatus;
import com.checkfood.checkfoodservice.module.reservation.exception.ReservationException;
import com.checkfood.checkfoodservice.module.reservation.logging.ReservationLogger;
import com.checkfood.checkfoodservice.module.reservation.repository.ReservationChangeRequestRepository;
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
import java.time.LocalDateTime;
import java.time.LocalTime;
import java.util.*;
import java.util.stream.Collectors;

/**
 * Implementace {@link ReservationService} pro zákaznické operace s rezervacemi.
 * Obsahuje algoritmus pro výpočet dostupných slotů s podporou hodin přes půlnoc,
 * race-safe kontrolu kolizí v transakci a anti-spam limity.
 *
 * @author Rostislav Jirák
 * @version 1.0.0
 */
@Slf4j
@Service
@RequiredArgsConstructor
public class ReservationServiceImpl implements ReservationService {

    private static final int SLOT_INTERVAL_MINUTES = 30;
    private static final int BOOKING_BUFFER_MINUTES = 10;
    private static final int EDIT_CUTOFF_MINUTES = 120;
    private static final int HISTORY_PREVIEW_LIMIT = 10;
    private static final int MAX_RESERVATIONS_PER_RESTAURANT_PER_DAY = 3;
    private static final int MAX_ACTIVE_RESERVATIONS_TOTAL = 10;

    /** Stavy označující "aktivní" rezervaci (nadcházející, editovatelné, blokující sloty). */
    private static final Set<ReservationStatus> ACTIVE_STATUSES = Set.of(
            ReservationStatus.PENDING_CONFIRMATION,
            ReservationStatus.CONFIRMED,
            ReservationStatus.RESERVED,   // zpětná kompatibilita s existujícími záznamy v databázi
            ReservationStatus.CHECKED_IN
    );

    /** Stavy vyloučené z dotazů na dostupné sloty a stav stolů. */
    private static final List<ReservationStatus> EXCLUDED_STATUSES = List.of(
            ReservationStatus.CANCELLED,
            ReservationStatus.REJECTED,
            ReservationStatus.COMPLETED
    );

    private final ReservationRepository reservationRepository;
    private final RestaurantRepository restaurantRepository;
    private final RestaurantTableRepository tableRepository;
    private final ReservationChangeRequestRepository changeRequestRepository;
    private final ReservationLogger reservationLogger;
    private final Clock clock;

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

    @Override
    @Transactional(readOnly = true)
    public TableStatusResponse getTableStatuses(UUID restaurantId, LocalDate date) {
        var tables = tableRepository.findAllByRestaurantIdAndActiveTrue(restaurantId);
        var reservations = reservationRepository.findAllByRestaurantIdAndDateAndStatusNotIn(
                restaurantId, date, EXCLUDED_STATUSES
        );

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

    @Override
    @Transactional(readOnly = true)
    public AvailableSlotsResponse getAvailableSlots(UUID restaurantId, UUID tableId, LocalDate date, UUID excludeReservationId) {
        var restaurant = findRestaurant(restaurantId);
        validateTableBelongsToRestaurant(tableId, restaurantId);

        var specialDay = restaurant.getSpecialDays().stream()
                .filter(sd -> sd.getDate().equals(date))
                .findFirst()
                .orElse(null);

        if (specialDay != null && specialDay.isClosed()) {
            return AvailableSlotsResponse.builder()
                    .date(date).tableId(tableId)
                    .slotMinutes(SLOT_INTERVAL_MINUTES)
                    .durationMinutes(restaurant.getDefaultReservationDurationMinutes())
                    .availableStartTimes(List.of())
                    .build();
        }

        DayOfWeek dayOfWeek = date.getDayOfWeek();
        OpeningHours hours;
        if (specialDay != null && specialDay.getOpenAt() != null && specialDay.getCloseAt() != null) {
            hours = OpeningHours.builder()
                    .dayOfWeek(dayOfWeek)
                    .openAt(specialDay.getOpenAt())
                    .closeAt(specialDay.getCloseAt())
                    .closed(false)
                    .build();
        } else {
            hours = restaurant.getOpeningHours().stream()
                    .filter(h -> h.getDayOfWeek() == dayOfWeek)
                    .findFirst()
                    .orElse(null);
        }

        if (hours == null || hours.isClosed() || hours.getOpenAt() == null || hours.getCloseAt() == null) {
            return AvailableSlotsResponse.builder()
                    .date(date)
                    .tableId(tableId)
                    .slotMinutes(SLOT_INTERVAL_MINUTES)
                    .durationMinutes(restaurant.getDefaultReservationDurationMinutes())
                    .availableStartTimes(List.of())
                    .build();
        }

        var existingReservations = reservationRepository.findAllByTableIdAndDateAndStatusNotIn(
                tableId, date, EXCLUDED_STATUSES
        );

        if (excludeReservationId != null) {
            existingReservations = existingReservations.stream()
                    .filter(r -> !r.getId().equals(excludeReservationId))
                    .toList();
        }

        LocalTime openAt = hours.getOpenAt();
        LocalTime closeAt = hours.getCloseAt();
        int durationMinutes = restaurant.getDefaultReservationDurationMinutes();

        boolean crossesMidnight = closeAt.isBefore(openAt) || closeAt.equals(openAt);

        int openMinutes = openAt.getHour() * 60 + openAt.getMinute();
        int totalOpenMinutes = crossesMidnight
                ? (24 * 60 - openMinutes) + (closeAt.getHour() * 60 + closeAt.getMinute())
                : (closeAt.getHour() * 60 + closeAt.getMinute()) - openMinutes;
        int lastPossibleOffset = totalOpenMinutes - durationMinutes;

        if (lastPossibleOffset < 0) {
            return AvailableSlotsResponse.builder()
                    .date(date).tableId(tableId)
                    .slotMinutes(SLOT_INTERVAL_MINUTES)
                    .durationMinutes(durationMinutes)
                    .availableStartTimes(List.of())
                    .build();
        }

        int startOffset = 0;
        if (date.equals(LocalDate.now(clock))) {
            var now = LocalTime.now(clock);
            var nowPlusBuffer = now.plusMinutes(BOOKING_BUFFER_MINUTES);
            int nowMinutes = nowPlusBuffer.getHour() * 60 + nowPlusBuffer.getMinute();
            int offsetFromOpen;
            if (crossesMidnight && nowMinutes < openMinutes) {
                offsetFromOpen = (24 * 60 - openMinutes) + nowMinutes;
            } else {
                offsetFromOpen = nowMinutes - openMinutes;
            }
            if (offsetFromOpen > lastPossibleOffset) {
                return AvailableSlotsResponse.builder()
                        .date(date).tableId(tableId)
                        .slotMinutes(SLOT_INTERVAL_MINUTES)
                        .durationMinutes(durationMinutes)
                        .availableStartTimes(List.of())
                        .build();
            }
            if (offsetFromOpen > 0) {
                int slotsToSkip = (offsetFromOpen + SLOT_INTERVAL_MINUTES - 1) / SLOT_INTERVAL_MINUTES;
                startOffset = slotsToSkip * SLOT_INTERVAL_MINUTES;
            }
        }

        List<LocalTime> availableSlots = new ArrayList<>();
        for (int offset = startOffset; offset <= lastPossibleOffset; offset += SLOT_INTERVAL_MINUTES) {
            int candidateMinutes = (openMinutes + offset) % (24 * 60);
            LocalTime slot = LocalTime.of(candidateMinutes / 60, candidateMinutes % 60);
            int slotEndMinutes = (candidateMinutes + durationMinutes) % (24 * 60);
            LocalTime slotEnd = LocalTime.of(slotEndMinutes / 60, slotEndMinutes % 60);

            final LocalTime fSlot = slot;
            final LocalTime fSlotEnd = slotEnd;
            final boolean slotCrossesMidnight = slotEndMinutes < candidateMinutes;

            boolean hasConflict = existingReservations.stream()
                    .anyMatch(r -> {
                        LocalTime rStart = r.getStartTime();
                        LocalTime rEnd = r.getEndTime() != null
                                ? r.getEndTime()
                                : r.getStartTime().plusMinutes(durationMinutes);

                            int s1 = fSlot.getHour() * 60 + fSlot.getMinute();
                        int e1 = s1 + durationMinutes;
                        int s2 = rStart.getHour() * 60 + rStart.getMinute();
                        int e2 = rEnd.getHour() * 60 + rEnd.getMinute();
                        if (e2 <= s2) e2 += 24 * 60;
                        if (slotCrossesMidnight) e1 = s1 + durationMinutes;

                        return s1 < e2 && e1 > s2;
                    });

            if (!hasConflict) {
                availableSlots.add(slot);
            }
        }

        return AvailableSlotsResponse.builder()
                .date(date)
                .tableId(tableId)
                .slotMinutes(SLOT_INTERVAL_MINUTES)
                .durationMinutes(durationMinutes)
                .availableStartTimes(availableSlots)
                .build();
    }

    @Override
    @Transactional
    public ReservationResponse createReservation(CreateReservationRequest request, Long userId) {
        var restaurant = findRestaurant(request.getRestaurantId());
        var table = findTableInRestaurant(request.getTableId(), request.getRestaurantId());

        validateNotInPast(request.getDate(), request.getStartTime());

        if (request.getPartySize() > table.getCapacity()) {
            throw ReservationException.partySizeExceedsCapacity(request.getPartySize(), table.getCapacity());
        }

        long perRestaurantPerDay = reservationRepository
                .findAllByRestaurantIdAndDateAndStatusNotIn(
                        request.getRestaurantId(), request.getDate(), EXCLUDED_STATUSES.stream().toList())
                .stream()
                .filter(r -> r.getUserId().equals(userId))
                .count();
        if (perRestaurantPerDay >= MAX_RESERVATIONS_PER_RESTAURANT_PER_DAY) {
            throw ReservationException.reservationLimitPerDay(MAX_RESERVATIONS_PER_RESTAURANT_PER_DAY);
        }

        long totalActive = reservationRepository
                .findAllByUserIdOrderByDateDescStartTimeDesc(userId)
                .stream()
                .filter(r -> ACTIVE_STATUSES.contains(r.getStatus()))
                .filter(r -> !r.getDate().isBefore(LocalDate.now(clock)))
                .count();
        if (totalActive >= MAX_ACTIVE_RESERVATIONS_TOTAL) {
            throw ReservationException.reservationLimitTotal(MAX_ACTIVE_RESERVATIONS_TOTAL);
        }

        int durationMinutes = restaurant.getDefaultReservationDurationMinutes();
        LocalTime endTime = request.getStartTime().plusMinutes(durationMinutes);

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
                .status(ReservationStatus.CONFIRMED)
                .partySize(request.getPartySize())
                .build();

        var saved = reservationRepository.save(reservation);

        reservationLogger.logReservationCreated(
                saved.getId(), saved.getRestaurantId(), saved.getTableId(), saved.getDate()
        );

        return toResponse(saved, null, null, false);
    }

    @Override
    @Transactional(readOnly = true)
    public MyReservationsOverviewResponse getMyReservationsOverview(Long userId) {
        var reservations = reservationRepository.findAllByUserIdOrderByDateDescStartTimeDesc(userId);

        var namesMaps = batchLoadNames(reservations);

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

    @Override
    @Transactional
    public ReservationResponse updateReservation(UUID id, UpdateReservationRequest request, Long userId) {
        var reservation = reservationRepository.findById(id)
                .orElseThrow(() -> ReservationException.notFound(id));

        if (!reservation.getUserId().equals(userId)) {
            throw ReservationException.accessDenied();
        }

        if (!computeCanEdit(reservation)) {
            throw ReservationException.cannotEdit();
        }

        validateNotInPast(request.getDate(), request.getStartTime());

        var table = findTableInRestaurant(request.getTableId(), reservation.getRestaurantId());
        if (request.getPartySize() > table.getCapacity()) {
            throw ReservationException.partySizeExceedsCapacity(request.getPartySize(), table.getCapacity());
        }

        var restaurant = findRestaurant(reservation.getRestaurantId());
        int dur = restaurant.getDefaultReservationDurationMinutes();
        LocalTime updateEndTime = request.getStartTime().plusMinutes(dur);
        boolean conflict = reservationRepository.existsOverlappingReservationExcluding(
                request.getTableId(),
                request.getDate(),
                request.getStartTime(),
                updateEndTime,
                id
        );

        if (conflict) {
            reservationLogger.logSlotConflict(request.getTableId(), request.getDate());
            throw ReservationException.slotConflict();
        }

        reservation.setTableId(request.getTableId());
        reservation.setDate(request.getDate());
        reservation.setStartTime(request.getStartTime());
        reservation.setEndTime(null);
        reservation.setPartySize(request.getPartySize());
        reservation.setStatus(ReservationStatus.PENDING_CONFIRMATION);

        var saved = reservationRepository.save(reservation);

        reservationLogger.logReservationUpdated(
                saved.getId(), saved.getTableId(), saved.getDate()
        );

        var restaurantName = restaurantRepository.findById(saved.getRestaurantId())
                .map(Restaurant::getName).orElse(null);
        var tableLabel = tableRepository.findById(saved.getTableId())
                .map(RestaurantTable::getLabel).orElse(null);

        return toResponse(saved, restaurantName, tableLabel, computeCanEdit(saved));
    }

    @Override
    @Transactional
    public ReservationResponse cancelReservation(UUID id, Long userId) {
        var reservation = reservationRepository.findById(id)
                .orElseThrow(() -> ReservationException.notFound(id));

        if (!reservation.getUserId().equals(userId)) {
            throw ReservationException.accessDenied();
        }

        if (reservation.getStatus() == ReservationStatus.CANCELLED) {
            throw ReservationException.alreadyCancelled();
        }

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

    @Override
    @Transactional(readOnly = true)
    public List<PendingChangeResponse> getPendingChangesForUser(Long userId) {
        var changeRequests = changeRequestRepository.findAllByReservationUserIdAndStatus(userId, ChangeRequestStatus.PENDING);

        if (changeRequests.isEmpty()) return List.of();

        var reservationIds = changeRequests.stream()
                .map(cr -> cr.getReservationId())
                .collect(Collectors.toSet());
        var reservationMap = reservationRepository.findAllById(reservationIds).stream()
                .collect(Collectors.toMap(Reservation::getId, r -> r));

        var restaurantIds = reservationMap.values().stream()
                .map(Reservation::getRestaurantId)
                .collect(Collectors.toSet());
        var restaurantNames = restaurantRepository.findAllById(restaurantIds).stream()
                .collect(Collectors.toMap(Restaurant::getId, Restaurant::getName));

        var allTableIds = new HashSet<UUID>();
        changeRequests.forEach(cr -> {
            allTableIds.add(cr.getOriginalTableId());
            if (cr.getProposedTableId() != null) allTableIds.add(cr.getProposedTableId());
        });
        var tableLabels = tableRepository.findAllById(allTableIds).stream()
                .collect(Collectors.toMap(RestaurantTable::getId, RestaurantTable::getLabel));

        return changeRequests.stream().map(cr -> {
            var reservation = reservationMap.get(cr.getReservationId());
            String restaurantName = reservation != null
                    ? restaurantNames.get(reservation.getRestaurantId()) : null;
            LocalDate reservationDate = reservation != null ? reservation.getDate() : null;

            return PendingChangeResponse.builder()
                    .id(cr.getId())
                    .reservationId(cr.getReservationId())
                    .restaurantName(restaurantName)
                    .proposedStartTime(cr.getProposedStartTime())
                    .proposedTableId(cr.getProposedTableId())
                    .proposedTableLabel(cr.getProposedTableId() != null
                            ? tableLabels.get(cr.getProposedTableId()) : null)
                    .originalStartTime(cr.getOriginalStartTime())
                    .originalTableId(cr.getOriginalTableId())
                    .originalTableLabel(tableLabels.get(cr.getOriginalTableId()))
                    .reservationDate(reservationDate)
                    .status(cr.getStatus())
                    .createdAt(cr.getCreatedAt())
                    .build();
        }).toList();
    }

    @Override
    @Transactional
    public ReservationResponse acceptChangeRequest(UUID changeRequestId, Long userId) {
        var changeRequest = changeRequestRepository.findById(changeRequestId)
                .orElseThrow(() -> ReservationException.changeRequestNotFound(changeRequestId));

        var reservation = reservationRepository.findById(changeRequest.getReservationId())
                .orElseThrow(() -> ReservationException.notFound(changeRequest.getReservationId()));
        if (!reservation.getUserId().equals(userId)) {
            throw ReservationException.accessDenied();
        }

        if (changeRequest.getStatus() != ChangeRequestStatus.PENDING) {
            throw ReservationException.invalidStatusTransition(
                    changeRequest.getStatus().name(), ChangeRequestStatus.ACCEPTED.name());
        }

        UUID targetTableId = changeRequest.getProposedTableId() != null
                ? changeRequest.getProposedTableId() : reservation.getTableId();
        LocalTime targetStartTime = changeRequest.getProposedStartTime() != null
                ? changeRequest.getProposedStartTime() : reservation.getStartTime();

        var acceptRestaurant = findRestaurant(reservation.getRestaurantId());
        LocalTime targetEndTime = targetStartTime.plusMinutes(acceptRestaurant.getDefaultReservationDurationMinutes());
        boolean conflict = reservationRepository.existsOverlappingReservationExcluding(
                targetTableId,
                reservation.getDate(),
                targetStartTime,
                targetEndTime,
                reservation.getId()
        );
        if (conflict) {
            throw ReservationException.slotConflict();
        }

        if (changeRequest.getProposedStartTime() != null) {
            reservation.setStartTime(changeRequest.getProposedStartTime());
        }
        if (changeRequest.getProposedTableId() != null) {
            reservation.setTableId(changeRequest.getProposedTableId());
        }
        var savedReservation = reservationRepository.save(reservation);

        changeRequest.setStatus(ChangeRequestStatus.ACCEPTED);
        changeRequest.setResolvedAt(LocalDateTime.now());
        changeRequestRepository.save(changeRequest);

        var restaurantName = restaurantRepository.findById(savedReservation.getRestaurantId())
                .map(Restaurant::getName).orElse(null);
        var tableLabel = tableRepository.findById(savedReservation.getTableId())
                .map(RestaurantTable::getLabel).orElse(null);

        return toResponse(savedReservation, restaurantName, tableLabel, computeCanEdit(savedReservation));
    }

    @Override
    @Transactional
    public ReservationResponse declineChangeRequest(UUID changeRequestId, Long userId) {
        var changeRequest = changeRequestRepository.findById(changeRequestId)
                .orElseThrow(() -> ReservationException.changeRequestNotFound(changeRequestId));

        var reservation = reservationRepository.findById(changeRequest.getReservationId())
                .orElseThrow(() -> ReservationException.notFound(changeRequest.getReservationId()));
        if (!reservation.getUserId().equals(userId)) {
            throw ReservationException.accessDenied();
        }

        if (changeRequest.getStatus() != ChangeRequestStatus.PENDING) {
            throw ReservationException.invalidStatusTransition(
                    changeRequest.getStatus().name(), ChangeRequestStatus.DECLINED.name());
        }

        changeRequest.setStatus(ChangeRequestStatus.DECLINED);
        changeRequest.setResolvedAt(LocalDateTime.now());
        changeRequestRepository.save(changeRequest);

        reservation.setStatus(ReservationStatus.CANCELLED);
        var savedReservation = reservationRepository.save(reservation);

        var restaurantName = restaurantRepository.findById(savedReservation.getRestaurantId())
                .map(Restaurant::getName).orElse(null);
        var tableLabel = tableRepository.findById(savedReservation.getTableId())
                .map(RestaurantTable::getLabel).orElse(null);

        return toResponse(savedReservation, restaurantName, tableLabel, false);
    }

    /**
     * Načte restauraci dle ID nebo vyhodí {@link RestaurantException} s HTTP 404.
     *
     * @param restaurantId UUID restaurace
     * @return nalezená entita restaurace
     */
    private Restaurant findRestaurant(UUID restaurantId) {
        return restaurantRepository.findById(restaurantId)
                .orElseThrow(() -> RestaurantException.notFound(restaurantId));
    }

    /**
     * Ověří, že stůl patří do dané restaurace. Vyhodí výjimku při neshodě.
     *
     * @param tableId      UUID stolu
     * @param restaurantId UUID restaurace
     */
    private void validateTableBelongsToRestaurant(UUID tableId, UUID restaurantId) {
        tableRepository.findByIdAndRestaurantId(tableId, restaurantId)
                .orElseThrow(ReservationException::tableNotInRestaurant);
    }

    /**
     * Načte stůl patřící do dané restaurace nebo vyhodí výjimku.
     *
     * @param tableId      UUID stolu
     * @param restaurantId UUID restaurace
     * @return entita stolu
     */
    private RestaurantTable findTableInRestaurant(UUID tableId, UUID restaurantId) {
        return tableRepository.findByIdAndRestaurantId(tableId, restaurantId)
                .orElseThrow(ReservationException::tableNotInRestaurant);
    }

    /**
     * Určí, zda je rezervace nadcházející (aktivní stav a datum/čas v budoucnosti).
     *
     * @param r rezervace ke kontrole
     * @return {@code true} pokud rezervace ještě nenastala
     */
    private boolean isUpcoming(Reservation r) {
        if (!ACTIVE_STATUSES.contains(r.getStatus())) return false;
        LocalDate today = LocalDate.now(clock);
        if (r.getDate().isAfter(today)) return true;
        if (r.getDate().isEqual(today)) return r.getStartTime().isAfter(LocalTime.now(clock));
        return false;
    }

    /**
     * Ověří, že kombinace data a času není v minulosti (s ohledem na booking buffer).
     * Vyhodí {@link ReservationException} pokud je datum nebo čas v minulosti.
     *
     * @param date      datum rezervace
     * @param startTime čas začátku rezervace
     */
    private void validateNotInPast(LocalDate date, LocalTime startTime) {
        LocalDate today = LocalDate.now(clock);
        if (date.isBefore(today)) {
            throw ReservationException.invalidTime("Nelze vytvořit rezervaci v minulosti.");
        }
        if (date.isEqual(today) && !startTime.isAfter(LocalTime.now(clock).plusMinutes(BOOKING_BUFFER_MINUTES))) {
            throw ReservationException.invalidTime("Čas rezervace musí být alespoň " + BOOKING_BUFFER_MINUTES + " minut od teď.");
        }
    }

    /**
     * Vypočítá, zda může zákazník rezervaci upravit.
     * Úprava je povolena jen pro rezervace v nadcházejícím datu a s editovatelným stavem,
     * přičemž ve stejný den musí být alespoň {@value #EDIT_CUTOFF_MINUTES} minut do začátku.
     *
     * @param r rezervace ke kontrole
     * @return {@code true} pokud lze rezervaci upravit
     */
    private boolean computeCanEdit(Reservation r) {
        if (!isUpcoming(r)) return false;
        if (r.getStatus() != ReservationStatus.PENDING_CONFIRMATION
                && r.getStatus() != ReservationStatus.CONFIRMED
                && r.getStatus() != ReservationStatus.RESERVED) {
            return false;
        }
        LocalDate today = LocalDate.now(clock);
        if (r.getDate().isAfter(today)) return true;
        return r.getStartTime().isAfter(LocalTime.now(clock).plusMinutes(EDIT_CUTOFF_MINUTES));
    }

    /**
     * Určí, zda může zákazník rezervaci zrušit (rezervace musí být nadcházející).
     *
     * @param r rezervace ke kontrole
     * @return {@code true} pokud lze rezervaci zrušit
     */
    private boolean computeCanCancel(Reservation r) {
        return isUpcoming(r);
    }

    /**
     * Sestaví {@link ReservationResponse} z entity rezervace a doplňkových dat.
     *
     * @param r              entita rezervace
     * @param restaurantName název restaurace (může být {@code null})
     * @param tableLabel     označení stolu (může být {@code null})
     * @param canEdit        příznak zda zákazník může rezervaci upravit
     * @return sestavený response DTO
     */
    private ReservationResponse toResponse(Reservation r, String restaurantName, String tableLabel, boolean canEdit) {
        var pendingChangeOpt = changeRequestRepository.findByReservationIdAndStatus(r.getId(), ChangeRequestStatus.PENDING);
        ReservationResponse.PendingChangeDetail pendingChangeDetail = null;
        if (pendingChangeOpt.isPresent()) {
            var cr = pendingChangeOpt.get();
            String proposedTableLabel = cr.getProposedTableId() != null
                    ? tableRepository.findById(cr.getProposedTableId()).map(RestaurantTable::getLabel).orElse(null)
                    : null;
            pendingChangeDetail = ReservationResponse.PendingChangeDetail.builder()
                    .changeRequestId(cr.getId())
                    .proposedStartTime(cr.getProposedStartTime())
                    .proposedTableId(cr.getProposedTableId())
                    .proposedTableLabel(proposedTableLabel)
                    .build();
        }

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
                .pendingChange(pendingChangeDetail)
                .recurringReservationId(r.getRecurringReservationId())
                .build();
    }

    private record NamesMaps(Map<UUID, String> restaurantNames, Map<UUID, String> tableLabels) {}

    /**
     * Hromadně načte názvy restaurací a označení stolů pro seznam rezervací.
     * Zabraňuje N+1 dotazům při sestavování odpovědí.
     *
     * @param reservations seznam rezervací
     * @return přepravní objekt s mapami názvů indexovanými dle UUID
     */
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
