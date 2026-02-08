package com.checkfood.checkfoodservice.security.ratelimit.config;

import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.EnableAspectJAutoProxy;

/**
 * Konfigurace rate limitingu.
 */
@Configuration
@EnableAspectJAutoProxy
public class RateLimitConfig {
    // Aktivuje AOP pro @RateLimited
}
