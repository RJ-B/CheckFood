package com.checkfood.checkfoodservice.security.module.mfa.exception;

/**
 * Výjimka vyhozená při zadání neplatného nebo expirovaného MFA kódu.
 *
 * @author Rostislav Jirák
 * @version 1.0.0
 */
public class MfaInvalidCodeException extends MfaException {

    public MfaInvalidCodeException(String message) {
        super(message);
    }

}
