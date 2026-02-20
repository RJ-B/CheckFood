package com.checkfood.checkfoodservice.security.module.oauth.provider.apple;

import com.checkfood.checkfoodservice.security.module.oauth.exception.OAuthTokenInvalidException;
import com.checkfood.checkfoodservice.security.module.oauth.properties.AppleOAuthProperties;
import io.jsonwebtoken.Claims;
import io.jsonwebtoken.Jwts;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Component;

/**
 * Finální komponenta pro validaci Apple Identity Tokenů.
 * Využívá AppleSigningKeyResolver pro dynamické ověření digitálního podpisu RS256.
 */
@Slf4j
@Component
@RequiredArgsConstructor
public class AppleIdTokenVerifier {

    private final AppleOAuthProperties appleProperties;
    private final AppleSigningKeyResolver appleSigningKeyResolver;

    /**
     * Provede kompletní validaci Apple ID tokenu.
     * Ověřuje: podpis, časovou platnost (exp), vydavatele (iss) a příjemce (aud).
     *
     * @param tokenString Surový JWT řetězec z mobilní aplikace.
     * @return Claims (nároky) extrahované z validního tokenu.
     * @throws OAuthTokenInvalidException pokud verifikace v jakémkoliv bodě selže.
     */
    public Claims verify(String tokenString) {
        try {
            return Jwts.parserBuilder()
                    // 1. Nastavení resolveru pro dynamické vyhledání veřejného klíče Apple
                    .setSigningKeyResolver(appleSigningKeyResolver)
                    // 2. Vynucení správného příjemce (Service ID / Bundle ID)
                    .requireAudience(appleProperties.getClientId())
                    // 3. Vynucení správného vydavatele
                    .requireIssuer("https://appleid.apple.com")
                    .build()
                    // 4. Parsování a verifikace (zde dojde k volání resolveru a kontrole podpisu)
                    .parseClaimsJws(tokenString)
                    .getBody();

        } catch (Exception e) {
            log.error("Kritická chyba při verifikaci Apple tokenu: {}", e.getMessage());
            throw new OAuthTokenInvalidException("Apple ID Token je neplatný, expirovaný nebo podvržený.");
        }
    }
}