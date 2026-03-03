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
    public void seedTestReservation() {
        // Find test restaurant
        Optional<Restaurant> restaurantOpt = restaurantRepository.findAll().stream()
                .filter(r -> TEST_RESTAURANT_NAME.equals(r.getName()))
                .findFirst();

        if (restaurantOpt.isEmpty()) {
            log.info("[ReservationSeed] Testovací restaurace neexistuje, přeskakuji.");
            return;
        }

        Restaurant restaurant = restaurantOpt.get();

        // Find test user
        Optional<UserEntity> userOpt = userRepository.findByEmail(TEST_USER_EMAIL);
        if (userOpt.isEmpty()) {
            log.info("[ReservationSeed] Testovací uživatel {} neexistuje, přeskakuji.", TEST_USER_EMAIL);
            return;
        }

        Long userId = userOpt.get().getId();

        // Find first table
        List<RestaurantTable> tables = tableRepository.findAllByRestaurantIdAndActiveTrue(restaurant.getId());
        if (tables.isEmpty()) {
            log.info("[ReservationSeed] Restaurace nemá stoly, přeskakuji.");
            return;
        }

        RestaurantTable table = tables.get(0);
        LocalDate today = LocalDate.now();

        // Check if reservation already exists for today
        List<Reservation> existing = reservationRepository
                .findAllByUserIdOrderByDateDescStartTimeDesc(userId);
        boolean hasToday = existing.stream().anyMatch(r ->
                r.getDate().equals(today)
                        && r.getRestaurantId().equals(restaurant.getId())
                        && r.getStatus() != ReservationStatus.CANCELLED
        );

        if (hasToday) {
            log.info("[ReservationSeed] Rezervace pro dnešek již existuje, přeskakuji.");
            return;
        }

        // Create all-day reservation for dev testing (10:00 - 22:00)
        Reservation reservation = Reservation.builder()
                .restaurantId(restaurant.getId())
                .tableId(table.getId())
                .userId(userId)
                .date(today)
                .startTime(LocalTime.of(10, 0))
                .endTime(LocalTime.of(22, 0))
                .status(ReservationStatus.RESERVED)
                .partySize(2)
                .build();

        reservationRepository.save(reservation);

        log.info("[ReservationSeed] Vytvořena testovací rezervace: user={}, restaurant={}, table={}, date={}",
                TEST_USER_EMAIL, restaurant.getName(), table.getLabel(), today);
    }
}
