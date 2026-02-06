package com.checkfood.checkfoodservice.security.mfa.exception;

/**
 * Vyhozena při zadání neplatného MFA kódu.
 */
public class MfaInvalidCodeException extends MfaException {

    public MfaInvalidCodeException(String message) {
        super(message);
    }

}
