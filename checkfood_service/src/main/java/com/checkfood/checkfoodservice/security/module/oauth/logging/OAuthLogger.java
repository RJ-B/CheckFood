package com.checkfood.checkfoodservice.security.module.oauth.logging;

import com.checkfood.checkfoodservice.security.logging.SecurityLogger;
import com.checkfood.checkfoodservice.security.module.auth.provider.AuthProvider;
import org.springframework.stereotype.Component;

/**
 * Specializovaný logger pro operace v modulu OAuth.
 * Slouží POUZE pro logování úspěšných operací (Happy Path).
 * Chybové stavy loguje OAuthExceptionHandler.
 */
@Component
public class OAuthLogger extends SecurityLogger {

    public void logAuthenticationAttempt(AuthProvider provider) {
        this.info("Zahajuji OAuth autentizaci u poskytovatele: {}", provider);
    }

    public void logProviderVerificationSuccess(AuthProvider provider, String providerUserId) {
        this.debug("Identita úspěšně ověřena u {} (External ID: {})", provider, providerUserId);
    }

    public void logSuccessfulOAuthLogin(String email, AuthProvider provider) {
        this.info("Uživatel '{}' se úspěšně přihlásil přes {}.", email, provider);
    }

    public void logSuccessfulOAuthRegistration(String email, AuthProvider provider) {
        this.info("Nový uživatel '{}' byl úspěšně registrován přes {}.", email, provider);
    }
}