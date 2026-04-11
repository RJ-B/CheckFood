package com.checkfood.checkfoodservice.security.module.user;

import com.checkfood.checkfoodservice.security.BaseAuthIntegrationTest;
import com.checkfood.checkfoodservice.security.module.user.dto.request.AssignRoleRequest;
import com.checkfood.checkfoodservice.security.module.user.dto.request.ChangePasswordRequest;
import com.checkfood.checkfoodservice.security.module.user.dto.request.UpdateNotificationRequest;
import com.checkfood.checkfoodservice.security.module.user.dto.request.UpdateProfileRequest;
import com.checkfood.checkfoodservice.security.module.user.entity.RoleEntity;
import com.checkfood.checkfoodservice.security.module.user.entity.UserEntity;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.springframework.http.MediaType;

import java.util.HashSet;

import static org.assertj.core.api.Assertions.assertThat;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.*;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.*;

@DisplayName("UserController integration tests")
class UserProfileIntegrationTest extends BaseAuthIntegrationTest {

    // =========================================================================
    // GET /api/user/me
    // =========================================================================

    @Test
    @DisplayName("GET /me — authenticated user returns profile")
    void should_returnProfile_when_authenticated() throws Exception {
        String token = getAccessToken(TEST_EMAIL, TEST_PASSWORD, TEST_DEVICE_ID);

        mockMvc.perform(get("/api/user/me")
                        .header("Authorization", "Bearer " + token))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.email").value(TEST_EMAIL))
                .andExpect(jsonPath("$.firstName").value(TEST_FIRST_NAME));
    }

    @Test
    @DisplayName("GET /me — anonymous → 401")
    void should_return401_when_getMe_anonymous() throws Exception {
        mockMvc.perform(get("/api/user/me"))
                .andExpect(status().isUnauthorized());
    }

    // =========================================================================
    // PATCH /api/user/profile
    // =========================================================================

    @Test
    @DisplayName("PATCH /profile — valid update returns updated profile")
    void should_updateProfile_when_validRequest() throws Exception {
        String token = getAccessToken(TEST_EMAIL, TEST_PASSWORD, TEST_DEVICE_ID);

        UpdateProfileRequest req = UpdateProfileRequest.builder()
                .firstName("Karel")
                .lastName("Novotny")
                .phone("+420777123456")
                .build();

        mockMvc.perform(patch("/api/user/profile")
                        .header("Authorization", "Bearer " + token)
                        .contentType(MediaType.APPLICATION_JSON)
                        .content(objectMapper.writeValueAsString(req)))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.firstName").value("Karel"))
                .andExpect(jsonPath("$.lastName").value("Novotny"));
    }

    @Test
    @DisplayName("PATCH /profile — missing firstName → 400")
    void should_return400_when_profileUpdateMissingFirstName() throws Exception {
        String token = getAccessToken(TEST_EMAIL, TEST_PASSWORD, TEST_DEVICE_ID);

        UpdateProfileRequest req = UpdateProfileRequest.builder()
                .firstName("")
                .lastName("Novotny")
                .build();

        mockMvc.perform(patch("/api/user/profile")
                        .header("Authorization", "Bearer " + token)
                        .contentType(MediaType.APPLICATION_JSON)
                        .content(objectMapper.writeValueAsString(req)))
                .andExpect(status().isBadRequest());
    }

    @Test
    @DisplayName("PATCH /profile — missing lastName → 400")
    void should_return400_when_profileUpdateMissingLastName() throws Exception {
        String token = getAccessToken(TEST_EMAIL, TEST_PASSWORD, TEST_DEVICE_ID);

        UpdateProfileRequest req = UpdateProfileRequest.builder()
                .firstName("Karel")
                .lastName("")
                .build();

        mockMvc.perform(patch("/api/user/profile")
                        .header("Authorization", "Bearer " + token)
                        .contentType(MediaType.APPLICATION_JSON)
                        .content(objectMapper.writeValueAsString(req)))
                .andExpect(status().isBadRequest());
    }

