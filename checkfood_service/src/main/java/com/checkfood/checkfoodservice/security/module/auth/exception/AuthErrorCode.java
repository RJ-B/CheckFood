package com.checkfood.checkfoodservice.security.module.auth.exception;

/**
 * Enumerace error codes pro autentizační modul s category-based metadata
 * pro automated logging strategy determination.
 *
 * Každý error code má assigned category určující logging level a handling
 * strategy v AuthExceptionHandler. Categories umožňují consistent
 * error processing napříč security incidents, business logic a system failures.
 *
 * @author Rostislav Jirák
 * @version 1.0.0
 * @see AuthException
 * @see AuthExceptionHandler
 */
public enum AuthErrorCode {

    // Security incidents requiring monitoring a potential response
    AUTH_INVALID_CREDENTIALS("SECURITY_INCIDENT"),
    AUTH_ACCOUNT_LOCKED("SECURITY_INCIDENT"),
    AUTH_INVALID_TOKEN("SECURITY_INCIDENT"),
    AUTH_DEVICE_MISMATCH("SECURITY_INCIDENT"),
    AUTH_INSUFFICIENT_PRIVILEGES("SECURITY_INCIDENT"),
    AUTH_TOO_MANY_ATTEMPTS("SECURITY_INCIDENT"),

    // Account state conditions requiring user awareness
    AUTH_ACCOUNT_DISABLED("SECURITY_ACCOUNT_STATE"),

    // Password reset token errors
    AUTH_RESET_TOKEN_INVALID("SECURITY_INCIDENT"),
    AUTH_RESET_TOKEN_EXPIRED("VALIDATION"),
    AUTH_RESET_TOKEN_USED("VALIDATION"),

    // Business logic validation a user input errors
    AUTH_EMAIL_EXISTS("VALIDATION"),
    AUTH_ACCOUNT_ALREADY_ACTIVATED("VALIDATION"),
    AUTH_ACCOUNT_NOT_VERIFIED("VALIDATION"),
    AUTH_TOKEN_EXPIRED("VALIDATION"),
    AUTH_SESSION_EXPIRED("VALIDATION"),
    AUTH_PASSWORD_MISMATCH("VALIDATION"),
    AUTH_WEAK_PASSWORD("VALIDATION"),
    AUTH_INVALID_EMAIL_FORMAT("VALIDATION"),
    AUTH_VALIDATION_ERROR("VALIDATION"),
    AUTH_PASSWORD_EXPIRED("VALIDATION"),
    AUTH_ACCOUNT_EXPIRED("VALIDATION"),

    // System errors requiring immediate attention
    AUTH_REGISTRATION_FAILED("SYSTEM"),
    AUTH_ROLE_NOT_FOUND("SYSTEM"),
    AUTH_SYSTEM_ERROR("SYSTEM");

    /**
     * Error category pro logging strategy determination.
     */
    private final String category;

    /**
     * Constructor s category assignment.
     *
     * @param category error category pro handler logic
     */
    AuthErrorCode(String category) {
        this.category = category;
    }

    /**
     * Getter pro category access.
     *
     * @return error category string
     */
    public String getCategory() {
        return category;
    }

    /**
     * Identifies security events requiring elevated logging attention.
     *
     * Security events jsou logged jako WARN level pro security monitoring
     * a potential incident response. Includes both active security threats
     * a account state security conditions.
     *
     * @return true pro security incident categories
     */
    public boolean isSecurityEvent() {
        return "SECURITY_INCIDENT".equals(category) || "SECURITY_ACCOUNT_STATE".equals(category);
    }

    /**
     * Identifies system errors requiring immediate technical attention.
     *
     * System errors jsou logged jako ERROR level s full stack traces
     * pro debugging a system health monitoring. Usually indicate
     * configuration problems nebo infrastructure issues.
     *
     * @return true pro system error category
     */
    public boolean isSystemError() {
        return "SYSTEM".equals(category);
    }
}