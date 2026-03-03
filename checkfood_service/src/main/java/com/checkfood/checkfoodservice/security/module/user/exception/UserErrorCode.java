package com.checkfood.checkfoodservice.security.module.user.exception;

/**
 * Enumerace chybových kódů pro User modul.
 * Obsahuje metadata pro automatické rozhodování o logování (Severity) v ExceptionHandleru.
 */
public enum UserErrorCode {

    // --- SECURITY INCIDENTS (WARN) ---
    /** Pokus o přístup k cizím datům. */
    USER_ACCESS_DENIED("SECURITY_INCIDENT"),
    /** Neoprávněná operace (např. admin akce běžným uživatelem). */
    USER_INSUFFICIENT_PERMISSIONS("SECURITY_INCIDENT"),

    // --- NOT FOUND (INFO) ---
    /** Uživatel nenalezen. */
    USER_NOT_FOUND("NOT_FOUND"),
    /** Role nenalezena. */
    ROLE_NOT_FOUND("NOT_FOUND"),

    // --- DATA CONFLICT / VALIDATION (INFO) ---
    /** Email již existuje (duplicita). */
    USER_EMAIL_EXISTS("DATA_CONFLICT"),
    /** Neplatná operace (validace vstupu). */
    USER_INVALID_OPERATION("VALIDATION"),

    // --- SYSTEM ERRORS (ERROR) ---
    /** Chyba databáze nebo systému. */
    USER_SYSTEM_ERROR("SYSTEM");

    private final String category;

    UserErrorCode(String category) {
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