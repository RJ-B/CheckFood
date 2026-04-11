package com.checkfood.checkfoodservice.module.restaurant.onboarding;

import com.checkfood.checkfoodservice.module.restaurant.entity.common.Address;
import com.checkfood.checkfoodservice.module.restaurant.entity.employee.EmployeePermission;
import com.checkfood.checkfoodservice.module.restaurant.entity.employee.MembershipStatus;
import com.checkfood.checkfoodservice.module.restaurant.entity.employee.RestaurantEmployee;
import com.checkfood.checkfoodservice.module.restaurant.entity.employee.RestaurantEmployeeRole;
import com.checkfood.checkfoodservice.module.restaurant.entity.restaurant.CuisineType;
import com.checkfood.checkfoodservice.module.restaurant.entity.restaurant.Restaurant;
import com.checkfood.checkfoodservice.module.restaurant.entity.restaurant.RestaurantStatus;
import com.checkfood.checkfoodservice.module.restaurant.repository.RestaurantEmployeeRepository;
import com.checkfood.checkfoodservice.module.restaurant.repository.RestaurantRepository;
import com.checkfood.checkfoodservice.security.BaseAuthIntegrationTest;
import com.checkfood.checkfoodservice.security.module.auth.dto.request.LoginRequest;
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
 * Integration tests for OwnerOnboardingController — info, hours, tables, onboarding status, publish.
 */
@Transactional
class OwnerOnboardingControllerIntegrationTest extends BaseAuthIntegrationTest {

    private static final String OWNER_EMAIL = "onboard-owner@checkfood.test";
    private static final String USER_EMAIL  = "onboard-user@checkfood.test";

    @Autowired
    private RestaurantRepository restaurantRepository;

    @Autowired
    private RestaurantEmployeeRepository employeeRepository;

    @BeforeEach
    void ensureOwnerRole() {
        ensureRole("OWNER");
    }

    // =========================================================================
    // GET /api/v1/owner/restaurant/me
    // =========================================================================

    @Nested
    @DisplayName("GET /api/v1/owner/restaurant/me")
    class GetMe {

        @Test
        @DisplayName("401 when unauthenticated")
        void should_return401_when_anonymous() throws Exception {
            mockMvc.perform(get("/api/v1/owner/restaurant/me"))
                    .andExpect(status().isUnauthorized());
        }

        @Test
        @DisplayName("403 when USER role")
        void should_return403_when_regularUser() throws Exception {
            String token = getAccessToken(USER_EMAIL, TEST_PASSWORD, "device-user-onboard");

            mockMvc.perform(get("/api/v1/owner/restaurant/me")
                            .header("Authorization", "Bearer " + token))
                    .andExpect(status().isForbidden());
        }

        @Test
        @DisplayName("404 when owner has no restaurant yet")
        void should_return404_when_ownerHasNoRestaurant() throws Exception {
            String token = getTokenWithRole(OWNER_EMAIL, "OWNER", "device-owner-norest");

            mockMvc.perform(get("/api/v1/owner/restaurant/me")
                            .header("Authorization", "Bearer " + token))
                    .andExpect(status().isNotFound());
        }

        @Test
        @DisplayName("200 when owner has restaurant")
        void should_return200_when_ownerHasRestaurant() throws Exception {
            String token = buildOwnerWithRestaurant(OWNER_EMAIL, "Onboarding Bistro");

            mockMvc.perform(get("/api/v1/owner/restaurant/me")
                            .header("Authorization", "Bearer " + token))
                    .andExpect(status().isOk())
                    .andExpect(jsonPath("$.name").value("Onboarding Bistro"));
        }
    }

    // =========================================================================
    // PUT /api/v1/owner/restaurant/me/info
    // =========================================================================

    @Nested
    @DisplayName("PUT /api/v1/owner/restaurant/me/info")
    class UpdateInfo {

        @Test
        @DisplayName("happy path — owner updates info successfully")
        void should_return200_when_validInfoProvided() throws Exception {
            String token = buildOwnerWithRestaurant(OWNER_EMAIL, "Info Test");

            String json = """
                    {"name":"Updated Bistro","phone":"123456789",
                     "address":{"street":"Main St","city":"Praha"}}
                    """;

            mockMvc.perform(put("/api/v1/owner/restaurant/me/info")
                            .header("Authorization", "Bearer " + token)
                            .contentType(MediaType.APPLICATION_JSON)
                            .content(json))
                    .andExpect(status().isOk())
                    .andExpect(jsonPath("$.name").value("Updated Bistro"));
        }

