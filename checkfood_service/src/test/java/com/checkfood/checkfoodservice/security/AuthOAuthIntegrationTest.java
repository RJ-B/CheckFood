package com.checkfood.checkfoodservice.security;

import com.checkfood.checkfoodservice.security.module.auth.provider.AuthProvider;
import com.checkfood.checkfoodservice.security.module.oauth.provider.OAuthClient;
import com.checkfood.checkfoodservice.security.module.oauth.provider.OAuthUserInfo;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.springframework.http.MediaType;

import java.util.LinkedHashMap;
import java.util.Map;

import static org.mockito.Mockito.mock;
import static org.mockito.Mockito.when;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.post;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.jsonPath;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;

/**
 * Integration tests for OAuth login flow.
 * Mocks the OAuthClientFactory to simulate Google and Apple token verification
 * without calling external provider APIs.
 * OAuthClientFactory is mocked in BaseAuthIntegrationTest.
 */
class AuthOAuthIntegrationTest extends BaseAuthIntegrationTest {

    private OAuthClient mockGoogleClient;
    private OAuthClient mockAppleClient;

    @BeforeEach
    void setUpOAuthMocks() {
        mockGoogleClient = mock(OAuthClient.class);
        mockAppleClient = mock(OAuthClient.class);

        when(mockGoogleClient.getProviderType()).thenReturn(AuthProvider.GOOGLE);
        when(mockAppleClient.getProviderType()).thenReturn(AuthProvider.APPLE);

        when(oauthClientFactory.getClient(AuthProvider.GOOGLE)).thenReturn(mockGoogleClient);
        when(oauthClientFactory.getClient(AuthProvider.APPLE)).thenReturn(mockAppleClient);
    }

    @Test
    @DisplayName("POST /api/oauth/login - Google OAuth with valid token returns auth response")
    void googleOAuth_ValidToken_ReturnsAuthResponse() throws Exception {
        // Arrange: mock the Google client to return valid user info
        when(mockGoogleClient.verifyAndGetUserInfo("valid-google-token")).thenReturn(
                OAuthUserInfo.builder()
                        .email("google@test.com")
                        .firstName("Google")
                        .lastName("User")
                        .providerUserId("google-123")
                        .providerType(AuthProvider.GOOGLE)
                        .build()
        );

        Map<String, Object> request = buildOAuthRequest(
                "GOOGLE", "valid-google-token",
                "google@test.com", "Google", "User",
                "google-device-001", "Pixel 9", "ANDROID"
        );

        // Act & Assert
        mockMvc.perform(post("/api/oauth/login")
                        .contentType(MediaType.APPLICATION_JSON)
                        .content(objectMapper.writeValueAsString(request)))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.accessToken").exists())
                .andExpect(jsonPath("$.refreshToken").exists())
                .andExpect(jsonPath("$.tokenType").value("Bearer"))
                .andExpect(jsonPath("$.user.email").value("google@test.com"));
    }

    @Test
    @DisplayName("POST /api/oauth/login - Apple OAuth with valid token returns auth response")
    void appleOAuth_ValidToken_ReturnsAuthResponse() throws Exception {
        // Arrange: mock the Apple client to return valid user info
        when(mockAppleClient.verifyAndGetUserInfo("valid-apple-token")).thenReturn(
                OAuthUserInfo.builder()
                        .email("apple@test.com")
                        .firstName("Apple")
                        .lastName("User")
                        .providerUserId("apple-456")
                        .providerType(AuthProvider.APPLE)
                        .build()
        );

        Map<String, Object> request = buildOAuthRequest(
                "APPLE", "valid-apple-token",
                "apple@test.com", "Apple", "User",
                "apple-device-001", "iPhone 16", "IOS"
        );

        // Act & Assert
        mockMvc.perform(post("/api/oauth/login")
                        .contentType(MediaType.APPLICATION_JSON)
                        .content(objectMapper.writeValueAsString(request)))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.accessToken").exists())
                .andExpect(jsonPath("$.refreshToken").exists())
                .andExpect(jsonPath("$.user.email").value("apple@test.com"));
    }

    @Test
    @DisplayName("POST /api/oauth/login - OAuth with missing email from provider returns error")
    void oauth_MissingEmail_ReturnsError() throws Exception {
        // Arrange: mock the Google client to return user info WITHOUT an email
        when(mockGoogleClient.verifyAndGetUserInfo("token-no-email")).thenReturn(
                OAuthUserInfo.builder()
                        .email(null)
                        .firstName("NoEmail")
                        .lastName("User")
                        .providerUserId("google-no-email")
                        .providerType(AuthProvider.GOOGLE)
                        .build()
        );

        Map<String, Object> request = buildOAuthRequest(
                "GOOGLE", "token-no-email",
                null, "NoEmail", "User",
                "device-no-email", "Test Device", "ANDROID"
        );

        // Act & Assert: OAuthServiceImpl throws OAuthException.userDataMissing -> 400
        mockMvc.perform(post("/api/oauth/login")
                        .contentType(MediaType.APPLICATION_JSON)
                        .content(objectMapper.writeValueAsString(request)))
                .andExpect(status().isBadRequest());
    }

    @Test
    @DisplayName("POST /api/oauth/login - unsupported provider returns error")
    void oauth_UnsupportedProvider_ReturnsError() throws Exception {
        // Arrange: send LOCAL as provider, which is not a valid OAuth provider.
        // Since the factory is fully mocked, we simulate the "not supported" behavior
        // by making the factory throw OAuthException for LOCAL provider.
        com.checkfood.checkfoodservice.security.module.oauth.exception.OAuthException notSupported =
                com.checkfood.checkfoodservice.security.module.oauth.exception.OAuthException
                        .providerNotSupported("LOCAL");
        when(oauthClientFactory.getClient(AuthProvider.LOCAL)).thenThrow(notSupported);

        Map<String, Object> request = buildOAuthRequest(
                "LOCAL", "some-token",
                "local@test.com", "Local", "User",
                "device-local", "Test Device", "ANDROID"
        );

        // Act & Assert: OAuthServiceImpl catches the exception in its generic catch block
        // and re-throws as OAuthException.invalidToken() which has HTTP 401
        mockMvc.perform(post("/api/oauth/login")
                        .contentType(MediaType.APPLICATION_JSON)
                        .content(objectMapper.writeValueAsString(request)))
                .andExpect(status().isUnauthorized());
    }

    // --- Helper ---

    /**
     * Builds an OAuth login request body as a Map for JSON serialization.
     * Using a Map avoids coupling to OAuthLoginRequest setter availability.
     */
    private Map<String, Object> buildOAuthRequest(
            String provider, String idToken,
            String email, String firstName, String lastName,
            String deviceIdentifier, String deviceName, String deviceType
    ) {
        Map<String, Object> map = new LinkedHashMap<>();
        map.put("provider", provider);
        map.put("idToken", idToken);
        map.put("email", email);
        map.put("firstName", firstName);
        map.put("lastName", lastName);
        map.put("deviceIdentifier", deviceIdentifier);
        map.put("deviceName", deviceName);
        map.put("deviceType", deviceType);
        return map;
    }
}
