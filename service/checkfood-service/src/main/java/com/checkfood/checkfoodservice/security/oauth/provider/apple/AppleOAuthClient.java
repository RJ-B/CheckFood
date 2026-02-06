package com.checkfood.checkfoodservice.security.oauth.provider.apple;

import com.checkfood.checkfoodservice.security.oauth.provider.OAuthClient;
import com.checkfood.checkfoodservice.security.oauth.provider.OAuthProviderType;
import com.checkfood.checkfoodservice.security.oauth.provider.OAuthUserInfo;

import lombok.RequiredArgsConstructor;

import org.springframework.security.oauth2.jwt.Jwt;
import org.springframework.stereotype.Component;

/**
 * OAuth klient pro Apple Sign-In.
 *
 * Ověřuje ID token a mapuje claims na OAuthUserInfo.
 */
@Component
@RequiredArgsConstructor
public class AppleOAuthClient implements OAuthClient {

    private final AppleIdTokenVerifier tokenVerifier;


    @Override
    public OAuthProviderType getProviderType() {
        return OAuthProviderType.APPLE;
    }


    @Override
    public OAuthUserInfo verifyAndExtractUserInfo(String idToken) {

        // Ověření tokenu přes Apple
        Jwt jwt = tokenVerifier.verify(idToken);

        // Mapování claims
        String providerUserId = jwt.getSubject();
        String email = jwt.getClaimAsString("email");

        String firstName = jwt.getClaimAsString("given_name");
        String lastName = jwt.getClaimAsString("family_name");

        String fullName = null;

        if (firstName != null || lastName != null) {
            fullName = String.format(
                    "%s %s",
                    firstName != null ? firstName : "",
                    lastName != null ? lastName : ""
            ).trim();
        }

        return new OAuthUserInfo(
                providerUserId,
                email,
                fullName,
                OAuthProviderType.APPLE
        );
    }

}
