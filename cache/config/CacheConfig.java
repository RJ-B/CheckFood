package com.checkfood.checkfoodservice.cache.config;

import org.springframework.cache.annotation.EnableCaching;
import org.springframework.context.annotation.Configuration;

/**
 * Globální konfigurace cache subsystému.
 *
 * - zapíná Spring Cache
 * - definuje cache manager (Caffeine / Redis)
 */
@Configuration
@EnableCaching
public class CacheConfig {

    // TODO:
    // - definovat CacheManager (CaffeineCacheManager / RedisCacheManager)
    // - rozlišit chování podle profilu (local vs prod)
}
