package com.checkfood.checkfoodservice.module.restaurant.favourite;

import com.checkfood.checkfoodservice.module.restaurant.entity.common.Address;
import com.checkfood.checkfoodservice.module.restaurant.entity.restaurant.CuisineType;
import com.checkfood.checkfoodservice.module.restaurant.entity.restaurant.Restaurant;
import com.checkfood.checkfoodservice.module.restaurant.entity.restaurant.RestaurantStatus;
import com.checkfood.checkfoodservice.module.restaurant.repository.RestaurantRepository;
import com.checkfood.checkfoodservice.security.BaseAuthIntegrationTest;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.transaction.annotation.Transactional;

import java.util.UUID;

import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.*;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.*;

@Transactional
class FavouriteIntegrationTest extends BaseAuthIntegrationTest {

    private static final String FAV_EMAIL = "favuser@checkfood.test";
    private static final String BASE_URL = "/api/v1/users/me/favourites";

    @Autowired
    private RestaurantRepository restaurantRepository;

    private UUID restaurantId;

    @BeforeEach
    void setUpRestaurant() {
        // Vytvoř testovací restauraci v H2 DB (bez PostGIS geometry — location je null)
        Restaurant restaurant = Restaurant.builder()
                .name("Test Restaurace")
                .cuisineType(CuisineType.CZECH)
                .status(RestaurantStatus.ACTIVE)
                .active(true)
                .address(Address.builder()
                        .street("Testovací")
                        .streetNumber("1")
                        .city("Praha")
                        .postalCode("11000")
                        .country("CZ")
                        .build())
                .build();
        restaurantId = restaurantRepository.save(restaurant).getId();
    }

    @Test
    @DisplayName("PUT /favourites/{id} - authenticated user can add favourite (204)")
    void addFavourite_Returns204() throws Exception {
        String token = getAccessToken(FAV_EMAIL, TEST_PASSWORD, "device-fav-1");

        mockMvc.perform(put(BASE_URL + "/" + restaurantId)
                        .header("Authorization", "Bearer " + token))
                .andExpect(status().isNoContent());
    }

    @Test
    @DisplayName("PUT /favourites/{id} - idempotent (second add also 204)")
    void addFavourite_Idempotent() throws Exception {
        String token = getAccessToken(FAV_EMAIL, TEST_PASSWORD, "device-fav-2");

        mockMvc.perform(put(BASE_URL + "/" + restaurantId)
                        .header("Authorization", "Bearer " + token))
                .andExpect(status().isNoContent());

        // Second add should not fail
        mockMvc.perform(put(BASE_URL + "/" + restaurantId)
                        .header("Authorization", "Bearer " + token))
                .andExpect(status().isNoContent());
    }

    @Test
    @DisplayName("DELETE /favourites/{id} - remove favourite returns 204")
    void removeFavourite_Returns204() throws Exception {
        String token = getAccessToken(FAV_EMAIL, TEST_PASSWORD, "device-fav-3");

        // Add first
        mockMvc.perform(put(BASE_URL + "/" + restaurantId)
                        .header("Authorization", "Bearer " + token))
                .andExpect(status().isNoContent());

        // Remove
        mockMvc.perform(delete(BASE_URL + "/" + restaurantId)
                        .header("Authorization", "Bearer " + token))
                .andExpect(status().isNoContent());
    }

    @Test
    @DisplayName("GET /favourites - returns list of favourited restaurants")
    void getFavourites_ReturnsList() throws Exception {
        String token = getAccessToken(FAV_EMAIL, TEST_PASSWORD, "device-fav-4");

        // Add favourite
        mockMvc.perform(put(BASE_URL + "/" + restaurantId)
                        .header("Authorization", "Bearer " + token))
                .andExpect(status().isNoContent());

        // Get list
        mockMvc.perform(get(BASE_URL)
                        .header("Authorization", "Bearer " + token))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$").isArray());
    }

    @Test
    @DisplayName("GET /favourites - without token returns 401")
    void getFavourites_WithoutToken_Returns401() throws Exception {
        mockMvc.perform(get(BASE_URL))
                .andExpect(status().isUnauthorized());
    }

    @Test
    @DisplayName("PUT /favourites/{id} - without token returns 401")
    void addFavourite_WithoutToken_Returns401() throws Exception {
        mockMvc.perform(put(BASE_URL + "/" + restaurantId))
                .andExpect(status().isUnauthorized());
    }
}
