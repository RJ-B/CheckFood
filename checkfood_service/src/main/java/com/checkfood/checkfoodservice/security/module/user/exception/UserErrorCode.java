package com.checkfood.checkfoodservice.security.module.user.exception;

/**
 * Výčet chybových kódů pro User modul s metadaty kategorie pro rozhodování o úrovni logování.
 *
 * @author Rostislav Jirák
 * @version 1.0.0
 */
public enum UserErrorCode {

    /** Pokus o přístup k datům jiného uživatele. */
    USER_ACCESS_DENIED("SECURITY_INCIDENT"),

    /** Neoprávněná operace vyžadující vyšší oprávnění. */
    USER_INSUFFICIENT_PERMISSIONS("SECURITY_INCIDENT"),

    /** Uživatel nebyl nalezen. */
    USER_NOT_FOUND("NOT_FOUND"),

    /** Role nebyla nalezena. */
    ROLE_NOT_FOUND("NOT_FOUND"),

    /** E-mail je již registrován jiným uživatelem. */
    USER_EMAIL_EXISTS("DATA_CONFLICT"),

    /** Neplatná operace nebo vstupní data. */
    USER_INVALID_OPERATION("VALIDATION"),

    /** Systémová nebo databázová chyba. */
    USER_SYSTEM_ERROR("SYSTEM");

    private final String category;

    UserErrorCode(String category) {
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
     * Určí, zda chyba reprezentuje bezpečnostní incident.
     *
     * @return true pro kategorii SECURITY_INCIDENT
     */
    public boolean isSecurityEvent() {
        return "SECURITY_INCIDENT".equals(category);
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