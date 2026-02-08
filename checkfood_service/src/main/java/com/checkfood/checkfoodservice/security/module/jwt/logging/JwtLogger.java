package com.checkfood.checkfoodservice.security.module.jwt.logging;

import com.checkfood.checkfoodservice.security.logging.SecurityLogger;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Component;

/**
 * Specializovaný logger pro JWT operace.
 * Poskytuje metody pro logování událostí specifických pro JWT autentizaci a validaci tokenů.
 *
 * @see SecurityLogger
 */
@Component
@RequiredArgsConstructor
public class JwtLogger {

    private final SecurityLogger securityLogger;

    /**
     * Loguje chybu při zpracování JWT autentizace.
     *
     * @param errorMessage popis chyby
     */
    public void logAuthenticationError(String errorMessage) {
        securityLogger.error("Chyba při zpracování JWT autentizace: {}", errorMessage);
    }

    /**
     * Loguje pokus o přístup s neplatným tokenem.
     *
     * @param uri URI požadavku
     * @param reason důvod neplatnosti tokenu
     */
    public void logInvalidToken(String uri, String reason) {
        securityLogger.warn("Neplatný JWT token pro {}: {}", uri, reason);
    }

    /**
     * Loguje pokus o přístup s expirovaným tokenem.
     *
     * @param uri URI požadavku
     * @param email email uživatele z tokenu
     */
    public void logExpiredToken(String uri, String email) {
        securityLogger.warn("Expirovaný JWT token pro {} (uživatel: {})", uri, email);
    }

    /**
     * Loguje úspěšnou autentizaci uživatele přes JWT.
     *
     * @param email email autentizovaného uživatele
     */
    public void logSuccessfulAuthentication(String email) {
        securityLogger.debug("Uživatel {} úspěšně autentizován přes JWT", email);
    }

    /**
     * Loguje chybějící nebo neplatnou Authorization hlavičku.
     *
     * @param uri URI požadavku
     */
    public void logMissingAuthorizationHeader(String uri) {
        securityLogger.debug("Chybějící nebo neplatná Authorization hlavička pro {}", uri);
    }

    /**
     * Loguje neautorizovaný přístup.
     *
     * @param uri URI požadavku
     * @param reason důvod zamítnutí
     */
    public void logUnauthorizedAccess(String uri, String reason) {
        securityLogger.warn("Neautorizovaný přístup k {}: {}", uri, reason);
    }

    /**
     * Loguje odepření přístupu kvůli nedostatečným oprávněním.
     *
     * @param uri URI požadavku
     * @param reason důvod odepření
     */
    public void logAccessDenied(String uri, String reason) {
        securityLogger.warn("Přístup odepřen k {}: {}", uri, reason);
    }

    /**
     * Loguje generování nového JWT tokenu.
     *
     * @param email email uživatele
     * @param tokenType typ tokenu (access/refresh)
     */
    public void logTokenGenerated(String email, String tokenType) {
        securityLogger.debug("Vygenerován {} token pro uživatele {}", tokenType, email);
    }

    /**
     * Loguje validaci JWT tokenu.
     *
     * @param email email uživatele z tokenu
     * @param isValid výsledek validace
     */
    public void logTokenValidation(String email, boolean isValid) {
        if (isValid) {
            securityLogger.debug("Token pro uživatele {} je platný", email);
        } else {
            securityLogger.warn("Token pro uživatele {} není platný", email);
        }
    }

    /**
     * Loguje obnovení tokenů pomocí refresh tokenu.
     *
     * @param email email uživatele
     */
    public void logTokenRefresh(String email) {
        securityLogger.info("Tokeny úspěšně obnoveny pro uživatele: {}", email);
    }
}