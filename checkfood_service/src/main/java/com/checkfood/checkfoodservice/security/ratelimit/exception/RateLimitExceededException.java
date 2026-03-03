package com.checkfood.checkfoodservice.security.ratelimit.exception;

/**
 * Runtime exception indikující překročení rate limiting thresholds.
 *
 * Throwována RateLimitAspect když request je rejected kvůli rate limiting
 * policies. Měla by být mapována na HTTP 429 Too Many Requests.
 *
 * @author Rostislav Jirák
 * @version 1.0.0
 */
public class RateLimitExceededException extends RuntimeException {

    /**
     * Vytvoří rate limit exceeded exception s custom message.
     *
     * @param message error message pro client consumption
     */
    public RateLimitExceededException(String message) {
        super(message);
    }
}