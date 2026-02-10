package com.checkfood.checkfoodservice.client.exception;

/**
 * Výjimka reprezentující timeout při komunikaci
 * s externí službou.
 */
public class ClientTimeoutException extends ClientException {

    public ClientTimeoutException(String message) {
        super(message);
    }
}
