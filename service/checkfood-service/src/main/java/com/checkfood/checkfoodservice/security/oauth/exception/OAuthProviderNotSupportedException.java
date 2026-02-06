package com.checkfood.checkfoodservice.security.oauth.exception;

/**
 * Výjimka vyhozená v případě, že klient požaduje nepodporovaného OAuth providera.
 */
public class OAuthProviderNotSupportedException extends RuntimeException {

    public OAuthProviderNotSupportedException(String message) {
        super(message);
    }

}
