package com.checkfood.checkfoodservice.security.auth.dto.response;

import lombok.*;

/**
 * Hlavní autentizační odpověď systému.
 * Obsahuje kompletní sadu tokenů pro udržení relace a základní profil uživatele.
 */
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class AuthResponse {

    /**
     * JWT Access Token pro autorizaci běžných API požadavků.
     */
    private String accessToken;

    /**
     * Dlouhodobý Refresh Token pro obnovu Access Tokenu po jeho vypršení.
     */
    private String refreshToken;

    /**
     * Typ tokenu (standardně "Bearer").
     */
    @Builder.Default
    private String tokenType = "Bearer";

    /**
     * Doba platnosti Access Tokenu v sekundách (např. 3600).
     */
    private Long expiresIn;

    /**
     * Základní údaje o uživateli pro okamžitou personalizaci UI ve Flutteru.
     */
    private UserResponse user;
}