package com.checkfood.checkfoodservice.module.reservation.service;

import com.checkfood.checkfoodservice.module.reservation.dto.request.CreateRecurringReservationRequest;
import com.checkfood.checkfoodservice.module.reservation.dto.response.RecurringReservationResponse;
import com.checkfood.checkfoodservice.module.reservation.entity.RecurringReservation;
import com.checkfood.checkfoodservice.module.reservation.entity.RecurringReservationStatus;
import com.checkfood.checkfoodservice.module.reservation.entity.Reservation;
import com.checkfood.checkfoodservice.module.reservation.entity.ReservationStatus;
import com.checkfood.checkfoodservice.module.reservation.exception.ReservationException;
import com.checkfood.checkfoodservice.module.reservation.repository.RecurringReservationRepository;
import com.checkfood.checkfoodservice.module.reservation.repository.ReservationRepository;
import com.checkfood.checkfoodservice.module.restaurant.entity.restaurant.Restaurant;
import com.checkfood.checkfoodservice.module.restaurant.entity.restaurant.table.RestaurantTable;
import com.checkfood.checkfoodservice.module.restaurant.exception.RestaurantException;
import com.checkfood.checkfoodservice.module.restaurant.repository.RestaurantRepository;
import com.checkfood.checkfoodservice.module.restaurant.repository.table.RestaurantTableRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.Clock;
import java.time.LocalDate;
import java.time.LocalTime;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

/**
 * Implementace {@link RecurringReservationService} pro zákaznické operace s opakovanými rezervacemi.
 * Poskytuje rovněž veřejné pomocné metody využívané třídou {@link StaffReservationServiceImpl}
 * pro generování a rušení instancí.
 *
 * @author Rostislav Jirák
 * @version 1.0.0
 */
@Service
@RequiredArgsConstructor
public class RecurringReservationServiceImpl implements RecurringReservationService {

    private static final int MAX_INSTANCES = 52;

    private static final List<ReservationStatus> CANCELLED_STATUSES = List.of(
            ReservationStatus.CANCELLED,
            ReservationStatus.REJECTED,
            ReservationStatus.COMPLETED
    );

    private final RecurringReservationRepository recurringRepository;
    private final ReservationRepository reservationRepository;
    private final RestaurantRepository restaurantRepository;
    private final RestaurantTableRepository tableRepository;
    private final Clock clock;

    @Override
    @Transactional
    public RecurringReservationResponse createRecurringReservation(CreateRecurringReservationRequest request, Long userId) {
        var restaurant = restaurantRepository.findById(request.getRestaurantId())
                .orElseThrow(() -> RestaurantException.notFound(request.getRestaurantId()));

        var table = tableRepository.findByIdAndRestaurantId(request.getTableId(), request.getRestaurantId())
                .orElseThrow(ReservationException::tableNotInRestaurant);

        if (request.getPartySize() > table.getCapacity()) {
            throw ReservationException.partySizeExceedsCapacity(request.getPartySize(), table.getCapacity());
        }

        var recurring = RecurringReservation.builder()
                .restaurantId(request.getRestaurantId())
                .tableId(request.getTableId())
                .userId(userId)
                .dayOfWeek(request.getDayOfWeek())
                .startTime(request.getStartTime())
                .partySize(request.getPartySize())
                .build();

        var saved = recurringRepository.save(recurring);

        return toResponse(saved, restaurant.getName(), table.getLabel(), 0);
    }

    @Override
    @Transactional(readOnly = true)
    public List<RecurringReservationResponse> getMyRecurringReservations(Long userId) {
        var list = recurringRepository.findAllByUserIdOrderByCreatedAtDesc(userId);

        return list.stream().map(r -> {
            String restaurantName = restaurantRepository.findById(r.getRestaurantId())
                    .map(Restaurant::getName).orElse(null);
            String tableLabel = tableRepository.findById(r.getTableId())
                    .map(RestaurantTable::getLabel).orElse(null);
            int instanceCount = countInstances(r.getId());
            return toResponse(r, restaurantName, tableLabel, instanceCount);
        }).toList();
    }

    @Override
    @Transactional
    public RecurringReservationResponse cancelRecurringReservation(UUID id, Long userId) {
        var recurring = recurringRepository.findById(id)
                .orElseThrow(() -> ReservationException.recurringNotFound(id));

        if (!recurring.getUserId().equals(userId)) {
            throw ReservationException.accessDenied();
        }

        if (recurring.getStatus() == RecurringReservationStatus.CANCELLED) {
            throw ReservationException.alreadyCancelled();
        }

        recurring.setStatus(RecurringReservationStatus.CANCELLED);
        recurringRepository.save(recurring);

        cancelFutureInstances(id);

        String restaurantName = restaurantRepository.findById(recurring.getRestaurantId())
                .map(Restaurant::getName).orElse(null);
        String tableLabel = tableRepository.findById(recurring.getTableId())
                .map(RestaurantTable::getLabel).orElse(null);
        int instanceCount = countInstances(id);

        return toResponse(recurring, restaurantName, tableLabel, instanceCount);
    }

