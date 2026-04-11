package com.checkfood.checkfoodservice.security.audit;

import com.checkfood.checkfoodservice.security.BaseAuthIntegrationTest;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.springframework.test.web.servlet.MvcResult;

import static org.assertj.core.api.Assertions.assertThat;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.get;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.options;

/**
 * HTTP security header / CORS audit.
 *
 * GAP markers fire when Spring-default protections have been opted out.
 */
class SecurityHeadersTest extends BaseAuthIntegrationTest {

    @Test
    @DisplayName("X-Content-Type-Options: nosniff is present on responses")
    void xContentTypeOptionsPresent() throws Exception {
        MvcResult result = mockMvc.perform(get("/actuator/health")).andReturn();
        String header = result.getResponse().getHeader("X-Content-Type-Options");

        assertThat(header)
                .as("Spring Security default includes X-Content-Type-Options: nosniff")
                .isEqualTo("nosniff");
    }

    @Test
    @DisplayName("X-Frame-Options: DENY is present on responses")
    void xFrameOptionsPresent() throws Exception {
        MvcResult result = mockMvc.perform(get("/actuator/health")).andReturn();
        String header = result.getResponse().getHeader("X-Frame-Options");

        assertThat(header)
                .as("X-Frame-Options should be DENY (default from Spring Security)")
                .isIn("DENY", "SAMEORIGIN");
    }

    @Test
    @DisplayName("GAP: Content-Security-Policy header should be set")
    void cspHeaderPresent() throws Exception {
        MvcResult result = mockMvc.perform(get("/actuator/health")).andReturn();
        String csp = result.getResponse().getHeader("Content-Security-Policy");

        assertThat(csp)
                .as("GAP: CSP not configured in SecurityConfig — add headers().contentSecurityPolicy(...)")
                .isNotNull();
    }

    @Test
    @DisplayName("GAP: Strict-Transport-Security header should be set in production-like profile")
    void hstsHeaderPresent() throws Exception {
        MvcResult result = mockMvc.perform(get("/actuator/health")).andReturn();
        String hsts = result.getResponse().getHeader("Strict-Transport-Security");

        assertThat(hsts)
                .as("GAP: HSTS header not explicitly configured. Add .headers(h -> h.httpStrictTransportSecurity(...))")
                .isNotNull();
    }

    @Test
    @DisplayName("GAP: Referrer-Policy header should be set")
    void referrerPolicyPresent() throws Exception {
        MvcResult result = mockMvc.perform(get("/actuator/health")).andReturn();
        String rp = result.getResponse().getHeader("Referrer-Policy");

        assertThat(rp)
                .as("GAP: Referrer-Policy not configured — add headers().referrerPolicy(...)")
                .isNotNull();
    }

    @Test
    @DisplayName("CORS does not allow wildcard origin with credentials")
    void corsNotWildcardWithCredentials() throws Exception {
        MvcResult result = mockMvc.perform(options("/api/auth/login")
                        .header("Origin", "http://localhost")
                        .header("Access-Control-Request-Method", "POST"))
                .andReturn();

        String allowOrigin = result.getResponse().getHeader("Access-Control-Allow-Origin");
        String allowCreds = result.getResponse().getHeader("Access-Control-Allow-Credentials");

        if ("true".equalsIgnoreCase(allowCreds)) {
            assertThat(allowOrigin)
                    .as("CORS with credentials=true MUST NOT use wildcard origin")
                    .isNotEqualTo("*");
        }
    }
}
