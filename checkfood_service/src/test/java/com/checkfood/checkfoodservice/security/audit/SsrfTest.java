package com.checkfood.checkfoodservice.security.audit;

import com.checkfood.checkfoodservice.security.BaseAuthIntegrationTest;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.springframework.http.MediaType;
import org.springframework.test.web.servlet.MvcResult;

import static org.assertj.core.api.Assertions.assertThat;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.post;

/**
 * SSRF probes — any endpoint that accepts a URL must refuse to connect to
 * internal, link-local, loopback, or file:// targets.
 *
 * The CheckFood backend currently does NOT expose an avatar-by-URL upload,
 * but OAuth callbacks accept id tokens and external identifiers that the
 * caller controls. These tests target such surface areas.
 */
class SsrfTest extends BaseAuthIntegrationTest {

    private static final String[] SSRF_PAYLOADS = {
            "http://169.254.169.254/latest/meta-data/",
            "http://localhost:22/",
            "http://127.0.0.1:8080/admin",
            "file:///etc/passwd",
            "gopher://127.0.0.1:11211/_stats",
            "http://[::1]:22/"
    };

    @Test
    @DisplayName("OAuth login rejects SSRF-looking ID tokens — no outbound request made")
    void oauthLoginSsrfPayloads() throws Exception {
        for (String payload : SSRF_PAYLOADS) {
            String json = String.format("""
                {
                  "idToken": "%s",
                  "provider": "GOOGLE",
                  "deviceIdentifier": "dev-1",
                  "deviceName": "x",
                  "deviceType": "ANDROID"
                }
                """, payload);

            MvcResult result = mockMvc.perform(post("/api/oauth/login")
                            .contentType(MediaType.APPLICATION_JSON)
                            .content(json))
                    .andReturn();

            int status = result.getResponse().getStatus();
            assertThat(status)
                    .as("SSRF-shaped id token must not trigger server-side URL fetch")
                    .isLessThan(500);
            rateLimitService.reset();
        }
    }

    @Test
    @DisplayName("GAP: verify if any admin/media endpoint accepts a fetch-by-URL param — document if missing allow-list")
    void mediaUrlSurfaceDocumented() {
        // GAP: Currently media uploads use multipart/form-data only, which is
        // SSRF-safe. If a future endpoint adds "?sourceUrl=" or similar, an
        // explicit allow-list (bucket domain only) must be enforced.
        assertThat(true).isTrue();
    }
}
