package com.checkfood.checkfoodservice.module.restaurant.controller;

import com.checkfood.checkfoodservice.module.restaurant.entity.common.Address;
import com.checkfood.checkfoodservice.module.restaurant.entity.employee.RestaurantEmployee;
import com.checkfood.checkfoodservice.module.restaurant.entity.employee.RestaurantEmployeeRole;
import com.checkfood.checkfoodservice.module.restaurant.entity.restaurant.CuisineType;
import com.checkfood.checkfoodservice.module.restaurant.entity.restaurant.Restaurant;
import com.checkfood.checkfoodservice.module.restaurant.entity.restaurant.RestaurantStatus;
import com.checkfood.checkfoodservice.module.restaurant.repository.RestaurantEmployeeRepository;
import com.checkfood.checkfoodservice.module.restaurant.repository.RestaurantRepository;
import com.checkfood.checkfoodservice.security.BaseAuthIntegrationTest;
import com.checkfood.checkfoodservice.security.module.user.entity.RoleEntity;
import com.fasterxml.jackson.databind.JsonNode;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Nested;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.test.web.servlet.MvcResult;
import org.springframework.transaction.annotation.Transactional;

import java.util.HashSet;
import java.util.Set;
import java.util.UUID;

import static org.assertj.core.api.Assertions.assertThat;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.*;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.*;

/**
 * Integration tests for RestaurantController — non-geospatial paths (H2).
 * Geospatial tests (getNearest, markers) live in RestaurantControllerPostgisIntegrationTest.
 */
@Transactional
class RestaurantControllerIntegrationTest extends BaseAuthIntegrationTest {

    private static final String OWNER_EMAIL = "owner-ctrl@checkfood.test";
    private static final String USER_EMAIL  = "user-ctrl@checkfood.test";
    private static final String OTHER_OWNER_EMAIL = "other-owner-ctrl@checkfood.test";

    @Autowired
    private RestaurantRepository restaurantRepository;

    @Autowired
    private RestaurantEmployeeRepository restaurantEmployeeRepository;

    @BeforeEach
    void ensureOwnerRole() {
        ensureRole("RESTAURANT_OWNER");
        ensureRole("OWNER");
    }

    // =========================================================================
    // GET /api/v1/restaurants/{id}
    // =========================================================================

    @Nested
    @DisplayName("GET /api/v1/restaurants/{id}")
    class GetRestaurantById {

        @Test
        @DisplayName("happy path — returns 200 with restaurant body")
        void should_return200_when_restaurantExists() throws Exception {
            Restaurant saved = persistRestaurant("Happy Bistro");

            mockMvc.perform(get("/api/v1/restaurants/" + saved.getId()))
                    .andExpect(status().isOk())
                    .andExpect(jsonPath("$.id").value(saved.getId().toString()))
                    .andExpect(jsonPath("$.name").value("Happy Bistro"));
        }

        @Test
        @DisplayName("404 when restaurant does not exist")
        void should_return404_when_restaurantNotFound() throws Exception {
            mockMvc.perform(get("/api/v1/restaurants/" + UUID.randomUUID()))
                    .andExpect(status().isNotFound());
        }

        @Test
        @DisplayName("anonymous user can access public detail")
        void should_return200_for_anonymous() throws Exception {
            Restaurant saved = persistRestaurant("Public Bistro");

            mockMvc.perform(get("/api/v1/restaurants/" + saved.getId()))
                    .andExpect(status().isOk());
        }

        @Test
        @DisplayName("authenticated user gets isFavourite field")
        void should_returnIsFavourite_when_authenticated() throws Exception {
            Restaurant saved = persistRestaurant("Fav Bistro");
            String token = getAccessToken(USER_EMAIL, TEST_PASSWORD, "device-user-fav");

            mockMvc.perform(get("/api/v1/restaurants/" + saved.getId())
                            .header("Authorization", "Bearer " + token))
                    .andExpect(status().isOk())
                    .andExpect(jsonPath("$.isFavourite").exists());
        }
    }

    // =========================================================================
    // POST /api/v1/restaurants
    // =========================================================================

    @Nested
    @DisplayName("POST /api/v1/restaurants")
    class CreateRestaurant {

