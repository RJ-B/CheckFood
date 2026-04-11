package com.checkfood.checkfoodservice.support;

import org.springframework.boot.test.autoconfigure.jdbc.AutoConfigureTestDatabase;
import org.springframework.boot.test.autoconfigure.orm.jpa.DataJpaTest;
import org.springframework.test.context.ActiveProfiles;
import org.springframework.test.context.DynamicPropertyRegistry;
import org.springframework.test.context.DynamicPropertySource;
import org.testcontainers.containers.PostgreSQLContainer;
import org.testcontainers.junit.jupiter.Container;
import org.testcontainers.junit.jupiter.Testcontainers;

/**
 * Abstract base for {@link DataJpaTest} slice tests that need a real
 * PostGIS database.
 *
 * <p>The canonical {@link DataJpaTest} replaces the datasource with an
 * in-memory H2. That does not work here because {@code Address.location}
 * is a {@code geometry(Point,4326)} column — H2 cannot build the DDL.
 * We disable the auto-replacement via
 * {@link AutoConfigureTestDatabase.Replace#NONE} and point the datasource
 * at a Testcontainers PostGIS instance.
 *
 * <p>Why slice tests at all when we already have full integration tests?
 * Speed. A {@code DataJpaTest} slice avoids booting the whole Spring MVC
 * / Security stack, cutting test class startup from ~25s to ~5s. That
 * matters for tests that iterate on repository queries (e.g. N+1
 * regression checks) where we want a tight inner loop.
 *
 * <p>The container is static/singleton, shared across all subclasses
 * in the same JVM — same strategy as {@link BasePostgresIntegrationTest}.
 * Both base classes reuse the same container instance because Testcontainers
 * deduplicates by image+config.
 */
@DataJpaTest
@AutoConfigureTestDatabase(replace = AutoConfigureTestDatabase.Replace.NONE)
@ActiveProfiles("postgres-test")
@Testcontainers
public abstract class BaseDataJpaTest {

    @Container
    static final PostgreSQLContainer<?> POSTGRES = new PostgreSQLContainer<>("postgis/postgis:16-3.4")
            .withDatabaseName("checkfood_test")
            .withUsername("test")
            .withPassword("test");

    @DynamicPropertySource
    static void configureProperties(DynamicPropertyRegistry registry) {
        registry.add("spring.datasource.url", POSTGRES::getJdbcUrl);
        registry.add("spring.datasource.username", POSTGRES::getUsername);
        registry.add("spring.datasource.password", POSTGRES::getPassword);
        registry.add("spring.datasource.driver-class-name", () -> "org.postgresql.Driver");
    }
}
