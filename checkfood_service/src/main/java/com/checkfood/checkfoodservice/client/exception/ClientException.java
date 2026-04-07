package com.checkfood.checkfoodservice.client.exception;

/**
 * Základní výjimka pro chyby vzniklé při komunikaci s externím systémem.
 * Slouží jako technická hranice mezi client a service vrstvou.
 *
 * @author Rostislav Jirák
 * @version 1.0.0
 */
public class ClientException extends RuntimeException {

    /**
     * Vytvoří výjimku s chybovou zprávou.
     *
     * @param message popis chyby
     */
    public ClientException(String message) {
        super(message);
    }

    /**
     * Vytvoří výjimku s chybovou zprávou a příčinou.
     *
     * @param message popis chyby
     * @param cause původní výjimka
     */
    public ClientException(String message, Throwable cause) {
        super(message, cause);
    }
}
