package com.checkfood.checkfoodservice.security.module.mfa.entity;

/**
 * Výčet podporovaných metod vícefaktorové autentizace.
 *
 * @author Rostislav Jirák
 * @version 1.0.0
 */
public enum MfaMethodType {

    /** Časově synchronizované jednorázové heslo kompatibilní s Google Authenticator, Authy a dalšími aplikacemi. */
    TOTP,

    /** Záložní jednorázové kódy použitelné při nedostupnosti TOTP aplikace. */
    BACKUP_CODE

}
