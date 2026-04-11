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
 * Rate-limiting probes. Hammer sensitive endpoints and assert 429 after
 * the configured threshold. Rate limiter is reset between tests.
 *
 * Also covers expensive public geospatial endpoints (marker/nearest).
 */
class RateLimitTest extends BaseAuthIntegrationTest {

    @Test
    @DisplayName("Login rate limit triggers 429 after 10 attempts per IP")
    void loginRateLimit() throws Exception {
        LoginRequest req = LoginRequest.builder()
                .email("nobody@checkfood.test")
                .password("WrongPass123!")
                .deviceIdentifier("dev-1")
                .deviceName("x")
                .deviceType("ANDROID")
                .build();
        String body = objectMapper.writeValueAsString(req);

        int last = 200;
        for (int i = 0; i < 15; i++) {
            MvcResult r = mockMvc.perform(post("/api/auth/login")
                            .contentType(MediaType.APPLICATION_JSON)
                            .content(body))
                    .andReturn();
            last = r.getResponse().getStatus();
            if (last == 429) break;
        }
        assertThat(last).as("Login must reach 429 within 15 requests").isEqualTo(429);
    }

    @Test
    @DisplayName("Register rate limit triggers 429 after 5 attempts per IP")
    void registerRateLimit() throws Exception {
        int last = 200;
        for (int i = 0; i < 10; i++) {
            String json = String.format("""
                {"firstName":"A","lastName":"B","email":"user%d@checkfood.test","password":"Test1234!"}
                """, i);
            MvcResult r = mockMvc.perform(post("/api/auth/register")
                            .contentType(MediaType.APPLICATION_JSON)
                            .content(json))
                    .andReturn();
            last = r.getResponse().getStatus();
            if (last == 429) break;
        }
        assertThat(last).as("Register must reach 429 within 10 attempts").isEqualTo(429);
    }

    @Test
    @DisplayName("Forgot-password rate limit triggers 429 after 3 attempts per IP")
    void forgotPasswordRateLimit() throws Exception {
        ForgotPasswordRequest req = new ForgotPasswordRequest();
        req.setEmail("target@checkfood.test");
        String body = objectMapper.writeValueAsString(req);

        int last = 200;
        for (int i = 0; i < 8; i++) {
            MvcResult r = mockMvc.perform(post("/api/auth/forgot-password")
                            .contentType(MediaType.APPLICATION_JSON)
                            .content(body))
                    .andReturn();
            last = r.getResponse().getStatus();
            if (last == 429) break;
        }
        assertThat(last).isEqualTo(429);
    }

    @Test
    @DisplayName("Marker bulk endpoint /all-markers is rate-limited")
    void allMarkersRateLimit() throws Exception {
        int last = 200;
        for (int i = 0; i < 60; i++) {
            MvcResult r = mockMvc.perform(get("/api/v1/restaurants/all-markers")).andReturn();
            last = r.getResponse().getStatus();
            if (last == 429) break;
        }
        assertThat(last)
                .as("All-markers is expensive; must be rate-limited to 30/min/IP")
                .isEqualTo(429);
    }

    @Test
    @DisplayName("Nearest search is rate-limited (expensive PostGIS query)")
    void nearestRateLimit() throws Exception {
        int last = 200;
        for (int i = 0; i < 120; i++) {
            MvcResult r = mockMvc.perform(get("/api/v1/restaurants/nearest")
                            .param("lat", "49.74")
                            .param("lng", "13.37"))
                    .andReturn();
            last = r.getResponse().getStatus();
            if (last == 429) break;
        }
        assertThat(last).isEqualTo(429);
    }

    @Test
    @DisplayName("GAP: /api/auth/verify (email link) has NO rate limit — token enumeration possible")
    void verifyEndpointGap() throws Exception {
        // GAP: /api/auth/verify is not annotated @RateLimited. A bot can
        // brute-force verification UUIDs across thousands of requests.
        // Mitigation is token entropy (UUID v4) — still, add rate limit.
        int hits = 0;
        for (int i = 0; i < 100; i++) {
            MvcResult r = mockMvc.perform(get("/api/auth/verify").param("token", "random-" + i))
                    .andReturn();
            if (r.getResponse().getStatus() < 500) hits++;
        }
        assertThat(hits)
                .as("GAP: /api/auth/verify has no rate limit — 100 requests all succeed")
                .isLessThan(100);
    }
}
