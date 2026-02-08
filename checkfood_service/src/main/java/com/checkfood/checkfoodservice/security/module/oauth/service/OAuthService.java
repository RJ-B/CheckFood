package com.checkfood.checkfoodservice.security.module.oauth.service;

import com.checkfood.checkfoodservice.security.module.auth.dto.response.AuthResponse;
import com.checkfood.checkfoodservice.security.module.oauth.dto.request.OAuthLoginRequest;

/**
 * Service pro OAuth autentizaci (Google / Apple).
 */
public interface OAuthService {

    /**
     * Přihlásí nebo zaregistruje uživatele na základě OAuth tokenu
     * a vrátí interní JWT.
     */
    AuthResponse login(OAuthLoginRequest request);

}
