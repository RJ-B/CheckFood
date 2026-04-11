package com.checkfood.checkfoodservice.security;

import com.checkfood.checkfoodservice.security.module.auth.dto.request.LogoutRequest;
import com.checkfood.checkfoodservice.security.module.auth.dto.request.RefreshRequest;
import com.fasterxml.jackson.databind.JsonNode;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.springframework.http.MediaType;
import org.springframework.test.web.servlet.MvcResult;

import static org.assertj.core.api.Assertions.assertThat;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.get;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.post;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.jsonPath;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;

/**
 * Integration tests for edge cases and complete authentication flows.
 * Covers the full register-verify-login-refresh-logout lifecycle,
 * multi-device sessions, and malformed request handling.
 */
class AuthEdgeCasesIntegrationTest extends BaseAuthIntegrationTest {

    @Test
    @DisplayName("Full flow: register -> verify -> login -> refresh -> logout")
    void fullFlow_Register_Verify_Login_Refresh_Logout() throws Exception {
        // 1. Register
        registerUser(TEST_EMAIL, TEST_PASSWORD, TEST_FIRST_NAME, TEST_LAST_NAME);

        // 2. Verify
        verifyUser(TEST_EMAIL);

        // 3. Login
        MvcResult loginResult = loginUser(TEST_EMAIL, TEST_PASSWORD, TEST_DEVICE_ID);
        JsonNode loginBody = parseResponseBody(loginResult);

        assertThat(loginBody.get("accessToken").asText()).isNotBlank();
        assertThat(loginBody.get("refreshToken").asText()).isNotBlank();
        assertThat(loginBody.has("user")).isTrue();
        assertThat(loginBody.get("user").get("email").asText()).isEqualTo(TEST_EMAIL);

        String accessToken = loginBody.get("accessToken").asText();
        String refreshToken = loginBody.get("refreshToken").asText();

        // 3a. Verify we can access a protected endpoint
        mockMvc.perform(get("/api/auth/me")
                        .header("Authorization", "Bearer " + accessToken))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.email").value(TEST_EMAIL));

        // 4. Refresh token
        RefreshRequest refreshRequest = RefreshRequest.builder()
                .refreshToken(refreshToken)
                .deviceIdentifier(TEST_DEVICE_ID)
                .build();

        MvcResult refreshResult = mockMvc.perform(post("/api/auth/refresh")
                        .contentType(MediaType.APPLICATION_JSON)
                        .content(objectMapper.writeValueAsString(refreshRequest)))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.accessToken").exists())
                .andExpect(jsonPath("$.refreshToken").exists())
                .andReturn();

        JsonNode refreshBody = parseResponseBody(refreshResult);
        String newAccessToken = refreshBody.get("accessToken").asText();
        String newRefreshToken = refreshBody.get("refreshToken").asText();
        assertThat(newAccessToken).isNotBlank();
        assertThat(newRefreshToken).isNotBlank();

        // 4a. Verify the new access token works
        mockMvc.perform(get("/api/auth/me")
                        .header("Authorization", "Bearer " + newAccessToken))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.email").value(TEST_EMAIL));

        // 5. Logout
        LogoutRequest logoutRequest = LogoutRequest.builder()
                .refreshToken(newRefreshToken)
                .deviceIdentifier(TEST_DEVICE_ID)
                .build();

        mockMvc.perform(post("/api/auth/logout")
                        .header("Authorization", "Bearer " + newAccessToken)
                        .contentType(MediaType.APPLICATION_JSON)
                        .content(objectMapper.writeValueAsString(logoutRequest)))
                .andExpect(status().isNoContent());

        // 5a. Verify the device was deactivated. NB: logout *deactivates*
        // the device row (sets active = false) instead of hard-deleting it
        // — the row is kept for auditing and so refresh-token revocation
        // has something to FK against.
        var user = userRepository.findByEmail(TEST_EMAIL).orElseThrow();
        var devices = deviceRepository.findAllByUser(user);
        assertThat(devices)
                .filteredOn(d -> TEST_DEVICE_ID.equals(d.getDeviceIdentifier()))
                .singleElement()
                .satisfies(d -> assertThat(d.isActive()).isFalse());
    }

    @Test
    @DisplayName("Login from multiple devices creates separate sessions")
    void loginFromMultipleDevices_CreatesSeparateSessions() throws Exception {
        // Arrange: create a verified user
        createVerifiedUser(TEST_EMAIL, TEST_PASSWORD, TEST_FIRST_NAME, TEST_LAST_NAME);

        // Act: login from three different devices
        MvcResult resultA = loginUser(TEST_EMAIL, TEST_PASSWORD, "device-phone");
        MvcResult resultB = loginUser(TEST_EMAIL, TEST_PASSWORD, "device-tablet");
        MvcResult resultC = loginUser(TEST_EMAIL, TEST_PASSWORD, "device-desktop");

        JsonNode bodyA = parseResponseBody(resultA);
        JsonNode bodyB = parseResponseBody(resultB);
        JsonNode bodyC = parseResponseBody(resultC);

        String tokenA = bodyA.get("accessToken").asText();
        String tokenB = bodyB.get("accessToken").asText();
        String tokenC = bodyC.get("accessToken").asText();

        // Assert: each login returns a distinct access token
        assertThat(tokenA).isNotEqualTo(tokenB);
        assertThat(tokenB).isNotEqualTo(tokenC);
        assertThat(tokenA).isNotEqualTo(tokenC);

        // Assert: three device records exist in the database
        var user = userRepository.findByEmail(TEST_EMAIL).orElseThrow();
        var devices = deviceRepository.findAllByUser(user);
        assertThat(devices).hasSize(3);

        // Assert: each device has a distinct identifier
        var identifiers = devices.stream()
                .map(d -> d.getDeviceIdentifier())
                .toList();
        assertThat(identifiers).containsExactlyInAnyOrder("device-phone", "device-tablet", "device-desktop");

        // Assert: all three access tokens are valid for accessing protected endpoints
        for (String token : new String[]{tokenA, tokenB, tokenC}) {
            mockMvc.perform(get("/api/auth/me")
                            .header("Authorization", "Bearer " + token))
                    .andExpect(status().isOk())
                    .andExpect(jsonPath("$.email").value(TEST_EMAIL));
        }
    }

    @Test
    @DisplayName("POST /api/auth/login - invalid JSON body returns 400")
    void invalidJson_Returns400() throws Exception {
        String malformedJson = "{ this is not valid json }";

        mockMvc.perform(post("/api/auth/login")
                        .contentType(MediaType.APPLICATION_JSON)
                        .content(malformedJson))
                .andExpect(status().isBadRequest());
    }
}
