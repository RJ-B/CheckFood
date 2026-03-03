package com.checkfood.checkfoodservice.security;

import com.checkfood.checkfoodservice.security.module.auth.dto.request.RegisterRequest;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.springframework.http.MediaType;

import static org.assertj.core.api.Assertions.assertThat;
import static org.mockito.ArgumentMatchers.anyString;
import static org.mockito.Mockito.verify;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.post;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;

/**
 * Integration tests for POST /api/auth/register.
 *
 * Verifies the complete registration flow including validation,
 * duplicate detection, password policy enforcement, and the
 * successful 202 Accepted happy path.
 */
class AuthRegistrationIntegrationTest extends BaseAuthIntegrationTest {

    // =========================================================================
    // Happy path
    // =========================================================================

    @Test
    @DisplayName("register - valid data - returns 202 Accepted and triggers verification email")
    void register_Success_Returns202() throws Exception {
        RegisterRequest request = RegisterRequest.builder()
                .firstName(TEST_FIRST_NAME)
                .lastName(TEST_LAST_NAME)
                .email(TEST_EMAIL)
                .password(TEST_PASSWORD)
                .build();

        mockMvc.perform(post("/api/auth/register")
                        .contentType(MediaType.APPLICATION_JSON)
                        .content(objectMapper.writeValueAsString(request)))
                .andExpect(status().isAccepted());

        // User should be persisted but not yet enabled
        var savedUser = userRepository.findByEmail(TEST_EMAIL);
        assertThat(savedUser).isPresent();
        assertThat(savedUser.get().isEnabled()).isFalse();
        assertThat(savedUser.get().getFirstName()).isEqualTo(TEST_FIRST_NAME);
        assertThat(savedUser.get().getLastName()).isEqualTo(TEST_LAST_NAME);

        // Verification token should exist
        assertThat(verificationTokenRepository.findByUser(savedUser.get())).isPresent();

        // Email service should have been called with the user's email
        verify(emailService).sendVerificationEmail(anyString(), anyString());
    }

    // =========================================================================
    // Duplicate email
    // =========================================================================

    @Test
    @DisplayName("register - duplicate email - returns 409 Conflict")
    void register_DuplicateEmail_Returns409() throws Exception {
        // First registration succeeds
        registerUser(TEST_EMAIL, TEST_PASSWORD, TEST_FIRST_NAME, TEST_LAST_NAME);

        // Second registration with the same email should fail
        RegisterRequest duplicate = RegisterRequest.builder()
                .firstName("Jiny")
                .lastName("Uzivatel")
                .email(TEST_EMAIL)
                .password(TEST_PASSWORD)
                .build();

        mockMvc.perform(post("/api/auth/register")
                        .contentType(MediaType.APPLICATION_JSON)
                        .content(objectMapper.writeValueAsString(duplicate)))
                .andExpect(status().isConflict());
    }

    // =========================================================================
    // Weak password
    // =========================================================================

    @Test
    @DisplayName("register - weak password (no special char) - returns 400 Bad Request")
    void register_WeakPassword_Returns400() throws Exception {
        RegisterRequest request = RegisterRequest.builder()
                .firstName(TEST_FIRST_NAME)
                .lastName(TEST_LAST_NAME)
                .email(TEST_EMAIL)
                .password("Weak1234")  // Missing special character
                .build();

        mockMvc.perform(post("/api/auth/register")
                        .contentType(MediaType.APPLICATION_JSON)
                        .content(objectMapper.writeValueAsString(request)))
                .andExpect(status().isBadRequest());

        // No user should have been persisted
        assertThat(userRepository.findByEmail(TEST_EMAIL)).isEmpty();
    }

    // =========================================================================
    // Missing required fields
    // =========================================================================

    @Test
    @DisplayName("register - missing required fields - returns 400 Bad Request")
    void register_MissingFields_Returns400() throws Exception {
        // Empty body - all required fields missing
        RegisterRequest request = RegisterRequest.builder().build();

        mockMvc.perform(post("/api/auth/register")
                        .contentType(MediaType.APPLICATION_JSON)
                        .content(objectMapper.writeValueAsString(request)))
                .andExpect(status().isBadRequest());

        // Also test with only email (missing firstName, lastName, password)
        RegisterRequest partialRequest = RegisterRequest.builder()
                .email(TEST_EMAIL)
                .build();

        mockMvc.perform(post("/api/auth/register")
                        .contentType(MediaType.APPLICATION_JSON)
                        .content(objectMapper.writeValueAsString(partialRequest)))
                .andExpect(status().isBadRequest());
    }

    // =========================================================================
    // Invalid email format
    // =========================================================================

    @Test
    @DisplayName("register - invalid email format - returns 400 Bad Request")
    void register_InvalidEmail_Returns400() throws Exception {
        RegisterRequest request = RegisterRequest.builder()
                .firstName(TEST_FIRST_NAME)
                .lastName(TEST_LAST_NAME)
                .email("not-an-email")
                .password(TEST_PASSWORD)
                .build();

        mockMvc.perform(post("/api/auth/register")
                        .contentType(MediaType.APPLICATION_JSON)
                        .content(objectMapper.writeValueAsString(request)))
                .andExpect(status().isBadRequest());

        // No user should have been persisted
        assertThat(userRepository.findByEmail("not-an-email")).isEmpty();
    }
}
