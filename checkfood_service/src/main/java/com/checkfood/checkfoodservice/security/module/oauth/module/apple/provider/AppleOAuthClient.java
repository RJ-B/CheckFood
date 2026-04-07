package com.checkfood.checkfoodservice.security.module.oauth.module.apple.provider;

import com.checkfood.checkfoodservice.security.module.auth.provider.AuthProvider;
import com.checkfood.checkfoodservice.security.module.oauth.logging.OAuthLogger;
import com.checkfood.checkfoodservice.security.module.oauth.provider.OAuthClient;
import com.checkfood.checkfoodservice.security.module.oauth.provider.OAuthUserInfo;
import io.jsonwebtoken.Claims;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Component;

/**
 * Implementace OAuth klienta pro Apple Sign In.
 * Ověřuje Apple ID token a extrahuje data uživatele z JWT claims.
 *
 * @author Rostislav Jirák
 * @version 1.0.0
 */
@Component
@RequiredArgsConstructor
public class AppleOAuthClient implements OAuthClient {

    private final AppleIdTokenVerifier appleVerifier;
    private final OAuthLogger oauthLogger;

    /**
     * Ověří Apple ID token kryptograficky a extrahuje data uživatele.
     * Jméno uživatele není součástí tokenu (Apple ho posílá pouze při prvním přihlášení)
     * a musí být doplněno z dat přijatých v požadavku.
     *
     * @param idToken surový Apple ID token z mobilní aplikace
     * @return normalizovaná data uživatele
     */
    @Override
    public OAuthUserInfo verifyAndGetUserInfo(String idToken) {
        oauthLogger.logAuthenticationAttempt(getProviderType());

        Claims claims = appleVerifier.verify(idToken);

        String providerUserId = claims.getSubject();
        String email = claims.get("email", String.class);

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