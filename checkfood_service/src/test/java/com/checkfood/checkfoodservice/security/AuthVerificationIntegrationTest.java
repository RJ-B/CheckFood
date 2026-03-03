package com.checkfood.checkfoodservice.security;

import com.checkfood.checkfoodservice.security.module.auth.dto.request.ResendCodeRequest;
import com.checkfood.checkfoodservice.security.module.auth.entity.VerificationTokenEntity;
import com.checkfood.checkfoodservice.security.module.user.entity.UserEntity;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.springframework.http.MediaType;

import java.time.LocalDateTime;
import java.util.UUID;

import static org.assertj.core.api.Assertions.assertThat;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.get;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.post;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.redirectedUrlPattern;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;

/**
 * Integration tests for the email verification and resend-code endpoints.
 *
 * GET  /api/auth/verify?token=...   - activates the account via redirect
 * POST /api/auth/resend-code        - re-sends the verification email
 *
 * The verify endpoint uses HttpServletResponse.sendRedirect() so all
 * assertions check for HTTP 302 and the redirect URL pattern.
 */
class AuthVerificationIntegrationTest extends BaseAuthIntegrationTest {

    // =========================================================================
    // GET /api/auth/verify - happy path
    // =========================================================================

    @Test
    @DisplayName("verify - valid token - redirects to success deep link and enables account")
    void verifyAccount_ValidToken_RedirectsSuccess() throws Exception {
        // Register a user (unverified)
        registerUser(TEST_EMAIL, TEST_PASSWORD, TEST_FIRST_NAME, TEST_LAST_NAME);

        // Retrieve the verification token that was created during registration
        UserEntity user = userRepository.findByEmail(TEST_EMAIL).orElseThrow();
        VerificationTokenEntity tokenEntity = verificationTokenRepository.findByUser(user).orElseThrow();
        String token = tokenEntity.getToken();

        // Perform the verification request
        mockMvc.perform(get("/api/auth/verify").param("token", token))
                .andExpect(status().isFound())
                .andExpect(redirectedUrlPattern("checkfood://app/login?status=success*"));

        // User should now be enabled
        UserEntity updatedUser = userRepository.findByEmail(TEST_EMAIL).orElseThrow();
        assertThat(updatedUser.isEnabled()).isTrue();

        // Verification token should be deleted after successful verification
        assertThat(verificationTokenRepository.findByToken(token)).isEmpty();
    }

    // =========================================================================
    // GET /api/auth/verify - invalid token
    // =========================================================================

    @Test
    @DisplayName("verify - invalid/non-existent token - redirects to error deep link")
    void verifyAccount_InvalidToken_RedirectsError() throws Exception {
        mockMvc.perform(get("/api/auth/verify").param("token", "non-existent-token-xyz"))
                .andExpect(status().isFound())
                .andExpect(redirectedUrlPattern("checkfood://app/login?status=error*"));
    }

    // =========================================================================
    // GET /api/auth/verify - expired token
    // =========================================================================

    @Test
    @DisplayName("verify - expired token - redirects to error deep link")
    void verifyAccount_ExpiredToken_RedirectsError() throws Exception {
        // Register a user
        registerUser(TEST_EMAIL, TEST_PASSWORD, TEST_FIRST_NAME, TEST_LAST_NAME);

        UserEntity user = userRepository.findByEmail(TEST_EMAIL).orElseThrow();

        // Delete the auto-created token and insert one that is already expired
        verificationTokenRepository.deleteAll();

        String expiredToken = UUID.randomUUID().toString();
        VerificationTokenEntity expired = VerificationTokenEntity.builder()
                .token(expiredToken)
                .user(user)
                .expiryDate(LocalDateTime.now().minusHours(1)) // Already expired
                .build();
        verificationTokenRepository.save(expired);

        // Attempt to verify with the expired token
        mockMvc.perform(get("/api/auth/verify").param("token", expiredToken))
                .andExpect(status().isFound())
                .andExpect(redirectedUrlPattern("checkfood://app/login?status=error*"));

        // User should still be disabled
        UserEntity stillDisabled = userRepository.findByEmail(TEST_EMAIL).orElseThrow();
        assertThat(stillDisabled.isEnabled()).isFalse();
    }

    // =========================================================================
    // GET /api/auth/verify - already verified (idempotent)
    // =========================================================================

    @Test
    @DisplayName("verify - already verified account - redirects to success (idempotent)")
    void verifyAccount_AlreadyVerified_Idempotent() throws Exception {
        // Register and manually verify the user
        registerUser(TEST_EMAIL, TEST_PASSWORD, TEST_FIRST_NAME, TEST_LAST_NAME);
        UserEntity user = userRepository.findByEmail(TEST_EMAIL).orElseThrow();

        // Get the token before enabling the user
        VerificationTokenEntity tokenEntity = verificationTokenRepository.findByUser(user).orElseThrow();
        String token = tokenEntity.getToken();

        // Enable the user directly (simulating a prior verification)
        user.setEnabled(true);
        userRepository.save(user);

        // Verifying again with the same valid token should still redirect to success
        // (the controller catches the already-verified case and redirects successfully)
        mockMvc.perform(get("/api/auth/verify").param("token", token))
                .andExpect(status().isFound())
                .andExpect(redirectedUrlPattern("checkfood://app/login?status=success*"));

        // User should still be enabled
        assertThat(userRepository.findByEmail(TEST_EMAIL).orElseThrow().isEnabled()).isTrue();
    }

    // =========================================================================
    // POST /api/auth/resend-code - unverified account
    // =========================================================================

    @Test
    @DisplayName("resend-code - unverified account - returns 200 OK")
    void resendCode_UnverifiedAccount_Returns200() throws Exception {
        // Register a user (unverified)
        registerUser(TEST_EMAIL, TEST_PASSWORD, TEST_FIRST_NAME, TEST_LAST_NAME);

        ResendCodeRequest request = ResendCodeRequest.builder()
                .email(TEST_EMAIL)
                .build();

        mockMvc.perform(post("/api/auth/resend-code")
                        .contentType(MediaType.APPLICATION_JSON)
                        .content(objectMapper.writeValueAsString(request)))
                .andExpect(status().isOk());

        // A new verification token should exist for the user
        UserEntity user = userRepository.findByEmail(TEST_EMAIL).orElseThrow();
        assertThat(verificationTokenRepository.findByUser(user)).isPresent();
    }

    // =========================================================================
    // POST /api/auth/resend-code - already verified account
    // =========================================================================

    @Test
    @DisplayName("resend-code - already verified account - returns 400 Bad Request")
    void resendCode_VerifiedAccount_Returns400() throws Exception {
        // Register and verify the user
        createVerifiedUser(TEST_EMAIL, TEST_PASSWORD, TEST_FIRST_NAME, TEST_LAST_NAME);

        ResendCodeRequest request = ResendCodeRequest.builder()
                .email(TEST_EMAIL)
                .build();

        mockMvc.perform(post("/api/auth/resend-code")
                        .contentType(MediaType.APPLICATION_JSON)
                        .content(objectMapper.writeValueAsString(request)))
                .andExpect(status().isBadRequest());
    }
}
