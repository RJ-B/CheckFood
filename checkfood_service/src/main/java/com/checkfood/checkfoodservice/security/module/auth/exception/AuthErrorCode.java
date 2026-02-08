package com.checkfood.checkfoodservice.security.module.auth.exception;

/**
 * Enumrace chybových kódů pro autentizační modul.
 * Poskytuje standardizované identifikátory chyb pro registraci, přihlašování a verifikaci účtů.
 */
public enum AuthErrorCode {

    /**
     * Neplatné přihlašovací údaje (email nebo heslo).
     */
    AUTH_INVALID_CREDENTIALS,

    /**
     * Email je již registrován v systému.
     */
    AUTH_EMAIL_EXISTS,

    /**
     * Uživatelský účet byl deaktivován administrátorem.
     */
    AUTH_ACCOUNT_DISABLED,

    /**
     * Uživatelský účet byl uzamčen z bezpečnostních důvodů.
     */
    AUTH_ACCOUNT_LOCKED,

    /**
     * Uživatelský účet nebyl aktivován prostřednictvím verifikačního emailu.
     */
    AUTH_ACCOUNT_NOT_VERIFIED,

    /**
     * Verifikační token je neplatný nebo neexistuje.
     */
    AUTH_TOKEN_INVALID,

    /**
     * Verifikační token vypršel.
     */
    AUTH_TOKEN_EXPIRED,

    /**
     * Hesla se neshodují.
     */
    AUTH_PASSWORD_MISMATCH,

    /**
     * Heslo nesplňuje bezpečnostní požadavky.
     */
    AUTH_WEAK_PASSWORD,

    /**
     * Neplatný formát emailové adresy.
     */
    AUTH_INVALID_EMAIL_FORMAT,

    /**
     * Refresh token je neplatný nebo vypršel.
     */
    AUTH_SESSION_EXPIRED,

    /**
     * Token nepatří danému zařízení.
     */
    AUTH_DEVICE_MISMATCH
}