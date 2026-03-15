package com.checkfood.checkfoodservice.module.initializer;

import com.checkfood.checkfoodservice.module.reservation.entity.Reservation;
import com.checkfood.checkfoodservice.module.reservation.entity.ReservationStatus;
import com.checkfood.checkfoodservice.module.reservation.repository.ReservationRepository;
import com.checkfood.checkfoodservice.module.restaurant.entity.restaurant.Restaurant;
import com.checkfood.checkfoodservice.module.restaurant.entity.restaurant.table.RestaurantTable;
import com.checkfood.checkfoodservice.module.restaurant.repository.RestaurantRepository;
import com.checkfood.checkfoodservice.module.restaurant.repository.table.RestaurantTableRepository;
import com.checkfood.checkfoodservice.security.module.user.entity.UserEntity;
import com.checkfood.checkfoodservice.security.module.user.repository.UserRepository;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.boot.context.event.ApplicationReadyEvent;
import org.springframework.context.annotation.Profile;
import org.springframework.context.event.EventListener;
import org.springframework.core.annotation.Order;
import org.springframework.stereotype.Component;

import java.time.LocalDate;
import java.time.LocalTime;
import java.util.List;
import java.util.Optional;

/**
 * Seeds realistic 90-minute test reservations across multiple tables and dates.
 * Only runs in "local" profile, after TestDataInitializer (100).
 */
@Slf4j
@Component
@RequiredArgsConstructor
@Profile("local")
public class TestReservationInitializer {

    private static final String TEST_RESTAURANT_NAME = "Testovací Restaurace Plzeň";
    private static final String TEST_USER_EMAIL = "admin@checkfood.cz";

    private final RestaurantRepository restaurantRepository;
    private final RestaurantTableRepository tableRepository;
    private final ReservationRepository reservationRepository;
    private final UserRepository userRepository;

    @EventListener(ApplicationReadyEvent.class)
    @Order(102)
    public void seedTestReservations() {
        // Find test restaurant
        Optional<Restaurant> restaurantOpt = restaurantRepository.findAll().stream()
                .filter(r -> TEST_RESTAURANT_NAME.equals(r.getName()))
                .findFirst();

        if (restaurantOpt.isEmpty()) {
            log.info("[ReservationSeed] Test restaurant not found, skipping.");
            return;
        }

        Restaurant restaurant = restaurantOpt.get();

        // Find test user
        Optional<UserEntity> userOpt = userRepository.findByEmail(TEST_USER_EMAIL);
        if (userOpt.isEmpty()) {
            log.info("[ReservationSeed] Test user {} not found, skipping.", TEST_USER_EMAIL);
            return;
        }

        Long userId = userOpt.get().getId();

        // Load tables sorted by label
        List<RestaurantTable> tables = tableRepository
                .findAllByRestaurantIdAndActiveTrue(restaurant.getId());
        if (tables.size() < 4) {
            log.info("[ReservationSeed] Not enough tables ({}), skipping.", tables.size());
            return;
        }

        // Check if reservations already seeded (idempotent)
        List<Reservation> existing = reservationRepository
                .findAllByUserIdOrderByDateDescStartTimeDesc(userId);
        long activeCount = existing.stream()
                .filter(r -> r.getRestaurantId().equals(restaurant.getId()))
                .filter(r -> r.getStatus() != ReservationStatus.CANCELLED)
                .count();
        if (activeCount >= 3) {
            log.info("[ReservationSeed] Already {} reservations, skipping.", activeCount);
            return;
        }

        // Tables: Stul 1 (2-cap), Stul 2 (4-cap), Stul 3 (4-cap), Stul 4 (6-cap), ...
        RestaurantTable table1 = tables.getFirst();
        RestaurantTable table2 = tables.get(1);
        RestaurantTable table3 = tables.get(2);
        RestaurantTable table4 = tables.get(3);

        LocalDate today = LocalDate.now();
        LocalDate tomorrow = today.plusDays(1);
        var rid = restaurant.getId();

        // --- TODAY ---
        // Stul 1: 12:00-13:30 CONFIRMED
        save(rid, table1.getId(), userId, today,
                LocalTime.of(12, 0), LocalTime.of(13, 30),
                ReservationStatus.CONFIRMED, 2);

        // Stul 1: 18:00-19:30 PENDING_CONFIRMATION
        save(rid, table1.getId(), userId, today,
                LocalTime.of(18, 0), LocalTime.of(19, 30),
                ReservationStatus.PENDING_CONFIRMATION, 2);

        // Stul 2: 11:00-12:30 RESERVED
        save(rid, table2.getId(), userId, today,
                LocalTime.of(11, 0), LocalTime.of(12, 30),
                ReservationStatus.RESERVED, 3);

        // Stul 3: 14:00-15:30 CONFIRMED
        save(rid, table3.getId(), userId, today,
                LocalTime.of(14, 0), LocalTime.of(15, 30),
                ReservationStatus.CONFIRMED, 4);

        // --- TOMORROW ---
        // Stul 2: 12:00-13:30 CONFIRMED
        save(rid, table2.getId(), userId, tomorrow,
                LocalTime.of(12, 0), LocalTime.of(13, 30),
                ReservationStatus.CONFIRMED, 2);

        // Stul 4: 19:00-20:30 PENDING_CONFIRMATION
        save(rid, table4.getId(), userId, tomorrow,
                LocalTime.of(19, 0), LocalTime.of(20, 30),
                ReservationStatus.PENDING_CONFIRMATION, 5);

        // Stul 1: 10:00-11:30 RESERVED
        save(rid, table1.getId(), userId, tomorrow,
                LocalTime.of(10, 0), LocalTime.of(11, 30),
                ReservationStatus.RESERVED, 2);

        // --- EXTRA: near-current-time for check-in testing ---
        // Stul 4: now-rounded CONFIRMED (staff can check-in immediately)
        LocalTime nowRounded = LocalTime.now().withSecond(0).withNano(0);
        LocalTime nearStart = nowRounded.getMinute() < 30
                ? nowRounded.withMinute(0) : nowRounded.withMinute(30);
        save(rid, table4.getId(), userId, today,
                nearStart, nearStart.plusMinutes(90),
                ReservationStatus.CONFIRMED, 4);

        // Stul 3: 20:00-21:30 CHECKED_IN (already checked-in, for complete testing)
        save(rid, table3.getId(), userId, today,
                LocalTime.of(20, 0), LocalTime.of(21, 30),
                ReservationStatus.CHECKED_IN, 3);

        log.info("[ReservationSeed] Created 9 test reservations for restaurant '{}' (today + tomorrow).",
                restaurant.getName());
    }

    private void save(java.util.UUID restaurantId, java.util.UUID tableId,
                      Long userId, LocalDate date,
                      LocalTime start, LocalTime end,
                      ReservationStatus status, int partySize) {
        reservationRepository.save(Reservation.builder()
                .restaurantId(restaurantId)
                .tableId(tableId)
                .userId(userId)
                .date(date)
                .startTime(start)
                .endTime(end)
                .status(status)
                .partySize(partySize)
                .build());
    }
}
