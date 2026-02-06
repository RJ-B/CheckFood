package com.checkfood.checkfoodservice.security.ratelimit.service;

/**
 * Service pro řízení rate limitů.
 */
public interface RateLimitService {

    /**
     * Zkontroluje, zda je povolen další pokus pro daný klíč.
     *
     * @param key identifikátor (např. auth:login:ip:user)
     * @param limit max počet pokusů
     * @param windowMillis délka okna v ms
     *
     * @return true pokud je povoleno
     */
    boolean tryAcquire(String key, int limit, long windowMillis);

}
