package com.checkfood.checkfoodservice.security.oauth.exception;

/**
 * Základní výjimka pro OAuth modul.
 *
 * Všechny OAuth-specifické výjimky by ji měly dědit.
 */
public abstract class OAuthException extends RuntimeException {

    protected OAuthException(String message) {
        super(message);
    }

    protected OAuthException(String message, Throwable cause) {
        super(message, cause);
    }

}
