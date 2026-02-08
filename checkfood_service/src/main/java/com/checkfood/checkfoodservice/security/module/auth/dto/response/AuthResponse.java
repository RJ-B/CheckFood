package com.checkfood.checkfoodservice.security.module.auth.dto.response;

import lombok.*;

/**
 * Autentizační odpověď systému po úspěšném přihlášení.
 * Obsahuje tokeny pro udržení relace a základní informace o uživateli.
 */
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class AuthResponse {

    /**
     * JWT access token pro autorizaci API požadavků.
     * Používá se v Authorization hlavičce jako "Bearer {token}".
     */
    private String accessToken;

    /**
     * Refresh token pro obnovení access tokenu po jeho expiraci.
     * Má delší platnost než access token.
     */
    private String refreshToken;

    @Builder.Default
    private String tokenType = "Bearer";

    private Long expiresIn;

    private UserResponse user;
}