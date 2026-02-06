package com.checkfood.checkfoodservice.security.audit.event;

/**
 * Typy auditovaných bezpečnostních akcí.
 */
public enum AuditAction {

    // =====================
    // AUTH
    // =====================

    LOGIN,

    REGISTER,

    VERIFY_EMAIL,

    LOGOUT,

    REFRESH_TOKEN,

    OAUTH_LOGIN,


    // =====================
    // MFA
    // =====================

    MFA_SETUP_START,

    MFA_SETUP_VERIFY,

    MFA_CHALLENGE,

    MFA_DISABLED,


    // =====================
    // USER
    // =====================

    PASSWORD_CHANGED,

    EMAIL_CHANGED,

    PROFILE_UPDATED,

    ACCOUNT_DELETED,


    // =====================
    // SECURITY
    // =====================

    RATE_LIMIT_EXCEEDED,

    INVALID_TOKEN,

    UNAUTHORIZED_ACCESS

}