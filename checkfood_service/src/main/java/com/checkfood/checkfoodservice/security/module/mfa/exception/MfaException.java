package com.checkfood.checkfoodservice.security.module.mfa.exception;

/**
 * Základní výjimka pro MFA modul, ze které dědí všechny specifičtější MFA výjimky.
 *
 * @author Rostislav Jirák
 * @version 1.0.0
 */
public class MfaException extends RuntimeException {

    public MfaException(String message) {
        super(message);
    }

    public MfaException(String message, Throwable cause) {
        super(message, cause);
    }

}
