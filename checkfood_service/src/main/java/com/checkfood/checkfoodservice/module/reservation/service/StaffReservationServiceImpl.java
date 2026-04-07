package com.checkfood.checkfoodservice.module.reservation.service;

import com.checkfood.checkfoodservice.module.reservation.dto.request.ConfirmRecurringReservationRequest;
import com.checkfood.checkfoodservice.module.reservation.dto.request.ExtendReservationRequest;
import com.checkfood.checkfoodservice.module.reservation.dto.request.ProposeChangeRequest;
import com.checkfood.checkfoodservice.module.reservation.dto.response.PendingChangeResponse;
import com.checkfood.checkfoodservice.module.reservation.dto.response.RecurringReservationResponse;
import com.checkfood.checkfoodservice.module.reservation.dto.response.ReservationResponse;
import com.checkfood.checkfoodservice.module.reservation.dto.response.StaffReservationResponse;
import com.checkfood.checkfoodservice.module.reservation.dto.response.StaffTableResponse;
import com.checkfood.checkfoodservice.module.reservation.entity.ChangeRequestStatus;
import com.checkfood.checkfoodservice.module.reservation.entity.RecurringReservation;
import com.checkfood.checkfoodservice.module.reservation.entity.RecurringReservationStatus;
import com.checkfood.checkfoodservice.module.reservation.entity.Reservation;
import com.checkfood.checkfoodservice.module.reservation.entity.ReservationChangeRequest;
import com.checkfood.checkfoodservice.module.reservation.entity.ReservationStatus;
import com.checkfood.checkfoodservice.module.reservation.exception.ReservationException;
import com.checkfood.checkfoodservice.module.reservation.logging.ReservationLogger;
import com.checkfood.checkfoodservice.module.reservation.repository.RecurringReservationRepository;
import com.checkfood.checkfoodservice.module.reservation.repository.ReservationChangeRequestRepository;
import com.checkfood.checkfoodservice.module.reservation.repository.ReservationRepository;
import com.checkfood.checkfoodservice.module.restaurant.entity.restaurant.Restaurant;
import com.checkfood.checkfoodservice.module.restaurant.entity.restaurant.table.RestaurantTable;
import com.checkfood.checkfoodservice.module.restaurant.entity.employee.EmployeePermission;
import com.checkfood.checkfoodservice.module.restaurant.entity.employee.MembershipStatus;
import com.checkfood.checkfoodservice.module.restaurant.entity.employee.RestaurantEmployee;
import com.checkfood.checkfoodservice.module.restaurant.exception.RestaurantException;
import com.checkfood.checkfoodservice.module.restaurant.repository.RestaurantEmployeeRepository;
import com.checkfood.checkfoodservice.module.restaurant.repository.RestaurantRepository;
import com.checkfood.checkfoodservice.module.restaurant.repository.table.RestaurantTableRepository;
import com.checkfood.checkfoodservice.security.module.user.service.UserService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.server.ResponseStatusException;

import java.time.Clock;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.LocalTime;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.UUID;
import java.util.stream.Collectors;

/**
 * Implementace {@link StaffReservationService} pro operace personálu restaurace.
 * Ověřuje příslušnost zaměstnance k restauraci a jeho konkrétní oprávnění před každou operací.
 *
 * @author Rostislav Jirák
 * @version 1.0.0
 */
@Service
@RequiredArgsConstructor
public class StaffReservationServiceImpl implements StaffReservationService {

    private static final int CHECKIN_BEFORE_MINUTES = 30;
    private static final int CHECKIN_AFTER_MINUTES = 60;

    private final ReservationRepository reservationRepository;
    private final RecurringReservationRepository recurringRepository;
    private final RestaurantRepository restaurantRepository;
    private final RestaurantTableRepository tableRepository;
    private final RestaurantEmployeeRepository employeeRepository;
    private final ReservationChangeRequestRepository changeRequestRepository;
    private final UserService userService;
    private final ReservationLogger reservationLogger;
    private final RecurringReservationServiceImpl recurringReservationService;
    private final Clock clock;

