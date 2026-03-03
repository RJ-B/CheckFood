package com.checkfood.checkfoodservice.security.module.oauth.service;

import com.checkfood.checkfoodservice.security.module.auth.dto.response.AuthResponse; // ✅ Sjednocený import
import com.checkfood.checkfoodservice.security.module.oauth.dto.request.OAuthLoginRequest;

/**
 * Hlavní orchestrační služba pro modul OAuth.
 * Zodpovídá za zpracování požadavků na přihlášení přes externí poskytovatele identity.
 */
public interface OAuthService {

    /**
     * Provede kompletní proces autentizace uživatele přes sociální sítě.
     * * @param request Požadavek obsahující typ poskytovatele, ID token a data o zařízení.
     * @return Sjednocená odpověď AuthResponse obsahující JWT tokeny a UserResponse.
     */
    AuthResponse login(OAuthLoginRequest request); // ✅ Změněno z OAuthResponse na AuthResponse
}