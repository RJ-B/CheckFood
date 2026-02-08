package com.checkfood.checkfoodservice.security.module.mfa.exception;

/**
 * Vyhozena, pokud MFA není aktivní.
 */
public class MfaNotEnabledException extends MfaException {

    public MfaNotEnabledException(String message) {
        super(message);
    }

}