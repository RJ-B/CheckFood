package com.checkfood.checkfoodservice.security.audit;

import com.checkfood.checkfoodservice.security.BaseAuthIntegrationTest;
import com.checkfood.checkfoodservice.security.module.auth.dto.request.ForgotPasswordRequest;
import com.checkfood.checkfoodservice.security.module.auth.dto.request.LoginRequest;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.springframework.http.MediaType;
import org.springframework.test.web.servlet.MvcResult;

import static org.assertj.core.api.Assertions.assertThat;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.get;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.post;

/**
 * SQL injection probe suite. JPA + parameterized queries should neutralize
 * every payload. Any 500 response containing a SQL fragment — or any
 * successful authentication with an injection payload — is a CRITICAL bug.
 *
 * Covers: login, forgot-password, restaurant search (q=), nearest filter.
 */
class SqlInjectionTest extends BaseAuthIntegrationTest {

    private static final String[] PAYLOADS = {
            "' OR '1'='1",
            "'; DROP TABLE users; --",
            "' UNION SELECT NULL --",
            "admin'--",
            "\" OR \"\"=\"",
            "1' OR '1'='1' /*",
            "' OR 1=1 --"
    };

    private static final String[] SQL_ERROR_MARKERS = {
            "SQLException", "PSQLException", "H2Exception",
            "org.hibernate", "JdbcSQLException",
            "syntax error", "relation \"", "ERROR: "
    };

    @Test
    @DisplayName("Login endpoint rejects SQL injection payloads in email field")
    void loginRejectsSqlInjectionInEmail() throws Exception {
        for (String payload : PAYLOADS) {
            LoginRequest req = LoginRequest.builder()
                    .email(payload + "@x.y")
                    .password("Test1234!")
                    .deviceIdentifier("d1")
                    .deviceName("x")
                    .deviceType("ANDROID")
                    .build();

            MvcResult result = mockMvc.perform(post("/api/auth/login")
                            .contentType(MediaType.APPLICATION_JSON)
                            .content(objectMapper.writeValueAsString(req)))
                    .andReturn();

            int status = result.getResponse().getStatus();
            String body = result.getResponse().getContentAsString();

            assertThat(status)
                    .as("Payload must NOT result in 200 OK: %s", payload)
                    .isNotEqualTo(200);
            assertNoSqlLeak(body, payload);
            rateLimitService.reset();
        }
    }

    @Test
    @DisplayName("Forgot-password endpoint does not leak SQL errors for injection payloads")
    void forgotPasswordRejectsSqlInjection() throws Exception {
        for (String payload : PAYLOADS) {
            ForgotPasswordRequest req = new ForgotPasswordRequest();
            req.setEmail(payload + "@x.y");

            MvcResult result = mockMvc.perform(post("/api/auth/forgot-password")
                            .contentType(MediaType.APPLICATION_JSON)
                            .content(objectMapper.writeValueAsString(req)))
                    .andReturn();

            String body = result.getResponse().getContentAsString();
            assertNoSqlLeak(body, payload);
            rateLimitService.reset();
        }
    }

    @Test
    @org.junit.jupiter.api.Tag("testcontainers")
    @DisplayName("Restaurant search 'q' parameter is parameterized — no SQL leak")
    void restaurantSearchParameterizedQuery() throws Exception {
        // NB: this test exercises the /restaurants/nearest endpoint, whose
        // backing query uses the PostGIS <-> KNN operator. H2 doesn't know
        // <->, so the test would crash with an unrelated H2 syntax error
        // and look like a 500 leak. Tagged @testcontainers so the CI matrix
        // runs it only against the real PostGIS container.
        for (String payload : PAYLOADS) {
            MvcResult result = mockMvc.perform(get("/api/v1/restaurants/nearest")
                            .param("lat", "49.74")
                            .param("lng", "13.37")
                            .param("q", payload))
                    .andReturn();

            int status = result.getResponse().getStatus();
            String body = result.getResponse().getContentAsString();

            assertThat(status)
                    .as("Injection payload %s must not crash search with 500", payload)
                    .isLessThan(500);
            assertNoSqlLeak(body, payload);
            rateLimitService.reset();
        }
    }

    private void assertNoSqlLeak(String body, String payload) {
        if (body == null) return;
        String lower = body.toLowerCase();
        for (String marker : SQL_ERROR_MARKERS) {
            assertThat(lower)
                    .as("Response must not leak SQL/Hibernate error for payload %s", payload)
                    .doesNotContain(marker.toLowerCase());
        }
    }
}