    @Test
    @DisplayName("PATCH /profile — firstName exceeds 50 chars → 400")
    void should_return400_when_firstNameTooLong() throws Exception {
        String token = getAccessToken(TEST_EMAIL, TEST_PASSWORD, TEST_DEVICE_ID);

        UpdateProfileRequest req = UpdateProfileRequest.builder()
                .firstName("A".repeat(51))
                .lastName("Novotny")
                .build();

        mockMvc.perform(patch("/api/user/profile")
                        .header("Authorization", "Bearer " + token)
                        .contentType(MediaType.APPLICATION_JSON)
                        .content(objectMapper.writeValueAsString(req)))
                .andExpect(status().isBadRequest());
    }

    @Test
    @DisplayName("PATCH /profile — lastName exactly 50 chars → 200")
    void should_accept_lastName_at_maxLength() throws Exception {
        String token = getAccessToken(TEST_EMAIL, TEST_PASSWORD, TEST_DEVICE_ID);

        UpdateProfileRequest req = UpdateProfileRequest.builder()
                .firstName("Karel")
                .lastName("A".repeat(50))
                .build();

        mockMvc.perform(patch("/api/user/profile")
                        .header("Authorization", "Bearer " + token)
                        .contentType(MediaType.APPLICATION_JSON)
                        .content(objectMapper.writeValueAsString(req)))
                .andExpect(status().isOk());
    }

    @Test
    @DisplayName("PATCH /profile — phone exceeds 20 chars → 400")
    void should_return400_when_phoneTooLong() throws Exception {
        String token = getAccessToken(TEST_EMAIL, TEST_PASSWORD, TEST_DEVICE_ID);

        UpdateProfileRequest req = UpdateProfileRequest.builder()
                .firstName("Karel")
                .lastName("Novotny")
                .phone("+".repeat(21))
                .build();

        mockMvc.perform(patch("/api/user/profile")
                        .header("Authorization", "Bearer " + token)
                        .contentType(MediaType.APPLICATION_JSON)
                        .content(objectMapper.writeValueAsString(req)))
                .andExpect(status().isBadRequest());
    }

    @Test
    @DisplayName("PATCH /profile — profileImageUrl exceeds 512 chars → 400")
    void should_return400_when_profileImageUrlTooLong() throws Exception {
        String token = getAccessToken(TEST_EMAIL, TEST_PASSWORD, TEST_DEVICE_ID);

        UpdateProfileRequest req = UpdateProfileRequest.builder()
                .firstName("Karel")
                .lastName("Novotny")
                .profileImageUrl("https://img.example.com/" + "x".repeat(500))
                .build();

        mockMvc.perform(patch("/api/user/profile")
                        .header("Authorization", "Bearer " + token)
                        .contentType(MediaType.APPLICATION_JSON)
                        .content(objectMapper.writeValueAsString(req)))
                .andExpect(status().isBadRequest());
    }

    @Test
    @DisplayName("PATCH /profile — anonymous → 401")
    void should_return401_when_patchProfile_anonymous() throws Exception {
        UpdateProfileRequest req = UpdateProfileRequest.builder()
                .firstName("Karel").lastName("N").build();

        mockMvc.perform(patch("/api/user/profile")
                        .contentType(MediaType.APPLICATION_JSON)
                        .content(objectMapper.writeValueAsString(req)))
                .andExpect(status().isUnauthorized());
    }

    @Test
    @DisplayName("PATCH /profile — persistence round-trip: saved values survive reload")
    void should_persistProfileUpdate() throws Exception {
        String token = getAccessToken(TEST_EMAIL, TEST_PASSWORD, TEST_DEVICE_ID);

        UpdateProfileRequest req = UpdateProfileRequest.builder()
                .firstName("Persisted")
                .lastName("Name")
                .addressCity("Praha")
                .addressCountry("CZ")
                .build();

        mockMvc.perform(patch("/api/user/profile")
                        .header("Authorization", "Bearer " + token)
                        .contentType(MediaType.APPLICATION_JSON)
                        .content(objectMapper.writeValueAsString(req)))
                .andExpect(status().isOk());

        UserEntity reloaded = userRepository.findByEmail(TEST_EMAIL).orElseThrow();
        assertThat(reloaded.getFirstName()).isEqualTo("Persisted");
        assertThat(reloaded.getAddressCity()).isEqualTo("Praha");
    }

