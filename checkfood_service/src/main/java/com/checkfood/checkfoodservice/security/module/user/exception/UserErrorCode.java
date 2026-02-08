package com.checkfood.checkfoodservice.security.module.user.exception;

/**
 * Enumrace chybových kódů pro user modul.
 * Poskytuje standardizované identifikátory chyb pro správu uživatelů a jejich dat.
 */
public enum UserErrorCode {

    /**
     * Uživatel nebyl nalezen v systému.
     */
    USER_NOT_FOUND,

    /**
     * Role nebyla nalezena v systému.
     */
    ROLE_NOT_FOUND,

    /**
     * Pokus o přístup k datům jiného uživatele.
     */
    USER_ACCESS_DENIED,

    /**
     * Email je již používán jiným uživatelem.
     */
    USER_EMAIL_EXISTS,

    /**
     * Neplatná operace nad uživatelským účtem.
     */
    USER_INVALID_OPERATION
}