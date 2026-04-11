package com.checkfood.checkfoodservice.security.module.oauth;

import com.checkfood.checkfoodservice.security.BaseAuthIntegrationTest;
import com.checkfood.checkfoodservice.security.module.auth.provider.AuthProvider;
import com.checkfood.checkfoodservice.security.module.oauth.dto.request.OAuthLoginRequest;
import com.checkfood.checkfoodservice.security.module.oauth.exception.OAuthException;
import com.checkfood.checkfoodservice.security.module.oauth.provider.OAuthClient;
import com.checkfood.checkfoodservice.security.module.oauth.provider.OAuthUserInfo;
import com.checkfood.checkfoodservice.security.module.user.entity.UserEntity;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.springframework.http.MediaType;

import static org.assertj.core.api.Assertions.assertThat;
import static org.mockito.ArgumentMatchers.anyString;
import static org.mockito.Mockito.mock;
import static org.mockito.Mockito.when;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.post;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.*;

@DisplayName("OAuthController integration tests")
class OAuthLoginIntegrationTest extends BaseAuthIntegrationTest {

    private static final String GOOGLE_ID_TOKEN = "fake-google-id-token";
    private static final String APPLE_ID_TOKEN  = "fake-apple-id-token";

    // =========================================================================
    // Happy path — Google new user
    // =========================================================================

    @Test
    @DisplayName("POST /oauth/login — Google new user is created and tokens returned")
    void should_createUser_and_returnTokens_when_googleFirstLogin() throws Exception {
        stubOAuthClient(AuthProvider.GOOGLE, buildUserInfo(
                AuthProvider.GOOGLE, "google-sub-001", "newgoogle@checkfood.test", "Google", "User"));

        OAuthLoginRequest req = buildRequest(GOOGLE_ID_TOKEN, AuthProvider.GOOGLE,
                "device-g-001", "Android", "ANDROID");

        mockMvc.perform(post("/api/oauth/login")
                        .contentType(MediaType.APPLICATION_JSON)
                        .content(objectMapper.writeValueAsString(req)))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.accessToken").isNotEmpty())
                .andExpect(jsonPath("$.refreshToken").isNotEmpty());

        assertThat(userRepository.findByEmail("newgoogle@checkfood.test")).isPresent();
        UserEntity created = userRepository.findByEmail("newgoogle@checkfood.test").orElseThrow();
        assertThat(created.isEnabled()).isTrue();
        assertThat(created.getAuthProvider()).isEqualTo(AuthProvider.GOOGLE);
    }

    // =========================================================================
    // Happy path — Google returning user (same provider, same sub)
    // =========================================================================

    @Test
    @DisplayName("POST /oauth/login — Google returning user merges by provider+sub")
    void should_mergeExistingUser_when_sameProviderAndSub() throws Exception {
        stubOAuthClient(AuthProvider.GOOGLE, buildUserInfo(
                AuthProvider.GOOGLE, "google-sub-002", "returning@checkfood.test", "Ret", "User"));

        OAuthLoginRequest req = buildRequest(GOOGLE_ID_TOKEN, AuthProvider.GOOGLE,
                "device-r-001", "iPhone", "IOS");

        // First call — create
        mockMvc.perform(post("/api/oauth/login")
                        .contentType(MediaType.APPLICATION_JSON)
                        .content(objectMapper.writeValueAsString(req)))
                .andExpect(status().isOk());

        long countBefore = userRepository.count();

        // Second call — merge, no new user
        mockMvc.perform(post("/api/oauth/login")
                        .contentType(MediaType.APPLICATION_JSON)
                        .content(objectMapper.writeValueAsString(req)))
                .andExpect(status().isOk());

        assertThat(userRepository.count()).isEqualTo(countBefore);
    }

    // =========================================================================
    // Happy path — Apple with name supplied in request (Apple hides name after first)
    // =========================================================================

    @Test
    @DisplayName("POST /oauth/login — Apple first login with name in request body")
    void should_createAppleUser_withNameFromRequest_when_providerNameMissing() throws Exception {
        // Apple returns info without name
        OAuthUserInfo appleInfo = OAuthUserInfo.builder()
                .providerUserId("apple-sub-001")
                .email("apple@checkfood.test")
                .firstName(null)
                .lastName(null)
                .providerType(AuthProvider.APPLE)
                .build();

        stubOAuthClient(AuthProvider.APPLE, appleInfo);

        OAuthLoginRequest req = new OAuthLoginRequest();
        req.setIdToken(APPLE_ID_TOKEN);
        req.setProvider(AuthProvider.APPLE);
        req.setEmail("apple@checkfood.test");
        req.setFirstName("Apple");
        req.setLastName("User");
        req.setDeviceIdentifier("device-a-001");
        req.setDeviceName("iPhone 15");
        req.setDeviceType("IOS");

        mockMvc.perform(post("/api/oauth/login")
                        .contentType(MediaType.APPLICATION_JSON)
                        .content(objectMapper.writeValueAsString(req)))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.accessToken").isNotEmpty());

        UserEntity created = userRepository.findByEmail("apple@checkfood.test").orElseThrow();
        assertThat(created.getFirstName()).isEqualTo("Apple");
    }