    // =========================================================================
    // POST /api/user/change-password
    // =========================================================================

    @Test
    @DisplayName("POST /change-password — correct current password → 204")
    void should_return204_when_changePassword_success() throws Exception {
        String token = getAccessToken(TEST_EMAIL, TEST_PASSWORD, TEST_DEVICE_ID);

        ChangePasswordRequest req = ChangePasswordRequest.builder()
                .currentPassword(TEST_PASSWORD)
                .newPassword("NewPass1234!")
                .confirmPassword("NewPass1234!")
                .build();

        mockMvc.perform(post("/api/user/change-password")
                        .header("Authorization", "Bearer " + token)
                        .contentType(MediaType.APPLICATION_JSON)
                        .content(objectMapper.writeValueAsString(req)))
                .andExpect(status().isNoContent());
    }

    @Test
    @DisplayName("POST /change-password — wrong current password → 400/422")
    void should_return4xx_when_changePassword_wrongCurrent() throws Exception {
        String token = getAccessToken(TEST_EMAIL, TEST_PASSWORD, TEST_DEVICE_ID);

        ChangePasswordRequest req = ChangePasswordRequest.builder()
                .currentPassword("WrongPassword!")
                .newPassword("NewPass1234!")
                .confirmPassword("NewPass1234!")
                .build();

        mockMvc.perform(post("/api/user/change-password")
                        .header("Authorization", "Bearer " + token)
                        .contentType(MediaType.APPLICATION_JSON)
                        .content(objectMapper.writeValueAsString(req)))
                .andExpect(status().is4xxClientError());
    }

    @Test
    @DisplayName("POST /change-password — blank currentPassword → 400")
    void should_return400_when_changePassword_blankCurrent() throws Exception {
        String token = getAccessToken(TEST_EMAIL, TEST_PASSWORD, TEST_DEVICE_ID);

        ChangePasswordRequest req = ChangePasswordRequest.builder()
                .currentPassword("")
                .newPassword("NewPass1234!")
                .confirmPassword("NewPass1234!")
                .build();

        mockMvc.perform(post("/api/user/change-password")
                        .header("Authorization", "Bearer " + token)
                        .contentType(MediaType.APPLICATION_JSON)
                        .content(objectMapper.writeValueAsString(req)))
                .andExpect(status().isBadRequest());
    }

    @Test
    @DisplayName("POST /change-password — newPassword too short (7 chars) → 400")
    void should_return400_when_newPassword_tooShort() throws Exception {
        String token = getAccessToken(TEST_EMAIL, TEST_PASSWORD, TEST_DEVICE_ID);

        ChangePasswordRequest req = ChangePasswordRequest.builder()
                .currentPassword(TEST_PASSWORD)
                .newPassword("Ab1234!")
                .confirmPassword("Ab1234!")
                .build();

        mockMvc.perform(post("/api/user/change-password")
                        .header("Authorization", "Bearer " + token)
                        .contentType(MediaType.APPLICATION_JSON)
                        .content(objectMapper.writeValueAsString(req)))
                .andExpect(status().isBadRequest());
    }

    @Test
    @DisplayName("POST /change-password — newPassword exceeds 64 chars → 400")
    void should_return400_when_newPassword_tooLong() throws Exception {
        String token = getAccessToken(TEST_EMAIL, TEST_PASSWORD, TEST_DEVICE_ID);

        ChangePasswordRequest req = ChangePasswordRequest.builder()
                .currentPassword(TEST_PASSWORD)
                .newPassword("A".repeat(65))
                .confirmPassword("A".repeat(65))
                .build();

        mockMvc.perform(post("/api/user/change-password")
                        .header("Authorization", "Bearer " + token)
                        .contentType(MediaType.APPLICATION_JSON)
                        .content(objectMapper.writeValueAsString(req)))
                .andExpect(status().isBadRequest());
    }

