package com.checkfood.checkfoodservice.client.exception;

/**
 * Výjimka signalizující, že externí systém je aktuálně nedostupný.
 *
 * @author Rostislav Jirák
 * @version 1.0.0
 */
public class ClientUnavailableException extends ClientException {

    /**
     * Vytvoří výjimku s chybovou zprávou.
     *
     * @param message popis nedostupnosti
     */
    public ClientUnavailableException(String message) {
        super(message);
    }
}
