package com.checkfood.checkfoodservice.security.module.oauth.module.apple.provider;

import com.checkfood.checkfoodservice.security.module.oauth.exception.OAuthException;
import com.checkfood.checkfoodservice.security.module.oauth.module.apple.properties.AppleOAuthProperties;
import io.jsonwebtoken.Claims;
import io.jsonwebtoken.JwtException;
import io.jsonwebtoken.Jwts;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Component;

@Component
@RequiredArgsConstructor
public class AppleIdTokenVerifier {

    private final AppleOAuthProperties appleProperties;
    private final AppleSigningKeyResolver signingKeyResolver;

    public Claims verify(String tokenString) {
        try {
            // Odstraněn explicitní .json(...) - parser si deserializér najde automaticky
            return Jwts.parser()
                    .keyLocator(signingKeyResolver)
                    .requireIssuer(appleProperties.getIssuer())
                    .requireAudience(appleProperties.getClientId())
                    .build()
                    .parseSignedClaims(tokenString)
                    .getPayload();

        } catch (JwtException | IllegalArgumentException e) {
            throw OAuthException.invalidToken("Apple Token validation failed: " + e.getMessage());
        }
    }
}