    @Test
    @DisplayName("POST /change-password — blank confirmPassword → 400")
    void should_return400_when_changePassword_blankConfirm() throws Exception {
        String token = getAccessToken(TEST_EMAIL, TEST_PASSWORD, TEST_DEVICE_ID);

        ChangePasswordRequest req = ChangePasswordRequest.builder()
                .currentPassword(TEST_PASSWORD)
                .newPassword("NewPass1234!")
                .confirmPassword("")
                .build();

        mockMvc.perform(post("/api/user/change-password")
                        .header("Authorization", "Bearer " + token)
                        .contentType(MediaType.APPLICATION_JSON)
                        .content(objectMapper.writeValueAsString(req)))
                .andExpect(status().isBadRequest());
    }

    @Test
    @DisplayName("POST /change-password — anonymous → 401")
    void should_return401_when_changePassword_anonymous() throws Exception {
        ChangePasswordRequest req = ChangePasswordRequest.builder()
                .currentPassword(TEST_PASSWORD)
                .newPassword("NewPass1234!")
                .confirmPassword("NewPass1234!")
                .build();

        mockMvc.perform(post("/api/user/change-password")
                        .contentType(MediaType.APPLICATION_JSON)
                        .content(objectMapper.writeValueAsString(req)))
                .andExpect(status().isUnauthorized());
    }

    @Test
    @DisplayName("POST /change-password — password actually hashed in DB after change")
    void should_hashNewPassword_in_db() throws Exception {
        String token = getAccessToken(TEST_EMAIL, TEST_PASSWORD, TEST_DEVICE_ID);
        String newPass = "NewSecurePass99!";

        ChangePasswordRequest req = ChangePasswordRequest.builder()
                .currentPassword(TEST_PASSWORD)
                .newPassword(newPass)
                .confirmPassword(newPass)
                .build();

        mockMvc.perform(post("/api/user/change-password")
                        .header("Authorization", "Bearer " + token)
                        .contentType(MediaType.APPLICATION_JSON)
                        .content(objectMapper.writeValueAsString(req)))
                .andExpect(status().isNoContent());

        UserEntity reloaded = userRepository.findByEmail(TEST_EMAIL).orElseThrow();
        assertThat(passwordEncoder.matches(newPass, reloaded.getPassword())).isTrue();
        assertThat(reloaded.getPassword()).doesNotContain(newPass);
    }

    // =========================================================================
    // Admin: GET /api/user
    // =========================================================================

    @Test
    @DisplayName("GET /api/user — non-admin USER → 403")
    void should_return403_when_getAllUsers_withUserRole() throws Exception {
        String token = getAccessToken(TEST_EMAIL, TEST_PASSWORD, TEST_DEVICE_ID);

        mockMvc.perform(get("/api/user")
                        .header("Authorization", "Bearer " + token))
                .andExpect(status().isForbidden());
    }

    @Test
    @DisplayName("GET /api/user — anonymous → 401")
    void should_return401_when_getAllUsers_anonymous() throws Exception {
        mockMvc.perform(get("/api/user"))
                .andExpect(status().isUnauthorized());
    }

    @Test
    @DisplayName("GET /api/user — ADMIN role → 200 with list")
    void should_return200_when_getAllUsers_withAdminRole() throws Exception {
        String token = getAccessToken(TEST_EMAIL, TEST_PASSWORD, TEST_DEVICE_ID);
        promoteToAdmin(TEST_EMAIL);
        String adminToken = loginAgain(TEST_EMAIL, TEST_PASSWORD);

        mockMvc.perform(get("/api/user")
                        .header("Authorization", "Bearer " + adminToken))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$").isArray());
    }

    // =========================================================================
    // Admin: GET /api/user/{id}
    // =========================================================================

