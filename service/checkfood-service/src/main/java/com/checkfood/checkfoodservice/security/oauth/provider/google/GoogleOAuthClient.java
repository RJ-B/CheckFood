package com.checkfood.checkfoodservice.security.oauth.provider.google;

import com.checkfood.checkfoodservice.security.oauth.provider.OAuthClient;
import com.checkfood.checkfoodservice.security.oauth.provider.OAuthProviderType;
import com.checkfood.checkfoodservice.security.oauth.provider.OAuthUserInfo;

import lombok.RequiredArgsConstructor;

import org.springframework.security.oauth2.jwt.Jwt;
import org.springframework.stereotype.Component;

/**
 * OAuth klient pro Google Sign-In.
 *
 * Ověřuje ID token a mapuje jeho claims na OAuthUserInfo.
 */
@Component
@RequiredArgsConstructor
public class GoogleOAuthClient implements OAuthClient {

    private final GoogleIdTokenVerifier tokenVerifier;


    @Override
    public OAuthProviderType getProviderType() {
        return OAuthProviderType.GOOGLE;
    }


    @Override
    public OAuthUserInfo verifyAndExtractUserInfo(String idToken) {

        // Ověření tokenu přes Google JWKS
        Jwt jwt = tokenVerifier.verify(idToken);

        // Mapování claims
        String providerUserId = jwt.getSubject();
        String email = jwt.getClaimAsString("email");
        String fullName = jwt.getClaimAsString("name");

        return new OAuthUserInfo(
                providerUserId,
                email,
                fullName,
                OAuthProviderType.GOOGLE
        );
    }

}
