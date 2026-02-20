package com.checkfood.checkfoodservice.security.module.oauth.provider.google;

import com.checkfood.checkfoodservice.security.module.auth.provider.AuthProvider;
import com.checkfood.checkfoodservice.security.module.oauth.provider.OAuthClient;
import com.checkfood.checkfoodservice.security.module.oauth.provider.OAuthUserInfo;
import com.google.api.client.googleapis.auth.oauth2.GoogleIdToken;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Component;

/**
 * Implementace OAuth klienta pro poskytovatele Google.
 * Transformuje specifický GoogleIdToken na sjednocený OAuthUserInfo.
 */
@Component
@RequiredArgsConstructor
public class GoogleOAuthClient implements OAuthClient {

    private final GoogleIdTokenVerifier googleVerifier;

    @Override
    public OAuthUserInfo verifyAndGetUserInfo(String idToken) {
        // 1. Kryptografické ověření tokenu
        GoogleIdToken verifiedToken = googleVerifier.verify(idToken);
        GoogleIdToken.Payload payload = verifiedToken.getPayload();

        // 2. Extrakce a mapování dat do sjednoceného modelu
        return OAuthUserInfo.builder()
                .providerUserId(payload.getSubject()) // Unikátní Google ID (sub)
                .email(payload.getEmail())
                .fullName((String) payload.get("name"))
                .providerType(getProviderType())
                .build();
    }

    @Override
    public AuthProvider getProviderType() {
        return AuthProvider.GOOGLE;
    }
}