package com.checkfood.checkfoodservice.module.restaurant.repository;

import com.checkfood.checkfoodservice.module.restaurant.entity.employee.RestaurantEmployee;
import com.checkfood.checkfoodservice.module.restaurant.entity.employee.RestaurantEmployeeRole;
import com.checkfood.checkfoodservice.module.restaurant.entity.restaurant.CuisineType;
import com.checkfood.checkfoodservice.module.restaurant.entity.restaurant.Restaurant;
import com.checkfood.checkfoodservice.module.restaurant.entity.restaurant.RestaurantStatus;
import com.checkfood.checkfoodservice.security.module.auth.provider.AuthProvider;
import com.checkfood.checkfoodservice.security.module.user.entity.UserEntity;
import com.checkfood.checkfoodservice.support.BaseDataJpaTest;
import jakarta.persistence.EntityManager;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;

import java.util.List;
import java.util.UUID;

import static org.assertj.core.api.Assertions.assertThat;

/**
 * Slice test for {@link RestaurantEmployeeRepository}.
 *
 * <p>This repository is the new source of truth for restaurant ownership
 * after the Apr-2026 A3 refactor that removed {@code Restaurant.ownerId}.
 * A regression in any of its queries would directly break:
 *
 * <ul>
 *   <li>{@code GET /api/v1/restaurants/me} (lists all restaurants the
 *       caller owns)</li>
 *   <li>Every {@code @PreAuthorize('hasRole(RESTAURANT_OWNER)')}
 *       authorization check on mutations (add table, update hours, …)</li>
 * </ul>
 *
 * <p>The tests here do NOT try to exercise every finder — they target
 * the ones that participate in auth decisions and the multi-restaurant
 * case (a single OWNER with two trial restaurants, which was the
 * motivating use case for keeping the join table rather than a single
 * {@code ownerId} column).
 */
class RestaurantEmployeeRepositoryDataJpaTest extends BaseDataJpaTest {

    @Autowired private RestaurantEmployeeRepository employeeRepository;
    @Autowired private EntityManager em;

    private Long ownerUserId;
    private UUID restaurantAId;
    private UUID restaurantBId;

    @BeforeEach
    void seed() {
        UserEntity owner = UserEntity.builder()
                .email("owner@checkfood.test")
                .firstName("Olivia")
                .lastName("Owner")
                .authProvider(AuthProvider.LOCAL)
                .providerId("owner@checkfood.test")
                .password("hash")
                .enabled(true)
                .build();
        em.persist(owner);

        UserEntity staff = UserEntity.builder()
                .email("staff@checkfood.test")
                .firstName("Sam")
                .lastName("Staff")
                .authProvider(AuthProvider.LOCAL)
                .providerId("staff@checkfood.test")
                .password("hash")
                .enabled(true)
                .build();
        em.persist(staff);

        Restaurant a = Restaurant.builder()
                .name("Bistro A")
                .description("First trial resto")
                .cuisineType(CuisineType.ITALIAN)
                .status(RestaurantStatus.APPROVED)
                .active(true)
                .build();
        em.persist(a);

        Restaurant b = Restaurant.builder()
                .name("Bistro B")
                .description("Second trial resto — same owner")
                .cuisineType(CuisineType.ASIAN)
                .status(RestaurantStatus.APPROVED)
                .active(true)
                .build();
        em.persist(b);

        em.persist(RestaurantEmployee.builder()
                .user(owner)
                .restaurant(a)
                .role(RestaurantEmployeeRole.OWNER)
                .build());
        em.persist(RestaurantEmployee.builder()
                .user(owner)
                .restaurant(b)
                .role(RestaurantEmployeeRole.OWNER)
                .build());
        em.persist(RestaurantEmployee.builder()
                .user(staff)
                .restaurant(a)
                .role(RestaurantEmployeeRole.STAFF)
                .build());

        em.flush();
        em.clear();

        ownerUserId = owner.getId();
        restaurantAId = a.getId();
        restaurantBId = b.getId();
    }

    @Test
    @DisplayName("findAllByUserIdAndRole returns both OWNER memberships (multi-restaurant owner)")
    void ownerCanHoldMultipleRestaurants() {
        List<RestaurantEmployee> owned = employeeRepository.findAllByUserIdAndRole(
                ownerUserId, RestaurantEmployeeRole.OWNER);

        assertThat(owned).hasSize(2);
        assertThat(owned).extracting(re -> re.getRestaurant().getId())
                .containsExactlyInAnyOrder(restaurantAId, restaurantBId);
    }

    @Test
    @DisplayName("findByUserIdAndRestaurantId eager-loads user and restaurant (no lazy init)")
    void authLookupFetchesFullObjectGraph() {
        RestaurantEmployee membership = employeeRepository
                .findByUserIdAndRestaurantId(ownerUserId, restaurantAId)
                .orElseThrow();

        em.clear(); // force any residual lazy proxies to fail

        // These getters would throw LazyInitializationException if the
        // @EntityGraph was not applied — which is the entire reason the
        // query exists instead of a plain findById on an ID tuple.
        assertThat(membership.getUser().getEmail()).isEqualTo("owner@checkfood.test");
        assertThat(membership.getRestaurant().getName()).isEqualTo("Bistro A");
        assertThat(membership.getRole()).isEqualTo(RestaurantEmployeeRole.OWNER);
    }

    @Test
    @DisplayName("existsByUserIdAndRestaurantId is the fast path for @PreAuthorize checks")
    void existsIsCheapAndCorrect() {
        assertThat(employeeRepository.existsByUserIdAndRestaurantId(ownerUserId, restaurantAId))
                .isTrue();
        assertThat(employeeRepository.existsByUserIdAndRestaurantId(ownerUserId, UUID.randomUUID()))
                .isFalse();
    }

    @Test
    @DisplayName("findFirstByUserIdAndRole tells TRIAL-tier OWNER where to resume onboarding")
    void findFirstOwnershipForResume() {
        RestaurantEmployee first = employeeRepository
                .findFirstByUserIdAndRole(ownerUserId, RestaurantEmployeeRole.OWNER)
                .orElseThrow();

        assertThat(first.getRole()).isEqualTo(RestaurantEmployeeRole.OWNER);
    }

    @Test
    @DisplayName("findAllByRestaurantId returns owner + staff together")
    void restaurantSidePullsEveryone() {
        List<RestaurantEmployee> employees = employeeRepository.findAllByRestaurantId(restaurantAId);

        assertThat(employees).hasSize(2);
        assertThat(employees).extracting(RestaurantEmployee::getRole)
                .containsExactlyInAnyOrder(
                        RestaurantEmployeeRole.OWNER,
                        RestaurantEmployeeRole.STAFF
                );
    }
}