    @Test
    @DisplayName("GET /api/user/{id} — non-existent ID → 404")
    void should_return404_when_getUserById_notFound() throws Exception {
        String token = getAccessToken(TEST_EMAIL, TEST_PASSWORD, TEST_DEVICE_ID);
        promoteToAdmin(TEST_EMAIL);
        String adminToken = loginAgain(TEST_EMAIL, TEST_PASSWORD);

        mockMvc.perform(get("/api/user/999999")
                        .header("Authorization", "Bearer " + adminToken))
                .andExpect(status().isNotFound());
    }

    // GAP: UserServiceImpl.findById() is not @Transactional, so accessing user.getRoles()
    //      in the mapper triggers LazyInitializationException → 500.
    //      Fix: add @Transactional(readOnly = true) to UserServiceImpl.findById()
    //      or use userRepository.findWithRolesByEmail() / a custom @EntityGraph query.
    @Test
    @DisplayName("GET /api/user/{id} — ADMIN returns user details")
    void should_return200_when_getUserById_asAdmin() throws Exception {
        String token = getAccessToken(TEST_EMAIL, TEST_PASSWORD, TEST_DEVICE_ID);
        promoteToAdmin(TEST_EMAIL);
        String adminToken = loginAgain(TEST_EMAIL, TEST_PASSWORD);

        Long userId = userRepository.findByEmail(TEST_EMAIL).orElseThrow().getId();

        mockMvc.perform(get("/api/user/" + userId)
                        .header("Authorization", "Bearer " + adminToken))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.email").value(TEST_EMAIL));
    }

    @Test
    @DisplayName("GET /api/user/{id} — USER role → 403")
    void should_return403_when_getUserById_withUserRole() throws Exception {
        String token = getAccessToken(TEST_EMAIL, TEST_PASSWORD, TEST_DEVICE_ID);

        mockMvc.perform(get("/api/user/1")
                        .header("Authorization", "Bearer " + token))
                .andExpect(status().isForbidden());
    }

    // =========================================================================
    // Admin: POST /api/user/assign-role
    // =========================================================================

    @Test
    @DisplayName("POST /assign-role — ADMIN assigns existing role → 200")
    void should_assignRole_when_admin() throws Exception {
        String token = getAccessToken(TEST_EMAIL, TEST_PASSWORD, TEST_DEVICE_ID);
        promoteToAdmin(TEST_EMAIL);
        String adminToken = loginAgain(TEST_EMAIL, TEST_PASSWORD);

        Long userId = userRepository.findByEmail(TEST_EMAIL).orElseThrow().getId();
        AssignRoleRequest req = AssignRoleRequest.builder()
                .userId(userId)
                .roleName("ADMIN")
                .build();

        mockMvc.perform(post("/api/user/assign-role")
                        .header("Authorization", "Bearer " + adminToken)
                        .contentType(MediaType.APPLICATION_JSON)
                        .content(objectMapper.writeValueAsString(req)))
                .andExpect(status().isOk());
    }

    @Test
    @DisplayName("POST /assign-role — non-existent role → 404")
    void should_return404_when_assignRole_roleNotFound() throws Exception {
        String token = getAccessToken(TEST_EMAIL, TEST_PASSWORD, TEST_DEVICE_ID);
        promoteToAdmin(TEST_EMAIL);
        String adminToken = loginAgain(TEST_EMAIL, TEST_PASSWORD);

        Long userId = userRepository.findByEmail(TEST_EMAIL).orElseThrow().getId();
        AssignRoleRequest req = AssignRoleRequest.builder()
                .userId(userId)
                .roleName("NONEXISTENT_ROLE")
                .build();

        mockMvc.perform(post("/api/user/assign-role")
                        .header("Authorization", "Bearer " + adminToken)
                        .contentType(MediaType.APPLICATION_JSON)
                        .content(objectMapper.writeValueAsString(req)))
                .andExpect(status().isNotFound());
    }

