package com.checkfood.checkfoodservice.security.mfa.exception;

/**
 * Vyhozena, pokud MFA není aktivní.
 */
public class MfaNotEnabledException extends MfaException {

    public MfaNotEnabledException(String message) {
        super(message);
    }

}