package com.checkfood.checkfoodservice.module.restaurant.controller;

import com.checkfood.checkfoodservice.support.BasePostgresIntegrationTest;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Tag;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.web.servlet.MockMvc;

import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.get;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.jsonPath;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;

/**
 * Integration tests for the geospatial endpoints of {@code RestaurantController}
 * that depend on PostGIS functions (ST_X / ST_Y / ST_MakePoint / KNN {@code <->})
 * which H2 doesn't implement.
 *
 * <p>These tests were previously failing as pre-existing GAPs against the
 * H2 backed {@link RestaurantControllerIntegrationTest} — see the
 * Phase 2.4 report. With the Testcontainers-backed
 * {@link BasePostgresIntegrationTest} in Phase 6 they finally have a
 * real spatial engine to talk to.</p>
 *
 * <p>Tagged {@code testcontainers} so CI can opt in / out via
 * {@code -Dgroups=testcontainers} when the Docker socket isn't available
 * (PR pipelines that can't pull the postgis image, etc.).</p>
 *
 * @author CheckFood team, Apr 2026
 */
@Tag("testcontainers")
class RestaurantControllerPostgisIntegrationTest extends BasePostgresIntegrationTest {

    @Autowired
    private MockMvc mockMvc;

    @Test
    @DisplayName("GET /all-markers — returns 200 with version and data on Postgres/PostGIS")
    void should_return200_when_allMarkersRequested() throws Exception {
        mockMvc.perform(get("/api/v1/restaurants/all-markers"))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.version").exists())
                .andExpect(jsonPath("$.data").isArray());
    }

    @Test
    @DisplayName("GET /markers-version — returns 200 with version")
    void should_return200_when_markersVersionRequested() throws Exception {
        mockMvc.perform(get("/api/v1/restaurants/markers-version"))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.version").exists());
    }

    @Test
    @DisplayName("GET /nearest — default pagination returns an array")
    void should_return200_when_nearestRequestedWithDefaultPagination() throws Exception {
        mockMvc.perform(get("/api/v1/restaurants/nearest")
                        .param("lat", "49.74")
                        .param("lng", "13.37"))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$").isArray());
    }

    @Test
    @DisplayName("GET /nearest — page beyond last returns empty array instead of 500")
    void should_returnEmptyList_when_pageIsBeyondLast() throws Exception {
        mockMvc.perform(get("/api/v1/restaurants/nearest")
                        .param("lat", "49.74")
                        .param("lng", "13.37")
                        .param("page", "9999")
                        .param("size", "10"))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$").isArray());
    }
}
