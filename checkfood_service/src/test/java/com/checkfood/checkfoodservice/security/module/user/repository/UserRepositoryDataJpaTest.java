package com.checkfood.checkfoodservice.security.module.user.repository;

import com.checkfood.checkfoodservice.security.module.auth.provider.AuthProvider;
import com.checkfood.checkfoodservice.security.module.user.entity.DeviceEntity;
import com.checkfood.checkfoodservice.security.module.user.entity.RoleEntity;
import com.checkfood.checkfoodservice.security.module.user.entity.UserEntity;
import com.checkfood.checkfoodservice.support.BaseDataJpaTest;
import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.PersistenceUnit;
import org.hibernate.SessionFactory;
import org.hibernate.stat.Statistics;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.TestPropertySource;

import java.util.Set;

import static org.assertj.core.api.Assertions.assertThat;

/**
 * {@code @DataJpaTest} slice for {@link UserRepository}.
 *
 * <p>Nails down two things:
 *
 * <ol>
 *   <li>{@code findWithRolesById} MUST fetch both {@code roles} and
 *       {@code devices} in a single round-trip, because
 *       {@code UserMapper.toAdmin()} reads {@code devices.lastLogin}
 *       after the Hibernate session closes. A regression would cause
 *       {@code LazyInitializationException} → HTTP 500 — the exact
 *       Apr-2026 incident this repository was fixed for (see the
 *       Javadoc on {@code findWithRolesById}).</li>
 *   <li>{@code findByEmail} does NOT eagerly load roles — it's used
 *       only for existence checks, and pulling the role join table
 *       on every password-reset or rate-limit lookup would be waste.</li>
 * </ol>
 *
 * <p>We assert both by reading Hibernate's prepared-statement counter
 * via {@link Statistics}. That gives us a measurable, failing-on-
 * regression signal — not just a passing smoke test.
 */
@TestPropertySource(properties = {
        // Turn on Hibernate stats for this slice specifically. The
        // postgres-test profile already has it, but DataJpaTest uses
        // a different bootstrap so we pin it again here to be safe.
        "spring.jpa.properties.hibernate.generate_statistics=true"
})
class UserRepositoryDataJpaTest extends BaseDataJpaTest {

    @Autowired private UserRepository userRepository;
    @Autowired private EntityManager entityManager;
    @PersistenceUnit private EntityManagerFactory emf;

    private Long userId;

    @BeforeEach
    void seed() {
        RoleEntity role = new RoleEntity("USER");
        entityManager.persist(role);

        UserEntity user = UserEntity.builder()
                .email("ada@checkfood.test")
                .firstName("Ada")
                .lastName("Tester")
                .authProvider(AuthProvider.LOCAL)
                .providerId("ada@checkfood.test")
                .password("hash")
                .enabled(true)
                .roles(Set.of(role))
                .build();
        entityManager.persist(user);

        DeviceEntity device = DeviceEntity.builder()
                .user(user)
                .deviceIdentifier("dev-ada-1")
                .deviceName("Pixel 8")
                .deviceType("ANDROID")
                .active(true)
                .build();
        entityManager.persist(device);

        entityManager.flush();
        entityManager.clear();

        userId = user.getId();
    }

    @Test
    @DisplayName("findWithRolesById fetches roles AND devices in one trip — no lazy init")
    void findWithRolesByIdFetchesBothCollections() {
        Statistics stats = emf.unwrap(SessionFactory.class).getStatistics();
        stats.clear();

        UserEntity found = userRepository.findWithRolesById(userId).orElseThrow();

        // Detach so any subsequent getter that triggers a lazy proxy
        // would blow up — which is exactly what we want to verify.
        entityManager.clear();

        // These two getters would throw LazyInitializationException if
        // the EntityGraph didn't actually fetch join them.
        assertThat(found.getRoles()).extracting(RoleEntity::getName)
                .containsExactly("USER");
        assertThat(found.getDevices()).hasSize(1);
        assertThat(found.getDevices().iterator().next().getDeviceIdentifier())
                .isEqualTo("dev-ada-1");

        // One statement for the user+roles+devices join graph, maybe a
        // second if Hibernate splits the two collections — but never
        // three (which would be the classic "select user, then select
        // roles, then select devices" N+1 pattern).
        assertThat(stats.getPrepareStatementCount())
                .as("findWithRolesById should use at most 2 statements (found N+1 regression)")
                .isLessThanOrEqualTo(2);
    }

    @Test
    @DisplayName("findByEmail does NOT eagerly load the role join table")
    void findByEmailDoesNotLoadRoles() {
        Statistics stats = emf.unwrap(SessionFactory.class).getStatistics();
        stats.clear();

        UserEntity found = userRepository.findByEmail("ada@checkfood.test").orElseThrow();

        // A single SELECT with no LEFT JOIN on user_roles — one statement
        // exactly, no more.
        assertThat(stats.getPrepareStatementCount()).isEqualTo(1);
        assertThat(found.getEmail()).isEqualTo("ada@checkfood.test");
    }

    @Test
    @DisplayName("existsByEmail returns true for known email, false otherwise")
    void existsByEmailFlag() {
        assertThat(userRepository.existsByEmail("ada@checkfood.test")).isTrue();
        assertThat(userRepository.existsByEmail("nobody@checkfood.test")).isFalse();
    }
}
