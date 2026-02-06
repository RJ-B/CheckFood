package com.checkfood.checkfoodservice.security.oauth.provider;

/**
 * Kontrakt pro OAuth providery.
 *
 * Implementace (Google/Apple) ověří token a vrátí sjednocená data uživatele.
 */
public interface OAuthClient {

    /**
     * Vrátí typ providera.
     */
    OAuthProviderType getProviderType();

    /**
     * Ověří OAuth token (typicky ID token) a vrátí sjednocené informace o uživateli.
     *
     * @param idToken ID token získaný z klienta (Google/Apple).
     * @return sjednocené informace o uživateli.
     */
    OAuthUserInfo verifyAndExtractUserInfo(String idToken);

}
