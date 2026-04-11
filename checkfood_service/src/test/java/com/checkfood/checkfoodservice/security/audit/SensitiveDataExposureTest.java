package com.checkfood.checkfoodservice.security.audit;

import com.checkfood.checkfoodservice.security.BaseAuthIntegrationTest;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.springframework.test.web.servlet.MvcResult;

import static org.assertj.core.api.Assertions.assertThat;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.get;

/**
 * Ensures responses do not leak passwords, password hashes, verification
 * tokens, or stack traces / SQL fragments.
 */
class SensitiveDataExposureTest extends BaseAuthIntegrationTest {

    private static final String[] FORBIDDEN = {
            "password", "passwordHash", "password_hash",
            "verificationToken", "verification_token",
            "resetToken", "reset_token",
            "hibernate", "SQLException", "stacktrace", "at org.springframework"
    };

    @Test
    @DisplayName("/api/auth/me response does not expose password hash or tokens")
    void authMeNoPassword() throws Exception {
        String token = getAccessToken(TEST_EMAIL, TEST_PASSWORD, "dev-1");

        MvcResult result = mockMvc.perform(get("/api/auth/me")
                        .header("Authorization", "Bearer " + token))
                .andReturn();

        String body = result.getResponse().getContentAsString();
        assertThat(body).doesNotContainIgnoringCase("password");
        assertThat(body).doesNotContainIgnoringCase("verificationtoken");
        assertThat(body).doesNotContain("$2a$"); // BCrypt prefix
    }

    @Test
    @DisplayName("/api/user/me response does not expose password / hash / tokens")
    void userMeNoPassword() throws Exception {
        String token = getAccessToken(TEST_EMAIL, TEST_PASSWORD, "dev-1");

        MvcResult result = mockMvc.perform(get("/api/user/me")
                        .header("Authorization", "Bearer " + token))
                .andReturn();

        String body = result.getResponse().getContentAsString();
        assertThat(body).doesNotContain("$2a$");
        for (String f : FORBIDDEN) {
            assertThat(body.toLowerCase())
                    .as("/api/user/me must not expose '%s'", f)
                    .doesNotContain(f.toLowerCase());
        }
    }

    @Test
    @DisplayName("Login response body does not expose password field at all")
    void loginResponseNoPassword() throws Exception {
        createVerifiedUser(TEST_EMAIL, TEST_PASSWORD, TEST_FIRST_NAME, TEST_LAST_NAME);
        MvcResult result = loginUser(TEST_EMAIL, TEST_PASSWORD, "dev-1");
        String body = result.getResponse().getContentAsString();

        assertThat(body).doesNotContainIgnoringCase("\"password\"");
        assertThat(body).doesNotContain("$2a$");
    }

    @Test
    @DisplayName("Unhandled exception (e.g. bad UUID path) does not leak stack trace")
    void unhandledExceptionNoStackTrace() throws Exception {
        MvcResult result = mockMvc.perform(get("/api/v1/restaurants/not-a-uuid")).andReturn();
        String body = result.getResponse().getContentAsString();

        assertThat(body).doesNotContain("at org.springframework");
        assertThat(body).doesNotContain("Caused by:");
        assertThat(body).doesNotContain("java.lang.");
        assertThat(body).doesNotContain("SQLException");
    }
}
