package com.checkfood.checkfoodservice.security.module.jwt.logging;

import com.checkfood.checkfoodservice.security.logging.SecurityLogger;
import org.springframework.stereotype.Component;

/**
 * Specializovaný logger pro JWT operace (happy path).
 * Chybové stavy a bezpečnostní incidenty jsou logovány v {@code JwtExceptionHandler}.
 *
 * @author Rostislav Jirák
 * @version 1.0.0
 * @see SecurityLogger
 */
@Component
public class JwtLogger extends SecurityLogger {

    /**
     * Zaloguje úspěšné vygenerování tokenu.
     *
     * @param email email uživatele, pro kterého byl token vygenerován
     * @param type  typ tokenu (ACCESS nebo REFRESH)
     */
    public void logTokenGenerated(String email, String type) {
        this.info("JWT {} token úspěšně vygenerován pro uživatele '{}'.", type.toUpperCase(), email);
    }

    /**
     * Zaloguje pokus o neautorizovaný přístup (HTTP 401).
     *
     * @param uri     URI požadavku
     * @param message důvod selhání autentizace
     */
    public void logUnauthorizedAccess(String uri, String message) {
        this.warn("Neautorizovaný přístup k URI: {} - Důvod: {}", uri, message);
    }

    /**
     * Zaloguje pokus o přístup k prostředku bez dostatečných oprávnění (HTTP 403).
     *
     * @param uri     URI požadavku
     * @param message důvod odepření přístupu
     */
    public void logAccessDenied(String uri, String message) {
        this.warn("Přístup odepřen k URI: {} - Důvod: {}", uri, message);
    }

    /**
     * Zaloguje chybu při JWT autentizaci během průchodu filtrem.
     *
     * @param message popis chyby autentizace
     */
    public void logAuthenticationError(String message) {
        this.warn("Chyba při JWT autentizaci: {}", message);
    }

    /**
     * Zaloguje úspěšnou validaci tokenu (debug úroveň).
     *
     * @param email email uživatele extrahovaný z validního tokenu
     */
    public void logTokenValidated(String email) {
        this.debug("JWT token validován pro uživatele '{}'.", email);
    }

    /**
     * Zaloguje použití refresh tokenu pro obnovu session.
     *
     * @param email email uživatele, jehož refresh token byl použit
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