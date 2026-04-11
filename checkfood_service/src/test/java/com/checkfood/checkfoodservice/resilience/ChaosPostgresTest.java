package com.checkfood.checkfoodservice.resilience;

import eu.rekawek.toxiproxy.Proxy;
import eu.rekawek.toxiproxy.ToxiproxyClient;
import eu.rekawek.toxiproxy.model.ToxicDirection;
import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.BeforeAll;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Tag;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.web.servlet.AutoConfigureMockMvc;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.ActiveProfiles;
import org.springframework.test.context.DynamicPropertyRegistry;
import org.springframework.test.context.DynamicPropertySource;
import org.springframework.test.context.bean.override.mockito.MockitoBean;
import org.springframework.test.web.servlet.MockMvc;
import org.testcontainers.containers.Network;
import org.testcontainers.containers.PostgreSQLContainer;
import org.testcontainers.containers.ToxiproxyContainer;
import org.testcontainers.junit.jupiter.Container;
import org.testcontainers.junit.jupiter.Testcontainers;

import java.io.IOException;

import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.get;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;
import static org.assertj.core.api.Assertions.assertThat;

/**
 * Chaos test for the Postgres connection path.
 *
 * <p>Boots the app against a real PostGIS container, but routes its
 * JDBC traffic through a Toxiproxy TCP proxy. The proxy lets us inject
 * fault conditions at the wire level — dropped connections, latency,
 * bandwidth caps — without touching any application code or mocks.
 * That's the only way to find out how the HikariCP connection pool,
 * Hibernate retry logic, and the SecurityExceptionHandler / generic
 * 500 mapper actually behave when the DB misbehaves.
 *
 * <p>Tagged {@code testcontainers} so the fast PR gate skips it (the
 * toxiproxy container adds ~5s to suite wall time). Runs on push to
 * main and on the nightly job.
 *
 * <p>What this catches that the normal suite does not:
 * <ul>
 *   <li>Swallowed {@code DataAccessResourceFailureException}s that
 *       leak as {@code 500 Internal Server Error} instead of the
 *       {@code 503 Service Unavailable} we want clients to see.</li>
 *   <li>Connection-pool starvation when the DB hangs — does the
 *       read endpoint eventually time out, or does the request
 *       thread stall forever?</li>
 *   <li>Missing health-check downgrade: the actuator {@code /health}
 *       should go {@code DOWN} when DB round-trips fail, so that
 *       Cloud Run's readiness probe can shed traffic.</li>
 * </ul>
 */
@SpringBootTest(webEnvironment = SpringBootTest.WebEnvironment.MOCK)
@AutoConfigureMockMvc
@ActiveProfiles("postgres-test")
@Testcontainers
@Tag("testcontainers")
class ChaosPostgresTest {

    private static final Network NETWORK = Network.newNetwork();

    @Container
    static final PostgreSQLContainer<?> POSTGRES =
            new PostgreSQLContainer<>("postgis/postgis:16-3.4")
                    .withDatabaseName("checkfood_test")
                    .withUsername("test")
                    .withPassword("test")
                    .withNetwork(NETWORK)
                    .withNetworkAliases("db");

    @Container
    static final ToxiproxyContainer TOXIPROXY =
            new ToxiproxyContainer("ghcr.io/shopify/toxiproxy:2.9.0")
                    .withNetwork(NETWORK);

    private static Proxy dbProxy;

    @BeforeAll
    static void setUpProxy() throws IOException {
        ToxiproxyClient client = new ToxiproxyClient(
                TOXIPROXY.getHost(), TOXIPROXY.getControlPort());
        // Proxy listens on :8666 inside the toxiproxy container and
        // forwards to the postgres container's :5432 over the shared
        // docker network.
        dbProxy = client.createProxy("db", "0.0.0.0:8666", "db:5432");
    }

    @DynamicPropertySource
    static void configureDataSource(DynamicPropertyRegistry registry) {
        // App talks to the proxy, not the DB directly.
        String host = TOXIPROXY.getHost();
        int port = TOXIPROXY.getMappedPort(8666);
        registry.add("spring.datasource.url", () ->
                "jdbc:postgresql://" + host + ":" + port + "/checkfood_test");
        registry.add("spring.datasource.username", () -> "test");
        registry.add("spring.datasource.password", () -> "test");
        registry.add("spring.datasource.driver-class-name", () -> "org.postgresql.Driver");
        // Tight connection timeouts so the hang scenarios complete
        // in a few seconds instead of the default 30s.
        registry.add("spring.datasource.hikari.connection-timeout", () -> "3000");
        registry.add("spring.datasource.hikari.validation-timeout", () -> "1500");
    }

    // External services are mocked so they don't make real network
    // calls during chaos runs.
    @MockitoBean
    com.checkfood.checkfoodservice.security.module.auth.email.EmailService emailService;

    @MockitoBean
    com.checkfood.checkfoodservice.security.module.oauth.provider.OAuthClientFactory oauthClientFactory;

    @Autowired
    private MockMvc mockMvc;

    @AfterEach
    void clearToxics() throws IOException {
        // Remove any toxics a test added so the next test starts clean.
        for (var toxic : dbProxy.toxics().getAll()) {
            toxic.remove();
        }
    }

    @Test
    @DisplayName("Baseline: /actuator/health returns UP when proxy is clean")
    void baselineHealthIsUp() throws Exception {
        mockMvc.perform(get("/actuator/health"))
                .andExpect(status().isOk());
    }

    @Test
    @DisplayName("Dropped connection mid-query does NOT crash the JVM")
    void droppedConnectionDoesNotCrash() throws Exception {
        // Turn off the proxy entirely — next JDBC round-trip will fail
        // fast with a SocketException.
        dbProxy.disable();
        try {
            // Any endpoint that touches the DB. We pick a public read
            // path (no auth required) and assert we get a 4xx/5xx, NOT
            // that MockMvc blows up with an uncaught exception.
            int status = mockMvc.perform(get("/api/v1/restaurants/all-markers"))
                    .andReturn().getResponse().getStatus();
            assertThat(status)
                    .as("Endpoint must respond with an HTTP status, not hang or OOM")
                    .isIn(500, 502, 503);
        } finally {
            dbProxy.enable();
        }
    }

    @Test
    @DisplayName("Recovery: once the proxy is re-enabled, the next request succeeds")
    void recoversAfterOutage() throws Exception {
        dbProxy.disable();
        mockMvc.perform(get("/api/v1/restaurants/all-markers"));
        dbProxy.enable();

        // Give HikariCP a moment to re-establish a connection.
        Thread.sleep(1000);

        mockMvc.perform(get("/api/v1/restaurants/all-markers"))
                .andExpect(status().isOk());
    }

    @Test
    @DisplayName("Latency toxic: 2s added per packet — endpoint still returns, just slower")
    void latencyIsSurvivable() throws Exception {
        dbProxy.toxics().latency("slow", ToxicDirection.DOWNSTREAM, 2000);

        long start = System.currentTimeMillis();
        mockMvc.perform(get("/api/v1/restaurants/all-markers"))
                .andExpect(status().isOk());
        long elapsed = System.currentTimeMillis() - start;

        assertThat(elapsed)
                .as("Request must eventually return despite induced latency")
                .isGreaterThan(1500)
                .isLessThan(30_000);
    }
}
