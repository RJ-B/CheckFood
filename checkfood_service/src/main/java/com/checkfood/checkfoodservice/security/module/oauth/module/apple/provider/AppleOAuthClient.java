package com.checkfood.checkfoodservice.security.module.oauth.provider.apple;

import com.checkfood.checkfoodservice.security.module.auth.provider.AuthProvider;
import com.checkfood.checkfoodservice.security.module.oauth.provider.OAuthClient;
import com.checkfood.checkfoodservice.security.module.oauth.provider.OAuthUserInfo;
import io.jsonwebtoken.Claims;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Component;

/**
 * Klient pro obsluhu autentizace Sign in with Apple.
 * Propojuje kryptografickou verifikaci s interním datovým modelem systému.
 */
@Component
@RequiredArgsConstructor
public class AppleOAuthClient implements OAuthClient {

    private final AppleIdTokenVerifier appleVerifier;

    @Override
    public OAuthUserInfo verifyAndGetUserInfo(String idToken) {
        // 1. Zavolání verifikátoru pro parsování a kontrolu podpisu
        Claims claims = appleVerifier.verify(idToken);

        // 2. Mapování Claims na sjednocený OAuthUserInfo
        return OAuthUserInfo.builder()
                .providerUserId(claims.getSubject()) // Unikátní ID uživatele (sub)
                .email(claims.get("email", String.class))
                .fullName(extractFullName(claims))
                .providerType(getProviderType())
                .build();
    }

    /**
     * Apple neposílá jméno v JWT tokenu při každém přihlášení.
     * Tato metoda se pokusí jméno získat, případně vrátí rozumnou výchozí hodnotu.
     */
    private String extractFullName(Claims claims) {
        String firstName = claims.get("firstName", String.class);
        String lastName = claims.get("lastName", String.class);

        if (firstName != null && lastName != null) {
            return firstName + " " + lastName;
        }

        // Pokud jméno v tokenu chybí (standard u Apple po prvním přihlášení),
        // použijeme prefix emailu nebo placeholder.
        return claims.get("email", String.class).split("@")[0];
    }

    @Override
    public AuthProvider getProviderType() {
        return AuthProvider.APPLE;
    }
}