        @Test
        @DisplayName("400 when name is blank")
        void should_return400_when_nameIsBlank() throws Exception {
            String token = buildOwnerWithRestaurant(OWNER_EMAIL, "Blank Name Test");

            mockMvc.perform(put("/api/v1/owner/restaurant/me/info")
                            .header("Authorization", "Bearer " + token)
                            .contentType(MediaType.APPLICATION_JSON)
                            .content("{\"name\":\"\"}"))
                    .andExpect(status().isBadRequest());
        }

        @Test
        @DisplayName("400 when email field is not valid email format")
        void should_return400_when_emailInvalid() throws Exception {
            String token = buildOwnerWithRestaurant(OWNER_EMAIL, "Email Invalid Test");

            mockMvc.perform(put("/api/v1/owner/restaurant/me/info")
                            .header("Authorization", "Bearer " + token)
                            .contentType(MediaType.APPLICATION_JSON)
                            .content("{\"name\":\"Valid\",\"email\":\"notvalid\"}"))
                    .andExpect(status().isBadRequest());
        }

        @Test
        @DisplayName("400 when name exceeds 150 characters")
        void should_return400_when_nameTooLong() throws Exception {
            String token = buildOwnerWithRestaurant(OWNER_EMAIL, "LongName Test");

            mockMvc.perform(put("/api/v1/owner/restaurant/me/info")
                            .header("Authorization", "Bearer " + token)
                            .contentType(MediaType.APPLICATION_JSON)
                            .content("{\"name\":\"" + "A".repeat(151) + "\"}"))
                    .andExpect(status().isBadRequest());
        }

        @Test
        @DisplayName("400 when phone exceeds 20 characters")
        void should_return400_when_phoneTooLong() throws Exception {
            String token = buildOwnerWithRestaurant(OWNER_EMAIL, "Phone Test");

            mockMvc.perform(put("/api/v1/owner/restaurant/me/info")
                            .header("Authorization", "Bearer " + token)
                            .contentType(MediaType.APPLICATION_JSON)
                            .content("{\"name\":\"Valid\",\"phone\":\"" + "1".repeat(21) + "\"}"))
                    .andExpect(status().isBadRequest());
        }

        @Test
        @DisplayName("persistence round-trip — updated name is saved to DB")
        void should_persistUpdatedName() throws Exception {
            String token = buildOwnerWithRestaurant(OWNER_EMAIL, "Persist Test");
            var user = userRepository.findByEmail(OWNER_EMAIL).orElseThrow();
            var membership = employeeRepository.findFirstByUserIdAndRole(user.getId(), RestaurantEmployeeRole.OWNER).orElseThrow();
            UUID restaurantId = membership.getRestaurant().getId();

            mockMvc.perform(put("/api/v1/owner/restaurant/me/info")
                            .header("Authorization", "Bearer " + token)
                            .contentType(MediaType.APPLICATION_JSON)
                            .content("{\"name\":\"Persisted Name\"}"))
                    .andExpect(status().isOk());

            assertThat(restaurantRepository.findById(restaurantId).get().getName())
                    .isEqualTo("Persisted Name");
        }
    }

    // =========================================================================
    // PUT /api/v1/owner/restaurant/me/hours
    // =========================================================================

    @Nested
    @DisplayName("PUT /api/v1/owner/restaurant/me/hours")
    class UpdateHours {

        @Test
        @DisplayName("happy path — valid opening hours are saved")
        void should_return200_when_hoursProvided() throws Exception {
            String token = buildOwnerWithRestaurant(OWNER_EMAIL, "Hours Test");

            String json = """
                    {"openingHours":[
                        {"dayOfWeek":"MONDAY","openAt":"09:00","closeAt":"22:00","closed":false}
                    ]}
                    """;

            mockMvc.perform(put("/api/v1/owner/restaurant/me/hours")
                            .header("Authorization", "Bearer " + token)
                            .contentType(MediaType.APPLICATION_JSON)
                            .content(json))
                    .andExpect(status().isOk());
        }

