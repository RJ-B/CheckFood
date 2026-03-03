package com.checkfood.checkfoodservice.security;

import com.checkfood.checkfoodservice.security.module.auth.dto.request.LoginRequest;
import com.fasterxml.jackson.databind.JsonNode;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.springframework.http.MediaType;
import org.springframework.test.web.servlet.MvcResult;

import static org.assertj.core.api.Assertions.assertThat;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.post;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;

/**
 * Integration tests for the login flow (POST /api/auth/login).
 */
class AuthLoginIntegrationTest extends BaseAuthIntegrationTest {

    @Test
    @DisplayName("Login with valid credentials returns tokens and user info")
    void login_ValidCredentials_ReturnsTokens() throws Exception {
        createVerifiedUser(TEST_EMAIL, TEST_PASSWORD, TEST_FIRST_NAME, TEST_LAST_NAME);

        MvcResult result = loginUser(TEST_EMAIL, TEST_PASSWORD, TEST_DEVICE_ID);
        assertThat(result.getResponse().getStatus()).isEqualTo(200);

        JsonNode body = parseResponseBody(result);
        assertThat(body.has("accessToken")).isTrue();
        assertThat(body.has("refreshToken")).isTrue();
        assertThat(body.get("accessToken").asText()).isNotBlank();
        assertThat(body.get("refreshToken").asText()).isNotBlank();
        assertThat(body.has("expiresIn")).isTrue();
        assertThat(body.get("tokenType").asText()).isEqualTo("Bearer");

        // User info present
        assertThat(body.has("user")).isTrue();
        assertThat(body.get("user").get("email").asText()).isEqualTo(TEST_EMAIL);
    }

    @Test
    @DisplayName("Login with wrong password returns 401")
    void login_WrongPassword_Returns401() throws Exception {
        createVerifiedUser(TEST_EMAIL, TEST_PASSWORD, TEST_FIRST_NAME, TEST_LAST_NAME);

        LoginRequest request = LoginRequest.builder()
                .email(TEST_EMAIL)
                .password("WrongPass1!")
                .deviceIdentifier(TEST_DEVICE_ID)
                .deviceName(TEST_DEVICE_NAME)
                .deviceType(TEST_DEVICE_TYPE)
                .build();

        mockMvc.perform(post("/api/auth/login")
                        .contentType(MediaType.APPLICATION_JSON)
                        .content(objectMapper.writeValueAsString(request)))
                .andExpect(status().isUnauthorized());
    }

    @Test
    @DisplayName("Login with non-existent user returns 401")
    void login_NonExistentUser_Returns401() throws Exception {
        LoginRequest request = LoginRequest.builder()
                .email("nobody@checkfood.test")
                .password(TEST_PASSWORD)
                .deviceIdentifier(TEST_DEVICE_ID)
                .deviceName(TEST_DEVICE_NAME)
                .deviceType(TEST_DEVICE_TYPE)
                .build();

        mockMvc.perform(post("/api/auth/login")
                        .contentType(MediaType.APPLICATION_JSON)
                        .content(objectMapper.writeValueAsString(request)))
                .andExpect(status().isUnauthorized());
    }

    @Test
    @DisplayName("Login with unverified account returns 403")
    void login_UnverifiedAccount_Returns403() throws Exception {
        // Register but do NOT verify
        registerUser(TEST_EMAIL, TEST_PASSWORD, TEST_FIRST_NAME, TEST_LAST_NAME);

        LoginRequest request = LoginRequest.builder()
                .email(TEST_EMAIL)
                .password(TEST_PASSWORD)
                .deviceIdentifier(TEST_DEVICE_ID)
                .deviceName(TEST_DEVICE_NAME)
                .deviceType(TEST_DEVICE_TYPE)
                .build();

        mockMvc.perform(post("/api/auth/login")
                        .contentType(MediaType.APPLICATION_JSON)
                        .content(objectMapper.writeValueAsString(request)))
                .andExpect(status().isForbidden());
    }

    @Test
    @DisplayName("Login with device info stores device in database")
    void login_WithDeviceInfo_StoresDevice() throws Exception {
        createVerifiedUser(TEST_EMAIL, TEST_PASSWORD, TEST_FIRST_NAME, TEST_LAST_NAME);

        String deviceId = "unique-device-xyz";
        loginUser(TEST_EMAIL, TEST_PASSWORD, deviceId);

        var user = userRepository.findByEmail(TEST_EMAIL).orElseThrow();
        var devices = deviceRepository.findAllByUser(user);
        assertThat(devices).hasSize(1);
        assertThat(devices.get(0).getDeviceIdentifier()).isEqualTo(deviceId);
    }
}