        // GAP: RestaurantController.extractUserId() calls UUID.fromString(authentication.getName())
        // but authentication.getName() returns the user's email (not a UUID).
        // POST /api/v1/restaurants, PUT /{id}, DELETE /{id} all throw IllegalArgumentException → 500.
        // The controller needs to be fixed to use the user's UUID (e.g., from a custom claim or via UserService).
        @Test
        @DisplayName("happy path — RESTAURANT_OWNER creates restaurant, gets 201")
        void should_return201_when_ownerCreatesRestaurant() throws Exception {
            String token = getTokenWithRole(OWNER_EMAIL, "RESTAURANT_OWNER", "device-owner-create");

            mockMvc.perform(post("/api/v1/restaurants")
                            .header("Authorization", "Bearer " + token)
                            .contentType(MediaType.APPLICATION_JSON)
                            .content(validRestaurantJson()))
                    .andExpect(status().isCreated())
                    .andExpect(jsonPath("$.name").value("Test Restaurant"))
                    .andExpect(jsonPath("$.status").value("PENDING"));
        }

        @Test
        @DisplayName("401 when unauthenticated")
        void should_return401_when_anonymous() throws Exception {
            mockMvc.perform(post("/api/v1/restaurants")
                            .contentType(MediaType.APPLICATION_JSON)
                            .content(validRestaurantJson()))
                    .andExpect(status().isUnauthorized());
        }

        @Test
        @DisplayName("403 when user lacks RESTAURANT_OWNER role")
        void should_return403_when_regularUser() throws Exception {
            String token = getAccessToken(USER_EMAIL, TEST_PASSWORD, "device-user-create");

            mockMvc.perform(post("/api/v1/restaurants")
                            .header("Authorization", "Bearer " + token)
                            .contentType(MediaType.APPLICATION_JSON)
                            .content(validRestaurantJson()))
                    .andExpect(status().isForbidden());
        }

        @Test
        @DisplayName("400 when name is blank")
        void should_return400_when_nameIsBlank() throws Exception {
            String token = getTokenWithRole(OWNER_EMAIL, "RESTAURANT_OWNER", "device-owner-val1");

            mockMvc.perform(post("/api/v1/restaurants")
                            .header("Authorization", "Bearer " + token)
                            .contentType(MediaType.APPLICATION_JSON)
                            .content(restaurantJsonWithName("")))
                    .andExpect(status().isBadRequest());
        }

        @Test
        @DisplayName("400 when name is null")
        void should_return400_when_nameIsNull() throws Exception {
            String token = getTokenWithRole(OWNER_EMAIL, "RESTAURANT_OWNER", "device-owner-val2");

            String json = """
                    {"cuisineType":"CZECH","address":{"street":"Testovací","city":"Praha"}}
                    """;

            mockMvc.perform(post("/api/v1/restaurants")
                            .header("Authorization", "Bearer " + token)
                            .contentType(MediaType.APPLICATION_JSON)
                            .content(json))
                    .andExpect(status().isBadRequest());
        }

        @Test
        @DisplayName("400 when cuisineType is null")
        void should_return400_when_cuisineTypeIsNull() throws Exception {
            String token = getTokenWithRole(OWNER_EMAIL, "RESTAURANT_OWNER", "device-owner-val3");

            String json = """
                    {"name":"Test","address":{"street":"Testovací","city":"Praha"}}
                    """;

            mockMvc.perform(post("/api/v1/restaurants")
                            .header("Authorization", "Bearer " + token)
                            .contentType(MediaType.APPLICATION_JSON)
                            .content(json))
                    .andExpect(status().isBadRequest());
        }

        @Test
        @DisplayName("400 when address is null")
        void should_return400_when_addressIsNull() throws Exception {
            String token = getTokenWithRole(OWNER_EMAIL, "RESTAURANT_OWNER", "device-owner-val4");

            String json = """
                    {"name":"Test","cuisineType":"CZECH"}
                    """;

            mockMvc.perform(post("/api/v1/restaurants")
                            .header("Authorization", "Bearer " + token)
                            .contentType(MediaType.APPLICATION_JSON)
                            .content(json))
                    .andExpect(status().isBadRequest());
        }

