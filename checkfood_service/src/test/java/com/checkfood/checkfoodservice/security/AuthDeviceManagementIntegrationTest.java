package com.checkfood.checkfoodservice.security;

import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;

import static org.hamcrest.Matchers.greaterThanOrEqualTo;
import static org.hamcrest.Matchers.hasSize;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.delete;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.get;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.jsonPath;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;

/**
 * Integration tests for device management endpoints.
 * Covers listing devices after login, removing an owned device,
 * and attempting to remove a non-existent device.
 */
class AuthDeviceManagementIntegrationTest extends BaseAuthIntegrationTest {

    @Test
    @DisplayName("GET /api/user/devices - after login shows at least one device")
    void getDevices_AfterLogin_ShowsDevice() throws Exception {
        // Arrange: create a verified user and log in (which registers a device)
        createVerifiedUser(TEST_EMAIL, TEST_PASSWORD, TEST_FIRST_NAME, TEST_LAST_NAME);
        String accessToken = getAccessToken(TEST_EMAIL, TEST_PASSWORD, TEST_DEVICE_ID);

        // Act & Assert: the devices endpoint requires the Authorization header
        // for determining the current device
        mockMvc.perform(get("/api/user/devices")
                        .header("Authorization", "Bearer " + accessToken))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$", hasSize(greaterThanOrEqualTo(1))))
                .andExpect(jsonPath("$[0].deviceIdentifier").exists());
    }

    @Test
    @DisplayName("DELETE /api/user/devices/{id} - removing own device returns 204")
    void logoutDevice_OwnDevice_Returns204() throws Exception {
        // Arrange: create a verified user and log in to create a device record
        createVerifiedUser(TEST_EMAIL, TEST_PASSWORD, TEST_FIRST_NAME, TEST_LAST_NAME);
        String accessToken = getAccessToken(TEST_EMAIL, TEST_PASSWORD, TEST_DEVICE_ID);

        // Find the device ID from the database
        var user = userRepository.findByEmail(TEST_EMAIL).orElseThrow();
        var devices = deviceRepository.findAllByUser(user);
        Long deviceId = devices.get(0).getId();

        // Act & Assert
        mockMvc.perform(delete("/api/user/devices/" + deviceId)
                        .header("Authorization", "Bearer " + accessToken))
                .andExpect(status().isNoContent());
    }

    @Test
    @DisplayName("DELETE /api/user/devices/{id} - non-existent device returns 400")
    void logoutDevice_NonExistentDevice_Returns400() throws Exception {
        // Arrange: create a verified user and log in
        createVerifiedUser(TEST_EMAIL, TEST_PASSWORD, TEST_FIRST_NAME, TEST_LAST_NAME);
        String accessToken = getAccessToken(TEST_EMAIL, TEST_PASSWORD, TEST_DEVICE_ID);

        // Use an ID that definitely does not exist
        long nonExistentDeviceId = 999999L;

        // Act & Assert: DeviceServiceImpl.removeByIdAndUser throws UserException
        // with HttpStatus.BAD_REQUEST when the device is not found
        mockMvc.perform(delete("/api/user/devices/" + nonExistentDeviceId)
                        .header("Authorization", "Bearer " + accessToken))
                .andExpect(status().isBadRequest());
    }
}