    // =========================================================================
    // Email collision — same email, different provider
    // =========================================================================

    @Test
    @DisplayName("POST /oauth/login — email already registered with LOCAL → 4xx provider mismatch")
    void should_return4xx_when_emailExistsWithDifferentProvider() throws Exception {
        // Register a LOCAL user first
        createVerifiedUser("collision@checkfood.test", TEST_PASSWORD, "Local", "User");

        // Now try Google OAuth with same email
        stubOAuthClient(AuthProvider.GOOGLE, buildUserInfo(
                AuthProvider.GOOGLE, "google-sub-collide", "collision@checkfood.test", "Google", "User"));

        OAuthLoginRequest req = buildRequest(GOOGLE_ID_TOKEN, AuthProvider.GOOGLE,
                "device-c-001", "Android", "ANDROID");

        mockMvc.perform(post("/api/oauth/login")
                        .contentType(MediaType.APPLICATION_JSON)
                        .content(objectMapper.writeValueAsString(req)))
                .andExpect(status().is4xxClientError());
    }

    // =========================================================================
    // Missing email from provider
    // =========================================================================

    @Test
    @DisplayName("POST /oauth/login — provider returns null email → 4xx")
    void should_return4xx_when_providerReturnsNullEmail() throws Exception {
        OAuthUserInfo noEmail = OAuthUserInfo.builder()
                .providerUserId("no-email-sub")
                .email(null)
                .firstName("No")
                .lastName("Email")
                .providerType(AuthProvider.GOOGLE)
                .build();

        stubOAuthClient(AuthProvider.GOOGLE, noEmail);

        OAuthLoginRequest req = buildRequest(GOOGLE_ID_TOKEN, AuthProvider.GOOGLE,
                "device-ne-001", "Android", "ANDROID");

        mockMvc.perform(post("/api/oauth/login")
                        .contentType(MediaType.APPLICATION_JSON)
                        .content(objectMapper.writeValueAsString(req)))
                .andExpect(status().is4xxClientError());
    }

    @Test
    @DisplayName("POST /oauth/login — provider returns blank email → 4xx")
    void should_return4xx_when_providerReturnsBlankEmail() throws Exception {
        OAuthUserInfo blankEmail = OAuthUserInfo.builder()
                .providerUserId("blank-email-sub")
                .email("   ")
                .firstName("Blank")
                .lastName("Email")
                .providerType(AuthProvider.GOOGLE)
                .build();

        stubOAuthClient(AuthProvider.GOOGLE, blankEmail);

        OAuthLoginRequest req = buildRequest(GOOGLE_ID_TOKEN, AuthProvider.GOOGLE,
                "device-be-001", "Android", "ANDROID");

        mockMvc.perform(post("/api/oauth/login")
                        .contentType(MediaType.APPLICATION_JSON)
                        .content(objectMapper.writeValueAsString(req)))
                .andExpect(status().is4xxClientError());
    }

    // =========================================================================
    // Invalid / expired token
    // =========================================================================

    @Test
    @DisplayName("POST /oauth/login — provider throws on token verification → 4xx")
    void should_return4xx_when_providerThrowsOnVerification() throws Exception {
        OAuthClient mockClient = mock(OAuthClient.class);
        when(mockClient.getProviderType()).thenReturn(AuthProvider.GOOGLE);
        when(mockClient.verifyAndGetUserInfo(anyString()))
                .thenThrow(new RuntimeException("Token signature invalid"));
        when(oauthClientFactory.getClient(AuthProvider.GOOGLE)).thenReturn(mockClient);

        OAuthLoginRequest req = buildRequest("bad-token", AuthProvider.GOOGLE,
                "device-bad-001", "Android", "ANDROID");

        mockMvc.perform(post("/api/oauth/login")
                        .contentType(MediaType.APPLICATION_JSON)
                        .content(objectMapper.writeValueAsString(req)))
                .andExpect(status().is4xxClientError());
    }

    // =========================================================================
    // Validation — DTO constraints
    // =========================================================================

    @Test
    @DisplayName("POST /oauth/login — blank idToken → 400")
    void should_return400_when_blankIdToken() throws Exception {
        OAuthLoginRequest req = buildRequest("", AuthProvider.GOOGLE,
                "device-v-001", "Android", "ANDROID");

        mockMvc.perform(post("/api/oauth/login")
                        .contentType(MediaType.APPLICATION_JSON)
                        .content(objectMapper.writeValueAsString(req)))
                .andExpect(status().isBadRequest());
    }

