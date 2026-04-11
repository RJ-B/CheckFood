package com.checkfood.checkfoodservice.security.audit;

import com.checkfood.checkfoodservice.security.BaseAuthIntegrationTest;
import com.checkfood.checkfoodservice.security.module.auth.dto.request.LoginRequest;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.springframework.http.MediaType;
import org.springframework.test.web.servlet.MvcResult;

import java.util.Base64;

import static org.assertj.core.api.Assertions.assertThat;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.get;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.post;

/**
 * Broken authentication / session probes.
 * Verifies wrong-password info leak, expired JWT, tampered JWT,
 * the "none" algorithm bypass, refresh reuse, logout invalidation.
 */
class BrokenAuthTest extends BaseAuthIntegrationTest {

    @Test
    @DisplayName("Login with wrong password returns 401 and does not distinguish 'user not found'")
    void loginWrongPasswordNoEnumeration() throws Exception {
        createVerifiedUser(TEST_EMAIL, TEST_PASSWORD, TEST_FIRST_NAME, TEST_LAST_NAME);

        // Existing user, wrong password
        MvcResult wrongPwd = loginUser(TEST_EMAIL, "WrongPassword1!", "dev-1");
        // Unknown user
        MvcResult unknown = loginUser("does.not.exist@checkfood.test", "WrongPassword1!", "dev-1");

        assertThat(wrongPwd.getResponse().getStatus()).isEqualTo(401);
        assertThat(unknown.getResponse().getStatus()).isEqualTo(401);

        // Bodies must not reveal whether the account exists
        String body1 = wrongPwd.getResponse().getContentAsString().toLowerCase();
        String body2 = unknown.getResponse().getContentAsString().toLowerCase();

        // Both endpoints should not mention "neexistuje" or "not found"
        // GAP: currently both paths return "Neplatné přihlašovací údaje" — OK. Add guard.
        assertThat(body1).doesNotContain("not found").doesNotContain("neexistuje");
        assertThat(body2).doesNotContain("not found").doesNotContain("neexistuje");
    }

    @Test
    @DisplayName("Expired JWT is rejected with 401")
    void expiredJwtRejected() throws Exception {
        // Forge an expired token structure (invalid signature) — filter must reject it.
        String fakeExpired = "eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJ0ZXN0IiwiZXhwIjoxfQ.invalidsig";

        MvcResult result = mockMvc.perform(get("/api/user/me")
                        .header("Authorization", "Bearer " + fakeExpired))
                .andReturn();

        assertThat(result.getResponse().getStatus()).isEqualTo(401);
    }

    @Test
    @DisplayName("Tampered JWT payload is rejected (signature mismatch)")
    void tamperedJwtRejected() throws Exception {
        String token = getAccessToken(TEST_EMAIL, TEST_PASSWORD, "dev-1");
        // Mutate the middle segment — signature will no longer match
        String[] parts = token.split("\\.");
        assertThat(parts).hasSize(3);
        String tamperedPayload = Base64.getUrlEncoder().withoutPadding().encodeToString(
                "{\"sub\":\"attacker@checkfood.test\",\"roles\":[\"ADMIN\"]}".getBytes()
        );
        String tampered = parts[0] + "." + tamperedPayload + "." + parts[2];

        MvcResult result = mockMvc.perform(get("/api/user/me")
                        .header("Authorization", "Bearer " + tampered))
                .andReturn();

        assertThat(result.getResponse().getStatus()).isEqualTo(401);
    }

    @Test
    @DisplayName("JWT signed with 'none' algorithm is rejected")
    void noneAlgorithmRejected() throws Exception {
        // {"alg":"none","typ":"JWT"}.{"sub":"testuser@checkfood.test","roles":["ADMIN"]}.
        String headerB64 = Base64.getUrlEncoder().withoutPadding().encodeToString(
                "{\"alg\":\"none\",\"typ\":\"JWT\"}".getBytes());
        String payloadB64 = Base64.getUrlEncoder().withoutPadding().encodeToString(
                "{\"sub\":\"testuser@checkfood.test\",\"roles\":[\"ADMIN\"],\"exp\":9999999999}".getBytes());
        String noneToken = headerB64 + "." + payloadB64 + ".";

        MvcResult result = mockMvc.perform(get("/api/user/me")
                        .header("Authorization", "Bearer " + noneToken))
                .andReturn();

        assertThat(result.getResponse().getStatus()).isEqualTo(401);
    }

    @Test
    @DisplayName("Refresh token reused after logout is rejected")
    void refreshReuseAfterLogoutRejected() throws Exception {
        createVerifiedUser(TEST_EMAIL, TEST_PASSWORD, TEST_FIRST_NAME, TEST_LAST_NAME);
        MvcResult loginRes = loginUser(TEST_EMAIL, TEST_PASSWORD, "dev-1");
        String refreshToken = parseResponseBody(loginRes).get("refreshToken").asText();
        String accessToken = parseResponseBody(loginRes).get("accessToken").asText();

        // Logout the device
        String logoutJson = String.format(
                "{\"refreshToken\":\"%s\",\"deviceIdentifier\":\"dev-1\"}",
                refreshToken);
        mockMvc.perform(post("/api/auth/logout")
                .header("Authorization", "Bearer " + accessToken)
                .contentType(MediaType.APPLICATION_JSON)
                .content(logoutJson));

        // Try to refresh with the same refresh token
        String refreshJson = String.format(
                "{\"refreshToken\":\"%s\",\"deviceIdentifier\":\"dev-1\"}",
                refreshToken);
        MvcResult refreshRes = mockMvc.perform(post("/api/auth/refresh")
                        .contentType(MediaType.APPLICATION_JSON)
                        .content(refreshJson))
                .andReturn();

        assertThat(refreshRes.getResponse().getStatus())
                .as("GAP: Refresh token reuse after logout should be rejected (device deactivated)")
                .isNotEqualTo(200);
    }

    @Test
    @DisplayName("Empty Authorization header is treated as anonymous — 401 on protected endpoints")
    void missingAuthHeaderGives401() throws Exception {
        MvcResult result = mockMvc.perform(get("/api/user/me")).andReturn();
        assertThat(result.getResponse().getStatus()).isEqualTo(401);
    }

    @Test
    @DisplayName("Login with only-whitespace password is rejected by validation, not accepted")
    void loginBlankPasswordRejected() throws Exception {
        LoginRequest req = LoginRequest.builder()
                .email(TEST_EMAIL)
                .password("        ")
                .deviceIdentifier("dev-1")
                .deviceName("x")
                .deviceType("ANDROID")
                .build();

        MvcResult result = mockMvc.perform(post("/api/auth/login")
                        .contentType(MediaType.APPLICATION_JSON)
                        .content(objectMapper.writeValueAsString(req)))
                .andReturn();

        assertThat(result.getResponse().getStatus()).isNotEqualTo(200);
    }
}
