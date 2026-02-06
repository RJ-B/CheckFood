package com.checkfood.checkfoodservice.security.oauth.provider.google;

import com.checkfood.checkfoodservice.security.oauth.exception.OAuthTokenInvalidException;
import com.checkfood.checkfoodservice.security.oauth.properties.GoogleOAuthProperties;

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
 * Ověřovač Google ID tokenu (JWT).
 *
 * Ověřuje:
 * - podpis přes Google JWKS
 * - exp/nbf (standardní validace)
 * - issuer
 * - audience (clientId)
 */
@Component
@RequiredArgsConstructor
public class GoogleIdTokenVerifier {

    // Google publikuje veřejné klíče pro ověřování ID tokenů přes JWKS endpoint
    private static final String GOOGLE_JWKS_URI = "https://www.googleapis.com/oauth2/v3/certs";

    private final GoogleOAuthProperties googleOAuthProperties;

    private JwtDecoder jwtDecoder;


    @PostConstruct
    void init() {

        NimbusJwtDecoder decoder = NimbusJwtDecoder.withJwkSetUri(GOOGLE_JWKS_URI).build();

        OAuth2TokenValidator<Jwt> issuerValidator =
                JwtValidators.createDefaultWithIssuer(googleOAuthProperties.getIssuer());

        OAuth2TokenValidator<Jwt> audienceValidator = new AudienceValidator(googleOAuthProperties.getClientId());

        OAuth2TokenValidator<Jwt> validator =
                new DelegatingOAuth2TokenValidator<>(issuerValidator, audienceValidator);

        decoder.setJwtValidator(validator);

        this.jwtDecoder = decoder;
    }


    /**
     * Ověří Google ID token a vrátí dekódovaný JWT.
     */
    public Jwt verify(String idToken) {

        try {
            return jwtDecoder.decode(idToken);
        } catch (JwtException ex) {
            throw new OAuthTokenInvalidException("Google ID token is invalid", ex);
        }
    }


    /**
     * Validace audience (aud) = musí obsahovat náš Google clientId.
     */
    private static class AudienceValidator implements OAuth2TokenValidator<Jwt> {

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
                    "Invalid audience in Google ID token",
                    null
            );

            return OAuth2TokenValidatorResult.failure(error);
        }
    }

}
