package com.checkfood.checkfoodservice.smoke;

import org.junit.jupiter.api.Tag;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.web.servlet.AutoConfigureMockMvc;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.ActiveProfiles;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.MvcResult;

import java.util.UUID;

import static org.assertj.core.api.Assertions.assertThat;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.get;

/**
 * Smoke test: public, read-only endpoints respond sanely.
 *
 * Excluded from the default `./mvnw test` run via Surefire excludedGroups=smoke.
 * Run manually against staging with:
 *   ./mvnw test -Dgroups=smoke -Dspring.profiles.active=staging
 */
@Tag("smoke")
@SpringBootTest(webEnvironment = SpringBootTest.WebEnvironment.MOCK)
@AutoConfigureMockMvc
@ActiveProfiles("test")
class SmokePublicReadTest {

    @Autowired
    private MockMvc mockMvc;

    @Test
    void allMarkersReturns200() throws Exception {
        MvcResult res = mockMvc.perform(get("/api/v1/restaurants/all-markers")).andReturn();
        assertThat(res.getResponse().getStatus()).isEqualTo(200);
    }

    @Test
    void markersVersionReturns200() throws Exception {
        MvcResult res = mockMvc.perform(get("/api/v1/restaurants/markers-version")).andReturn();
        assertThat(res.getResponse().getStatus()).isEqualTo(200);
    }

    @Test
    void nearestRestaurantsReturns200() throws Exception {
        MvcResult res = mockMvc.perform(get("/api/v1/restaurants/nearest")
                        .param("lat", "49.74")
                        .param("lng", "13.37"))
                .andReturn();
        assertThat(res.getResponse().getStatus()).isEqualTo(200);
    }

    @Test
    void restaurantDetailBogusIdReturns4xx() throws Exception {
        UUID bogus = UUID.randomUUID();
        MvcResult res = mockMvc.perform(get("/api/v1/restaurants/" + bogus)).andReturn();
        assertThat(res.getResponse().getStatus()).isGreaterThanOrEqualTo(400);
    }
}
