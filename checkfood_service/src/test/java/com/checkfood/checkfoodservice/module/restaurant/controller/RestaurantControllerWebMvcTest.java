package com.checkfood.checkfoodservice.module.restaurant.controller;

import com.checkfood.checkfoodservice.module.restaurant.dto.response.AllMarkersResponse;
import com.checkfood.checkfoodservice.module.restaurant.dto.response.RestaurantResponse;
import com.checkfood.checkfoodservice.module.restaurant.entity.restaurant.RestaurantStatus;
import com.checkfood.checkfoodservice.module.restaurant.favourite.service.FavouriteService;
import com.checkfood.checkfoodservice.module.restaurant.service.RestaurantService;
import com.checkfood.checkfoodservice.module.restaurant.service.TableManagementService;
import com.checkfood.checkfoodservice.security.module.user.service.UserService;
import com.checkfood.checkfoodservice.testsupport.WebMvcSliceTestConfig;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.web.servlet.AutoConfigureMockMvc;
import org.springframework.boot.test.autoconfigure.web.servlet.WebMvcTest;
import org.springframework.context.annotation.Import;
import org.springframework.test.context.bean.override.mockito.MockitoBean;
import org.springframework.test.web.servlet.MockMvc;

import java.math.BigDecimal;
import java.util.List;
import java.util.UUID;

import static org.mockito.ArgumentMatchers.any;
import static org.mockito.ArgumentMatchers.anyDouble;
import static org.mockito.ArgumentMatchers.anyInt;
import static org.mockito.BDDMockito.given;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.get;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.jsonPath;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;

/**
 * Web-layer slice test for {@link RestaurantController}.
 *
 * <p>Focuses on the three public, unauthenticated endpoints that power
 * the Explore screen on the Flutter client:
 *
 * <ul>
 *   <li>{@code GET /api/v1/restaurants/all-markers}</li>
 *   <li>{@code GET /api/v1/restaurants/nearest}</li>
 *   <li>{@code GET /api/v1/restaurants/{id}}</li>
 * </ul>
 *
 * <p>The owner-only endpoints (@PreAuthorize('hasRole(...)')) are NOT
 * covered here because they need the full Spring Security method-security
 * infrastructure which doesn't mesh with {@code @WebMvcTest} slicing —
 * they are covered by the existing {@code BaseAuthIntegrationTest}
 * subclasses instead.
 */
@WebMvcTest(controllers = RestaurantController.class)
@AutoConfigureMockMvc(addFilters = false)
@Import(WebMvcSliceTestConfig.class)
class RestaurantControllerWebMvcTest {

    @Autowired private MockMvc mockMvc;

    @MockitoBean private RestaurantService restaurantService;
    @MockitoBean private TableManagementService tableManagementService;
    @MockitoBean private FavouriteService favouriteService;
    @MockitoBean private UserService userService;

    @Test
    @DisplayName("GET /all-markers returns 200 with wrapped version + data")
    void allMarkersHappyPath() throws Exception {
        given(restaurantService.getAllActiveMarkers()).willReturn(
                AllMarkersResponse.builder()
                        .version(42L)
                        .data(List.of())
                        .build()
        );

        mockMvc.perform(get("/api/v1/restaurants/all-markers"))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.version").value(42))
                .andExpect(jsonPath("$.data").isArray());
    }

    @Test
    @DisplayName("GET /nearest returns 200 and passes lat/lng/pagination to service")
    void nearestHappyPath() throws Exception {
        UUID id = UUID.fromString("11111111-1111-1111-1111-111111111111");
        RestaurantResponse r = RestaurantResponse.builder()
                .id(id)
                .name("Bistro 1")
                .status(RestaurantStatus.ACTIVE)
                .active(true)
                .rating(new BigDecimal("4.5"))
                .build();

        given(restaurantService.getNearestRestaurants(
                anyDouble(), anyDouble(), anyInt(), anyInt(),
                any(), any(), any(), any(), any()
        )).willReturn(List.of(r));

        mockMvc.perform(get("/api/v1/restaurants/nearest")
                        .param("lat", "49.74")
                        .param("lng", "13.37")
                        .param("page", "0")
                        .param("size", "10"))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$[0].id").value(id.toString()))
                .andExpect(jsonPath("$[0].name").value("Bistro 1"))
                .andExpect(jsonPath("$[0].status").value("ACTIVE"));
    }

    @Test
    @DisplayName("GET /nearest requires lat — missing param → 400")
    void nearestRejectsMissingLat() throws Exception {
        mockMvc.perform(get("/api/v1/restaurants/nearest")
                        .param("lng", "13.37"))
                .andExpect(status().isBadRequest());
    }

    @Test
    @DisplayName("GET /{id} returns 200 with the payload and never calls favouriteService when anonymous")
    void detailAnonymousSkipsFavouriteLookup() throws Exception {
        UUID id = UUID.fromString("22222222-2222-2222-2222-222222222222");
        RestaurantResponse r = RestaurantResponse.builder()
                .id(id)
                .name("Bistro 2")
                .status(RestaurantStatus.ACTIVE)
                .active(true)
                .rating(new BigDecimal("4.0"))
                .build();
        given(restaurantService.getRestaurantById(id)).willReturn(r);

        mockMvc.perform(get("/api/v1/restaurants/{id}", id))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.id").value(id.toString()));

        // Anonymous client must NOT trigger a favourite lookup — that path
        // is reserved for authenticated users. If this regresses, every
        // public /nearest call will suddenly start hitting the favourites
        // table on behalf of nobody, which was the 2026-03 CPU spike.
        org.mockito.Mockito.verifyNoInteractions(favouriteService);
    }

    @Test
    @DisplayName("GET /{id} with malformed UUID returns 400")
    void detailRejectsMalformedId() throws Exception {
        mockMvc.perform(get("/api/v1/restaurants/{id}", "not-a-uuid"))
                .andExpect(status().isBadRequest());
    }
}
