package com.checkfood.checkfoodservice.security.module.oauth.service;

import com.checkfood.checkfoodservice.security.module.auth.dto.response.AuthResponse;
import com.checkfood.checkfoodservice.security.module.oauth.dto.request.OAuthLoginRequest;

/**
 * Hlavní orchestrační rozhraní pro OAuth modul.
 * Zodpovídá za zpracování požadavků na přihlášení přes externí poskytovatele identity.
 *
 * @author Rostislav Jirák
 * @version 1.0.0
 */
public interface OAuthService {

    /**
     * Provede kompletní OAuth autentizaci: ověří ID token, získá nebo vytvoří uživatele
     * a vydá JWT tokeny.
     *
     * @param request požadavek obsahující typ poskytovatele, ID token a data o zařízení
     * @return sjednocená odpověď s JWT tokeny a daty uživatele
     */
    AuthResponse login(OAuthLoginRequest request);
}