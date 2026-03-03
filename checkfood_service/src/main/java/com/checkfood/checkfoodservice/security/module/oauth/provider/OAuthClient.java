package com.checkfood.checkfoodservice.security.module.oauth.provider;

import com.checkfood.checkfoodservice.security.module.auth.provider.AuthProvider;

/**
 * Kontrakt pro implementaci specifických OAuth2 klientů.
 * Definuje sjednocené rozhraní pro ověřování externích identit.
 */
public interface OAuthClient {

    /**
     * Provede kryptografické ověření přijatého ID tokenu a extrahuje data.
     * Každý poskytovatel (Google/Apple) implementuje vlastní logiku verifikace.
     *
     * @param idToken Surový token získaný z mobilní aplikace
     * @return Normalizovaný objekt OAuthUserInfo s daty uživatele
     */
    OAuthUserInfo verifyAndGetUserInfo(String idToken);

    /**
     * Vrací typ poskytovatele, kterého tento klient obsluhuje.
     * Klíčové pro správné směrování v rámci OAuthClientFactory.
     *
     * @return AuthProvider (GOOGLE nebo APPLE)
     */
    AuthProvider getProviderType();
}