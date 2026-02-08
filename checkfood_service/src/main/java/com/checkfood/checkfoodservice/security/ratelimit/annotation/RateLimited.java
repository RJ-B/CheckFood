package com.checkfood.checkfoodservice.security.ratelimit.annotation;

import java.lang.annotation.*;

import java.util.concurrent.TimeUnit;

/**
 * Anotace pro rate limiting nad metodami (typicky controller endpointy).
 */
@Target(ElementType.METHOD)
@Retention(RetentionPolicy.RUNTIME)
@Documented
public @interface RateLimited {

    /**
     * Logický klíč limitu (např. "auth:login", "mfa:verify").
     */
    String key();

    /**
     * Maximální počet pokusů v okně.
     */
    int limit();

    /**
     * Délka okna.
     */
    long duration();

    /**
     * Jednotka okna.
     */
    TimeUnit unit() default TimeUnit.MINUTES;

    /**
     * Pokud true, bude klíč limitu obsahovat i userId (pokud je dostupný).
     */
    boolean perUser() default false;

    /**
     * Pokud true, bude klíč limitu obsahovat i IP adresu.
     */
    boolean perIp() default true;

}