    @Test
    @DisplayName("POST /assign-role — null userId → 400")
    void should_return400_when_assignRole_nullUserId() throws Exception {
        String token = getAccessToken(TEST_EMAIL, TEST_PASSWORD, TEST_DEVICE_ID);
        promoteToAdmin(TEST_EMAIL);
        String adminToken = loginAgain(TEST_EMAIL, TEST_PASSWORD);

        String body = "{\"roleName\":\"USER\"}";
        mockMvc.perform(post("/api/user/assign-role")
                        .header("Authorization", "Bearer " + adminToken)
                        .contentType(MediaType.APPLICATION_JSON)
                        .content(body))
                .andExpect(status().isBadRequest());
    }

    @Test
    @DisplayName("POST /assign-role — blank roleName → 400")
    void should_return400_when_assignRole_blankRoleName() throws Exception {
        String token = getAccessToken(TEST_EMAIL, TEST_PASSWORD, TEST_DEVICE_ID);
        promoteToAdmin(TEST_EMAIL);
        String adminToken = loginAgain(TEST_EMAIL, TEST_PASSWORD);

        AssignRoleRequest req = AssignRoleRequest.builder()
                .userId(1L)
                .roleName("")
                .build();

        mockMvc.perform(post("/api/user/assign-role")
                        .header("Authorization", "Bearer " + adminToken)
                        .contentType(MediaType.APPLICATION_JSON)
                        .content(objectMapper.writeValueAsString(req)))
                .andExpect(status().isBadRequest());
    }

    @Test
    @DisplayName("POST /assign-role — USER role → 403")
    void should_return403_when_assignRole_withUserRole() throws Exception {
        String token = getAccessToken(TEST_EMAIL, TEST_PASSWORD, TEST_DEVICE_ID);

        AssignRoleRequest req = AssignRoleRequest.builder()
                .userId(1L)
                .roleName("ADMIN")
                .build();

        mockMvc.perform(post("/api/user/assign-role")
                        .header("Authorization", "Bearer " + token)
                        .contentType(MediaType.APPLICATION_JSON)
                        .content(objectMapper.writeValueAsString(req)))
                .andExpect(status().isForbidden());
    }

    // =========================================================================
    // Device management
    // =========================================================================

    @Test
    @DisplayName("GET /devices — returns own devices with current-device flag")
    void should_returnDevices_withCurrentDeviceFlag() throws Exception {
        String token = getAccessToken(TEST_EMAIL, TEST_PASSWORD, TEST_DEVICE_ID);

        mockMvc.perform(get("/api/user/devices")
                        .header("Authorization", "Bearer " + token))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$").isArray())
                .andExpect(jsonPath("$[0].currentDevice").value(true));
    }

    @Test
    @DisplayName("GET /devices — anonymous → 401")
    void should_return401_when_getDevices_anonymous() throws Exception {
        mockMvc.perform(get("/api/user/devices"))
                .andExpect(status().isUnauthorized());
    }

    @Test
    @DisplayName("POST /logout-all — deactivates other devices")
    void should_deactivateOtherDevices_when_logoutAll() throws Exception {
        String token = getAccessToken(TEST_EMAIL, TEST_PASSWORD, TEST_DEVICE_ID);
        // Login from second device
        loginUser(TEST_EMAIL, TEST_PASSWORD, "second-device-001");

        UserEntity user = userRepository.findByEmail(TEST_EMAIL).orElseThrow();
        long devicesBefore = deviceRepository.findAll().stream()
                .filter(d -> d.getUser().getId().equals(user.getId()))
                .count();
        assertThat(devicesBefore).isGreaterThanOrEqualTo(2);

        mockMvc.perform(post("/api/user/logout-all")
                        .header("Authorization", "Bearer " + token))
                .andExpect(status().isNoContent());

        long activeDevices = deviceRepository.findAll().stream()
                .filter(d -> d.getUser().getId().equals(user.getId()))
                .filter(d -> d.isActive() && !d.getDeviceIdentifier().equals(TEST_DEVICE_ID))
                .count();
        assertThat(activeDevices).isZero();
    }

