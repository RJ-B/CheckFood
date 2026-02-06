package com.checkfood.checkfoodservice.security.oauth.provider.apple;

import com.checkfood.checkfoodservice.security.oauth.exception.OAuthTokenInvalidException;
import com.checkfood.checkfoodservice.security.oauth.properties.AppleOAuthProperties;

import jakarta.annotation.PostConstruct;

import lombok.RequiredArgsConstructor;

import org.springframework.security.oauth2.core.DelegatingOAuth2TokenValidator;
import org.springframework.security.oauth2.core.OAuth2Error;
import org.springframework.security.oauth2.core.OAuth2TokenValidator;
import org.springframework.security.oauth2.core.OAuth2TokenValidatorResult;

import org.springframework.security.oauth2.jwt.Jwt;
import org.springframework.security.oauth2.jwt.JwtDecoder;
import org.springframework.security.oauth2.jwt.JwtException;
import org.springframework.security.oauth2.jwt.JwtValidators;
import org.springframework.security.oauth2.jwt.NimbusJwtDecoder;

import org.springframework.stereotype.Component;

import java.util.List;

/**
 * Ověřovač Apple ID tokenu.
 *
 * Validuje:
 * - podpis (Apple JWKS)
 * - issuer
 * - audience
 * - exp / nbf
 */
@Component
@RequiredArgsConstructor
public class AppleIdTokenVerifier {

    // Apple JWKS endpoint
    private static final String APPLE_JWKS_URI =
            "https://appleid.apple.com/auth/keys";

    private final AppleOAuthProperties appleProperties;

    private JwtDecoder jwtDecoder;


    @PostConstruct
    void init() {

        NimbusJwtDecoder decoder =
                NimbusJwtDecoder.withJwkSetUri(APPLE_JWKS_URI).build();

        OAuth2TokenValidator<Jwt> issuerValidator =
                JwtValidators.createDefaultWithIssuer(
                        appleProperties.getIssuer()
                );

        OAuth2TokenValidator<Jwt> audienceValidator =
                new AudienceValidator(appleProperties.getClientId());

        OAuth2TokenValidator<Jwt> validator =
                new DelegatingOAuth2TokenValidator<>(
                        issuerValidator,
                        audienceValidator
                );

        decoder.setJwtValidator(validator);

        this.jwtDecoder = decoder;
    }


    /**
     * Ověří Apple ID token.
     */
    public Jwt verify(String idToken) {

        try {
            return jwtDecoder.decode(idToken);

        } catch (JwtException ex) {

            throw new OAuthTokenInvalidException(
                    "Apple ID token is invalid",
                    ex
            );
        }
    }


    /**
     * Kontrola audience (aud).
     */
    private static class AudienceValidator
            implements OAuth2TokenValidator<Jwt> {

        private final String expectedClientId;


        private AudienceValidator(String expectedClientId) {
            this.expectedClientId = expectedClientId;
        }


        @Override
        public OAuth2TokenValidatorResult validate(Jwt token) {

            List<String> audience = token.getAudience();

            if (audience != null && audience.contains(expectedClientId)) {
                return OAuth2TokenValidatorResult.success();
            }

            OAuth2Error error = new OAuth2Error(
                    "invalid_token",
                    "Invalid audience in Apple ID token",
                    null
            );

            return OAuth2TokenValidatorResult.failure(error);
        }
    }

}
