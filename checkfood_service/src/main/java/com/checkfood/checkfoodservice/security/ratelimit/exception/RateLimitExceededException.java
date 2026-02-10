package com.checkfood.checkfoodservice.security.ratelimit.exception;

/**
 * Vyhozena při překročení rate limitu.
 */
public class RateLimitExceededException extends RuntimeException {

    public RateLimitExceededException(String message) {
        super(message);
    }

}
