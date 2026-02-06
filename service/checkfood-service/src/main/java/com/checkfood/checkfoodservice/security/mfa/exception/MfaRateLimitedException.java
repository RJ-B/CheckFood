package com.checkfood.checkfoodservice.security.mfa.exception;

/**
 * Vyhozena při překročení limitu pokusů o MFA ověření.
 */
public class MfaRateLimitedException extends MfaException {

    public MfaRateLimitedException(String message) {
        super(message);
    }

}