        @Test
        @DisplayName("400 when address.street is blank")
        void should_return400_when_addressStreetIsBlank() throws Exception {
            String token = getTokenWithRole(OWNER_EMAIL, "RESTAURANT_OWNER", "device-owner-val5");

            String json = """
                    {"name":"Test","cuisineType":"CZECH","address":{"street":"","city":"Praha"}}
                    """;

            mockMvc.perform(post("/api/v1/restaurants")
                            .header("Authorization", "Bearer " + token)
                            .contentType(MediaType.APPLICATION_JSON)
                            .content(json))
                    .andExpect(status().isBadRequest());
        }

        @Test
        @DisplayName("400 when address.city is blank")
        void should_return400_when_addressCityIsBlank() throws Exception {
            String token = getTokenWithRole(OWNER_EMAIL, "RESTAURANT_OWNER", "device-owner-val6");

            String json = """
                    {"name":"Test","cuisineType":"CZECH","address":{"street":"Main St","city":""}}
                    """;

            mockMvc.perform(post("/api/v1/restaurants")
                            .header("Authorization", "Bearer " + token)
                            .contentType(MediaType.APPLICATION_JSON)
                            .content(json))
                    .andExpect(status().isBadRequest());
        }

        @Test
        @DisplayName("400 when name exceeds 150 chars")
        void should_return400_when_nameTooLong() throws Exception {
            String token = getTokenWithRole(OWNER_EMAIL, "RESTAURANT_OWNER", "device-owner-val7");

            mockMvc.perform(post("/api/v1/restaurants")
                            .header("Authorization", "Bearer " + token)
                            .contentType(MediaType.APPLICATION_JSON)
                            .content(restaurantJsonWithName("A".repeat(151))))
                    .andExpect(status().isBadRequest());
        }

        @Test
        @DisplayName("200 when name is exactly 150 chars")
        void should_return201_when_nameIs150Chars() throws Exception {
            String token = getTokenWithRole(OWNER_EMAIL, "RESTAURANT_OWNER", "device-owner-val7b");

            mockMvc.perform(post("/api/v1/restaurants")
                            .header("Authorization", "Bearer " + token)
                            .contentType(MediaType.APPLICATION_JSON)
                            .content(restaurantJsonWithName("A".repeat(150))))
                    .andExpect(status().isCreated());
        }

        @Test
        @DisplayName("400 when defaultReservationDurationMinutes below minimum (14)")
        void should_return400_when_reservationDurationBelowMin() throws Exception {
            String token = getTokenWithRole(OWNER_EMAIL, "RESTAURANT_OWNER", "device-owner-val8");

            String json = """
                    {"name":"Test","cuisineType":"CZECH","address":{"street":"Main","city":"Praha"},
                     "defaultReservationDurationMinutes":14}
                    """;

            mockMvc.perform(post("/api/v1/restaurants")
                            .header("Authorization", "Bearer " + token)
                            .contentType(MediaType.APPLICATION_JSON)
                            .content(json))
                    .andExpect(status().isBadRequest());
        }

        @Test
        @DisplayName("400 when defaultReservationDurationMinutes exceeds maximum (481)")
        void should_return400_when_reservationDurationAboveMax() throws Exception {
            String token = getTokenWithRole(OWNER_EMAIL, "RESTAURANT_OWNER", "device-owner-val9");

            String json = """
                    {"name":"Test","cuisineType":"CZECH","address":{"street":"Main","city":"Praha"},
                     "defaultReservationDurationMinutes":481}
                    """;

            mockMvc.perform(post("/api/v1/restaurants")
                            .header("Authorization", "Bearer " + token)
                            .contentType(MediaType.APPLICATION_JSON)
                            .content(json))
                    .andExpect(status().isBadRequest());
        }

        @Test
        @DisplayName("persistence round-trip — saved restaurant readable by findById")
        void should_persistRestaurant_when_created() throws Exception {
            String token = getTokenWithRole(OWNER_EMAIL, "RESTAURANT_OWNER", "device-owner-persist");

            MvcResult result = mockMvc.perform(post("/api/v1/restaurants")
                            .header("Authorization", "Bearer " + token)
                            .contentType(MediaType.APPLICATION_JSON)
                            .content(validRestaurantJson()))
                    .andExpect(status().isCreated())
                    .andReturn();

            JsonNode body = objectMapper.readTree(result.getResponse().getContentAsString());
            UUID id = UUID.fromString(body.get("id").asText());

            assertThat(restaurantRepository.findById(id)).isPresent();
            assertThat(restaurantRepository.findById(id).get().getName()).isEqualTo("Test Restaurant");
        }
    }

