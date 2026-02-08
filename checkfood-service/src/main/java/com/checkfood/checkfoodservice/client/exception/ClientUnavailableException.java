package com.checkfood.checkfoodservice.client.exception;

/**
 * Výjimka signalizující, že externí systém
 * je aktuálně nedostupný.
 */
public class ClientUnavailableException extends ClientException {

    public ClientUnavailableException(String message) {
        super(message);
    }
}
