package com.checkfood.checkfoodservice.security.module.mfa.exception;

/**
 * Vyhozena při zadání neplatného MFA kódu.
 */
public class MfaInvalidCodeException extends MfaException {

    public MfaInvalidCodeException(String message) {
        super(message);
    }

}
