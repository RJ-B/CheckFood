package com.checkfood.checkfoodservice.security.module.oauth.logging;

import com.checkfood.checkfoodservice.security.logging.SecurityLogger;
import com.checkfood.checkfoodservice.security.module.auth.provider.AuthProvider;
import org.springframework.stereotype.Component;

/**
 * Specializovaný logger pro úspěšné operace v OAuth modulu.
 * Chybové stavy jsou logovány výhradně v OAuthExceptionHandler.
 *
 * @author Rostislav Jirák
 * @version 1.0.0
 */
@Component
public class OAuthLogger extends SecurityLogger {

    /**
     * Zaloguje zahájení OAuth autentizace u daného poskytovatele.
     *
     * @param provider typ poskytovatele identity
     */
    public void logAuthenticationAttempt(AuthProvider provider) {
        this.info("Zahajuji OAuth autentizaci u poskytovatele: {}", provider);
    }

    /**
     * Zaloguje úspěšné ověření identity u externího poskytovatele.
     *
     * @param provider       typ poskytovatele identity
     * @param providerUserId unikátní ID uživatele u poskytovatele
     */
    public void logProviderVerificationSuccess(AuthProvider provider, String providerUserId) {
        this.debug("Identita uspesne overena u {} (External ID: {})", provider, providerUserId);
    }

    /**
     * Zaloguje úspěšné přihlášení uživatele přes OAuth.
     *
     * @param email    e-mailová adresa uživatele
     * @param provider typ poskytovatele identity
     */
    public void logSuccessfulOAuthLogin(String email, AuthProvider provider) {
        this.info("Uzivatel '{}' se uspesne prihlasil pres {}.", email, provider);
    }

    /**
     * Zaloguje úspěšnou registraci nového uživatele přes OAuth.
     *
     * @param email    e-mailová adresa nového uživatele
     * @param provider typ poskytovatele identity
     */
    public void logSuccessfulOAuthRegistration(String email, AuthProvider provider) {
        this.info("Novy uzivatel '{}' byl uspesne registrovan pres {}.", email, provider);
    }
}