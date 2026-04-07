package com.checkfood.checkfoodservice.security.module.oauth.exception;

/**
 * Výčet chybových kódů pro OAuth modul s metadaty kategorie pro rozhodování o úrovni logování.
 *
 * @author Rostislav Jirák
 * @version 1.0.0
 */
public enum OAuthErrorCode {

    /** ID token od providera je neplatný nebo podvržený. */
    OAUTH_TOKEN_INVALID("SECURITY_INCIDENT"),

    /** Konflikt providerů — email je registrován přes jiného providera. */
    OAUTH_PROVIDER_MISMATCH("SECURITY_ACCOUNT_STATE"),

    /** Provider není podporován. */
    OAUTH_PROVIDER_NOT_SUPPORTED("VALIDATION"),

    /** Provider nevrátil povinné údaje (email). */
    OAUTH_USER_DATA_MISSING("VALIDATION"),

    /** Chyba komunikace s externím API providera. */
    OAUTH_PROVIDER_COMMUNICATION_ERROR("SYSTEM"),

    /** Interní chyba zpracování (kryptografie, JSON parsing). */
    OAUTH_INTERNAL_ERROR("SYSTEM");

    private final String category;

    OAuthErrorCode(String category) {
        this.category = category;
    }

    /**
     * Vrátí kategorii chybového kódu pro rozhodování o úrovni logování.
     *
     * @return název kategorie
     */
    public String getCategory() {
        return category;
    }

    /**
     * Určí, zda chyba reprezentuje bezpečnostní incident vyžadující zvýšenou pozornost.
     *
     * @return true pro kategorie SECURITY_INCIDENT a SECURITY_ACCOUNT_STATE
     */
    public boolean isSecurityEvent() {
        return "SECURITY_INCIDENT".equals(category) || "SECURITY_ACCOUNT_STATE".equals(category);
    }

    /**
     * Určí, zda chyba představuje systémovou chybu infrastruktury.
     *
     * @return true pro kategorii SYSTEM
     */
    public boolean isSystemError() {
        return "SYSTEM".equals(category);
    }
}