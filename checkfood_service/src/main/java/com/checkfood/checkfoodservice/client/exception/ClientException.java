package com.checkfood.checkfoodservice.client.exception;

/**
 * Základní výjimka pro chyby vzniklé při komunikaci
 * s externím systémem.
 *
 * Slouží jako:
 * - technická výjimka
 * - hranice mezi client a service vrstvou
 */
public class ClientException extends RuntimeException {

    public ClientException(String message) {
        super(message);
    }

    public ClientException(String message, Throwable cause) {
        super(message, cause);
    }
}
