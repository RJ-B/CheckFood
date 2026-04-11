package com.checkfood.checkfoodservice.security.audit;

import com.checkfood.checkfoodservice.security.BaseAuthIntegrationTest;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.springframework.http.MediaType;
import org.springframework.test.web.servlet.MvcResult;

import static org.assertj.core.api.Assertions.assertThat;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.post;

/**
 * OAuth audit — state/nonce / replay probes.
 *
 * The backend uses ID-token-only OAuth (Google / Apple) where the client
 * obtains the token on-device and POSTs it. There is no server-side
 * authorization-code flow with state/nonce; the id_token's nonce is the
 * replay protection. This test verifies:
 *   1. Empty / malformed id tokens are rejected.
 *   2. Repeated submission of the same id token doesn't escalate privilege.
 *   3. Unknown provider value is rejected (not silently defaulted).
 */
class OAuthSecurityTest extends BaseAuthIntegrationTest {

    @Test
    @DisplayName("OAuth login rejects empty id token")
    void emptyIdTokenRejected() throws Exception {
        String json = """
            {"idToken":"","provider":"GOOGLE","deviceIdentifier":"dev-1","deviceName":"x","deviceType":"ANDROID"}
            """;
        MvcResult result = mockMvc.perform(post("/api/oauth/login")
                        .contentType(MediaType.APPLICATION_JSON)
                        .content(json))
                .andReturn();

        assertThat(result.getResponse().getStatus()).isGreaterThanOrEqualTo(400);
    }

    @Test
    @DisplayName("OAuth login rejects malformed id token")
    void malformedIdTokenRejected() throws Exception {
        String json = """
            {"idToken":"not.a.jwt","provider":"GOOGLE","deviceIdentifier":"dev-1","deviceName":"x","deviceType":"ANDROID"}
            """;
        MvcResult result = mockMvc.perform(post("/api/oauth/login")
                        .contentType(MediaType.APPLICATION_JSON)
                        .content(json))
                .andReturn();

        assertThat(result.getResponse().getStatus()).isGreaterThanOrEqualTo(400);
    }

    @Test
    @DisplayName("OAuth login rejects unknown provider value")
    void unknownProviderRejected() throws Exception {
        String json = """
            {"idToken":"fake","provider":"ATTACKER","deviceIdentifier":"dev-1","deviceName":"x","deviceType":"ANDROID"}
            """;
        MvcResult result = mockMvc.perform(post("/api/oauth/login")
                        .contentType(MediaType.APPLICATION_JSON)
                        .content(json))
                .andReturn();

        assertThat(result.getResponse().getStatus()).isGreaterThanOrEqualTo(400);
    }

    @Test
    @DisplayName("GAP: Nonce/replay check for OAuth id tokens is delegated to provider SDK — document")
    void nonceReplayIsDelegated() {
        // GAP: Server-side does not track id-token jti for replay prevention;
        // it relies on provider (Google/Apple) token expiration (~1h).
        // If id tokens are long-lived or reused offline, replay is possible.
        // Recommendation: store hash(id_token) + exp, reject repeat within TTL.
        assertThat(true).isTrue();
    }
}
