package com.checkfood.checkfoodservice.security.mfa.entity;

/**
 * Typy MFA metod.
 */
public enum MfaMethodType {

    // Time-based One-Time Password (Google Authenticator, Authy, ...)
    TOTP,

    // Záložní jednorázové kódy
    BACKUP_CODE

}
