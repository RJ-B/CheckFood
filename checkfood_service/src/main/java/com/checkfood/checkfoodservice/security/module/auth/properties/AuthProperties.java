package com.checkfood.checkfoodservice.security.module.auth.properties;

import lombok.Getter;
import lombok.Setter;
import org.springframework.boot.context.properties.ConfigurationProperties;

import java.time.Duration;

/**
 * Configuration properties pro authentication module s environment-specific settings.
 *
 * Centralizuje konfigurovatelné authentication parameters pro easy adjustment
 * across different deployment environments (development, staging, production).
 * Mapped from application.yml pod "security.auth" prefix.
 *
 * @author Rostislav Jirák
 * @version 1.0.0
 * @see org.springframework.boot.context.properties.ConfigurationProperties
 */
@Getter
@Setter
@ConfigurationProperties(prefix = "security.auth")
public class AuthProperties {

    /**
     * Email verification token TTL (time to live).
     *
     * Duration for which verification tokens zůstávají valid po generation.
     * Balance mezi user convenience (longer TTL) a security (shorter TTL).
     * Default 24 hours provides reasonable timeframe pro email checking.
     */
    private Duration verificationTokenTtl = Duration.ofHours(24);

    /**
     * Maximum failed login attempts před account lockout.
     *
     * Brute force protection threshold. Po dosažení limitu je account
     * temporarily nebo permanently locked podle implementation strategy.
     * Default 5 attempts provides balance mezi security a user experience.
     */
    private int maxLoginAttempts = 5;

    /**
     * Success redirect URL po successful email verification.
     *
     * Optional configuration pro applications requiring custom redirect
     * behavior po account activation. Null indicates default deep link
     * behavior nebo API-only verification flow.
     */
    private String verificationSuccessUrl;
}