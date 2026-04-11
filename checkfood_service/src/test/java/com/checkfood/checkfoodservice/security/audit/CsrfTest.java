package com.checkfood.checkfoodservice.security.audit;

import com.checkfood.checkfoodservice.security.BaseAuthIntegrationTest;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.springframework.http.MediaType;
import org.springframework.test.web.servlet.MvcResult;

import static org.assertj.core.api.Assertions.assertThat;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.post;

/**
 * CSRF audit.
 *
 * CheckFood is a JWT-bearer API with no session cookies — CSRF is
 * structurally N/A. This test asserts:
 *   1. No JSESSIONID cookie is ever issued (stateless).
 *   2. State-changing requests with only Origin: evil.com still require
 *      a valid Authorization header (no implicit cookie-based trust).
 */
class CsrfTest extends BaseAuthIntegrationTest {

    @Test
    @DisplayName("Login does not issue a JSESSIONID cookie (stateless policy)")
    void loginNoSessionCookie() throws Exception {
        createVerifiedUser(TEST_EMAIL, TEST_PASSWORD, TEST_FIRST_NAME, TEST_LAST_NAME);
        MvcResult result = loginUser(TEST_EMAIL, TEST_PASSWORD, "dev-1");

        String setCookie = result.getResponse().getHeader("Set-Cookie");
        if (setCookie != null) {
            assertThat(setCookie)
                    .as("Stateless JWT API must not issue JSESSIONID cookies")
                    .doesNotContain("JSESSIONID");
        }
    }

    @Test
    @DisplayName("State-changing POST from foreign origin with no Authorization is rejected")
    void foreignOriginNoTokenRejected() throws Exception {
        MvcResult result = mockMvc.perform(post("/api/v1/reservations")
                        .header("Origin", "https://evil.example.com")
                        .contentType(MediaType.APPLICATION_JSON)
                        .content("{}"))
                .andReturn();

        assertThat(result.getResponse().getStatus()).isIn(401, 403);
    }
}
