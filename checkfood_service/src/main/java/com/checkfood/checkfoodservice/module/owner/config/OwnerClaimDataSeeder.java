package com.checkfood.checkfoodservice.module.owner.config;

import com.checkfood.checkfoodservice.module.restaurant.entity.common.Address;
import com.checkfood.checkfoodservice.module.restaurant.entity.restaurant.CuisineType;
import com.checkfood.checkfoodservice.module.restaurant.entity.restaurant.Restaurant;
import com.checkfood.checkfoodservice.module.restaurant.entity.restaurant.RestaurantStatus;
import com.checkfood.checkfoodservice.module.restaurant.repository.RestaurantRepository;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.boot.CommandLineRunner;
import org.springframework.core.annotation.Order;
import org.springframework.stereotype.Component;

import java.util.UUID;

/**
 * Datový seeder pro inicializaci testovací restaurace používané v owner claim flow.
 * Spouští se při startu aplikace s pořadím 3.
 *
 * @author Rostislav Jirák
 * @version 1.0.0
 */
@Slf4j
@Component
@Order(3)
@RequiredArgsConstructor
public class OwnerClaimDataSeeder implements CommandLineRunner {

    private final RestaurantRepository restaurantRepository;

    /**
     * Vytvoří testovací restauraci s IČO 12345678, pokud ještě neexistuje.
     *
     * @param args argumenty příkazové řádky (nevyužívány)
     */
    @Override
    public void run(String... args) {
        if (restaurantRepository.findByIco("12345678").isPresent()) {
            log.info("Test restaurant (ICO 12345678) already exists, skipping seed.");
            return;
        }

        var address = Address.builder()
                .street("Vodickova")
                .streetNumber("30")
                .city("Praha")
                .postalCode("11000")
                .country("CZ")
                .build();
        address.setCoordinates(50.0833, 14.4253);

        var restaurant = Restaurant.builder()
                .ico("12345678")
                .ownerId(UUID.randomUUID())
                .name("Test Restaurant s.r.o.")
                .description("Testovaci restaurace pro owner claim flow")
                .cuisineType(CuisineType.CZECH)
                .contactEmail("test@restaurant.cz")
                .phone("+420123456789")
                .status(RestaurantStatus.PENDING)
                .active(false)
                .onboardingCompleted(false)
                .address(address)
                .build();

        restaurantRepository.save(restaurant);
        log.info("Seeded test restaurant: ICO=12345678, name='Test Restaurant s.r.o.'");
    }
}