    // =========================================================================
    // PUT /api/v1/restaurants/{id}
    // =========================================================================

    @Nested
    @DisplayName("PUT /api/v1/restaurants/{id}")
    class UpdateRestaurant {

        @Test
        @DisplayName("happy path — owner updates own restaurant")
        void should_return200_when_ownerUpdatesRestaurant() throws Exception {
            String token = getTokenWithRole(OWNER_EMAIL, "RESTAURANT_OWNER", "device-owner-upd");
            Long ownerId = getOwnerIdFromToken(token);
            Restaurant saved = persistRestaurantForOwner("Original Name", ownerId);

            mockMvc.perform(put("/api/v1/restaurants/" + saved.getId())
                            .header("Authorization", "Bearer " + token)
                            .contentType(MediaType.APPLICATION_JSON)
                            .content(restaurantJsonWithName("Updated Name")))
                    .andExpect(status().isOk())
                    .andExpect(jsonPath("$.name").value("Updated Name"));
        }

        @Test
        @DisplayName("403 when wrong owner tries to update")
        void should_return403_when_notOwner() throws Exception {
            String ownerToken = getTokenWithRole(OWNER_EMAIL, "RESTAURANT_OWNER", "device-owner-upd2");
            String otherToken = getTokenWithRole(OTHER_OWNER_EMAIL, "RESTAURANT_OWNER", "device-other-owner-upd");

            Long ownerId = getOwnerIdFromToken(ownerToken);
            Restaurant saved = persistRestaurantForOwner("Not Your Restaurant", ownerId);

            mockMvc.perform(put("/api/v1/restaurants/" + saved.getId())
                            .header("Authorization", "Bearer " + otherToken)
                            .contentType(MediaType.APPLICATION_JSON)
                            .content(restaurantJsonWithName("Hacked")))
                    .andExpect(status().isForbidden());
        }

        @Test
        @DisplayName("404 when restaurant does not exist")
        void should_return404_when_restaurantNotFound() throws Exception {
            String token = getTokenWithRole(OWNER_EMAIL, "RESTAURANT_OWNER", "device-owner-upd3");

            mockMvc.perform(put("/api/v1/restaurants/" + UUID.randomUUID())
                            .header("Authorization", "Bearer " + token)
                            .contentType(MediaType.APPLICATION_JSON)
                            .content(restaurantJsonWithName("Updated")))
                    .andExpect(status().isNotFound());
        }

        @Test
        @DisplayName("idempotency — PUT twice results in same final state")
        void should_beIdempotent_when_putTwice() throws Exception {
            String token = getTokenWithRole(OWNER_EMAIL, "RESTAURANT_OWNER", "device-owner-idem");
            Long ownerId = getOwnerIdFromToken(token);
            Restaurant saved = persistRestaurantForOwner("Idempotent Restaurant", ownerId);

            mockMvc.perform(put("/api/v1/restaurants/" + saved.getId())
                            .header("Authorization", "Bearer " + token)
                            .contentType(MediaType.APPLICATION_JSON)
                            .content(restaurantJsonWithName("Final Name")))
                    .andExpect(status().isOk());

            mockMvc.perform(put("/api/v1/restaurants/" + saved.getId())
                            .header("Authorization", "Bearer " + token)
                            .contentType(MediaType.APPLICATION_JSON)
                            .content(restaurantJsonWithName("Final Name")))
                    .andExpect(status().isOk())
                    .andExpect(jsonPath("$.name").value("Final Name"));

            assertThat(restaurantRepository.findById(saved.getId()).get().getName()).isEqualTo("Final Name");
        }
    }

    // =========================================================================
    // DELETE /api/v1/restaurants/{id}
    // =========================================================================

    @Nested
    @DisplayName("DELETE /api/v1/restaurants/{id}")
    class DeleteRestaurant {