    @Test
    @DisplayName("POST /oauth/login — null provider → 400")
    void should_return400_when_nullProvider() throws Exception {
        String body = "{\"idToken\":\"some-token\",\"deviceIdentifier\":\"d1\",\"deviceName\":\"Dev\",\"deviceType\":\"ANDROID\"}";

        mockMvc.perform(post("/api/oauth/login")
                        .contentType(MediaType.APPLICATION_JSON)
                        .content(body))
                .andExpect(status().isBadRequest());
    }

    @Test
    @DisplayName("POST /oauth/login — blank deviceIdentifier → 400")
    void should_return400_when_blankDeviceIdentifier() throws Exception {
        OAuthLoginRequest req = buildRequest(GOOGLE_ID_TOKEN, AuthProvider.GOOGLE,
                "", "Android", "ANDROID");

        mockMvc.perform(post("/api/oauth/login")
                        .contentType(MediaType.APPLICATION_JSON)
                        .content(objectMapper.writeValueAsString(req)))
                .andExpect(status().isBadRequest());
    }

    @Test
    @DisplayName("POST /oauth/login — blank deviceName → 400")
    void should_return400_when_blankDeviceName() throws Exception {
        OAuthLoginRequest req = buildRequest(GOOGLE_ID_TOKEN, AuthProvider.GOOGLE,
                "device-v-002", "", "ANDROID");

        mockMvc.perform(post("/api/oauth/login")
                        .contentType(MediaType.APPLICATION_JSON)
                        .content(objectMapper.writeValueAsString(req)))
                .andExpect(status().isBadRequest());
    }

    @Test
    @DisplayName("POST /oauth/login — blank deviceType → 400")
    void should_return400_when_blankDeviceType() throws Exception {
        OAuthLoginRequest req = buildRequest(GOOGLE_ID_TOKEN, AuthProvider.GOOGLE,
                "device-v-003", "Android", "");

        mockMvc.perform(post("/api/oauth/login")
                        .contentType(MediaType.APPLICATION_JSON)
                        .content(objectMapper.writeValueAsString(req)))
                .andExpect(status().isBadRequest());
    }

    // =========================================================================
    // Rate limiting surfaced
    // =========================================================================

    // GAP: rate limiter fires after 5 req/min per IP — no pagination gap here,
    //      but 6th consecutive call should return 429
    @Test
    @DisplayName("POST /oauth/login — 6th call within 1 min should be rate-limited → 429")
    void should_return429_when_oauthRateLimitExceeded() throws Exception {
        stubOAuthClient(AuthProvider.GOOGLE, buildUserInfo(
                AuthProvider.GOOGLE, "rl-sub", "ratelimit@checkfood.test", "RL", "User"));

        OAuthLoginRequest req = buildRequest(GOOGLE_ID_TOKEN, AuthProvider.GOOGLE,
                "rl-device", "Android", "ANDROID");

        for (int i = 0; i < 5; i++) {
            mockMvc.perform(post("/api/oauth/login")
                            .contentType(MediaType.APPLICATION_JSON)
                            .content(objectMapper.writeValueAsString(req)));
        }

        mockMvc.perform(post("/api/oauth/login")
                        .contentType(MediaType.APPLICATION_JSON)
                        .content(objectMapper.writeValueAsString(req)))
                .andExpect(status().isTooManyRequests());
    }

    // =========================================================================
    // Private helpers
    // =========================================================================

    private void stubOAuthClient(AuthProvider provider, OAuthUserInfo info) {
        OAuthClient mockClient = mock(OAuthClient.class);
        when(mockClient.getProviderType()).thenReturn(provider);
        when(mockClient.verifyAndGetUserInfo(anyString())).thenReturn(info);
        when(oauthClientFactory.getClient(provider)).thenReturn(mockClient);
    }

    private OAuthUserInfo buildUserInfo(AuthProvider provider, String sub,
                                        String email, String first, String last) {
        return OAuthUserInfo.builder()
                .providerUserId(sub)
                .email(email)
                .firstName(first)
                .lastName(last)
                .providerType(provider)
                .build();
    }

    private OAuthLoginRequest buildRequest(String idToken, AuthProvider provider,
                                           String deviceId, String deviceName, String deviceType) {
        OAuthLoginRequest req = new OAuthLoginRequest();
        req.setIdToken(idToken);
        req.setProvider(provider);
        req.setDeviceIdentifier(deviceId);
        req.setDeviceName(deviceName);
        req.setDeviceType(deviceType);
        return req;
    }
}