    @Override
    @Transactional(readOnly = true)
    public List<StaffReservationResponse> getReservationsForMyRestaurant(String userEmail, LocalDate date, UUID restaurantId) {
        var membership = findActiveMembership(userEmail, restaurantId);
        var resolvedRestaurantId = membership.getRestaurant().getId();

        var reservations = reservationRepository
                .findAllByRestaurantIdAndDateOrderByStartTimeAsc(resolvedRestaurantId, date);

        var tableIds = reservations.stream()
                .map(Reservation::getTableId)
                .collect(Collectors.toSet());
        var tableLabels = tableRepository.findAllById(tableIds).stream()
                .collect(Collectors.toMap(RestaurantTable::getId, RestaurantTable::getLabel));

        var userIds = reservations.stream()
                .map(Reservation::getUserId)
                .collect(Collectors.toSet());
        var userNames = new HashMap<Long, String>();
        for (var userId : userIds) {
            try {
                var user = userService.findById(userId);
                var name = buildUserName(user);
                userNames.put(userId, name);
            } catch (Exception e) {
                // Uživatel může být smazán — záměrně ignorováno
            }
        }

        var reservationIds = reservations.stream()
                .map(Reservation::getId)
                .collect(Collectors.toSet());
        Set<UUID> reservationIdsWithPendingChange = reservationIds.isEmpty()
                ? Set.of()
                : new HashSet<>(changeRequestRepository.findReservationIdsWithStatus(reservationIds, ChangeRequestStatus.PENDING));

        var now = LocalTime.now(clock);
        var today = LocalDate.now(clock);

        return reservations.stream()
                .map(r -> toStaffResponse(r, tableLabels.get(r.getTableId()),
                        userNames.get(r.getUserId()), date, today, now,
                        reservationIdsWithPendingChange.contains(r.getId())))
                .toList();
    }