        @Test
        @DisplayName("400 when openingHours list is empty")
        void should_return400_when_openingHoursEmpty() throws Exception {
            String token = buildOwnerWithRestaurant(OWNER_EMAIL, "Empty Hours Test");

            mockMvc.perform(put("/api/v1/owner/restaurant/me/hours")
                            .header("Authorization", "Bearer " + token)
                            .contentType(MediaType.APPLICATION_JSON)
                            .content("{\"openingHours\":[]}"))
                    .andExpect(status().isBadRequest());
        }
    }

    // =========================================================================
    // Table management: POST, PUT, DELETE /api/v1/owner/restaurant/me/tables
    // =========================================================================

    @Nested
    @DisplayName("Table management")
    class TableManagement {

        @Test
        @DisplayName("GET /me/tables — returns empty list initially")
        void should_returnEmptyList_when_noTables() throws Exception {
            String token = buildOwnerWithRestaurant(OWNER_EMAIL, "Table List Test");

            mockMvc.perform(get("/api/v1/owner/restaurant/me/tables")
                            .header("Authorization", "Bearer " + token))
                    .andExpect(status().isOk())
                    .andExpect(jsonPath("$").isArray())
                    .andExpect(jsonPath("$").isEmpty());
        }

        @Test
        @DisplayName("POST /me/tables — happy path adds table")
        void should_return200_when_tableAdded() throws Exception {
            String token = buildOwnerWithRestaurant(OWNER_EMAIL, "Add Table Test");

            mockMvc.perform(post("/api/v1/owner/restaurant/me/tables")
                            .header("Authorization", "Bearer " + token)
                            .contentType(MediaType.APPLICATION_JSON)
                            .content("{\"label\":\"T1\",\"capacity\":4,\"active\":true}"))
                    .andExpect(status().isOk())
                    .andExpect(jsonPath("$.label").value("T1"));
        }

        @Test
        @DisplayName("POST /me/tables — 400 when label is blank")
        void should_return400_when_tableLabelBlank() throws Exception {
            String token = buildOwnerWithRestaurant(OWNER_EMAIL, "Blank Label Test");

            mockMvc.perform(post("/api/v1/owner/restaurant/me/tables")
                            .header("Authorization", "Bearer " + token)
                            .contentType(MediaType.APPLICATION_JSON)
                            .content("{\"label\":\"\",\"capacity\":4}"))
                    .andExpect(status().isBadRequest());
        }

        @Test
        @DisplayName("POST /me/tables — 400 when capacity is 0")
        void should_return400_when_tableCapacityZero() throws Exception {
            String token = buildOwnerWithRestaurant(OWNER_EMAIL, "Zero Cap Test");

            mockMvc.perform(post("/api/v1/owner/restaurant/me/tables")
                            .header("Authorization", "Bearer " + token)
                            .contentType(MediaType.APPLICATION_JSON)
                            .content("{\"label\":\"T1\",\"capacity\":0}"))
                    .andExpect(status().isBadRequest());
        }

        @Test
        @DisplayName("DELETE /me/tables/{id} — 404 when table does not exist")
        void should_return404_when_tableNotFound() throws Exception {
            String token = buildOwnerWithRestaurant(OWNER_EMAIL, "Table 404 Test");

            mockMvc.perform(delete("/api/v1/owner/restaurant/me/tables/" + UUID.randomUUID())
                            .header("Authorization", "Bearer " + token))
                    .andExpect(status().isNotFound());
        }

        @Test
        @DisplayName("PUT /me/tables/{id} — 404 when table does not exist")
        void should_return404_when_tableUpdateNotFound() throws Exception {
            String token = buildOwnerWithRestaurant(OWNER_EMAIL, "Table Update 404");

            mockMvc.perform(put("/api/v1/owner/restaurant/me/tables/" + UUID.randomUUID())
                            .header("Authorization", "Bearer " + token)
                            .contentType(MediaType.APPLICATION_JSON)
                            .content("{\"label\":\"T1\",\"capacity\":4}"))
                    .andExpect(status().isNotFound());
        }
    }

    // =========================================================================
    // GET /api/v1/owner/restaurant/me/onboarding-status
    // =========================================================================

