package com.checkfood.checkfoodservice.security.module.mfa.exception;

/**
 * Výjimka vyhozená při překročení povoleného počtu neúspěšných pokusů o MFA ověření.
 *
 * @author Rostislav Jirák
 * @version 1.0.0
 */
public class MfaRateLimitedException extends MfaException {

    public MfaRateLimitedException(String message) {
        super(message);
    }

}
