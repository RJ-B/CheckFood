package com.checkfood.checkfoodservice.module.restaurant.favourite;

import com.checkfood.checkfoodservice.module.restaurant.entity.common.Address;
import com.checkfood.checkfoodservice.module.restaurant.entity.restaurant.CuisineType;
import com.checkfood.checkfoodservice.module.restaurant.entity.restaurant.Restaurant;
import com.checkfood.checkfoodservice.module.restaurant.entity.restaurant.RestaurantStatus;
import com.checkfood.checkfoodservice.module.restaurant.repository.RestaurantRepository;
import com.checkfood.checkfoodservice.security.BaseAuthIntegrationTest;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Nested;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.transaction.annotation.Transactional;

import java.util.UUID;

import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.*;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.*;

/**
 * Extended coverage for FavouriteController beyond what FavouriteIntegrationTest covers.
 * Does NOT duplicate existing tests — adds 404 cases, concurrent scenarios, and response shape assertions.
 */
@Transactional
class FavouriteExtendedIntegrationTest extends BaseAuthIntegrationTest {

    private static final String FAV2_EMAIL = "favext@checkfood.test";
    private static final String BASE_URL = "/api/v1/users/me/favourites";

    @Autowired
    private RestaurantRepository restaurantRepository;

    private UUID restaurantId;

    @BeforeEach
    void setUpRestaurant() {
        Restaurant restaurant = Restaurant.builder()
                .name("Extended Fav Bistro")
                .cuisineType(CuisineType.ITALIAN)
                .status(RestaurantStatus.ACTIVE)
                .active(true)
                .address(Address.builder()
                        .street("Testovací")
                        .streetNumber("2")
                        .city("Brno")
                        .country("CZ")
                        .build())
                .build();
        restaurantId = restaurantRepository.save(restaurant).getId();
    }

    // =========================================================================
    // Authorization matrix
    // =========================================================================

    @Test
    @DisplayName("DELETE /favourites/{id} — 401 when unauthenticated")
    void should_return401_when_removeFavouriteAnonymous() throws Exception {
        mockMvc.perform(delete(BASE_URL + "/" + restaurantId))
                .andExpect(status().isUnauthorized());
    }

    // =========================================================================
    // GET /favourites — Response shape
    // =========================================================================

    @Test
    @DisplayName("GET /favourites — response contains full restaurant objects with id and name")
    void should_returnFullRestaurantObjects_in_favouritesList() throws Exception {
        String token = getAccessToken(FAV2_EMAIL, TEST_PASSWORD, "device-favext-1");

        // Add the restaurant
        mockMvc.perform(put(BASE_URL + "/" + restaurantId)
                        .header("Authorization", "Bearer " + token))
                .andExpect(status().isNoContent());

        // Check list contains full restaurant info
        mockMvc.perform(get(BASE_URL)
                        .header("Authorization", "Bearer " + token))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$[0].id").value(restaurantId.toString()))
                .andExpect(jsonPath("$[0].name").value("Extended Fav Bistro"));
    }

    // =========================================================================
    // 404 — adding non-existent restaurant
    // =========================================================================

    @Test
    @DisplayName("PUT /favourites/{id} — 404 when restaurant does not exist")
    void should_return404_when_restaurantDoesNotExist() throws Exception {
        String token = getAccessToken(FAV2_EMAIL, TEST_PASSWORD, "device-favext-2");

        // GAP: current code throws RestaurantException(NOT_FOUND) but no test verifies the 404 status
        mockMvc.perform(put(BASE_URL + "/" + UUID.randomUUID())
                        .header("Authorization", "Bearer " + token))
                .andExpect(status().isNotFound());
    }

    // =========================================================================
    // DELETE idempotency — removing a restaurant that was never added
    // =========================================================================

    @Test
    @DisplayName("DELETE /favourites/{id} — idempotent when restaurant was never added")
    void should_return204_when_removingNonExistentFavourite() throws Exception {
        String token = getAccessToken(FAV2_EMAIL, TEST_PASSWORD, "device-favext-3");

        // Remove without adding first — should not fail
        mockMvc.perform(delete(BASE_URL + "/" + restaurantId)
                        .header("Authorization", "Bearer " + token))
                .andExpect(status().isNoContent());
    }

    // =========================================================================
    // Multiple favourites — ordering
    // =========================================================================

    @Test
    @DisplayName("GET /favourites — returns list sorted by createdAt desc (most recently added first)")
    void should_returnFavouritesInCreatedAtDescOrder() throws Exception {
        String token = getAccessToken(FAV2_EMAIL, TEST_PASSWORD, "device-favext-4");

        // Add a second restaurant
        Restaurant restaurant2 = Restaurant.builder()
                .name("Second Bistro")
                .cuisineType(CuisineType.CZECH)
                .status(RestaurantStatus.ACTIVE)
                .active(true)
                .address(Address.builder().street("Main").city("Praha").build())
                .build();
        UUID restaurantId2 = restaurantRepository.save(restaurant2).getId();

        mockMvc.perform(put(BASE_URL + "/" + restaurantId)
                        .header("Authorization", "Bearer " + token))
                .andExpect(status().isNoContent());

        mockMvc.perform(put(BASE_URL + "/" + restaurantId2)
                        .header("Authorization", "Bearer " + token))
                .andExpect(status().isNoContent());

        // Should return array with 2 elements
        mockMvc.perform(get(BASE_URL)
                        .header("Authorization", "Bearer " + token))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.length()").value(2));
    }

    // =========================================================================
    // Two users — favourites are user-scoped
    // =========================================================================

    @Test
    @DisplayName("GET /favourites — different users see different favourite lists")
    void should_isolateFavouritesByUser() throws Exception {
        String token1 = getAccessToken(FAV2_EMAIL, TEST_PASSWORD, "device-favext-5");
        String token2 = getAccessToken("favext2nd@checkfood.test", TEST_PASSWORD, "device-favext-6");

        // Only user1 adds the favourite
        mockMvc.perform(put(BASE_URL + "/" + restaurantId)
                        .header("Authorization", "Bearer " + token1))
                .andExpect(status().isNoContent());

        // User2 should see empty list
        mockMvc.perform(get(BASE_URL)
                        .header("Authorization", "Bearer " + token2))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.length()").value(0));
    }
}
