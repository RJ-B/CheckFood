package com.checkfood.checkfoodservice.security.module.oauth.module.apple.provider;

import com.checkfood.checkfoodservice.security.module.auth.provider.AuthProvider;
import com.checkfood.checkfoodservice.security.module.oauth.logging.OAuthLogger;
import com.checkfood.checkfoodservice.security.module.oauth.provider.OAuthClient;
import com.checkfood.checkfoodservice.security.module.oauth.provider.OAuthUserInfo;
import io.jsonwebtoken.Claims;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Component;

@Component
@RequiredArgsConstructor
public class AppleOAuthClient implements OAuthClient {

    private final AppleIdTokenVerifier appleVerifier;
    private final OAuthLogger oauthLogger;

    @Override
    public OAuthUserInfo verifyAndGetUserInfo(String idToken) {
        // Logování pokusu
        oauthLogger.logAuthenticationAttempt(getProviderType());

        // Verifikace
        Claims claims = appleVerifier.verify(idToken);

        String providerUserId = claims.getSubject();
        String email = claims.get("email", String.class);

        // Poznámka: Apple tokeny obsahují email, ale neobsahují jméno (to chodí jen při prvním req).
        // To řešíme v OAuthServiceImpl (enrichUserInfoWithName).

        oauthLogger.logProviderVerificationSuccess(getProviderType(), providerUserId);

        return OAuthUserInfo.builder()
                .providerUserId(providerUserId)
                .email(email)
                .providerType(getProviderType())
                .build();
    }

    @Override
    public AuthProvider getProviderType() {
        return AuthProvider.APPLE;
    }
}