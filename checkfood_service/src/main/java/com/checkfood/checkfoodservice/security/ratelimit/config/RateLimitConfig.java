package com.checkfood.checkfoodservice.security.ratelimit.config;

import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.EnableAspectJAutoProxy;

/**
 * Konfigurace rate limitingu. Aktivuje AspectJ auto proxy pro zpracování anotace {@code @RateLimited}.
 *
 * @author Rostislav Jirák
 * @version 1.0.0
 */
@Configuration
@EnableAspectJAutoProxy
public class RateLimitConfig {
}
