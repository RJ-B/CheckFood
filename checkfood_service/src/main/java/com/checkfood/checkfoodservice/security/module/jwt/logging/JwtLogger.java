package com.checkfood.checkfoodservice.security.module.jwt.logging;

import com.checkfood.checkfoodservice.security.logging.SecurityLogger;
import org.springframework.stereotype.Component;

/**
 * Logger pro JWT operace (Happy Path).
 * Loguje pouze úspěšné události. Chyby řeší JwtExceptionHandler.
 */
@Component
public class JwtLogger extends SecurityLogger {

    /**
     * Zaloguje úspěšné vygenerování tokenu.
     * @param email Uživatel
     * @param type Typ tokenu (ACCESS / REFRESH)
     */
    public void logTokenGenerated(String email, String type) {
        this.info("JWT {} token úspěšně vygenerován pro uživatele '{}'.", type.toUpperCase(), email);
    }

    /**
     * Zaloguje pokus o neautorizovaný přístup (401 Unauthorized).
     * Používáno v JwtAuthenticationEntryPoint.
     * * @param uri URI požadavku
     * @param message chybová zpráva
     */
    public void logUnauthorizedAccess(String uri, String message) {
        this.warn("Neautorizovaný přístup k URI: {} - Důvod: {}", uri, message);
    }

    /**
     * Zaloguje pokus o přístup k prostředku bez dostatečných oprávnění (403 Forbidden).
     * Používáno v JwtAccessDeniedHandler.
     * * @param uri URI požadavku
     * @param message chybová zpráva
     */
    public void logAccessDenied(String uri, String message) {
        this.warn("Přístup odepřen k URI: {} - Důvod: {}", uri, message);
    }

    /**
     * Zaloguje chybu při autentizaci během průchodu filtrem.
     * * @param message chybová zpráva
     */
    public void logAuthenticationError(String message) {
        this.warn("Chyba při JWT autentizaci: {}", message);
    }

    /**
     * Zaloguje úspěšnou validaci a extrakci claims (pro debug účely).
     */
    public void logTokenValidated(String email) {
        this.debug("JWT token validován pro uživatele '{}'.", email);
    }

    /**
     * Zaloguje rotaci refresh tokenu.
     */
    public void logTokenRefresh(String email) {
        this.info("Refresh token použit pro obnovu session uživatele '{}'.", email);
    }

    /**
     * Zaloguje neúspěšnou validaci tokenu ve filtru.
     * Důležité pro detekci bezpečnostních incidentů (expirované, podvržené, malformované tokeny).
     *
     * @param uri URI požadavku
     * @param reason důvod selhání
     */
    public void logTokenValidationFailed(String uri, String reason) {
        this.warn("JWT validace selhala pro URI: {} - Důvod: {}", uri, reason);
    }
}