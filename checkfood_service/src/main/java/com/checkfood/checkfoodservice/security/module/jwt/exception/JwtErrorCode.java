package com.checkfood.checkfoodservice.security.module.jwt.exception;

/**
 * Enumerace chybových kódů pro JWT modul.
 * Obsahuje metadata pro automatické rozhodování o úrovni logování v {@code JwtExceptionHandler}.
 *
 * @author Rostislav Jirák
 * @version 1.0.0
 */
public enum JwtErrorCode {

    /** Podpis tokenu nesedí — potenciální manipulace s tokenem. */
    JWT_INVALID_SIGNATURE("SECURITY_INCIDENT"),
    /** Token je na blacklistu — pokus o použití odhlášeného tokenu. */
    JWT_BLACKLISTED("SECURITY_INCIDENT"),
    /** Token nepatří k danému zařízení nebo uživateli. */
    JWT_INVALID_CLAIMS("SECURITY_INCIDENT"),
    /** Token má nepodporovaný formát. */
    JWT_UNSUPPORTED("SECURITY_INCIDENT"),

    /** Token vypršel — běžný stav vyžadující refresh. */
    JWT_EXPIRED("VALIDATION"),
    /** Token chybí v Authorization headeru. */
    JWT_MISSING("VALIDATION"),
    /** Token je neplatný (malformed). */
    JWT_INVALID("VALIDATION"),
    /** Uživatel extrahovaný z tokenu nebyl nalezen. */
    JWT_USER_NOT_FOUND("VALIDATION"),
    /** Uživatelský účet je deaktivován. */
    JWT_ACCOUNT_DISABLED("VALIDATION"),

    /** Chyba při generování tokenu (kryptografická chyba). */
    JWT_GENERATION_ERROR("SYSTEM"),
    /** Interní chyba parseru při čtení tokenu. */
    JWT_PARSE_ERROR("SYSTEM");

    private final String category;

    JwtErrorCode(String category) {
        this.category = category;
    }

    /**
     * Vrátí kategorii chyby pro rozhodování o úrovni logování.
     *
     * @return kategorie chyby (SECURITY_INCIDENT, VALIDATION, SYSTEM)
     */
    public String getCategory() {
        return category;
    }

    /**
     * Určuje, zda jde o bezpečnostní incident vyžadující zvýšenou pozornost.
     *
     * @return {@code true} pro kategorii SECURITY_INCIDENT
     */
    public boolean isSecurityEvent() {
        return "SECURITY_INCIDENT".equals(category);
    }

    /**
     * Určuje, zda jde o systémovou chybu vyžadující okamžitou technickou pozornost.
     *
     * @return {@code true} pro kategorii SYSTEM
     */
    public boolean isSystemError() {
        return "SYSTEM".equals(category);
    }
}