package com.checkfood.checkfoodservice.security.audit;

import com.checkfood.checkfoodservice.security.BaseAuthIntegrationTest;
import com.checkfood.checkfoodservice.security.module.user.entity.UserEntity;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.springframework.http.MediaType;

import static org.assertj.core.api.Assertions.assertThat;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.*;

/**
 * Mass-assignment probes. Send extra fields the DTO did NOT declare
 * (role, isVerified, id, enabled, ownerTier) and verify that the
 * persisted entity does NOT reflect the injected values.
 */
class MassAssignmentTest extends BaseAuthIntegrationTest {

    @Test
    @DisplayName("Registration cannot promote user to ADMIN via extra role field")
    void registerCannotSetAdminRole() throws Exception {
        String json = """
            {
              "firstName": "Evil",
              "lastName": "Hax",
              "email": "evil@checkfood.test",
              "password": "Test1234!",
              "role": "ADMIN",
              "roles": ["ADMIN"],
              "authorities": ["ROLE_ADMIN"],
              "enabled": true,
              "isVerified": true,
              "id": 99999
            }
            """;

        mockMvc.perform(post("/api/auth/register")
                        .contentType(MediaType.APPLICATION_JSON)
                        .content(json));

        UserEntity saved = userRepository.findByEmail("evil@checkfood.test").orElseThrow();

        assertThat(saved.getRoles())
                .as("Mass assignment must not grant ADMIN role")
                .noneMatch(r -> "ADMIN".equals(r.getName()));

        assertThat(saved.isEnabled())
                .as("Mass assignment must not bypass email verification")
                .isFalse();

        assertThat(saved.getId())
                .as("Mass assignment must not pin a chosen primary key")
                .isNotEqualTo(99999L);
    }

    @Test
    @DisplayName("Registration cannot flip ownerRegistration to become OWNER unexpectedly — honored only when intended")
    void registerOwnerRegistrationFlag() throws Exception {
        // This test documents the current behavior: ownerRegistration is a
        // declared field so it IS assignable. Any FUTURE change that
        // allows role injection should fail via the roles assertion below.
        String json = """
            {
              "firstName": "Evil",
              "lastName": "Hax",
              "email": "evil2@checkfood.test",
              "password": "Test1234!",
              "ownerRegistration": false,
              "role": "OWNER"
            }
            """;

        mockMvc.perform(post("/api/auth/register")
                        .contentType(MediaType.APPLICATION_JSON)
                        .content(json));

        UserEntity saved = userRepository.findByEmail("evil2@checkfood.test").orElseThrow();
        assertThat(saved.getRoles())
                .noneMatch(r -> "OWNER".equals(r.getName()) || "ADMIN".equals(r.getName()));
    }

    @Test
    @DisplayName("Profile update cannot inject email change or role via extra fields")
    void profileUpdateIgnoresExtraFields() throws Exception {
        String token = getAccessToken(TEST_EMAIL, TEST_PASSWORD, "dev-1");

        String json = """
            {
              "firstName": "Patched",
              "email": "someone-else@checkfood.test",
              "role": "ADMIN",
              "enabled": true,
              "id": 77777
            }
            """;

        mockMvc.perform(patch("/api/user/profile")
                        .header("Authorization", "Bearer " + token)
                        .contentType(MediaType.APPLICATION_JSON)
                        .content(json));

        UserEntity user = userRepository.findByEmail(TEST_EMAIL).orElseThrow();
        assertThat(user.getEmail()).isEqualTo(TEST_EMAIL);
        assertThat(user.getRoles()).noneMatch(r -> "ADMIN".equals(r.getName()));
    }
}