        @Test
        @DisplayName("happy path — owner deletes own restaurant, gets 204")
        void should_return204_when_ownerDeletes() throws Exception {
            String token = getTokenWithRole(OWNER_EMAIL, "RESTAURANT_OWNER", "device-owner-del");
            Long ownerId = getOwnerIdFromToken(token);
            Restaurant saved = persistRestaurantForOwner("To Delete", ownerId);

            mockMvc.perform(delete("/api/v1/restaurants/" + saved.getId())
                            .header("Authorization", "Bearer " + token))
                    .andExpect(status().isNoContent());

            // Soft delete — entity still exists but is not active
            Restaurant after = restaurantRepository.findById(saved.getId()).orElseThrow();
            assertThat(after.isActive()).isFalse();
            assertThat(after.getStatus()).isEqualTo(RestaurantStatus.ARCHIVED);
        }

        @Test
        @DisplayName("403 when non-owner tries to delete")
        void should_return403_when_notOwner() throws Exception {
            String ownerToken = getTokenWithRole(OWNER_EMAIL, "RESTAURANT_OWNER", "device-owner-del2");
            String otherToken = getTokenWithRole(OTHER_OWNER_EMAIL, "RESTAURANT_OWNER", "device-other-del");

            Long ownerId = getOwnerIdFromToken(ownerToken);
            Restaurant saved = persistRestaurantForOwner("Protected Restaurant", ownerId);

            mockMvc.perform(delete("/api/v1/restaurants/" + saved.getId())
                            .header("Authorization", "Bearer " + otherToken))
                    .andExpect(status().isForbidden());
        }

        @Test
        @DisplayName("404 when restaurant does not exist")
        void should_return404_when_restaurantNotFound() throws Exception {
            String token = getTokenWithRole(OWNER_EMAIL, "RESTAURANT_OWNER", "device-owner-del3");

            mockMvc.perform(delete("/api/v1/restaurants/" + UUID.randomUUID())
                            .header("Authorization", "Bearer " + token))
                    .andExpect(status().isNotFound());
        }

        @Test
        @DisplayName("idempotency — DELETE twice is idempotent (second call keeps archived state)")
        void should_beIdempotent_when_deleteTwice() throws Exception {
            String token = getTokenWithRole(OWNER_EMAIL, "RESTAURANT_OWNER", "device-owner-del4");
            Long ownerId = getOwnerIdFromToken(token);
            Restaurant saved = persistRestaurantForOwner("Double Delete", ownerId);

            mockMvc.perform(delete("/api/v1/restaurants/" + saved.getId())
                            .header("Authorization", "Bearer " + token))
                    .andExpect(status().isNoContent());

            // Second delete — still 204 (resource exists but is ARCHIVED)
            mockMvc.perform(delete("/api/v1/restaurants/" + saved.getId())
                            .header("Authorization", "Bearer " + token))
                    .andExpect(status().isNoContent());
        }
    }

    // =========================================================================
    // GET /api/my-restaurant/list
    // =========================================================================

    @Nested
    @DisplayName("GET /api/my-restaurant/list")
    class GetMyRestaurants {

        @Test
        @DisplayName("OWNER sees their own restaurants")
        void should_returnMyRestaurants_when_ownerAuthenticated() throws Exception {
            // /api/my-restaurant/list is gated by hasAnyRole('OWNER',
            // 'MANAGER', 'STAFF') — note OWNER, not RESTAURANT_OWNER.
            // RESTAURANT_OWNER is the older "can register a new restaurant"
            // role and lives on a different controller
            // (RestaurantController.create*).
            ensureRole("OWNER");
            String token = getTokenWithRole(OWNER_EMAIL, "OWNER", "device-owner-me");
            Long ownerId = getOwnerIdFromToken(token);
            // persistRestaurantForOwner already wires up a RestaurantEmployee
            // row with role=OWNER, which is what MyRestaurantService walks.
            persistRestaurantForOwner("My Restaurant", ownerId);

            mockMvc.perform(get("/api/my-restaurant/list")
                            .header("Authorization", "Bearer " + token))
                    .andExpect(status().isOk())
                    .andExpect(jsonPath("$").isArray())
                    .andExpect(jsonPath("$[0].name").value("My Restaurant"));
        }

