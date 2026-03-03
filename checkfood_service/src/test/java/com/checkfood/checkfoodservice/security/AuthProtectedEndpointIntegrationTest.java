package com.checkfood.checkfoodservice.security;

import com.checkfood.checkfoodservice.security.module.auth.dto.request.LoginRequest;
import com.fasterxml.jackson.databind.JsonNode;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.springframework.http.MediaType;
import org.springframework.test.web.servlet.MvcResult;
import org.springframework.transaction.annotation.Transactional;

import java.util.HashSet;
import java.util.Set;

import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.get;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.post;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.jsonPath;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;

/**
 * Integration tests for protected endpoint access control.
 * Verifies that unauthenticated requests are rejected, valid tokens grant access,
 * malformed tokens are rejected, and role-based authorization works correctly.
 */
class AuthProtectedEndpointIntegrationTest extends BaseAuthIntegrationTest {

    private static final String ADMIN_EMAIL = "admin@checkfood.com";

    @Test
    @DisplayName("GET /api/user/me - without token returns 401")
    void accessUserMe_WithoutToken_Returns401() throws Exception {
        mockMvc.perform(get("/api/user/me"))
                .andExpect(status().isUnauthorized());
    }

    @Test
    @DisplayName("GET /api/user/me - with valid token returns 200 and profile data")
    void accessUserMe_WithValidToken_Returns200() throws Exception {
        String accessToken = getAccessToken(TEST_EMAIL, TEST_PASSWORD, TEST_DEVICE_ID);

        mockMvc.perform(get("/api/user/me")
                        .header("Authorization", "Bearer " + accessToken))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.email").value(TEST_EMAIL))
                .andExpect(jsonPath("$.firstName").value(TEST_FIRST_NAME))
                .andExpect(jsonPath("$.lastName").value(TEST_LAST_NAME));
    }

    @Test
    @DisplayName("GET /api/user/me - with garbled/malformed token returns 401")
    void accessUserMe_WithMalformedToken_Returns401() throws Exception {
        mockMvc.perform(get("/api/user/me")
                        .header("Authorization", "Bearer this.is.not.a.valid.jwt.token"))
                .andExpect(status().isUnauthorized());
    }

    @Test
    @DisplayName("GET /api/auth/me - with valid token returns 200 and user identity")
    void accessAuthMe_WithValidToken_Returns200() throws Exception {
        String accessToken = getAccessToken(TEST_EMAIL, TEST_PASSWORD, TEST_DEVICE_ID);

        mockMvc.perform(get("/api/auth/me")
                        .header("Authorization", "Bearer " + accessToken))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.email").value(TEST_EMAIL));
    }

    @Test
    @DisplayName("GET /api/user - user with USER role gets 403 Forbidden on admin endpoint")
    void accessAdminEndpoint_WithUserRole_Returns403() throws Exception {
        String accessToken = getAccessToken(TEST_EMAIL, TEST_PASSWORD, TEST_DEVICE_ID);

        mockMvc.perform(get("/api/user")
                        .header("Authorization", "Bearer " + accessToken))
                .andExpect(status().isForbidden());
    }

    @Test
    @Transactional
    @DisplayName("GET /api/user - user with ADMIN role gets 200 on admin endpoint")
    void accessAdminEndpoint_WithAdminRole_Returns200() throws Exception {
        // Arrange: register, verify, and elevate to ADMIN within a transaction
        registerUser(ADMIN_EMAIL, TEST_PASSWORD, "Admin", "User");
        verifyUser(ADMIN_EMAIL);

        var user = userRepository.findByEmail(ADMIN_EMAIL).orElseThrow();
        var adminRole = roleRepository.findByName("ADMIN").orElseThrow();
        // Set roles explicitly to avoid LazyInitializationException
        Set<com.checkfood.checkfoodservice.security.module.user.entity.RoleEntity> roles = new HashSet<>(user.getRoles());
        roles.add(adminRole);
        user.setRoles(roles);
        userRepository.saveAndFlush(user);

        // Login to get a token that reflects the ADMIN role
        MvcResult loginResult = mockMvc.perform(post("/api/auth/login")
                        .contentType(MediaType.APPLICATION_JSON)
                        .content(objectMapper.writeValueAsString(
                                LoginRequest.builder()
                                        .email(ADMIN_EMAIL)
                                        .password(TEST_PASSWORD)
                                        .deviceIdentifier(TEST_DEVICE_ID)
                                        .deviceName(TEST_DEVICE_NAME)
                                        .deviceType(TEST_DEVICE_TYPE)
                                        .build())))
                .andExpect(status().isOk())
                .andReturn();

        JsonNode body = parseResponseBody(loginResult);
        String accessToken = body.get("accessToken").asText();

        // Act & Assert
        mockMvc.perform(get("/api/user")
                        .header("Authorization", "Bearer " + accessToken))
                .andExpect(status().isOk());
    }

    @Test
    @DisplayName("POST /api/user/assign-role - user with USER role gets 403")
    void assignRole_WithUserRole_Returns403() throws Exception {
        String accessToken = getAccessToken(TEST_EMAIL, TEST_PASSWORD, TEST_DEVICE_ID);

        String requestBody = objectMapper.writeValueAsString(
                java.util.Map.of("userId", 1, "roleName", "ADMIN")
        );

        mockMvc.perform(post("/api/user/assign-role")
                        .header("Authorization", "Bearer " + accessToken)
                        .contentType("application/json")
                        .content(requestBody))
                .andExpect(status().isForbidden());
    }
}
