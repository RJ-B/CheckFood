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

@Slf4j
@Component
@RequiredArgsConstructor
@Profile("local")
public class TestStaffInitializer {

    private static final String TEST_STAFF_EMAIL = "staff@test.cz";
    private static final String TEST_STAFF_PASSWORD = "Test123!";
    private static final String TEST_STAFF_FIRST_NAME = "Test";
    private static final String TEST_STAFF_LAST_NAME = "Staff";
    private static final String TEST_RESTAURANT_NAME = "Testovací Restaurace Plzeň";

    private final UserRepository userRepository;
    private final RoleRepository roleRepository;
    private final RestaurantRepository restaurantRepository;
    private final RestaurantEmployeeRepository employeeRepository;
    private final PasswordEncoder passwordEncoder;

    @EventListener(ApplicationReadyEvent.class)
    @Order(104)
    public void seedTestStaff() {
        if (userRepository.findByEmail(TEST_STAFF_EMAIL).isPresent()) {
            log.info("[TestStaff] User {} already exists, skipping.", TEST_STAFF_EMAIL);
            return;
        }

        Optional<RoleEntity> staffRoleOpt = roleRepository.findByName("STAFF");
        if (staffRoleOpt.isEmpty()) {
            log.warn("[TestStaff] STAFF role not found, skipping.");
            return;
        }

        UserEntity staff = UserEntity.builder()
                .email(TEST_STAFF_EMAIL)
                .password(passwordEncoder.encode(TEST_STAFF_PASSWORD))
                .firstName(TEST_STAFF_FIRST_NAME)
                .lastName(TEST_STAFF_LAST_NAME)
                .authProvider(AuthProvider.LOCAL)
                .providerId(TEST_STAFF_EMAIL)
                .enabled(true)
                .roles(new HashSet<>(Set.of(staffRoleOpt.get())))
                .build();

        staff = userRepository.save(staff);
        log.info("[TestStaff] Created test staff: email={}, id={}", TEST_STAFF_EMAIL, staff.getId());

        Optional<Restaurant> restaurantOpt = restaurantRepository.findAll().stream()
                .filter(r -> TEST_RESTAURANT_NAME.equals(r.getName()))
                .findFirst();
        if (restaurantOpt.isEmpty()) {
            log.info("[TestStaff] Test restaurant '{}' not found, no membership created.", TEST_RESTAURANT_NAME);
            return;
        }

        Restaurant restaurant = restaurantOpt.get();

        RestaurantEmployee membership = RestaurantEmployee.builder()
                .user(staff)
                .restaurant(restaurant)
                .role(RestaurantEmployeeRole.STAFF)
                .build();

        employeeRepository.save(membership);
        log.info("[TestStaff] Created STAFF membership: user={} -> restaurant='{}'",
                TEST_STAFF_EMAIL, restaurant.getName());
    }
}