        @Test
        @DisplayName("401 when unauthenticated")
        void should_return401_when_anonymous() throws Exception {
            mockMvc.perform(get("/api/my-restaurant/list"))
                    .andExpect(status().isUnauthorized());
        }

        @Test
        @DisplayName("403 when regular user lacks RESTAURANT_OWNER role")
        void should_return403_when_regularUser() throws Exception {
            String token = getAccessToken(USER_EMAIL, TEST_PASSWORD, "device-user-me");

            mockMvc.perform(get("/api/my-restaurant/list")
                            .header("Authorization", "Bearer " + token))
                    .andExpect(status().isForbidden());
        }
    }

    // =========================================================================
    // POST /api/v1/restaurants/{id}/tables
    // =========================================================================

    @Nested
    @DisplayName("POST /api/v1/restaurants/{id}/tables")
    class AddTable {

        @Test
        @DisplayName("happy path — owner adds table, gets 201")
        void should_return201_when_ownerAddsTable() throws Exception {
            String token = getTokenWithRole(OWNER_EMAIL, "RESTAURANT_OWNER", "device-owner-tbl");
            Long ownerId = getOwnerIdFromToken(token);
            Restaurant saved = persistRestaurantForOwner("Table Restaurant", ownerId);

            mockMvc.perform(post("/api/v1/restaurants/" + saved.getId() + "/tables")
                            .header("Authorization", "Bearer " + token)
                            .contentType(MediaType.APPLICATION_JSON)
                            .content("{\"label\":\"T1\",\"capacity\":4,\"active\":true}"))
                    .andExpect(status().isCreated())
                    .andExpect(jsonPath("$.label").value("T1"))
                    .andExpect(jsonPath("$.capacity").value(4));
        }

        @Test
        @DisplayName("400 when label is blank")
        void should_return400_when_labelIsBlank() throws Exception {
            String token = getTokenWithRole(OWNER_EMAIL, "RESTAURANT_OWNER", "device-owner-tbl2");
            Long ownerId = getOwnerIdFromToken(token);
            Restaurant saved = persistRestaurantForOwner("Table Restaurant 2", ownerId);

            mockMvc.perform(post("/api/v1/restaurants/" + saved.getId() + "/tables")
                            .header("Authorization", "Bearer " + token)
                            .contentType(MediaType.APPLICATION_JSON)
                            .content("{\"label\":\"\",\"capacity\":4}"))
                    .andExpect(status().isBadRequest());
        }

        @Test
        @DisplayName("400 when capacity is 0 (below minimum 1)")
        void should_return400_when_capacityIsZero() throws Exception {
            String token = getTokenWithRole(OWNER_EMAIL, "RESTAURANT_OWNER", "device-owner-tbl3");
            Long ownerId = getOwnerIdFromToken(token);
            Restaurant saved = persistRestaurantForOwner("Table Restaurant 3", ownerId);

            mockMvc.perform(post("/api/v1/restaurants/" + saved.getId() + "/tables")
                            .header("Authorization", "Bearer " + token)
                            .contentType(MediaType.APPLICATION_JSON)
                            .content("{\"label\":\"T1\",\"capacity\":0}"))
                    .andExpect(status().isBadRequest());
        }

        @Test
        @DisplayName("403 when restaurant belongs to different owner")
        void should_return403_when_notOwner() throws Exception {
            String ownerToken = getTokenWithRole(OWNER_EMAIL, "RESTAURANT_OWNER", "device-owner-tbl4");
            String otherToken = getTokenWithRole(OTHER_OWNER_EMAIL, "RESTAURANT_OWNER", "device-other-tbl");

            Long ownerId = getOwnerIdFromToken(ownerToken);
            Restaurant saved = persistRestaurantForOwner("Someone Else's Restaurant", ownerId);

            mockMvc.perform(post("/api/v1/restaurants/" + saved.getId() + "/tables")
                            .header("Authorization", "Bearer " + otherToken)
                            .contentType(MediaType.APPLICATION_JSON)
                            .content("{\"label\":\"T1\",\"capacity\":4}"))
                    .andExpect(status().isForbidden());
        }
    }

