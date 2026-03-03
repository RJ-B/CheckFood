package com.checkfood.checkfoodservice.module.restaurant;

import com.checkfood.checkfoodservice.security.BaseAuthIntegrationTest;
import com.checkfood.checkfoodservice.security.module.auth.dto.request.LoginRequest;
import com.checkfood.checkfoodservice.security.module.user.entity.RoleEntity;
import com.fasterxml.jackson.databind.JsonNode;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.springframework.http.MediaType;
import org.springframework.test.web.servlet.MvcResult;
import org.springframework.transaction.annotation.Transactional;

import java.util.HashSet;
import java.util.Set;

import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.*;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;

@Transactional
class MyRestaurantAuthorizationTest extends BaseAuthIntegrationTest {

    private static final String OWNER_EMAIL = "owner@checkfood.test";
    private static final String MANAGER_EMAIL = "manager@checkfood.test";
    private static final String REGULAR_EMAIL = "regular@checkfood.test";

    @BeforeEach
    void setUpRoles() {
        ensureRoleExists("OWNER");
        ensureRoleExists("MANAGER");
    }

    // --- Authorization Tests ---

    @Test
    @DisplayName("GET /api/my-restaurant - regular USER gets 403")
    void getMyRestaurant_WithUserRole_Returns403() throws Exception {
        String token = getAccessToken(REGULAR_EMAIL, TEST_PASSWORD, "device-regular");

        mockMvc.perform(get("/api/my-restaurant")
                        .header("Authorization", "Bearer " + token))
                .andExpect(status().isForbidden());
    }

    @Test
    @DisplayName("GET /api/my-restaurant - OWNER role gets through auth (may 404 if no restaurant)")
    void getMyRestaurant_WithOwnerRole_PassesAuth() throws Exception {
        String token = getTokenWithRole(OWNER_EMAIL, "OWNER", "device-owner");

        mockMvc.perform(get("/api/my-restaurant")
                        .header("Authorization", "Bearer " + token))
                .andExpect(status().isNotFound()); // No restaurant assigned yet, but auth passed
    }

    @Test
    @DisplayName("GET /api/my-restaurant - MANAGER role gets through auth")
    void getMyRestaurant_WithManagerRole_PassesAuth() throws Exception {
        String token = getTokenWithRole(MANAGER_EMAIL, "MANAGER", "device-manager");

        mockMvc.perform(get("/api/my-restaurant")
                        .header("Authorization", "Bearer " + token))
                .andExpect(status().isNotFound()); // No restaurant assigned yet, but auth passed
    }

    @Test
    @DisplayName("POST /api/my-restaurant/employees - MANAGER gets 403 (only OWNER can add)")
    void addEmployee_WithManagerRole_Returns403() throws Exception {
        String token = getTokenWithRole(MANAGER_EMAIL, "MANAGER", "device-manager-2");

        String requestBody = """
                {"email": "new@employee.com", "role": "STAFF"}
                """;

        mockMvc.perform(post("/api/my-restaurant/employees")
                        .header("Authorization", "Bearer " + token)
                        .contentType(MediaType.APPLICATION_JSON)
                        .content(requestBody))
                .andExpect(status().isForbidden());
    }

    @Test
    @DisplayName("DELETE /api/my-restaurant/employees/1 - MANAGER gets 403 (only OWNER can delete)")
    void removeEmployee_WithManagerRole_Returns403() throws Exception {
        String token = getTokenWithRole(MANAGER_EMAIL, "MANAGER", "device-manager-3");

        mockMvc.perform(delete("/api/my-restaurant/employees/1")
                        .header("Authorization", "Bearer " + token))
                .andExpect(status().isForbidden());
    }

    @Test
    @DisplayName("PUT /api/my-restaurant/employees/1 - MANAGER gets 403 (only OWNER can change roles)")
    void updateEmployeeRole_WithManagerRole_Returns403() throws Exception {
        String token = getTokenWithRole(MANAGER_EMAIL, "MANAGER", "device-manager-4");

        String requestBody = """
                {"role": "STAFF"}
                """;

        mockMvc.perform(put("/api/my-restaurant/employees/1")
                        .header("Authorization", "Bearer " + token)
                        .contentType(MediaType.APPLICATION_JSON)
                        .content(requestBody))
                .andExpect(status().isForbidden());
    }

    @Test
    @DisplayName("GET /api/my-restaurant - without token returns 401")
    void getMyRestaurant_WithoutToken_Returns401() throws Exception {
        mockMvc.perform(get("/api/my-restaurant"))
                .andExpect(status().isUnauthorized());
    }

    // --- Helper Methods ---

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
                                LoginRequest.builder()
                                        .email(email)
                                        .password(TEST_PASSWORD)
                                        .deviceIdentifier(deviceId)
                                        .deviceName(TEST_DEVICE_NAME)
                                        .deviceType(TEST_DEVICE_TYPE)
                                        .build())))
                .andExpect(status().isOk())
                .andReturn();

        JsonNode body = parseResponseBody(loginResult);
        return body.get("accessToken").asText();
    }

    private void ensureRoleExists(String roleName) {
        roleRepository.findByName(roleName).orElseGet(() -> {
            RoleEntity role = new RoleEntity();
            role.setName(roleName);
            return roleRepository.save(role);
        });
    }
}
