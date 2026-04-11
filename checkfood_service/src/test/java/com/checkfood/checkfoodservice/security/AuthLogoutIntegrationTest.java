package com.checkfood.checkfoodservice.security;

import com.checkfood.checkfoodservice.security.module.auth.dto.request.LogoutRequest;
import com.fasterxml.jackson.databind.JsonNode;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.springframework.http.MediaType;
import org.springframework.test.web.servlet.MvcResult;

import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.post;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;
import static org.assertj.core.api.Assertions.assertThat;

/**
 * Integration tests for logout functionality.
 * Covers single-device logout, graceful handling of invalid device IDs,
 * and bulk logout of all devices.
 */
class AuthLogoutIntegrationTest extends BaseAuthIntegrationTest {

    @Test
    @DisplayName("POST /api/auth/logout - valid refresh token and device returns 204")
    void logout_WithValidTokenAndDevice_Returns204() throws Exception {
        // Arrange: create a verified user and log in to obtain tokens
        createVerifiedUser(TEST_EMAIL, TEST_PASSWORD, TEST_FIRST_NAME, TEST_LAST_NAME);
        MvcResult loginResult = loginUser(TEST_EMAIL, TEST_PASSWORD, TEST_DEVICE_ID);
        JsonNode body = parseResponseBody(loginResult);

        String accessToken = body.get("accessToken").asText();
        String refreshToken = body.get("refreshToken").asText();

        LogoutRequest logoutRequest = LogoutRequest.builder()
                .refreshToken(refreshToken)
                .deviceIdentifier(TEST_DEVICE_ID)
                .build();

        // Act & Assert
        mockMvc.perform(post("/api/auth/logout")
                        .header("Authorization", "Bearer " + accessToken)
                        .contentType(MediaType.APPLICATION_JSON)
                        .content(objectMapper.writeValueAsString(logoutRequest)))
                .andExpect(status().isNoContent());

        // Verify the device record was soft-deleted (isActive=false).
        // deactivateByIdentifierAndUser keeps the row in the DB and just
        // flips the active flag — future refresh attempts are blocked by
        // the rotation table (revoked_at) not by the device record itself.
        var user = userRepository.findByEmail(TEST_EMAIL).orElseThrow();
        var deactivated = deviceRepository
                .findByDeviceIdentifierAndUser(TEST_DEVICE_ID, user)
                .orElseThrow();
        assertThat(deactivated.isActive()).isFalse();
    }

    @Test
    @DisplayName("POST /api/auth/logout - invalid device identifier still succeeds gracefully")
    void logout_WithInvalidDeviceId_StillSucceeds() throws Exception {
        // Arrange: create a verified user and log in
        createVerifiedUser(TEST_EMAIL, TEST_PASSWORD, TEST_FIRST_NAME, TEST_LAST_NAME);
        MvcResult loginResult = loginUser(TEST_EMAIL, TEST_PASSWORD, TEST_DEVICE_ID);
        JsonNode body = parseResponseBody(loginResult);

        String accessToken = body.get("accessToken").asText();
        String refreshToken = body.get("refreshToken").asText();

        // Use a device identifier that does not match any registered device
        LogoutRequest logoutRequest = LogoutRequest.builder()
                .refreshToken(refreshToken)
                .deviceIdentifier("non-existent-device-999")
                .build();

        // Act & Assert: the server should handle this gracefully (204 No Content)
        mockMvc.perform(post("/api/auth/logout")
                        .header("Authorization", "Bearer " + accessToken)
                        .contentType(MediaType.APPLICATION_JSON)
                        .content(objectMapper.writeValueAsString(logoutRequest)))
                .andExpect(status().isNoContent());
    }

    @Test
    @DisplayName("POST /api/user/logout-all - removes all devices and returns 204")
    void logoutAll_RemovesAllDevices() throws Exception {
        // Arrange: create a verified user and log in from two different devices
        createVerifiedUser(TEST_EMAIL, TEST_PASSWORD, TEST_FIRST_NAME, TEST_LAST_NAME);
        loginUser(TEST_EMAIL, TEST_PASSWORD, "device-A");
        MvcResult loginResultB = loginUser(TEST_EMAIL, TEST_PASSWORD, "device-B");
        JsonNode bodyB = parseResponseBody(loginResultB);

        String accessToken = bodyB.get("accessToken").asText();

        // Verify that at least 2 devices exist before logout-all
        var user = userRepository.findByEmail(TEST_EMAIL).orElseThrow();
        var devicesBefore = deviceRepository.findAllByUser(user);
        assertThat(devicesBefore).hasSizeGreaterThanOrEqualTo(2);

        // Act
        mockMvc.perform(post("/api/user/logout-all")
                        .header("Authorization", "Bearer " + accessToken))
                .andExpect(status().isNoContent());

        // Assert: all "other device" rows are deactivated (soft-delete),
        // only the current device (device-B) stays active. The rows
        // themselves remain in the DB so the audit log keeps its history.
        var devicesAfter = deviceRepository.findAllByUser(user);
        long stillActive = devicesAfter.stream().filter(d -> d.isActive()).count();
        assertThat(stillActive).isEqualTo(1);
        var activeOne = devicesAfter.stream().filter(d -> d.isActive()).findFirst().orElseThrow();
        assertThat(activeOne.getDeviceIdentifier()).isEqualTo("device-B");
    }
}
