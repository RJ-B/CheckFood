package com.checkfood.checkfoodservice.security.mfa.exception;

/**
 * Základní výjimka pro MFA modul.
 */
public class MfaException extends RuntimeException {

    public MfaException(String message) {
        super(message);
    }

    public MfaException(String message, Throwable cause) {
        super(message, cause);
    }

}
