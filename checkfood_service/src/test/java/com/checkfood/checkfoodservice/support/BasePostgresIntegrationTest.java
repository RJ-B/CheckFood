package com.checkfood.checkfoodservice.support;

import com.checkfood.checkfoodservice.security.module.auth.email.EmailService;
import com.checkfood.checkfoodservice.security.module.oauth.provider.OAuthClientFactory;
import org.springframework.boot.test.autoconfigure.web.servlet.AutoConfigureMockMvc;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.ActiveProfiles;
import org.springframework.test.context.DynamicPropertyRegistry;
import org.springframework.test.context.DynamicPropertySource;
import org.springframework.test.context.bean.override.mockito.MockitoBean;
import org.testcontainers.containers.PostgreSQLContainer;
import org.testcontainers.junit.jupiter.Container;
import org.testcontainers.junit.jupiter.Testcontainers;

/**
 * Abstract base class for integration tests that require a real PostGIS database.
 *
 * Uses a singleton PostgreSQL+PostGIS container shared across all subclasses in the same JVM.
 * This prevents container restart overhead between test classes.
 *
 * H2 tests (BaseAuthIntegrationTest) remain completely unaffected — they use a separate context.
 */
@SpringBootTest(webEnvironment = SpringBootTest.WebEnvironment.MOCK)
@AutoConfigureMockMvc
@ActiveProfiles("postgres-test")
@Testcontainers
public abstract class BasePostgresIntegrationTest {

    /**
     * Singleton container — static ensures only one instance per JVM.
     * The postgis/postgis image includes the PostGIS extension on top of Postgres 16.
     */
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
        // JPA/Flyway strategy is pinned in application-postgres-test.properties:
        //   ddl-auto=create-drop (Hibernate bootstraps the schema from entities)
        //   flyway.enabled=false (V1..V4 are incremental and assume an
        //                          initial schema that doesn't exist here).
    }

    /**
     * Mock external services to prevent network calls during geospatial tests.
     */
    @MockitoBean
    protected EmailService emailService;

    @MockitoBean
    protected OAuthClientFactory oauthClientFactory;
}
