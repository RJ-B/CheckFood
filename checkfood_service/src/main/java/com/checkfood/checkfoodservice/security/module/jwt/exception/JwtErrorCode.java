package com.checkfood.checkfoodservice.security.module.jwt.exception;

/**
 * Enumerace chybových kódů pro JWT modul.
 * Obsahuje metadata pro automatické rozhodování o logování (Severity) v ExceptionHandleru.
 */
public enum JwtErrorCode {

    // --- SECURITY INCIDENTS (WARN) ---
    /** Podpis nesedí (kritické - někdo token změnil). */
    JWT_INVALID_SIGNATURE("SECURITY_INCIDENT"),
    /** Token je na blacklistu (pokus o použití odhlášeného tokenu). */
    JWT_BLACKLISTED("SECURITY_INCIDENT"),
    /** Token nepatří k zařízení/uživateli. */
    JWT_INVALID_CLAIMS("SECURITY_INCIDENT"),
    /** Token má nepodporovaný formát (útok fuzzingem). */
    JWT_UNSUPPORTED("SECURITY_INCIDENT"),

    // --- VALIDATION (INFO) ---
    /** Token vypršel (běžný stav). */
    JWT_EXPIRED("VALIDATION"),
    /** Token chybí v headeru. */
    JWT_MISSING("VALIDATION"),
    /** Token je neplatný (malformed). */
    JWT_INVALID("VALIDATION"),
    /** Uživatel z tokenu nenalezen. */
    JWT_USER_NOT_FOUND("VALIDATION"),
    /** Účet deaktivován. */
    JWT_ACCOUNT_DISABLED("VALIDATION"),

    // --- SYSTEM ERRORS (ERROR) ---
    /** Chyba při generování (kryptografie). */
    JWT_GENERATION_ERROR("SYSTEM"),
    /** Chyba při čtení (interní chyba parseru). */
    JWT_PARSE_ERROR("SYSTEM");

    private final String category;

    JwtErrorCode(String category) {
        this.category = category;
    }

    public String getCategory() {
        return category;
    }

    public boolean isSecurityEvent() {
        return "SECURITY_INCIDENT".equals(category);
    }

    public boolean isSystemError() {
        return "SYSTEM".equals(category);
    }
}