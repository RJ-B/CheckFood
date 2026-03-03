package com.checkfood.checkfoodservice.security.exception;

import com.checkfood.checkfoodservice.exception.ServiceException;
import lombok.Getter;
import org.springframework.http.HttpStatus;

/**
 * Základní výjimka pro celou security vrstvu aplikace poskytující společnou
 * strukturu a funkcionalitu pro všechny bezpečnostní výjimky.
 *
 * Slouží jako rodičovská třída pro specifické výjimky jednotlivých security
 * modulů (AuthException, JwtException, UserException). Zajišťuje konzistentní
 * error handling a response formatting napříč security komponentami.
 *
 * Architektonické výhody:
 * - Centralizace společné exception logiky
 * - Konzistentní error response structure
 * - Type-safe exception hierarchy
 * - Simplified exception handling v controllers
 *
 * Exception hierarchy:
 * ServiceException -> SecurityException -> ModuleSpecificException
 *
 * @author Rostislav Jirák
 * @version 1.0.0
 * @see ServiceException
 */
@Getter
public class SecurityException extends ServiceException {

    /**
     * Vytvoří novou security výjimku se základními error informacemi.
     * Standardní konstruktor pro většinu security error scenářů.
     *
     * @param errorCode security error kód pro kategorizaci a handling
     * @param message lidsky čitelná chybová zpráva pro uživatele
     * @param status HTTP status kód pro REST API response
     */
    public SecurityException(Object errorCode, String message, HttpStatus status) {
        super(errorCode, message, status);
    }

    /**
     * Vytvoří novou security výjimku s root cause exception chaining.
     * Používá se pro wrapping underlying exceptions se zachováním stack trace.
     *
     * @param errorCode security error kód pro kategorizaci a handling
     * @param message lidsky čitelná chybová zpráva pro uživatele
     * @param status HTTP status kód pro REST API response
     * @param cause původní výjimka pro exception chaining a debugging
     */
    public SecurityException(Object errorCode, String message, HttpStatus status, Throwable cause) {
        super(errorCode, message, status, cause);
    }
}