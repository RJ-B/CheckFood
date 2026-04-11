package com.checkfood.checkfoodservice.security.audit;

import com.checkfood.checkfoodservice.security.BaseAuthIntegrationTest;
import com.checkfood.checkfoodservice.security.module.auth.dto.request.ForgotPasswordRequest;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.springframework.http.MediaType;
import org.springframework.test.web.servlet.MvcResult;

import static org.assertj.core.api.Assertions.assertThat;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.post;

/**
 * Account-enumeration probes.
 *
 * register / login / forgot-password responses must be indistinguishable
 * between "account exists" and "account does not exist".
 */
class EmailEnumerationTest extends BaseAuthIntegrationTest {

    @Test
    @DisplayName("Forgot-password returns the same 200 for existing and non-existing email")
    void forgotPasswordConstantResponse() throws Exception {
        createVerifiedUser(TEST_EMAIL, TEST_PASSWORD, TEST_FIRST_NAME, TEST_LAST_NAME);

        MvcResult existing = postForgotPassword(TEST_EMAIL);
        rateLimitService.reset();
        MvcResult missing = postForgotPassword("ghost@checkfood.test");

        assertThat(existing.getResponse().getStatus()).isEqualTo(200);
        assertThat(missing.getResponse().getStatus()).isEqualTo(200);

        // Body should be identical (empty or same shape)
        assertThat(existing.getResponse().getContentAsString())
                .isEqualTo(missing.getResponse().getContentAsString());
    }

    @Test
    @DisplayName("GAP: Register with existing email currently returns 409 — enumeration surface")
    void registerExistingEmailEnumeration() throws Exception {
        createVerifiedUser(TEST_EMAIL, TEST_PASSWORD, TEST_FIRST_NAME, TEST_LAST_NAME);

        String json = String.format("""
            {"firstName":"A","lastName":"B","email":"%s","password":"Test1234!"}
            """, TEST_EMAIL);

        MvcResult dup = mockMvc.perform(post("/api/auth/register")
                        .contentType(MediaType.APPLICATION_JSON)
                        .content(json))
                .andReturn();
        rateLimitService.reset();

        String jsonNew = """
            {"firstName":"A","lastName":"B","email":"newuser@checkfood.test","password":"Test1234!"}
            """;
        MvcResult fresh = mockMvc.perform(post("/api/auth/register")
                        .contentType(MediaType.APPLICATION_JSON)
                        .content(jsonNew))
                .andReturn();

        // Ideally both return 202 (async). If one returns 409, it is enumeration.
        assertThat(dup.getResponse().getStatus())
                .as("GAP: /register leaks account existence via different HTTP status")
                .isEqualTo(fresh.getResponse().getStatus());
    }

    @Test
    @DisplayName("Login returns same 401 code for wrong password and unknown email")
    void loginUniformFailure() throws Exception {
        createVerifiedUser(TEST_EMAIL, TEST_PASSWORD, TEST_FIRST_NAME, TEST_LAST_NAME);

        MvcResult wrongPwd = loginUser(TEST_EMAIL, "BadPassword1!", "dev-1");
        rateLimitService.reset();
        MvcResult noAccount = loginUser("ghost@checkfood.test", "BadPassword1!", "dev-1");

        assertThat(wrongPwd.getResponse().getStatus()).isEqualTo(401);
        assertThat(noAccount.getResponse().getStatus()).isEqualTo(401);
    }

    private MvcResult postForgotPassword(String email) throws Exception {
        ForgotPasswordRequest req = new ForgotPasswordRequest();
        req.setEmail(email);
        return mockMvc.perform(post("/api/auth/forgot-password")
                        .contentType(MediaType.APPLICATION_JSON)
                        .content(objectMapper.writeValueAsString(req)))
                .andReturn();
    }
}
