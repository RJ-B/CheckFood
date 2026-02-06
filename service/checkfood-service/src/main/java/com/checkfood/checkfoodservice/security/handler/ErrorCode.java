package com.checkfood.checkfoodservice.security.handler;

/**
 * Centrální seznam bezpečnostních chybových kódů.
 */
public enum ErrorCode {

    // ================= AUTH =================
    AUTH_INVALID_CREDENTIALS,
    AUTH_ACCOUNT_DISABLED,
    AUTH_ACCOUNT_LOCKED,
    AUTH_ACCOUNT_NOT_VERIFIED,

    // ================= VERIFICATION =================
    AUTH_TOKEN_INVALID,
    AUTH_TOKEN_EXPIRED,

    // ================= JWT =================
    JWT_INVALID,
    JWT_EXPIRED,
    JWT_MISSING,

    // ================= REFRESH =================
    REFRESH_INVALID,
    REFRESH_EXPIRED,

    // ================= MFA =================
    MFA_NOT_ENABLED,
    MFA_ALREADY_ENABLED,
    MFA_INVALID_CODE,
    MFA_RATE_LIMITED,

    // ================= OAUTH =================
    OAUTH_INVALID_TOKEN,
    OAUTH_EMAIL_MISSING,
    OAUTH_PROVIDER_NOT_SUPPORTED,

    // ================= VALIDATION =================
    VALIDATION_ERROR,

    // ================= SYSTEM =================
    INTERNAL_ERROR,
    INTERNAL_SERVER_ERROR


    }