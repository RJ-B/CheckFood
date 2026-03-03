package com.checkfood.checkfoodservice.security.ratelimit.service;

/**
 * Service interface pro rate limiting functionality providing abstraction
 * nad různými rate limiting implementacemi a storage backends.
 *
 * Umožňuje pluggable implementations pro různé deployment scenarios
 * (in-memory, Redis, database) a rate limiting algoritmy.
 *
 * @author Rostislav Jirák
 * @version 1.0.0
 */
public interface RateLimitService {

    /**
     * Pokusí se acquire rate limiting token pro specifikovaný key a limit constraints.
     *
     * Method je thread-safe a může být volána concurrently pro stejné i různé keys.
     * Implementace musí zajistit atomic operations pro accurate rate limiting.
     *
     * @param key unique identifier pro rate limit bucket (např. "auth:login:ip:192.168.1.1")
     * @param limit maximální počet allowed requests per time window
     * @param windowMillis délka time window v millisekondách pro rate limiting period
     * @return true pokud request je within rate limit, false pokud limit exceeded
     */
    boolean tryAcquire(String key, int limit, long windowMillis);

    /**
     * Resets all rate limiting state. Primarily used in tests to prevent
     * cross-test rate limit pollution.
     */
    default void reset() {
        // Default no-op; overridden by implementations that support reset.
    }
}