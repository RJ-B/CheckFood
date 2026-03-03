package com.checkfood.checkfoodservice.security;

import com.checkfood.checkfoodservice.security.module.auth.dto.request.LoginRequest;
import com.checkfood.checkfoodservice.security.module.auth.dto.request.RefreshRequest;
import com.fasterxml.jackson.databind.JsonNode;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.springframework.http.MediaType;
import org.springframework.test.web.servlet.MvcResult;

import static org.assertj.core.api.Assertions.assertThat;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.post;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;

/**
 * Integration tests for the refresh token flow (POST /api/auth/refresh).
 */
class AuthRefreshTokenIntegrationTest extends BaseAuthIntegrationTest {

    private String accessToken;
    private String refreshToken;

    @BeforeEach
    void loginTestUser() throws Exception {
        createVerifiedUser(TEST_EMAIL, TEST_PASSWORD, TEST_FIRST_NAME, TEST_LAST_NAME);

        MvcResult loginResult = mockMvc.perform(post("/api/auth/login")
                        .contentType(MediaType.APPLICATION_JSON)
                        .content(objectMapper.writeValueAsString(
                                LoginRequest.builder()
                                        .email(TEST_EMAIL)
                                        .password(TEST_PASSWORD)
                                        .deviceIdentifier(TEST_DEVICE_ID)
                                        .deviceName(TEST_DEVICE_NAME)
                                        .deviceType(TEST_DEVICE_TYPE)
                                        .build())))
                .andExpect(status().isOk())
                .andReturn();

        JsonNode body = parseResponseBody(loginResult);
        accessToken = body.get("accessToken").asText();
        refreshToken = body.get("refreshToken").asText();
    }

    @Test
    @DisplayName("Valid refresh token returns new token pair")
    void refreshToken_ValidRefresh_ReturnsNewTokens() throws Exception {
        RefreshRequest request = RefreshRequest.builder()
                .refreshToken(refreshToken)
                .deviceIdentifier(TEST_DEVICE_ID)
                .build();

        MvcResult result = mockMvc.perform(post("/api/auth/refresh")
                        .contentType(MediaType.APPLICATION_JSON)
                        .content(objectMapper.writeValueAsString(request)))
                .andExpect(status().isOk())
                .andReturn();

        JsonNode body = parseResponseBody(result);
        assertThat(body.get("accessToken").asText()).isNotBlank();
        assertThat(body.get("refreshToken").asText()).isNotBlank();
    }

    @Test
    @DisplayName("Using access token as refresh token returns 401")
    void refreshToken_AccessTokenAsRefresh_ReturnsError() throws Exception {
        RefreshRequest request = RefreshRequest.builder()
                .refreshToken(accessToken)
                .deviceIdentifier(TEST_DEVICE_ID)
                .build();

        mockMvc.perform(post("/api/auth/refresh")
                        .contentType(MediaType.APPLICATION_JSON)
                        .content(objectMapper.writeValueAsString(request)))
                .andExpect(status().isUnauthorized());
    }

    @Test
    @DisplayName("Refresh with device mismatch returns 401")
    void refreshToken_DeviceMismatch_Returns401() throws Exception {
        RefreshRequest request = RefreshRequest.builder()
                .refreshToken(refreshToken)
                .deviceIdentifier("different-device-999")
                .build();

        mockMvc.perform(post("/api/auth/refresh")
                        .contentType(MediaType.APPLICATION_JSON)
                        .content(objectMapper.writeValueAsString(request)))
                .andExpect(status().isUnauthorized());
    }

    @Test
    @DisplayName("Refresh with invalid/garbage token returns 401")
    void refreshToken_InvalidToken_ReturnsError() throws Exception {
        RefreshRequest request = RefreshRequest.builder()
                .refreshToken("this-is-not-a-valid-jwt-token")
                .deviceIdentifier(TEST_DEVICE_ID)
                .build();

        mockMvc.perform(post("/api/auth/refresh")
                        .contentType(MediaType.APPLICATION_JSON)
                        .content(objectMapper.writeValueAsString(request)))
                .andExpect(status().isUnauthorized());
    }
}
