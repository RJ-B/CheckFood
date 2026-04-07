package com.checkfood.checkfoodservice.security.module.oauth.module.google.provider;

import com.checkfood.checkfoodservice.security.module.auth.provider.AuthProvider;
import com.checkfood.checkfoodservice.security.module.oauth.exception.OAuthException;
import com.checkfood.checkfoodservice.security.module.oauth.logging.OAuthLogger;
import com.checkfood.checkfoodservice.security.module.oauth.provider.OAuthClient;
import com.checkfood.checkfoodservice.security.module.oauth.provider.OAuthUserInfo;
import com.google.api.client.googleapis.auth.oauth2.GoogleIdToken;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Component;

import java.io.IOException;
import java.security.GeneralSecurityException;

/**
 * Implementace OAuth klienta pro Google Sign In.
 * Ověřuje Google ID token prostřednictvím oficiální Google knihovny a extrahuje data uživatele.
 *
 * @author Rostislav Jirák
 * @version 1.0.0
 */
@Component
@RequiredArgsConstructor
public class GoogleOAuthClient implements OAuthClient {

    private final GoogleIdTokenProvider googleTokenProvider;
    private final OAuthLogger oauthLogger;

    /**
     * Ověří Google ID token a extrahuje data uživatele z payloadu.
     * Kontroluje, zda je e-mail Google účtu verifikovaný.
     *
     * @param idToken surový Google ID token z mobilní aplikace
     * @return normalizovaná data uživatele
     * @throws OAuthException pokud je token neplatný nebo e-mail není verifikovaný
     */
    @Override
    public OAuthUserInfo verifyAndGetUserInfo(String idToken) {
        try {
            var googleIdToken = googleTokenProvider.verify(idToken);

            if (googleIdToken == null) {
                throw OAuthException.invalidToken("Google ID Token je neplatný nebo expirovaný.");
            }

            var payload = googleIdToken.getPayload();

            if (!payload.getEmailVerified()) {
                throw OAuthException.invalidToken("Email u Google účtu není verifikován.");
            }

            var providerUserId = payload.getSubject();

            oauthLogger.logProviderVerificationSuccess(getProviderType(), providerUserId);

            return OAuthUserInfo.builder()
                    .providerUserId(providerUserId)
                    .email(payload.getEmail())
                    .firstName((String) payload.get("given_name"))
                    .lastName((String) payload.get("family_name"))
                    .profileImageUrl((String) payload.get("picture"))
                    .providerType(getProviderType())
                    .build();

        } catch (GeneralSecurityException | IOException e) {
            throw OAuthException.communicationError("GOOGLE", "Chyba při komunikaci s Google API: " + e.getMessage(), e);
        } catch (IllegalArgumentException e) {
            throw OAuthException.invalidToken("Formát Google ID Tokenu je neplatný.");
        }
    }

    @Override
    public AuthProvider getProviderType() {
        return AuthProvider.GOOGLE;
    }
}