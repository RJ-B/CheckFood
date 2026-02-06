package com.checkfood.checkfoodservice.application.entity.user;

/**
 * Poskytovatel identity uživatele.
 */
public enum IdentityProvider {

    /**
     * Lokální přihlášení (email / username + heslo).
     */
    LOCAL,

    /**
     * Google účet (web i Android).
     */
    GOOGLE,

    /**
     * Apple účet (Sign in with Apple).
     */
    APPLE,

    /**
     * Facebook účet.
     */
    FACEBOOK
}
