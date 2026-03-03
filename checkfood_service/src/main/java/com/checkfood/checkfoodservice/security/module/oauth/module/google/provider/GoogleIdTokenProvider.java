package com.checkfood.checkfoodservice.security.module.oauth.module.google.provider;

import com.checkfood.checkfoodservice.security.module.oauth.module.google.properties.GoogleOAuthProperties;
import com.google.api.client.googleapis.auth.oauth2.GoogleIdToken;
import com.google.api.client.googleapis.auth.oauth2.GoogleIdTokenVerifier;
import com.google.api.client.http.javanet.NetHttpTransport;
import com.google.api.client.json.gson.GsonFactory;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Component;

import java.io.IOException;
import java.security.GeneralSecurityException;
import java.time.Instant;
import java.util.Collections;

/**
 * Poskytovatel verifikace pro Google ID Tokeny s rozšířenou diagnostikou.
 * Zapouzdřuje oficiální Google knihovnu a zajišťuje její správnou inicializaci s tolerancí na časový posun.
 */
@Slf4j
@Component
public class GoogleIdTokenProvider {

    private final GoogleIdTokenVerifier verifier;
    private final String expectedClientId;

    public GoogleIdTokenProvider(GoogleOAuthProperties googleProperties) {
        this.expectedClientId = googleProperties.getClientId();

        // Inicializace verifieru s tolerancí 60 sekund pro vyrovnání časových rozdílů (clock skew) [cite: 2026-01-23]
        this.verifier = new GoogleIdTokenVerifier.Builder(new NetHttpTransport(), new GsonFactory())
                .setAudience(Collections.singletonList(expectedClientId))
                .setAcceptableTimeSkewSeconds(60)
                .build();
    }

    /**
     * Provede nízkoúrovňovou verifikaci tokenu s detailním logováním pro účely debugování. [cite: 2026-01-23]
     */
    public GoogleIdToken verify(String idTokenString) throws GeneralSecurityException, IOException {
        log.info("🔍 [DEBUG-OAUTH] Zahájení verifikace Google tokenu.");
        log.info("🔍 [DEBUG-OAUTH] Očekávané Client ID na backendu: {}", expectedClientId);
        log.info("🔍 [DEBUG-OAUTH] Aktuální čas serveru (UTC): {}", Instant.now());

        try {
            GoogleIdToken idToken = verifier.verify(idTokenString);

            if (idToken == null) {
                log.error("❌ [DEBUG-OAUTH] Verifikace selhala: verifier.verify() vrátil null.");
                log.error("💡 Tip: Porovnejte výše uvedené Client ID s hodnotou 'aud' v tokenu z Flutter logu.");
                return null;
            }

            GoogleIdToken.Payload payload = idToken.getPayload();
            log.info("✅ [DEBUG-OAUTH] Verifikace proběhla úspěšně.");
            log.info("ℹ️ [DEBUG-OAUTH] Vystaveno v (iat): {}", Instant.ofEpochSecond(payload.getIssuedAtTimeSeconds()));
            log.info("ℹ️ [DEBUG-OAUTH] Vyprší v (exp): {}", Instant.ofEpochSecond(payload.getExpirationTimeSeconds()));
            log.info("ℹ️ [DEBUG-OAUTH] Audience v přijatém tokenu (aud): {}", payload.getAudience());
            log.info("ℹ️ [DEBUG-OAUTH] Email uživatele: {}", payload.getEmail());

            return idToken;
        } catch (Exception e) {
            log.error("💥 [DEBUG-OAUTH] Kritická technická chyba při verifikaci: {}", e.getMessage());
            throw e;
        }
    }
}