    @Test
    @DisplayName("DELETE /devices/all — hard-deletes other devices")
    void should_deleteOtherDevices_when_deleteAll() throws Exception {
        String token = getAccessToken(TEST_EMAIL, TEST_PASSWORD, TEST_DEVICE_ID);
        loginUser(TEST_EMAIL, TEST_PASSWORD, "device-to-delete-001");

        UserEntity user = userRepository.findByEmail(TEST_EMAIL).orElseThrow();
        long before = deviceRepository.findAll().stream()
                .filter(d -> d.getUser().getId().equals(user.getId()))
                .count();
        assertThat(before).isGreaterThanOrEqualTo(2);

        mockMvc.perform(delete("/api/user/devices/all")
                        .header("Authorization", "Bearer " + token))
                .andExpect(status().isNoContent());

        long after = deviceRepository.findAll().stream()
                .filter(d -> d.getUser().getId().equals(user.getId()))
                .count();
        assertThat(after).isEqualTo(1);
    }

    @Test
    @DisplayName("POST /devices/{deviceId}/logout — cannot logout current device")
    void should_return4xx_when_logoutCurrentDevice() throws Exception {
        String token = getAccessToken(TEST_EMAIL, TEST_PASSWORD, TEST_DEVICE_ID);

        Long currentDeviceId = deviceRepository.findAll().stream()
                .filter(d -> d.getDeviceIdentifier().equals(TEST_DEVICE_ID))
                .findFirst().orElseThrow().getId();

        mockMvc.perform(post("/api/user/devices/" + currentDeviceId + "/logout")
                        .header("Authorization", "Bearer " + token))
                .andExpect(status().is4xxClientError());
    }

    @Test
    @DisplayName("DELETE /devices/{deviceId} — cannot delete current device")
    void should_return4xx_when_deleteCurrentDevice() throws Exception {
        String token = getAccessToken(TEST_EMAIL, TEST_PASSWORD, TEST_DEVICE_ID);

        Long currentDeviceId = deviceRepository.findAll().stream()
                .filter(d -> d.getDeviceIdentifier().equals(TEST_DEVICE_ID))
                .findFirst().orElseThrow().getId();

        mockMvc.perform(delete("/api/user/devices/" + currentDeviceId)
                        .header("Authorization", "Bearer " + token))
                .andExpect(status().is4xxClientError());
    }

    @Test
    @DisplayName("DELETE /devices/{deviceId} — idempotent: second call on already-deleted device → not 500")
    // GAP: second delete on non-existent device ID should return 404 not 500
    void should_not500_when_deleteDevice_alreadyDeleted() throws Exception {
        String token = getAccessToken(TEST_EMAIL, TEST_PASSWORD, TEST_DEVICE_ID);

        mockMvc.perform(delete("/api/user/devices/999999")
                        .header("Authorization", "Bearer " + token))
                .andExpect(status().is4xxClientError());
    }

    @Test
    @DisplayName("POST /devices/{deviceId}/logout — device belonging to other user → 4xx not 204")
    // GAP: no ownership check enforced — other user's device can be soft-logged out
    void should_return4xx_when_logoutDeviceOfAnotherUser() throws Exception {
        String token = getAccessToken(TEST_EMAIL, TEST_PASSWORD, TEST_DEVICE_ID);
        String otherEmail = "other@checkfood.test";
        createVerifiedUser(otherEmail, TEST_PASSWORD, "Other", "User");
        loginUser(otherEmail, TEST_PASSWORD, "other-device-002");

        Long otherDeviceId = deviceRepository.findAll().stream()
                .filter(d -> d.getDeviceIdentifier().equals("other-device-002"))
                .findFirst().orElseThrow().getId();

        mockMvc.perform(post("/api/user/devices/" + otherDeviceId + "/logout")
                        .header("Authorization", "Bearer " + token))
                .andExpect(status().is4xxClientError());
    }

    // =========================================================================
    // DELETE /api/user/account
    // =========================================================================

    @Test
    @DisplayName("DELETE /account — deletes own account → 204")
    void should_deleteAccount_when_authenticated() throws Exception {
        String token = getAccessToken(TEST_EMAIL, TEST_PASSWORD, TEST_DEVICE_ID);

        mockMvc.perform(delete("/api/user/account")
                        .header("Authorization", "Bearer " + token))
                .andExpect(status().isNoContent());

        assertThat(userRepository.findByEmail(TEST_EMAIL)).isEmpty();
    }

