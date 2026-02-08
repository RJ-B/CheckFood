package com.checkfood.checkfoodservice.security.audit.event;

/**
 * Enumrace typů auditovaných bezpečnostních akcí v systému.
 * Pokrývá autentizaci, MFA operace, správu uživatelského účtu a bezpečnostní události.
 */
public enum AuditAction {

    // =====================
    // AUTH
    // =====================

    /**
     * Přihlášení uživatele do systému.
     */
    LOGIN,

    /**
     * Registrace nového uživatelského účtu.
     */
    REGISTER,

    /**
     * Ověření emailové adresy uživatele.
     */
    VERIFY_EMAIL,

    /**
     * Odhlášení uživatele ze systému.
     */
    LOGOUT,

    /**
     * Obnovení autentizačního tokenu.
     */
    REFRESH_TOKEN,

    /**
     * Přihlášení pomocí OAuth providera.
     */
    OAUTH_LOGIN,


    // =====================
    // MFA
    // =====================

    /**
     * Zahájení procesu nastavení vícefaktorové autentizace.
     */
    MFA_SETUP_START,

    /**
     * Ověření a dokončení nastavení MFA.
     */
    MFA_SETUP_VERIFY,

    /**
     * Ověření MFA kódu při přihlášení.
     */
    MFA_CHALLENGE,

    /**
     * Vypnutí vícefaktorové autentizace.
     */
    MFA_DISABLED,


    // =====================
    // USER
    // =====================

    /**
     * Změna hesla uživatele.
     */
    PASSWORD_CHANGED,

    /**
     * Změna emailové adresy.
     */
    EMAIL_CHANGED,

    /**
     * Aktualizace profilových údajů.
     */
    PROFILE_UPDATED,

    /**
     * Smazání uživatelského účtu.
     */
    ACCOUNT_DELETED,


    // =====================
    // SECURITY
    // =====================

    /**
     * Překročení rate limitu pro API požadavky.
     */
    RATE_LIMIT_EXCEEDED,

    /**
     * Pokus o použití neplatného tokenu.
     */
    INVALID_TOKEN,

    /**
     * Pokus o neoprávněný přístup k chráněnému zdroji.
     */
    UNAUTHORIZED_ACCESS

}