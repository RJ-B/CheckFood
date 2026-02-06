package com.checkfood.checkfoodservice.security.refresh.service;

import com.checkfood.checkfoodservice.security.auth.dto.response.AuthResponse;

/**
 * Service pro obnovu JWT tokenů.
 */
public interface RefreshService {

    /**
     * Obnoví access token pomocí refresh tokenu.
     */
    AuthResponse refresh(String refreshToken);

}
