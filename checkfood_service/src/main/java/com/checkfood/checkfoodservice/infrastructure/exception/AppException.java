package com.checkfood.checkfoodservice.infrastructure.exception;

import com.checkfood.checkfoodservice.exception.ServiceException;
import lombok.Getter;
import org.springframework.http.HttpStatus;

/**
 * Základní výjimka pro všechny byznys moduly v rámci balíčku {@code module}.
 * Rozšiřuje {@link ServiceException} a slouží jako společný předek modulových výjimek.
 *
 * @author Rostislav Jirák
 * @version 1.0.0
 */
@Getter
public abstract class AppException extends ServiceException {

    /**
     * Vytvoří výjimku s chybovým kódem, zprávou a HTTP statusem.
     *
     * @param errorCode chybový kód specifický pro daný modul
     * @param message   popis chyby
     * @param status    HTTP status odpovědi
     */
    public AppException(Object errorCode, String message, HttpStatus status) {
        super(errorCode, message, status);
    }

    /**
     * Vytvoří výjimku s chybovým kódem, zprávou, HTTP statusem a příčinou.
     *
     * @param errorCode chybový kód specifický pro daný modul
     * @param message   popis chyby
     * @param status    HTTP status odpovědi
     * @param cause     původní výjimka
     */
    public AppException(Object errorCode, String message, HttpStatus status, Throwable cause) {
        super(errorCode, message, status, cause);
    }
}
