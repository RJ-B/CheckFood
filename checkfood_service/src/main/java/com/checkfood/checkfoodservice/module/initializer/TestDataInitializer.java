package com.checkfood.checkfoodservice.module.initializer;

import com.checkfood.checkfoodservice.module.restaurant.entity.common.Address;
import com.checkfood.checkfoodservice.module.restaurant.entity.restaurant.CuisineType;
import com.checkfood.checkfoodservice.module.restaurant.entity.restaurant.OpeningHours;
import com.checkfood.checkfoodservice.module.restaurant.entity.restaurant.Restaurant;
import com.checkfood.checkfoodservice.module.restaurant.entity.restaurant.RestaurantStatus;
import com.checkfood.checkfoodservice.module.restaurant.entity.restaurant.table.RestaurantTable;
import com.checkfood.checkfoodservice.module.restaurant.repository.RestaurantRepository;
import com.checkfood.checkfoodservice.module.restaurant.repository.table.RestaurantTableRepository;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.locationtech.jts.geom.Coordinate;
import org.locationtech.jts.geom.GeometryFactory;
import org.locationtech.jts.geom.PrecisionModel;
import org.springframework.boot.context.event.ApplicationReadyEvent;
import org.springframework.context.annotation.Profile;
import org.springframework.context.event.EventListener;
import org.springframework.core.annotation.Order;
import org.springframework.stereotype.Component;

import java.math.BigDecimal;
import java.time.DayOfWeek;
import java.time.LocalTime;
import java.util.*;

/**
 * Vloží testovací restauraci s panoramatem a stoly pro ověření rezervačního systému.
 * Aktivní pouze v profilu "local".
 */
@Slf4j
@Component
@RequiredArgsConstructor
@Profile("local")
public class TestDataInitializer {

    private static final String TEST_RESTAURANT_NAME = "Testovací Restaurace Plzeň";
    private static final UUID SYSTEM_OWNER_ID = UUID.fromString("00000000-0000-0000-0000-000000000000");

    // Plzeň — náměstí Republiky (center of the main square)
    private static final double PLZEN_LAT = 49.7477;
    private static final double PLZEN_LNG = 13.3776;

    private final RestaurantRepository restaurantRepository;
    private final RestaurantTableRepository tableRepository;

    private final GeometryFactory geometryFactory = new GeometryFactory(new PrecisionModel(), 4326);

    @EventListener(ApplicationReadyEvent.class)
    @Order(100) // Run after RestaurantDataInitializer
    public void seedTestRestaurant() {
        // Skip if already exists
        if (restaurantRepository.existsByName(TEST_RESTAURANT_NAME)) {
            log.info("[TestData] Testovací restaurace již existuje, přeskakuji.");
            return;
        }

        log.info("[TestData] Vytvářím testovací restauraci v centru Plzně...");

        // --- Restaurant ---
        Address address = Address.builder()
                .street("náměstí Republiky")
                .streetNumber("1")
                .city("Plzeň")
                .postalCode("30100")
                .country("Česká republika")
                .location(geometryFactory.createPoint(new Coordinate(PLZEN_LNG, PLZEN_LAT)))
                .build();

        List<OpeningHours> hours = new ArrayList<>();
        for (int i = 1; i <= 7; i++) {
            hours.add(OpeningHours.builder()
                    .dayOfWeek(DayOfWeek.of(i))
                    .openAt(LocalTime.of(10, 0))
                    .closeAt(LocalTime.of(22, 0))
                    .closed(false)
                    .build());
        }

        Restaurant restaurant = Restaurant.builder()
                .ownerId(SYSTEM_OWNER_ID)
                .name(TEST_RESTAURANT_NAME)
                .description("Testovací restaurace pro ověření 360° rezervačního systému. " +
                        "Umístěna na náměstí Republiky v Plzni.")
                .cuisineType(CuisineType.CZECH)
                .panoramaUrl("/panoramas/restaurant_360.jpg")
                .status(RestaurantStatus.ACTIVE)
                .active(true)
                .rating(new BigDecimal("4.5"))
                .address(address)
                .openingHours(hours)
                .tags(new HashSet<>(List.of("czech", "test", "panorama")))
                .build();

        restaurant = restaurantRepository.save(restaurant);
        UUID restaurantId = restaurant.getId();

        log.info("[TestData] Restaurace vytvořena: id={}", restaurantId);

        // --- Tables with yaw/pitch positions in the panorama ---
        // Positions distributed around the 360° panorama at roughly eye level
        List<RestaurantTable> tables = List.of(
                RestaurantTable.builder()
                        .restaurantId(restaurantId)
                        .label("Stůl 1")
                        .capacity(2)
                        .active(true)
                        .yaw(30.0)
                        .pitch(-5.0)
                        .build(),
                RestaurantTable.builder()
                        .restaurantId(restaurantId)
                        .label("Stůl 2")
                        .capacity(4)
                        .active(true)
                        .yaw(85.0)
                        .pitch(-8.0)
                        .build(),
                RestaurantTable.builder()
                        .restaurantId(restaurantId)
                        .label("Stůl 3")
                        .capacity(4)
                        .active(true)
                        .yaw(150.0)
                        .pitch(-3.0)
                        .build(),
                RestaurantTable.builder()
                        .restaurantId(restaurantId)
                        .label("Stůl 4")
                        .capacity(6)
                        .active(true)
                        .yaw(210.0)
                        .pitch(-6.0)
                        .build(),
                RestaurantTable.builder()
                        .restaurantId(restaurantId)
                        .label("Stůl 5")
                        .capacity(2)
                        .active(true)
                        .yaw(270.0)
                        .pitch(-4.0)
                        .build(),
                RestaurantTable.builder()
                        .restaurantId(restaurantId)
                        .label("Stůl 6")
                        .capacity(8)
                        .active(true)
                        .yaw(330.0)
                        .pitch(-7.0)
                        .build()
        );

        tableRepository.saveAll(tables);

        log.info("[TestData] Vytvořeno {} stolů s yaw/pitch pro panorama.", tables.size());
        log.info("[TestData] Testovací data připravena. Restaurace: '{}' ({})", TEST_RESTAURANT_NAME, restaurantId);
    }
}