    // =========================================================================
    // Geospatial endpoints (all-markers, markers-version, nearest) live in
    // RestaurantControllerPostgisIntegrationTest — they depend on PostGIS
    // functions (ST_X / ST_Y / ST_MakePoint / KNN <->) that H2 doesn't
    // implement. Keeping them here would be a guaranteed 500.
    // =========================================================================

    // =========================================================================
    // Helpers
    // =========================================================================

    private Restaurant persistRestaurant(String name) {
        return restaurantRepository.save(Restaurant.builder()
                .name(name)
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
                .build());
    }

    /**
     * Persist a restaurant and attach the given user as its OWNER via
     * restaurant_employee. This mirrors the production path (see
     * {@code RestaurantServiceImpl.createRestaurant}) after the V3 migration
     * removed {@code restaurant.owner_id}.
     */
    private Restaurant persistRestaurantForOwner(String name, Long userId) {
        Restaurant saved = restaurantRepository.save(Restaurant.builder()
                .name(name)
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
                .build());

        var user = userRepository.findById(userId)
                .orElseThrow(() -> new IllegalStateException("Test user " + userId + " not found"));
        restaurantEmployeeRepository.saveAndFlush(RestaurantEmployee.builder()
                .user(user)
                .restaurant(saved)
                .role(RestaurantEmployeeRole.OWNER)
                .build());

        return saved;
    }

    private String validRestaurantJson() {
        return """
                {
                  "name": "Test Restaurant",
                  "cuisineType": "CZECH",
                  "address": {
                    "street": "Testovací ulice",
                    "streetNumber": "1",
                    "city": "Praha"
                  }
                }
                """;
    }

    private String restaurantJsonWithName(String name) {
        return """
                {
                  "name": "%s",
                  "cuisineType": "CZECH",
                  "address": {
                    "street": "Testovací ulice",
                    "streetNumber": "1",
                    "city": "Praha"
                  }
                }
                """.formatted(name);
    }

    private String getTokenWithRole(String email, String roleName, String deviceId) throws Exception {
        createVerifiedUser(email, TEST_PASSWORD, TEST_FIRST_NAME, TEST_LAST_NAME);
        var user = userRepository.findByEmail(email).orElseThrow();
        var role = roleRepository.findByName(roleName).orElseThrow();
        Set<RoleEntity> roles = new HashSet<>(user.getRoles());
        roles.add(role);
        user.setRoles(roles);
        userRepository.saveAndFlush(user);

        MvcResult loginResult = mockMvc.perform(post("/api/auth/login")
                        .contentType(MediaType.APPLICATION_JSON)
                        .content(objectMapper.writeValueAsString(
                                com.checkfood.checkfoodservice.security.module.auth.dto.request.LoginRequest.builder()
                                        .email(email)
                                        .password(TEST_PASSWORD)
                                        .deviceIdentifier(deviceId)
                                        .deviceName(TEST_DEVICE_NAME)
                                        .deviceType(TEST_DEVICE_TYPE)
                                        .build())))
                .andExpect(status().isOk())
                .andReturn();

        JsonNode body = objectMapper.readTree(loginResult.getResponse().getContentAsString());
        return body.get("accessToken").asText();
    }

    /**
     * Resolve the authenticated user's primary-key id from a JWT token by
     * reading the {@code sub} claim (e-mail) and looking up the user record.
     * Mirrors the production path in {@link
     * com.checkfood.checkfoodservice.module.restaurant.controller.RestaurantController#extractUserId
     * RestaurantController.extractUserId}.
     */
    private Long getOwnerIdFromToken(String token) {
        String[] parts = token.split("\\.");
        String payload = new String(java.util.Base64.getUrlDecoder().decode(parts[1]));
        try {
            JsonNode node = objectMapper.readTree(payload);
            String email = node.get("sub").asText();
            return userRepository.findByEmail(email)
                    .orElseThrow(() -> new IllegalStateException("User " + email + " not found in test DB"))
                    .getId();
        } catch (Exception e) {
            throw new RuntimeException("Cannot extract user id from JWT sub claim", e);
        }
    }

    private void ensureRole(String roleName) {
        roleRepository.findByName(roleName).orElseGet(() -> {
            RoleEntity role = new RoleEntity();
            role.setName(roleName);
            return roleRepository.save(role);
        });
    }
}
