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
import java.util.Collections;

/**
 * Poskytovatel verifikace pro Google ID tokeny s diagnostickým logováním.
 * Zapouzdřuje oficiální Google knihovnu a zajišťuje její správnou inicializaci s tolerancí
 * na časový posun (clock skew) 60 sekund.
 *
 * @author Rostislav Jirák
 * @version 1.0.0
 */
@Slf4j
@Component
public class GoogleIdTokenProvider {

    private final GoogleIdTokenVerifier verifier;
    private final String expectedClientId;

    /**
     * Inicializuje Google ID token verifier s konfigurovaným Client ID a tolerancí na časový posun.
     *
     * @param googleProperties konfigurační vlastnosti Google OAuth
     */
    public GoogleIdTokenProvider(GoogleOAuthProperties googleProperties) {
        this.expectedClientId = googleProperties.getClientId();

        this.verifier = new GoogleIdTokenVerifier.Builder(new NetHttpTransport(), new GsonFactory())
                .setAudience(Collections.singletonList(expectedClientId))
                .setAcceptableTimeSkewSeconds(60)
                .build();
    }

    /**
     * Provede kryptografické ověření Google ID tokenu a vrátí jeho strukturovanou reprezentaci.
     *
     * @param idTokenString surový Google ID token jako JWT řetězec
     * @return ověřený Google ID token nebo null pokud je token neplatný
     * @throws GeneralSecurityException při chybě kryptografické operace
     * @throws IOException              při chybě komunikace s Google API
     */
    public GoogleIdToken verify(String idTokenString) throws GeneralSecurityException, IOException {
        log.info("[OAUTH] Zahajuji verifikaci Google tokenu. Ocekavane Client ID: {}", expectedClientId);

        try {
            GoogleIdToken idToken = verifier.verify(idTokenString);

            if (idToken == null) {
                log.error("[OAUTH] Verifikace selhala: verifier.verify() vratil null.");
                return null;
            }

            GoogleIdToken.Payload payload = idToken.getPayload();
            log.info("[OAUTH] Verifikace uspesna. Email: {}", payload.getEmail());

            return idToken;
        } catch (Exception e) {
            log.error("[OAUTH] Kriticka chyba pri verifikaci Google tokenu: {}", e.getMessage());
            throw e;
        }
    }
}