    @Test
    @DisplayName("DELETE /account — anonymous → 401")
    void should_return401_when_deleteAccount_anonymous() throws Exception {
        mockMvc.perform(delete("/api/user/account"))
                .andExpect(status().isUnauthorized());
    }

    // =========================================================================
    // Notifications
    // =========================================================================

    @Test
    @DisplayName("PUT /devices/notifications — update notification preference → 200")
    void should_updateNotificationPreference_success() throws Exception {
        String token = getAccessToken(TEST_EMAIL, TEST_PASSWORD, TEST_DEVICE_ID);

        UpdateNotificationRequest req = UpdateNotificationRequest.builder()
                .deviceIdentifier(TEST_DEVICE_ID)
                .fcmToken("test-fcm-token-abc123")
                .notificationsEnabled(true)
                .build();

        mockMvc.perform(put("/api/user/devices/notifications")
                        .header("Authorization", "Bearer " + token)
                        .contentType(MediaType.APPLICATION_JSON)
                        .content(objectMapper.writeValueAsString(req)))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.notificationsEnabled").value(true));
    }

    @Test
    @DisplayName("PUT /devices/notifications — blank deviceIdentifier → 400")
    void should_return400_when_updateNotification_blankDeviceIdentifier() throws Exception {
        String token = getAccessToken(TEST_EMAIL, TEST_PASSWORD, TEST_DEVICE_ID);

        UpdateNotificationRequest req = UpdateNotificationRequest.builder()
                .deviceIdentifier("")
                .notificationsEnabled(false)
                .build();

        mockMvc.perform(put("/api/user/devices/notifications")
                        .header("Authorization", "Bearer " + token)
                        .contentType(MediaType.APPLICATION_JSON)
                        .content(objectMapper.writeValueAsString(req)))
                .andExpect(status().isBadRequest());
    }

    @Test
    @DisplayName("PUT /devices/notifications — null notificationsEnabled → 400")
    void should_return400_when_updateNotification_nullFlag() throws Exception {
        String token = getAccessToken(TEST_EMAIL, TEST_PASSWORD, TEST_DEVICE_ID);

        String body = "{\"deviceIdentifier\":\"" + TEST_DEVICE_ID + "\"}";

        mockMvc.perform(put("/api/user/devices/notifications")
                        .header("Authorization", "Bearer " + token)
                        .contentType(MediaType.APPLICATION_JSON)
                        .content(body))
                .andExpect(status().isBadRequest());
    }

    @Test
    @DisplayName("GET /devices/notifications — returns preference for own device")
    void should_getNotificationPreference_success() throws Exception {
        String token = getAccessToken(TEST_EMAIL, TEST_PASSWORD, TEST_DEVICE_ID);

        mockMvc.perform(get("/api/user/devices/notifications")
                        .header("Authorization", "Bearer " + token)
                        .param("deviceIdentifier", TEST_DEVICE_ID))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.notificationsEnabled").isBoolean());
    }

    // =========================================================================
    // Private helpers
    // =========================================================================

    private void promoteToAdmin(String email) {
        // ADMIN role is already ensured in BaseAuthIntegrationTest @BeforeEach
        // findWithRolesByEmail eagerly loads roles to avoid LazyInitializationException
        UserEntity user = userRepository.findWithRolesByEmail(email).orElseThrow();
        RoleEntity adminRole = roleRepository.findByName("ADMIN").orElseThrow();
        HashSet<RoleEntity> roles = new HashSet<>(user.getRoles());
        roles.add(adminRole);
        user.setRoles(roles);
        userRepository.saveAndFlush(user);
    }

    private String loginAgain(String email, String password) throws Exception {
        var result = loginUser(email, password, TEST_DEVICE_ID);
        var body = objectMapper.readTree(result.getResponse().getContentAsString());
        return body.get("accessToken").asText();
    }
}
