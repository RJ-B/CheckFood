package com.checkfood.checkfoodservice.security.exception;

import com.checkfood.checkfoodservice.exception.ServiceException;
import lombok.Getter;
import org.springframework.http.HttpStatus;

/**
 * Základní výjimka pro celou security vrstvu aplikace.
 * Poskytuje společnou strukturu pro všechny bezpečnostní výjimky.
 * Slouží jako rodičovská třída pro specifické výjimky jednotlivých security modulů.
 *
 * @see ServiceException
 */
@Getter
public class SecurityException extends ServiceException {

    /**
     * Vytvoří novou security výjimku.
     *
     * @param errorCode security error kód
     * @param message lidsky čitelná chybová zpráva
     * @param status HTTP status kód odpovědi
     */
    public SecurityException(Object errorCode, String message, HttpStatus status) {
        super(errorCode, message, status);
    }

    /**
     * Vytvoří novou security výjimku s příčinou.
     *
     * @param errorCode security error kód
     * @param message lidsky čitelná chybová zpráva
     * @param status HTTP status kód odpovědi
     * @param cause původní výjimka
     */
    public SecurityException(Object errorCode, String message, HttpStatus status, Throwable cause) {
        super(errorCode, message, status, cause);
    }
}