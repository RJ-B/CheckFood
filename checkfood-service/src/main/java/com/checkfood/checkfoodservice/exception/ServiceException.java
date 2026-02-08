package com.checkfood.checkfoodservice.exception;

import lombok.Getter;
import org.springframework.http.HttpStatus;

/**
 * Základní výjimka pro celou aplikaci.
 * Poskytuje společnou strukturu pro všechny aplikační výjimky včetně error kódu a HTTP statusu.
 * Slouží jako rodičovská třída pro specifické výjimky jednotlivých vrstev.
 *
 * @see ErrorCode
 */
@Getter
public class ServiceException extends RuntimeException {

    private final Object errorCode;
    private final HttpStatus status;

    /**
     * Vytvoří novou service výjimku.
     *
     * @param errorCode aplikační error kód
     * @param message lidsky čitelná chybová zpráva
     * @param status HTTP status kód odpovědi
     */
    public ServiceException(Object errorCode, String message, HttpStatus status) {
        super(message);
        this.errorCode = errorCode;
        this.status = status;
    }

    /**
     * Vytvoří novou service výjimku s příčinou.
     *
     * @param errorCode aplikační error kód
     * @param message lidsky čitelná chybová zpráva
     * @param status HTTP status kód odpovědi
     * @param cause původní výjimka
     */
    public ServiceException(Object errorCode, String message, HttpStatus status, Throwable cause) {
        super(message, cause);
        this.errorCode = errorCode;
        this.status = status;
    }
}