    @Test
    @DisplayName("GET /me/onboarding-status — returns structured status")
    void should_returnOnboardingStatus_when_ownerAuthenticated() throws Exception {
        String token = buildOwnerWithRestaurant(OWNER_EMAIL, "Onboarding Status Test");

        mockMvc.perform(get("/api/v1/owner/restaurant/me/onboarding-status")
                        .header("Authorization", "Bearer " + token))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.onboardingCompleted").exists())
                .andExpect(jsonPath("$.hasInfo").exists())
                .andExpect(jsonPath("$.hasHours").exists())
                .andExpect(jsonPath("$.hasTables").exists())
                .andExpect(jsonPath("$.hasMenu").exists());
    }

    // =========================================================================
    // POST /api/v1/owner/restaurant/me/publish
    // =========================================================================

    @Nested
    @DisplayName("POST /api/v1/owner/restaurant/me/publish")
    class Publish {

        @Test
        @DisplayName("400 when restaurant is incomplete (no opening hours)")
        void should_return400_when_noOpeningHours() throws Exception {
            String token = buildOwnerWithRestaurant(OWNER_EMAIL, "Publish Incomplete Test");

            // Restaurant exists but has no hours → publish must fail
            mockMvc.perform(post("/api/v1/owner/restaurant/me/publish")
                            .header("Authorization", "Bearer " + token))
                    .andExpect(status().isBadRequest());
        }

        // GAP: publish with all onboarding steps completed should succeed → production code
        // requires hours + tables + menu — add a full happy path test once seeding helpers exist
    }

    // =========================================================================
    // Helpers
    // =========================================================================

    private String buildOwnerWithRestaurant(String email, String restaurantName) throws Exception {
        createVerifiedUser(email, TEST_PASSWORD, TEST_FIRST_NAME, TEST_LAST_NAME);
        var user = userRepository.findByEmail(email).orElseThrow();
        var role = roleRepository.findByName("OWNER").orElseThrow();
        Set<RoleEntity> roles = new HashSet<>(user.getRoles());
        roles.add(role);
        user.setRoles(roles);
        userRepository.saveAndFlush(user);

        Restaurant restaurant = restaurantRepository.save(Restaurant.builder()
                .name(restaurantName)
                .cuisineType(CuisineType.CZECH)
                .status(RestaurantStatus.PENDING)
                .active(false)
                .address(Address.builder()
                        .street("Testovací")
                        .streetNumber("1")
                        .city("Praha")
                        .postalCode("11000")
                        .country("CZ")
                        .build())
                .build());

        RestaurantEmployee ownership = RestaurantEmployee.builder()
                .user(user)
                .restaurant(restaurant)
                .role(RestaurantEmployeeRole.OWNER)
                .membershipStatus(MembershipStatus.ACTIVE)
                .permissions(EmployeePermission.defaultsForRole(RestaurantEmployeeRole.OWNER))
                .build();
        employeeRepository.save(ownership);

        return loginAndGetToken(email, "device-onboard-" + email.hashCode());
    }

    private String loginAndGetToken(String email, String deviceId) throws Exception {
        MvcResult result = mockMvc.perform(post("/api/auth/login")
                        .contentType(MediaType.APPLICATION_JSON)
                        .content(objectMapper.writeValueAsString(
                                LoginRequest.builder()
                                        .email(email)
                                        .password(TEST_PASSWORD)
                                        .deviceIdentifier(deviceId)
                                        .deviceName(TEST_DEVICE_NAME)
                                        .deviceType(TEST_DEVICE_TYPE)
                                        .build())))
                .andExpect(status().isOk())
                .andReturn();
        return objectMapper.readTree(result.getResponse().getContentAsString()).get("accessToken").asText();
    }

    private String getTokenWithRole(String email, String roleName, String deviceId) throws Exception {
        createVerifiedUser(email, TEST_PASSWORD, TEST_FIRST_NAME, TEST_LAST_NAME);
        var user = userRepository.findByEmail(email).orElseThrow();
        var role = roleRepository.findByName(roleName).orElseThrow();
        Set<RoleEntity> roles = new HashSet<>(user.getRoles());
        roles.add(role);
        user.setRoles(roles);
        userRepository.saveAndFlush(user);
        return loginAndGetToken(email, deviceId);
    }

    private void ensureRole(String roleName) {
        roleRepository.findByName(roleName).orElseGet(() -> {
            RoleEntity r = new RoleEntity();
            r.setName(roleName);
            return roleRepository.save(r);
        });
    }
}
