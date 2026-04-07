package com.checkfood.checkfoodservice.security.module.mfa.exception;

/**
 * Výjimka vyhozená při pokusu o nastavení nebo aktivaci MFA, které je již zapnuto.
 *
 * @author Rostislav Jirák
 * @version 1.0.0
 */
public class MfaAlreadyEnabledException extends MfaException {

    public MfaAlreadyEnabledException(String message) {
        super(message);
    }

}
