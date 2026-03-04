package com.checkfood.checkfoodservice.module.dining.service;

import com.checkfood.checkfoodservice.module.dining.config.DiningContextProperties;
import com.checkfood.checkfoodservice.module.dining.dto.response.DiningContextResponse;
import com.checkfood.checkfoodservice.module.dining.exception.DiningContextException;
import com.checkfood.checkfoodservice.module.dining.logging.DiningContextLogger;
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

@Service
@RequiredArgsConstructor
@Transactional(readOnly = true)
public class DiningContextServiceImpl implements DiningContextService {

    private final ReservationRepository reservationRepository;
    private final RestaurantRepository restaurantRepository;
    private final RestaurantTableRepository restaurantTableRepository;
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

        Reservation reservation = candidates.get(0);

        String restaurantName = restaurantRepository.findById(reservation.getRestaurantId())
                .map(Restaurant::getName)
                .orElse("Neznámá restaurace");

        String tableLabel = restaurantTableRepository.findById(reservation.getTableId())
                .map(RestaurantTable::getLabel)
                .orElse("Neznámý stůl");

        logger.logContextResolved(userId, reservation.getId());

        // Open-ended model: if endTime is null, use restaurant closing time as validTo
        LocalTime validToTime;
        if (reservation.getEndTime() != null) {
            validToTime = reservation.getEndTime();
        } else {
            validToTime = restaurantRepository.findById(reservation.getRestaurantId())
                    .map(Restaurant::getOpeningHours)
                    .flatMap(hours -> hours.stream()
                            .filter(h -> h.getDayOfWeek() == today.getDayOfWeek())
                            .filter(h -> !h.isClosed() && h.getCloseAt() != null)
                            .map(OpeningHours::getCloseAt)
                            .findFirst())
                    .orElse(LocalTime.of(23, 59));
        }

        DiningContextResponse response = DiningContextResponse.builder()
                .restaurantId(reservation.getRestaurantId())
                .tableId(reservation.getTableId())
                .reservationId(reservation.getId())
                .sessionId(null)
                .contextType("RESERVATION")
                .restaurantName(restaurantName)
                .tableLabel(tableLabel)
                .validFrom(LocalDateTime.of(reservation.getDate(), reservation.getStartTime()))
                .validTo(LocalDateTime.of(reservation.getDate(), validToTime))
                .build();

        return Optional.of(response);
    }
}
