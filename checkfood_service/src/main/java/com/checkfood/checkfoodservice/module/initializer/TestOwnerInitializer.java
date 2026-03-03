package com.checkfood.checkfoodservice.module.initializer;

import com.checkfood.checkfoodservice.module.restaurant.entity.employee.RestaurantEmployee;
import com.checkfood.checkfoodservice.module.restaurant.entity.employee.RestaurantEmployeeRole;
import com.checkfood.checkfoodservice.module.restaurant.entity.restaurant.Restaurant;
import com.checkfood.checkfoodservice.module.restaurant.repository.RestaurantEmployeeRepository;
import com.checkfood.checkfoodservice.module.restaurant.repository.RestaurantRepository;
import com.checkfood.checkfoodservice.security.module.auth.provider.AuthProvider;
import com.checkfood.checkfoodservice.security.module.user.entity.RoleEntity;
import com.checkfood.checkfoodservice.security.module.user.entity.UserEntity;
import com.checkfood.checkfoodservice.security.module.user.repository.RoleRepository;
import com.checkfood.checkfoodservice.security.module.user.repository.UserRepository;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.boot.context.event.ApplicationReadyEvent;
import org.springframework.context.annotation.Profile;
import org.springframework.context.event.EventListener;
import org.springframework.core.annotation.Order;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Component;

import java.util.HashSet;
import java.util.Optional;
import java.util.Set;

/**
 * Seeds a test owner user (owner@test.cz / Test123!) with OWNER role
 * and an ACTIVE membership to the test restaurant (ICO 12345678).
 * Only runs in "local" profile.
 */
@Slf4j
@Component
@RequiredArgsConstructor
@Profile("local")
public class TestOwnerInitializer {

    private static final String TEST_OWNER_EMAIL = "owner@test.cz";
    private static final String TEST_OWNER_PASSWORD = "Test123!";
    private static final String TEST_OWNER_FIRST_NAME = "Test";
    private static final String TEST_OWNER_LAST_NAME = "Owner";
    private static final String TEST_RESTAURANT_ICO = "12345678";

    private final UserRepository userRepository;
    private final RoleRepository roleRepository;
    private final RestaurantRepository restaurantRepository;
    private final RestaurantEmployeeRepository employeeRepository;
    private final PasswordEncoder passwordEncoder;

    @EventListener(ApplicationReadyEvent.class)
    @Order(103) // After TestDataInitializer (100) and TestReservationInitializer (102)
    public void seedTestOwner() {
        // Skip if user already exists
        if (userRepository.findByEmail(TEST_OWNER_EMAIL).isPresent()) {
            log.info("[TestOwner] User {} already exists, skipping.", TEST_OWNER_EMAIL);
            return;
        }

        // Find OWNER role
        Optional<RoleEntity> ownerRoleOpt = roleRepository.findByName("OWNER");
        if (ownerRoleOpt.isEmpty()) {
            log.warn("[TestOwner] OWNER role not found, skipping.");
            return;
        }

        // Create the user
        UserEntity owner = UserEntity.builder()
                .email(TEST_OWNER_EMAIL)
                .password(passwordEncoder.encode(TEST_OWNER_PASSWORD))
                .firstName(TEST_OWNER_FIRST_NAME)
                .lastName(TEST_OWNER_LAST_NAME)
                .authProvider(AuthProvider.LOCAL)
                .providerId(TEST_OWNER_EMAIL)
                .enabled(true)
                .roles(new HashSet<>(Set.of(ownerRoleOpt.get())))
                .build();

        owner = userRepository.save(owner);
        log.info("[TestOwner] Created test owner: email={}, id={}", TEST_OWNER_EMAIL, owner.getId());

        // Link to test restaurant (ICO 12345678) if it exists
        Optional<Restaurant> restaurantOpt = restaurantRepository.findByIco(TEST_RESTAURANT_ICO);
        if (restaurantOpt.isEmpty()) {
            log.info("[TestOwner] Test restaurant (ICO {}) not found, no membership created.", TEST_RESTAURANT_ICO);
            return;
        }

        Restaurant restaurant = restaurantOpt.get();

        // Update restaurant ownerId to this user's UUID
        // (ownerId is UUID-based but user has Long id — use restaurant's existing ownerId pattern)
        // Create employee membership
        RestaurantEmployee membership = RestaurantEmployee.builder()
                .user(owner)
                .restaurant(restaurant)
                .role(RestaurantEmployeeRole.OWNER)
                .build();

        employeeRepository.save(membership);
        log.info("[TestOwner] Created OWNER membership: user={} -> restaurant={} (ICO {})",
                TEST_OWNER_EMAIL, restaurant.getName(), TEST_RESTAURANT_ICO);
    }
}
