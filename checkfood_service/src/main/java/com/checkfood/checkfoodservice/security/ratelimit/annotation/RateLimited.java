package com.checkfood.checkfoodservice.security.ratelimit.annotation;

import java.lang.annotation.*;
import java.util.concurrent.TimeUnit;

/**
 * Deklarativní anotace pro rate limiting nad metodami, typicky controller endpointy.
 * Umožňuje flexibilní konfiguraci rate limiting pravidel pomocí AOP interceptoru.
 *
 * Podporuje různé strategie rate limitingu:
 * - Per-IP rate limiting pro DDoS protection
 * - Per-user rate limiting pro user-specific abuse prevention
 * - Kombinované rate limiting pro advanced security scenarios
 * - Custom time windows a limit configurations
 *
 * Rate limiting implementace je typicky založená na sliding window nebo
 * token bucket algoritmu s backing storage (Redis, in-memory cache).
 *
 * Použití:
 * @RateLimited(key = "auth:login", limit = 5, duration = 15, unit = TimeUnit.MINUTES, perIp = true)
 * public void login(@RequestBody LoginRequest request) { ... }
 *
 * @author Rostislav Jirák
 * @version 1.0.0
 * @see java.util.concurrent.TimeUnit
 */
@Target(ElementType.METHOD)
@Retention(RetentionPolicy.RUNTIME)
@Documented
public @interface RateLimited {

    /**
     * Logický identifikátor pro rate limit bucket. Používá se pro kategorizaci
     * a groupování related operací pod společný rate limit.
     *
     * Doporučené naming convention: "module:operation" (např. "auth:login", "mfa:verify").
     *
     * @return string klíč pro rate limit bucket
     */
    String key();

    /**
     * Maximální počet povolených operací v rámci definovaného time window.
     * Po dosažení limitu jsou další requests blokovány až do konce window.
     *
     * @return maximální počet requests per window
     */
    int limit();

    /**
     * Délka time window v jednotkách specifikovaných v unit parametru.
     * Definuje časový interval pro reset rate limit counteru.
     *
     * @return délka time window
     */
    long duration();

    /**
     * Časová jednotka pro duration parametr. Umožňuje flexibilní
     * konfiguraci od sekund po hodiny podle security requirements.
     *
     * @return časová jednotka pro window duration
     */
    TimeUnit unit() default TimeUnit.MINUTES;

    /**
     * Určuje zda rate limit klíč bude obsahovat userId pro per-user limiting.
     * Užitečné pro prevenci abuse jednotlivými uživateli napříč sessions.
     *
     * Finální klíč: "{key}:user:{userId}" pokud je user authenticated.
     *
     * @return true pro per-user rate limiting
     */
    boolean perUser() default false;

    /**
     * Určuje zda rate limit klíč bude obsahovat IP adresu pro per-IP limiting.
     * Primary obrana proti DDoS a distributed brute force attacks.
     *
     * Finální klíč: "{key}:ip:{ipAddress}" s IP extraction z request.
     *
     * @return true pro per-IP rate limiting
     */
    boolean perIp() default true;
}