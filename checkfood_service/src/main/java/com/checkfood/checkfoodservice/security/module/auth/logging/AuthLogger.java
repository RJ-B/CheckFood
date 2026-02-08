package com.checkfood.checkfoodservice.security.module.auth.logging;

import com.checkfood.checkfoodservice.security.logging.SecurityLogger;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Component;

/**
 * Specializovaný logger pro autentizační operace.
 * Poskytuje metody pro logování událostí specifických pro přihlašování, registraci a správu účtů.
 *
 * @see SecurityLogger
 */
@Component
@RequiredArgsConstructor
public class AuthLogger {

    private final SecurityLogger securityLogger;

    public void logSuccessfulLogin(String email) {
        securityLogger.info("Uživatel {} se úspěšně přihlásil", email);
    }

    public void logFailedLogin(String email, String reason) {
        securityLogger.warn("Neúspěšný pokus o přihlášení pro {}: {}", email, reason);
    }

    public void logRegistration(String email) {
        securityLogger.info("Registrace nového uživatele: {}", email);
    }

    public void logVerificationEmailSent(String email) {
        securityLogger.info("Odesílám verifikační email na: {}", email);
    }

    public void logAccountActivated(String email) {
        securityLogger.info("Účet {} byl úspěšně aktivován", email);
    }

    public void logResendVerificationCode(String email) {
        securityLogger.info("Žádost o znovuzaslání verifikačního kódu pro: {}", email);
    }

    public void logLogout(String email) {
        securityLogger.info("Uživatel {} se odhlásil", email);
    }

    public void logTokenRefresh(String email) {
        securityLogger.debug("Obnovení tokenu pro uživatele {}", email);
    }

    public void logAuthenticationError(String message) {
        securityLogger.error("Chyba při autentizaci: {}", message);
    }
}