    /**
     * Generuje jednotlivé {@link Reservation} instance pro opakovanou rezervaci.
     * Obsazené sloty jsou přeskočeny; zbývající termíny serie jsou zachovány.
     * Maximální počet instancí je omezen konstantou {@value #MAX_INSTANCES}.
     *
     * @param recurring entita opakované rezervace (musí být ve stavu ACTIVE s nastavením repeatUntil)
     * @param restaurant entita restaurace (pro výchozí délku rezervace)
     * @return počet skutečně vytvořených instancí
     */
    public int generateInstances(RecurringReservation recurring, Restaurant restaurant) {
        LocalDate today = LocalDate.now(clock);
        int durationMinutes = restaurant.getDefaultReservationDurationMinutes();
        LocalDate repeatUntil = recurring.getRepeatUntil();

        LocalDate current = today;
        while (current.getDayOfWeek() != recurring.getDayOfWeek()) {
            current = current.plusDays(1);
        }

        List<Reservation> toSave = new ArrayList<>();
        int count = 0;

        while (!current.isAfter(repeatUntil) && count < MAX_INSTANCES) {
            LocalTime endTime = recurring.getStartTime().plusMinutes(durationMinutes);

            boolean occupied = reservationRepository.existsOverlappingReservation(
                    recurring.getTableId(),
                    current,
                    recurring.getStartTime(),
                    endTime
            );

            if (!occupied) {
                toSave.add(Reservation.builder()
                        .restaurantId(recurring.getRestaurantId())
                        .tableId(recurring.getTableId())
                        .userId(recurring.getUserId())
                        .date(current)
                        .startTime(recurring.getStartTime())
                        .endTime(endTime)
                        .status(ReservationStatus.CONFIRMED)
                        .partySize(recurring.getPartySize())
                        .recurringReservationId(recurring.getId())
                        .build());
                count++;
            }

            current = current.plusWeeks(1);
        }

        if (!toSave.isEmpty()) {
            reservationRepository.saveAll(toSave);
        }

        return count;
    }

    /**
     * Zruší všechny budoucí instance opakované rezervace (datum &gt;= dnes).
     *
     * @param recurringId UUID opakované rezervace
     */
    public void cancelFutureInstances(UUID recurringId) {
        LocalDate today = LocalDate.now(clock);
        var futureInstances = reservationRepository
                .findAllByRecurringReservationIdAndDateGreaterThanEqualAndStatusNotIn(
                        recurringId, today, CANCELLED_STATUSES);

        futureInstances.forEach(r -> r.setStatus(ReservationStatus.CANCELLED));
        if (!futureInstances.isEmpty()) {
            reservationRepository.saveAll(futureInstances);
        }
    }

    /**
     * Vrátí počet existujících (nezrušených) instancí opakované rezervace.
     *
     * @param recurringId UUID opakované rezervace
     * @return počet instancí
     */
    private int countInstances(UUID recurringId) {
        return reservationRepository
                .findAllByRecurringReservationIdAndDateGreaterThanEqualAndStatusNotIn(
                        recurringId, LocalDate.of(2000, 1, 1), CANCELLED_STATUSES)
                .size();
    }

    /**
     * Sestaví {@link RecurringReservationResponse} z entity opakované rezervace a doplňkových dat.
     *
     * @param r             entita opakované rezervace
     * @param restaurantName název restaurace (může být {@code null})
     * @param tableLabel    označení stolu (může být {@code null})
     * @param instanceCount počet vygenerovaných instancí
     * @return sestavený response DTO
     */
    public RecurringReservationResponse toResponse(RecurringReservation r, String restaurantName, String tableLabel, int instanceCount) {
        return RecurringReservationResponse.builder()
                .id(r.getId())
                .restaurantId(r.getRestaurantId())
                .tableId(r.getTableId())
                .restaurantName(restaurantName)
                .tableLabel(tableLabel)
                .dayOfWeek(r.getDayOfWeek())
                .startTime(r.getStartTime())
                .partySize(r.getPartySize())
                .status(r.getStatus())
                .repeatUntil(r.getRepeatUntil())
                .createdAt(r.getCreatedAt())
                .instanceCount(instanceCount)
                .build();
    }
}
