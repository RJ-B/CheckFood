package com.checkfood.checkfoodservice.security.audit;

import com.checkfood.checkfoodservice.security.BaseAuthIntegrationTest;
import com.checkfood.checkfoodservice.security.module.jwt.properties.JwtProperties;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.web.servlet.MvcResult;

import java.util.Base64;

import static org.assertj.core.api.Assertions.assertThat;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.get;

/**
 * JWT crypto / claim audit.
 *
 * Asserts: HS256 is pinned, issuer claim is set, minimum secret length,
 * the "none" algorithm token is rejected (also in BrokenAuthTest).
 */
class JwtCryptoTest extends BaseAuthIntegrationTest {

    @Autowired
    private JwtProperties jwtProperties;

    @Test
    @DisplayName("JWT secret is at least 256 bits (32 bytes) for HS256")
    void jwtSecretMinLength() {
        assertThat(jwtProperties.getSecret())
                .as("HS256 requires >= 32 byte secret")
                .isNotNull();
        assertThat(jwtProperties.getSecret().getBytes().length).isGreaterThanOrEqualTo(32);
    }

    @Test
    @DisplayName("JWT issuer claim is present in issued access tokens")
    void jwtIssuerClaimPresent() throws Exception {
        String token = getAccessToken(TEST_EMAIL, TEST_PASSWORD, "dev-1");

        String[] parts = token.split("\\.");
        String payloadJson = new String(Base64.getUrlDecoder().decode(parts[1]));
        JsonNode payload = new ObjectMapper().readTree(payloadJson);

        assertThat(payload.has("iss"))
                .as("Access token must carry issuer claim")
                .isTrue();
        assertThat(payload.get("iss").asText()).isNotBlank();
    }

    @Test
    @DisplayName("JWT header advertises HS256 (not 'none')")
    void jwtHeaderHs256() throws Exception {
        String token = getAccessToken(TEST_EMAIL, TEST_PASSWORD, "dev-1");

        String[] parts = token.split("\\.");
        String headerJson = new String(Base64.getUrlDecoder().decode(parts[0]));
        JsonNode header = new ObjectMapper().readTree(headerJson);

        assertThat(header.get("alg").asText()).isEqualTo("HS256");
    }

    @Test
    @DisplayName("GAP: JWT 'aud' (audience) claim should be set for defense in depth")
    void jwtAudienceClaimPresent() throws Exception {
        String token = getAccessToken(TEST_EMAIL, TEST_PASSWORD, "dev-1");

        String[] parts = token.split("\\.");
        String payloadJson = new String(Base64.getUrlDecoder().decode(parts[1]));
        JsonNode payload = new ObjectMapper().readTree(payloadJson);

        assertThat(payload.has("aud"))
                .as("GAP: 'aud' (audience) claim not set — add for token-scope defense")
                .isTrue();
    }

    @Test
    @DisplayName("Token with forged HS256 signature is rejected")
    void forgedSignatureRejected() throws Exception {
        String forged = "eyJhbGciOiJIUzI1NiJ9." +
                Base64.getUrlEncoder().withoutPadding().encodeToString(
                        "{\"sub\":\"attacker@checkfood.test\",\"exp\":9999999999,\"roles\":[\"ADMIN\"]}".getBytes())
                + ".forgedSignatureBytes";

        MvcResult result = mockMvc.perform(get("/api/user/me")
                        .header("Authorization", "Bearer " + forged))
                .andReturn();

        assertThat(result.getResponse().getStatus()).isEqualTo(401);
    }
}
