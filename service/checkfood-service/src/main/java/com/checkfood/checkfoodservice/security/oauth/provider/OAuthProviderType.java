package com.checkfood.checkfoodservice.security.oauth.provider;

/**
 * Typy OAuth providerů podporovaných aplikací.
 *
 * Používá se pro routing logiky (factory) a validaci vstupů z klienta.
 */
public enum OAuthProviderType {

    GOOGLE,
    APPLE

}
