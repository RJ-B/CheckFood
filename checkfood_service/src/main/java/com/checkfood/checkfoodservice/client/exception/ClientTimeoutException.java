package com.checkfood.checkfoodservice.client.exception;

/**
 * Výjimka reprezentující timeout při komunikaci s externí službou.
 *
 * @author Rostislav Jirák
 * @version 1.0.0
 */
public class ClientTimeoutException extends ClientException {

    /**
     * Vytvoří výjimku s chybovou zprávou.
     *
     * @param message popis timeoutu
     */
    public ClientTimeoutException(String message) {
        super(message);
    }
}
