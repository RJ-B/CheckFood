package com.checkfood.checkfoodservice.security.module.oauth.exception;

/**
 * Enumerace chybových kódů pro modul OAuth.
 * Obsahuje metadata pro automatické rozhodování o logování (Severity) v ExceptionHandleru.
 */
public enum OAuthErrorCode {

    // --- SECURITY INCIDENTS (WARN) ---
    /** ID Token od poskytovatele je neplatný/podvržený. */
    OAUTH_TOKEN_INVALID("SECURITY_INCIDENT"),
    /** Konflikt providerů (např. email registrován přes Google, ale přihlášení přes Apple). */
    OAUTH_PROVIDER_MISMATCH("SECURITY_ACCOUNT_STATE"),

    // --- VALIDATION / CONFIG (INFO) ---
    /** Poskytovatel není podporován (chybný request). */
    OAUTH_PROVIDER_NOT_SUPPORTED("VALIDATION"),
    /** Chybí povinná data (email) od poskytovatele. */
    OAUTH_USER_DATA_MISSING("VALIDATION"),

    // --- SYSTEM ERRORS (ERROR) ---
    /** Chyba komunikace s externím API (Google/Apple down). */
    OAUTH_PROVIDER_COMMUNICATION_ERROR("SYSTEM"),
    /** Interní chyba zpracování (kryptografie, JSON parsing). */
    OAUTH_INTERNAL_ERROR("SYSTEM");

    private final String category;

    OAuthErrorCode(String category) {
        this.category = category;
    }

    public String getCategory() {
        return category;
    }

    public boolean isSecurityEvent() {
        return "SECURITY_INCIDENT".equals(category) || "SECURITY_ACCOUNT_STATE".equals(category);
    }

    public boolean isSystemError() {
        return "SYSTEM".equals(category);
    }
}