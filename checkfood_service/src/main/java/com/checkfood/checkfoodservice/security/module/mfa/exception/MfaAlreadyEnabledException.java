package com.checkfood.checkfoodservice.security.module.mfa.exception;

/**
 * Vyhozena, pokud je MFA již aktivní.
 */
public class MfaAlreadyEnabledException extends MfaException {

    public MfaAlreadyEnabledException(String message) {
        super(message);
    }

}
