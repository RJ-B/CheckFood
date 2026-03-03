package com.checkfood.checkfoodservice.security;

import com.checkfood.checkfoodservice.security.module.auth.dto.request.LoginRequest;
import com.checkfood.checkfoodservice.security.module.auth.dto.request.RegisterRequest;
import com.checkfood.checkfoodservice.security.module.auth.email.EmailService;
import com.checkfood.checkfoodservice.security.module.auth.repository.VerificationTokenRepository;
import com.checkfood.checkfoodservice.security.module.oauth.provider.OAuthClientFactory;
import com.checkfood.checkfoodservice.security.module.user.entity.RoleEntity;
import com.checkfood.checkfoodservice.security.module.user.entity.UserEntity;
import com.checkfood.checkfoodservice.security.module.user.repository.DeviceRepository;
import com.checkfood.checkfoodservice.security.module.user.repository.RoleRepository;
import com.checkfood.checkfoodservice.security.module.user.repository.UserRepository;
import com.checkfood.checkfoodservice.security.ratelimit.service.RateLimitService;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import org.junit.jupiter.api.BeforeEach;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.web.servlet.AutoConfigureMockMvc;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.http.MediaType;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.test.context.ActiveProfiles;
import org.springframework.test.context.bean.override.mockito.MockitoBean;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.MvcResult;

import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.post;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;

/**
 * Abstract base class for authentication integration tests.
 *
 * Provides shared infrastructure including MockMvc, test data constants,
 * database cleanup, role bootstrapping, and helper methods for the full
 * register-verify-login lifecycle used across all auth test suites.
 */
@SpringBootTest(webEnvironment = SpringBootTest.WebEnvironment.MOCK)
@ActiveProfiles("test")
@AutoConfigureMockMvc
public abstract class BaseAuthIntegrationTest {

    // =========================================================================
    // Test constants
    // =========================================================================

    protected static final String TEST_EMAIL = "testuser@checkfood.test";
    protected static final String TEST_PASSWORD = "Test1234!";
    protected static final String TEST_FIRST_NAME = "Jan";
    protected static final String TEST_LAST_NAME = "Novak";
    protected static final String TEST_DEVICE_ID = "test-device-001";
    protected static final String TEST_DEVICE_NAME = "Integration Test Device";
    protected static final String TEST_DEVICE_TYPE = "ANDROID";

    // =========================================================================
    // Injected dependencies
    // =========================================================================

    @Autowired
    protected MockMvc mockMvc;

    @Autowired
    protected ObjectMapper objectMapper;

    @Autowired
    protected UserRepository userRepository;

    @Autowired
    protected DeviceRepository deviceRepository;

    @Autowired
    protected VerificationTokenRepository verificationTokenRepository;

    @Autowired
    protected PasswordEncoder passwordEncoder;

    @Autowired
    protected RoleRepository roleRepository;

    @Autowired
    protected RateLimitService rateLimitService;

    /**
     * EmailService is mocked to prevent real email delivery during tests.
     * The mock is application-context-wide so all service-layer code that
     * depends on EmailService will receive this mock automatically.
     */
    @MockitoBean
    protected EmailService emailService;

    /**
     * OAuthClientFactory is mocked so all test classes share the same Spring
     * context (prevents H2 DB state pollution from multiple contexts).
     */
    @MockitoBean
    protected OAuthClientFactory oauthClientFactory;

    // =========================================================================
    // Setup / teardown
    // =========================================================================

    /**
     * Cleans all transactional data before each test while preserving
     * reference data (roles). Ensures role "USER" and "ADMIN" exist for
     * the registration flow that assigns the default role.
     */
    @BeforeEach
    void setUpBase() {
        // Clear rate limiter state to prevent cross-test rate limit pollution
        rateLimitService.reset();

        // Order matters: verification tokens reference users, devices reference users
        verificationTokenRepository.deleteAll();
        deviceRepository.deleteAll();
        userRepository.deleteAll();

        // Ensure required roles exist (idempotent)
        ensureRoleExists("USER");
        ensureRoleExists("ADMIN");
    }

    // =========================================================================
    // Helper methods
    // =========================================================================

    /**
     * Performs a POST /api/auth/register request and returns the raw MvcResult.
     */
    protected MvcResult registerUser(String email, String password,
                                     String firstName, String lastName) throws Exception {
        RegisterRequest request = RegisterRequest.builder()
                .email(email)
                .password(password)
                .firstName(firstName)
                .lastName(lastName)
                .build();

        return mockMvc.perform(post("/api/auth/register")
                        .contentType(MediaType.APPLICATION_JSON)
                        .content(objectMapper.writeValueAsString(request)))
                .andReturn();
    }

    /**
     * Directly enables a user account in the database, bypassing the email
     * verification workflow. This is the fastest path for tests that need
     * an already-verified user.
     */
    protected void verifyUser(String email) {
        UserEntity user = userRepository.findByEmail(email)
                .orElseThrow(() -> new IllegalStateException(
                        "Cannot verify non-existent user: " + email));
        user.setEnabled(true);
        userRepository.save(user);
    }

    /**
     * Performs a POST /api/auth/login and returns the raw MvcResult.
     */
    protected MvcResult loginUser(String email, String password,
                                  String deviceId) throws Exception {
        LoginRequest request = LoginRequest.builder()
                .email(email)
                .password(password)
                .deviceIdentifier(deviceId)
                .deviceName(TEST_DEVICE_NAME)
                .deviceType(TEST_DEVICE_TYPE)
                .build();

        return mockMvc.perform(post("/api/auth/login")
                        .contentType(MediaType.APPLICATION_JSON)
                        .content(objectMapper.writeValueAsString(request)))
                .andReturn();
    }

    /**
     * Convenience method: registers a user AND directly verifies them in
     * the database so they are ready to log in.
     *
     * @return the MvcResult of the registration request
     */
    protected MvcResult createVerifiedUser(String email, String password,
                                           String firstName, String lastName) throws Exception {
        MvcResult result = registerUser(email, password, firstName, lastName);
        verifyUser(email);
        return result;
    }

    /**
     * Full lifecycle helper: register, verify, login, and extract the
     * access token from the login response.
     *
     * @return the JWT access token string
     */
    protected String getAccessToken(String email, String password,
                                    String deviceId) throws Exception {
        createVerifiedUser(email, password, TEST_FIRST_NAME, TEST_LAST_NAME);

        MvcResult loginResult = mockMvc.perform(post("/api/auth/login")
                        .contentType(MediaType.APPLICATION_JSON)
                        .content(objectMapper.writeValueAsString(
                                LoginRequest.builder()
                                        .email(email)
                                        .password(password)
                                        .deviceIdentifier(deviceId)
                                        .deviceName(TEST_DEVICE_NAME)
                                        .deviceType(TEST_DEVICE_TYPE)
                                        .build())))
                .andExpect(status().isOk())
                .andReturn();

        JsonNode body = objectMapper.readTree(loginResult.getResponse().getContentAsString());
        return body.get("accessToken").asText();
    }

    /**
     * Parses a login / refresh response body and returns the full JSON tree.
     */
    protected JsonNode parseResponseBody(MvcResult result) throws Exception {
        return objectMapper.readTree(result.getResponse().getContentAsString());
    }

    // =========================================================================
    // Private helpers
    // =========================================================================

    private void ensureRoleExists(String roleName) {
        if (!roleRepository.existsByName(roleName)) {
            roleRepository.save(new RoleEntity(roleName));
        }
    }
}
