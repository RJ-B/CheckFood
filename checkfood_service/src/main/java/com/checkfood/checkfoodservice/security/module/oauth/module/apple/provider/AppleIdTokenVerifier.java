package com.checkfood.checkfoodservice.security.module.oauth.module.apple.provider;

import com.checkfood.checkfoodservice.security.module.oauth.exception.OAuthException;
import com.checkfood.checkfoodservice.security.module.oauth.module.apple.properties.AppleOAuthProperties;
import io.jsonwebtoken.Claims;
import io.jsonwebtoken.JwtException;
import io.jsonwebtoken.Jwts;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Component;

/**
 * Ověřovač Apple ID tokenů využívající dynamicky stahované veřejné klíče z Apple JWKS endpointu.
 *
 * @author Rostislav Jirák
 * @version 1.0.0
 */
@Component
@RequiredArgsConstructor
public class AppleIdTokenVerifier {

    private final AppleOAuthProperties appleProperties;
    private final AppleSigningKeyResolver signingKeyResolver;

    /**
     * Kryptograficky ověří Apple ID token a vrátí jeho claims.
     *
     * @param tokenString surový Apple ID token jako JWT řetězec
     * @return ověřené JWT claims
     * @throws OAuthException pokud je token neplatný, expirovaný nebo jeho podpis nelze ověřit
     */
    public Claims verify(String tokenString) {
        try {
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