package com.checkfood.checkfoodservice.module.order.dining.service;

import com.checkfood.checkfoodservice.module.order.dining.config.DiningContextProperties;
import com.checkfood.checkfoodservice.module.order.dining.dto.response.DiningContextResponse;
import com.checkfood.checkfoodservice.module.order.dining.entity.DiningSessionStatus;
import com.checkfood.checkfoodservice.module.order.dining.exception.DiningContextException;
import com.checkfood.checkfoodservice.module.order.dining.logging.DiningContextLogger;
import com.checkfood.checkfoodservice.module.order.dining.repository.DiningSessionRepository;
import com.checkfood.checkfoodservice.module.reservation.entity.Reservation;
import com.checkfood.checkfoodservice.module.reservation.repository.ReservationRepository;
import com.checkfood.checkfoodservice.module.restaurant.entity.restaurant.OpeningHours;
import com.checkfood.checkfoodservice.module.restaurant.entity.restaurant.Restaurant;
import com.checkfood.checkfoodservice.module.restaurant.entity.restaurant.table.RestaurantTable;
import com.checkfood.checkfoodservice.module.restaurant.repository.RestaurantRepository;
import com.checkfood.checkfoodservice.module.restaurant.repository.table.RestaurantTableRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.Clock;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.LocalTime;
import java.util.List;
import java.util.Optional;

/**
 * Implementace {@link DiningContextService} určující aktivní kontext stravování uživatele
 * na základě rezervací v časovém okně grace periody a případného aktivního skupinového sezení.
 *
 * @author Rostislav Jirák
 * @version 1.0.0
 */
@Service
@RequiredArgsConstructor
@Transactional(readOnly = true)
public class DiningContextServiceImpl implements DiningContextService {

    private final ReservationRepository reservationRepository;
    private final RestaurantRepository restaurantRepository;
    private final RestaurantTableRepository restaurantTableRepository;
    private final DiningSessionRepository diningSessionRepository;
    private final DiningContextProperties properties;
    private final DiningContextLogger logger;
    private final Clock clock;

    @Override
    public DiningContextResponse getActiveDiningContext(Long userId) {
        return findActiveDiningContext(userId)
                .orElseThrow(() -> {
                    logger.logNoContextFound(userId);
                    return DiningContextException.noActiveContext();
                });
    }

    @Override
    public Optional<DiningContextResponse> findActiveDiningContext(Long userId) {
        LocalDate today = LocalDate.now(clock);
        LocalTime now = LocalTime.now(clock);

        LocalTime windowStart = now.minusMinutes(properties.getGraceAfterMinutes());
        LocalTime windowEnd = now.plusMinutes(properties.getGraceBeforeMinutes());

        List<Reservation> candidates = reservationRepository.findActiveDiningReservations(
                userId, today, windowStart, windowEnd
        );

        if (candidates.isEmpty()) {
            return Optional.empty();
        }

        Reservation reservation = candidates.getFirst();

        Restaurant restaurant = restaurantRepository.findById(reservation.getRestaurantId())
                .orElse(null);

        String restaurantName = restaurant != null ? restaurant.getName() : "Neznámá restaurace";

        String tableLabel = restaurantTableRepository.findById(reservation.getTableId())
                .map(RestaurantTable::getLabel)
                .orElse("Neznámý stůl");

        logger.logContextResolved(userId, reservation.getId());

        // Pokud endTime není zadán, použijeme zavírací čas restaurace jako validTo (open-ended model)
        LocalTime validToTime;
        if (reservation.getEndTime() != null) {
            validToTime = reservation.getEndTime();
        } else {
            validToTime = Optional.ofNullable(restaurant)
                    .map(Restaurant::getOpeningHours)
                    .flatMap(hours -> hours.stream()
                            .filter(h -> h.getDayOfWeek() == today.getDayOfWeek())
                            .filter(h -> !h.isClosed() && h.getCloseAt() != null)
                            .map(OpeningHours::getCloseAt)
                            .findFirst())
                    .orElse(LocalTime.of(23, 59));
        }

        var sessionId = diningSessionRepository.findByReservationIdAndStatus(
                reservation.getId(), DiningSessionStatus.ACTIVE)
                .map(s -> s.getId())
                .or(() -> diningSessionRepository.findActiveByUserId(userId).map(s -> s.getId()))
                .orElse(null);

        DiningContextResponse response = DiningContextResponse.builder()
                .restaurantId(reservation.getRestaurantId())
                .tableId(reservation.getTableId())
                .reservationId(reservation.getId())
                .sessionId(sessionId)
                .contextType(sessionId != null ? "SESSION" : "RESERVATION")
                .restaurantName(restaurantName)
                .tableLabel(tableLabel)
                .validFrom(LocalDateTime.of(reservation.getDate(), reservation.getStartTime()))
                .validTo(LocalDateTime.of(reservation.getDate(), validToTime))
                .build();

        return Optional.of(response);
    }
}
