package com.checkfood.checkfoodservice.security.module.mfa.exception;

/**
 * Výjimka vyhozená při pokusu o operaci vyžadující aktivní MFA, které není zapnuto.
 *
 * @author Rostislav Jirák
 * @version 1.0.0
 */
public class MfaNotEnabledException extends MfaException {

    public MfaNotEnabledException(String message) {
        super(message);
    }

}