    @Override
    @Transactional
    public ReservationResponse confirmReservation(UUID reservationId, String userEmail, UUID restaurantId) {
        var membership = findActiveMembership(userEmail, restaurantId);
        requirePermission(membership, EmployeePermission.CONFIRM_RESERVATION);
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

    @Override
    @Transactional
    public ReservationResponse rejectReservation(UUID reservationId, String userEmail, UUID restaurantId) {
        var membership = findActiveMembership(userEmail, restaurantId);
        requirePermission(membership, EmployeePermission.CANCEL_RESERVATION);
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

    @Override
    @Transactional
    public ReservationResponse checkInReservation(UUID reservationId, String userEmail, UUID restaurantId) {
        var membership = findActiveMembership(userEmail, restaurantId);
        requirePermission(membership, EmployeePermission.CHECK_IN_RESERVATION);
        var reservation = findAndVerifyAccess(reservationId, membership);

        if (reservation.getStatus() != ReservationStatus.CONFIRMED
                && reservation.getStatus() != ReservationStatus.RESERVED) {
            throw ReservationException.invalidStatusTransition(
                    reservation.getStatus().name(), ReservationStatus.CHECKED_IN.name());
        }

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

    @Override
    @Transactional
    public ReservationResponse completeReservation(UUID reservationId, String userEmail, UUID restaurantId) {
        var membership = findActiveMembership(userEmail, restaurantId);
        requirePermission(membership, EmployeePermission.COMPLETE_RESERVATION);
        var reservation = findAndVerifyAccess(reservationId, membership);

        if (reservation.getStatus() != ReservationStatus.CHECKED_IN) {
            throw ReservationException.invalidStatusTransition(
                    reservation.getStatus().name(), ReservationStatus.COMPLETED.name());
        }

        reservation.setEndTime(LocalTime.now(clock));
        reservation.setStatus(ReservationStatus.COMPLETED);
        var saved = reservationRepository.save(reservation);
        reservationLogger.logReservationCompleted(saved.getId(), saved.getDate());

        return toReservationResponse(saved);
    }

    @Override
    @Transactional(readOnly = true)
    public List<StaffTableResponse> getTablesForMyRestaurant(String userEmail, UUID restaurantId) {
        var membership = findActiveMembership(userEmail, restaurantId);
        var resolvedRestaurantId = membership.getRestaurant().getId();

        return tableRepository.findAllByRestaurantId(resolvedRestaurantId).stream()
                .map(t -> StaffTableResponse.builder()
                        .id(t.getId())
                        .label(t.getLabel())
                        .capacity(t.getCapacity())
                        .active(t.isActive())
                        .build())
                .toList();
    }

    @Override
    @Transactional
    public PendingChangeResponse proposeChange(UUID reservationId, ProposeChangeRequest request, String userEmail, UUID restaurantId) {
        var membership = findActiveMembership(userEmail, restaurantId);
        requirePermission(membership, EmployeePermission.EDIT_RESERVATION);
        var reservation = findAndVerifyAccess(reservationId, membership);
        var resolvedRestaurantId = membership.getRestaurant().getId();

        if (reservation.getStatus() != ReservationStatus.CONFIRMED
                && reservation.getStatus() != ReservationStatus.RESERVED) {
            throw ReservationException.invalidStatusTransition(
                    reservation.getStatus().name(), "CHANGE_PROPOSED");
        }

        if (request.getStartTime() == null && request.getTableId() == null) {
            throw new ResponseStatusException(HttpStatus.BAD_REQUEST,
                    "Alespoň jedno pole (startTime nebo tableId) musí být vyplněno.");
        }

        changeRequestRepository.findByReservationIdAndStatus(reservationId, ChangeRequestStatus.PENDING)
                .ifPresent(existing -> {
                    existing.setStatus(ChangeRequestStatus.DECLINED);
                    existing.setResolvedAt(java.time.LocalDateTime.now());
                    changeRequestRepository.save(existing);
                });

        if (request.getTableId() != null) {
            tableRepository.findByIdAndRestaurantId(request.getTableId(), resolvedRestaurantId)
                    .orElseThrow(ReservationException::tableNotInRestaurant);
        }

        if (request.getStartTime() != null) {
            UUID targetTableId = request.getTableId() != null ? request.getTableId() : reservation.getTableId();
            int proposeDur = membership.getRestaurant().getDefaultReservationDurationMinutes();
            LocalTime proposeEndTime = request.getStartTime().plusMinutes(proposeDur);
            boolean conflict = reservationRepository.existsOverlappingReservationExcluding(
                    targetTableId,
                    reservation.getDate(),
                    request.getStartTime(),
                    proposeEndTime,
                    reservationId
            );
            if (conflict) {
                throw ReservationException.slotConflict();
            }
        }

        String originalTableLabel = tableRepository.findById(reservation.getTableId())
                .map(RestaurantTable::getLabel).orElse(null);

        String proposedTableLabel = null;
        if (request.getTableId() != null) {
            proposedTableLabel = tableRepository.findById(request.getTableId())
                    .map(RestaurantTable::getLabel).orElse(null);
        }

        var staffUser = userService.findByEmail(userEmail);
        var changeRequest = ReservationChangeRequest.builder()
                .reservationId(reservationId)
                .requestedByUserId(staffUser.getId())
                .proposedStartTime(request.getStartTime())
                .proposedTableId(request.getTableId())
                .originalStartTime(reservation.getStartTime())
                .originalTableId(reservation.getTableId())
                .build();

        var saved = changeRequestRepository.save(changeRequest);

        if (staffUser.getId().equals(reservation.getUserId())) {
            saved.setStatus(ChangeRequestStatus.ACCEPTED);
            saved.setResolvedAt(java.time.LocalDateTime.now());
            changeRequestRepository.save(saved);

            if (saved.getProposedStartTime() != null) {
                reservation.setStartTime(saved.getProposedStartTime());
                int dur = membership.getRestaurant().getDefaultReservationDurationMinutes();
                reservation.setEndTime(saved.getProposedStartTime().plusMinutes(dur));
            }
            if (saved.getProposedTableId() != null) {
                reservation.setTableId(saved.getProposedTableId());
            }
            reservationRepository.save(reservation);
        }

        return PendingChangeResponse.builder()
                .id(saved.getId())
                .reservationId(reservationId)
                .proposedStartTime(saved.getProposedStartTime())
                .proposedTableId(saved.getProposedTableId())
                .proposedTableLabel(proposedTableLabel)
                .originalStartTime(saved.getOriginalStartTime())
                .originalTableId(saved.getOriginalTableId())
                .originalTableLabel(originalTableLabel)
                .status(saved.getStatus())
                .createdAt(saved.getCreatedAt())
                .build();
    }

    @Override
    @Transactional
    public ReservationResponse extendReservation(UUID reservationId, ExtendReservationRequest request, String userEmail, UUID restaurantId) {
        var membership = findActiveMembership(userEmail, restaurantId);
        requirePermission(membership, EmployeePermission.EDIT_RESERVATION_DURATION);
        var reservation = findAndVerifyAccess(reservationId, membership);

        if (reservation.getStatus() != ReservationStatus.CHECKED_IN
                && reservation.getStatus() != ReservationStatus.CONFIRMED
                && reservation.getStatus() != ReservationStatus.RESERVED) {
            throw ReservationException.invalidStatusTransition(
                    reservation.getStatus().name(), "EXTENDED");
        }

        var now = LocalTime.now(clock);
        if (!request.getEndTime().isAfter(now)) {
            throw ReservationException.invalidTime("Čas ukončení musí být v budoucnosti.");
        }

        boolean conflict = reservationRepository.existsOverlappingReservationExcluding(
                reservation.getTableId(),
                reservation.getDate(),
                reservation.getStartTime(),
                request.getEndTime(),
                reservationId
        );
        if (conflict) {
            throw ReservationException.slotConflict();
        }

        reservation.setEndTime(request.getEndTime());
        var saved = reservationRepository.save(reservation);

        return toReservationResponse(saved);
    }

    @Override
    @Transactional
    public RecurringReservationResponse confirmRecurringReservation(UUID id, ConfirmRecurringReservationRequest request, String userEmail, UUID restaurantId) {
        var membership = findActiveMembership(userEmail, restaurantId);
        requirePermission(membership, EmployeePermission.CONFIRM_RESERVATION);

        var recurring = recurringRepository.findById(id)
                .orElseThrow(() -> ReservationException.recurringNotFound(id));

        if (!recurring.getRestaurantId().equals(membership.getRestaurant().getId())) {
            throw ReservationException.notRestaurantStaff();
        }

        if (recurring.getStatus() != RecurringReservationStatus.PENDING_CONFIRMATION) {
            throw ReservationException.recurringAlreadyActive();
        }

        recurring.setRepeatUntil(request.getRepeatUntil());
        recurring.setStatus(RecurringReservationStatus.ACTIVE);
        var saved = recurringRepository.save(recurring);

        var restaurant = restaurantRepository.findById(recurring.getRestaurantId())
                .orElseThrow(() -> RestaurantException.notFound(recurring.getRestaurantId()));
        int instanceCount = recurringReservationService.generateInstances(saved, restaurant);

        if (instanceCount == 0) {
            throw ReservationException.recurringNoInstances();
        }

        String tableLabel = tableRepository.findById(recurring.getTableId())
                .map(RestaurantTable::getLabel).orElse(null);

        return recurringReservationService.toResponse(saved, restaurant.getName(), tableLabel, instanceCount);
    }

    @Override
    @Transactional
    public RecurringReservationResponse rejectRecurringReservation(UUID id, String userEmail, UUID restaurantId) {
        var membership = findActiveMembership(userEmail, restaurantId);
        requirePermission(membership, EmployeePermission.CANCEL_RESERVATION);

        var recurring = recurringRepository.findById(id)
                .orElseThrow(() -> ReservationException.recurringNotFound(id));

        if (!recurring.getRestaurantId().equals(membership.getRestaurant().getId())) {
            throw ReservationException.notRestaurantStaff();
        }

        if (recurring.getStatus() != RecurringReservationStatus.PENDING_CONFIRMATION) {
            throw ReservationException.recurringAlreadyActive();
        }

        recurring.setStatus(RecurringReservationStatus.REJECTED);
        var saved = recurringRepository.save(recurring);

        String restaurantName = restaurantRepository.findById(recurring.getRestaurantId())
                .map(Restaurant::getName).orElse(null);
        String tableLabel = tableRepository.findById(recurring.getTableId())
                .map(RestaurantTable::getLabel).orElse(null);

        return recurringReservationService.toResponse(saved, restaurantName, tableLabel, 0);
    }

    @Override
    @Transactional
    public RecurringReservationResponse cancelRecurringReservation(UUID id, String userEmail, UUID restaurantId) {
        var membership = findActiveMembership(userEmail, restaurantId);
        requirePermission(membership, EmployeePermission.CANCEL_RESERVATION);

        var recurring = recurringRepository.findById(id)
                .orElseThrow(() -> ReservationException.recurringNotFound(id));

        if (!recurring.getRestaurantId().equals(membership.getRestaurant().getId())) {
            throw ReservationException.notRestaurantStaff();
        }

        if (recurring.getStatus() == RecurringReservationStatus.CANCELLED) {
            throw ReservationException.alreadyCancelled();
        }

        recurring.setStatus(RecurringReservationStatus.CANCELLED);
        recurringRepository.save(recurring);

        recurringReservationService.cancelFutureInstances(id);

        String restaurantName = restaurantRepository.findById(recurring.getRestaurantId())
                .map(Restaurant::getName).orElse(null);
        String tableLabel = tableRepository.findById(recurring.getTableId())
                .map(RestaurantTable::getLabel).orElse(null);

        return recurringReservationService.toResponse(recurring, restaurantName, tableLabel, 0);
    }

    @Override
    @Transactional(readOnly = true)
    public List<RecurringReservationResponse> getRecurringReservationsForMyRestaurant(String userEmail, UUID restaurantId) {
        var membership = findActiveMembership(userEmail, restaurantId);
        var resolvedRestaurantId = membership.getRestaurant().getId();

        var allStatuses = List.of(
                RecurringReservationStatus.PENDING_CONFIRMATION,
                RecurringReservationStatus.ACTIVE,
                RecurringReservationStatus.REJECTED,
                RecurringReservationStatus.CANCELLED
        );

        var list = recurringRepository.findAllByRestaurantIdAndStatusIn(resolvedRestaurantId, allStatuses);

        String restaurantName = membership.getRestaurant().getName();

        return list.stream().map(r -> {
            String tableLabel = tableRepository.findById(r.getTableId())
                    .map(RestaurantTable::getLabel).orElse(null);
            int instanceCount = 0;
            if (r.getStatus() == RecurringReservationStatus.ACTIVE) {
                instanceCount = (int) reservationRepository
                        .findAllByRecurringReservationIdAndDateGreaterThanEqualAndStatusNotIn(
                                r.getId(),
                                LocalDate.of(2000, 1, 1),
                                List.of(ReservationStatus.CANCELLED, ReservationStatus.REJECTED, ReservationStatus.COMPLETED))
                        .size();
            }
            return recurringReservationService.toResponse(r, restaurantName, tableLabel, instanceCount);
        }).toList();
    }

    /**
     * Najde aktivní členství zaměstnance v restauraci.
     * Pokud je {@code restaurantId} {@code null}, vrátí první přiřazenou restauraci.
     *
     * @param userEmail    e-mail zaměstnance
     * @param restaurantId UUID konkrétní restaurace, nebo {@code null}
     * @return entita členství s načtenou restaurací
     * @throws ReservationException pokud zaměstnanec nemá aktivní členství
     */
    private RestaurantEmployee findActiveMembership(String userEmail, UUID restaurantId) {
        var user = userService.findByEmail(userEmail);
        RestaurantEmployee membership;
        if (restaurantId != null) {
            membership = employeeRepository.findByUserIdAndRestaurantId(user.getId(), restaurantId)
                    .orElseThrow(ReservationException::notRestaurantStaff);
        } else {
            membership = employeeRepository.findAllByUserId(user.getId())
                    .stream().findFirst()
                    .orElseThrow(ReservationException::notRestaurantStaff);
        }
        if (membership.getMembershipStatus() != MembershipStatus.ACTIVE) {
            throw ReservationException.notRestaurantStaff();
        }
        return membership;
    }

    /**
     * Načte rezervaci a ověří, že patří do restaurace zaměstnance.
     *
     * @param reservationId UUID rezervace
     * @param membership    aktivní členství zaměstnance
     * @return entita rezervace
     * @throws ReservationException pokud rezervace nepatří do restaurace zaměstnance
     */
    private Reservation findAndVerifyAccess(UUID reservationId, RestaurantEmployee membership) {
        var reservation = reservationRepository.findById(reservationId)
                .orElseThrow(() -> ReservationException.notFound(reservationId));
        if (!reservation.getRestaurantId().equals(membership.getRestaurant().getId())) {
            throw ReservationException.notRestaurantStaff();
        }
        return reservation;
    }

    /**
     * Ověří, že zaměstnanec má požadované oprávnění. Vyhodí výjimku při chybějícím oprávnění.
     *
     * @param membership aktivní členství zaměstnance
     * @param permission požadované oprávnění
     */
    private void requirePermission(RestaurantEmployee membership, EmployeePermission permission) {
        if (!membership.hasPermission(permission)) {
            throw RestaurantException.permissionDenied(permission.name());
        }
    }

    /**
     * Sestaví zobrazované jméno uživatele z dostupných polí (jméno + příjmení, jméno, nebo username).
     *
     * @param user entita uživatele
     * @return zobrazované jméno
     */
    private String buildUserName(com.checkfood.checkfoodservice.security.module.user.entity.UserEntity user) {
        if (user.getFirstName() != null && user.getLastName() != null) {
            return user.getFirstName() + " " + user.getLastName();
        }
        if (user.getFirstName() != null) return user.getFirstName();
        return user.getUsername();
    }

    /**
     * Sestaví {@link StaffReservationResponse} z entity rezervace a kontextových dat.
     * Vypočítá dostupné akce (canConfirm, canReject, canCheckIn, canComplete, canEdit) na základě
     * aktuálního stavu, dnešního data a přítomnosti nevyřízeného návrhu změny.
     *
     * @param r               entita rezervace
     * @param tableLabel      označení stolu
     * @param userName        zobrazované jméno zákazníka
     * @param queryDate       datum pro který je dotaz (může být jiný než dnes)
     * @param today           dnešní datum
     * @param now             aktuální čas
     * @param hasPendingChange příznak přítomnosti nevyřízeného návrhu změny
     * @return sestavený response DTO pro personál
     */
    private StaffReservationResponse toStaffResponse(
            Reservation r, String tableLabel, String userName,
            LocalDate queryDate, LocalDate today, LocalTime now,
            boolean hasPendingChange) {

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

        boolean canEdit = (status == ReservationStatus.CONFIRMED
                || status == ReservationStatus.RESERVED
                || status == ReservationStatus.CHECKED_IN)
                && !hasPendingChange;

        boolean canExtend = false;

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
                .userName(userName)
                .canEdit(canEdit)
                .canExtend(canExtend)
                .hasPendingChange(hasPendingChange)
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
